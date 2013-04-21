From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [BUG] Filenames with single colon being treated as remote
 repository
Date: Sat, 20 Apr 2013 23:05:39 -0700
Message-ID: <20130421060538.GB10429@elie.Belkin>
References: <20130421045329.GB30538@WST420>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, fsckdaemon@gmail.com,
	Daniel Barkalow <barkalow@iabervon.org>
To: William Giokas <1007380@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 08:06:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTnPX-0005nT-50
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 08:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751693Ab3DUGFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 02:05:49 -0400
Received: from mail-da0-f48.google.com ([209.85.210.48]:65114 "EHLO
	mail-da0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab3DUGFs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 02:05:48 -0400
Received: by mail-da0-f48.google.com with SMTP id f10so927570dak.7
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 23:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xgQYcuJ23fhv9FJZgzrPlnZf9GGo6glKbPtSV/5f0AY=;
        b=gyjiJToGnBOKgl3V9W7+vvTCo4W+p2PKGyxQMs4zTVe01aSJYrspuRSu5q+O55u6XK
         xRIhNekHihN7cBK1CzveDr4rXjdt2bt2QYRvPZKHSHjoOGm4ldqoDP0e0U7CXoSeG/GW
         5uYWMjG117VT7XVlCKoRIADbg6upZbMHuZ+g/c8VKvKbr8+Eywx4d4vH1hd0XcFuLk9/
         8zVHxiVzjtK0pf7OEfajHn39JaCjoKz1OWpKAd3vJ+vcD+WkrHzj1uP764KaGrBsKGhL
         E5syb+fnBf783hvMixM2JKZ4c/VWiGWGCbT/L2R9MKUSMMIA8ZyiRoe9X3KvebxinT1K
         F0Lw==
X-Received: by 10.66.122.97 with SMTP id lr1mr6194592pab.147.1366524347734;
        Sat, 20 Apr 2013 23:05:47 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id bs3sm19796418pbb.36.2013.04.20.23.05.45
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 23:05:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130421045329.GB30538@WST420>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221893>

Hi,

William Giokas wrote:

>     $ git clone /tmp/foo:bar/baz /tmp/new-baz
>
> but running this gives me this output::
>
>     Cloning into 'new-baz'...
>     ssh: Could not resolve hostname /tmp/foo: Success
>     fatal: Could not read from remote repository.

Here's a toy patch.  I haven't thought carefully about whether it's a
good idea, but maybe it can be useful for thinking about that.

Still needs documentation and tests.

My main worry is that the proposed rule for when an argument is
treated as a local path is hard to explain.  There's some precedent in
handling of bundles, though.  What do you think?

Thanks,
Jonathan

diff --git i/transport.c w/transport.c
index e6f9346c..61eba842 100644
--- i/transport.c
+++ w/transport.c
@@ -903,6 +903,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 {
 	const char *helper;
 	struct transport *ret = xcalloc(1, sizeof(*ret));
+	struct stat st;
 
 	ret->progress = isatty(2);
 
@@ -942,6 +943,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->disconnect = close_bundle;
 		ret->smart_options = NULL;
 	} else if (!is_url(url)
+		|| (is_local(url) && !stat(url, &st))
 		|| !prefixcmp(url, "file://")
 		|| !prefixcmp(url, "git://")
 		|| !prefixcmp(url, "ssh://")

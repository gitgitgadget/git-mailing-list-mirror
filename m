From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/4] add -u: only show pathless 'add -u' warning when
 changes exist outside cwd
Date: Mon, 18 Mar 2013 22:34:02 -0700
Message-ID: <20130319053402.GP5062@elie.Belkin>
References: <20130313040845.GA5057@sigill.intra.peff.net>
 <20130313041037.GB5378@sigill.intra.peff.net>
 <20130319034415.GI5062@elie.Belkin>
 <20130319034822.GL5062@elie.Belkin>
 <7vli9kkoci.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 19 06:34:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHpC1-0008Oe-6f
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 06:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756530Ab3CSFeJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 01:34:09 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:54297 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756515Ab3CSFeI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 01:34:08 -0400
Received: by mail-pb0-f49.google.com with SMTP id xa12so113060pbc.22
        for <git@vger.kernel.org>; Mon, 18 Mar 2013 22:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=i0GAMEcI+Mcxaab+Wlcx8Nv9OsjueviI03N9Igdn8Ns=;
        b=XQtp9lAZcJLDqo2/4Z/VVlUVOUy1royThK7SPksktPqshmvXgyvfbY/aP8fJA//aFy
         ItvRTcO2h/lrl1FAxKpQpTVffiQp1vH7ekGc+2NfYpSW5+jsUR14y4P8UXY4SGqnVOLX
         MGXeBtNGRcFdmt/NmYauRoC113NHL0d4CVPW9JxRT5HElqPNtCffzkX1ctTv2K3BgTfH
         ZnwaxHEp4HNsS4GlmFMhjIKK5kdslZxuowhtNlvpF4LREMY71SPSHQWoEpse5dl+f+Zu
         wCgBbK402Hsrz2xQiKEnou7h2O5We2o3WmNmitA3kR5Yr6dZbkZkMUrYMA02M+91nzNK
         FxpA==
X-Received: by 10.68.103.98 with SMTP id fv2mr1118754pbb.121.1363671247767;
        Mon, 18 Mar 2013 22:34:07 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id 1sm22860861pbg.18.2013.03.18.22.34.05
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Mar 2013 22:34:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vli9kkoci.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218483>

Junio C Hamano wrote:

> The implemenation appears to run an extra diff_files() in addition
> to the one we already have to run in order to implement the "add -u"
> to collect modified/deleted paths.  Is that the best we can do?  

At least the following should be squashed in to avoid wasted effort in
the easy case (cwd at top of worktree).  Thanks for catching it.

diff --git i/builtin/add.c w/builtin/add.c
index f05ec1c1..8e4cdfae 100644
--- i/builtin/add.c
+++ w/builtin/add.c
@@ -483,7 +483,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 	 * "git add -u ." in the future.  This warning prepares for
 	 * that change.
 	 */
-	if (implicit_dot)
+	if (prefix && implicit_dot)
 		diff_files_with_callback(prefix, NULL,
 				warn_if_outside_pathspec, pathspec);
 

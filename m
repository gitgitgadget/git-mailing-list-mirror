From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 4/9] patch-id: make it stable against hunk reordering
Date: Thu, 24 Apr 2014 10:30:44 -0700
Message-ID: <20140424173043.GJ15516@google.com>
References: <1398331809-11309-1-git-send-email-mst@redhat.com>
 <1398331809-11309-4-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, peff@peff.net,
	gitster@pobox.com
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 19:30:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdNU5-0003oH-C1
	for gcvg-git-2@plane.gmane.org; Thu, 24 Apr 2014 19:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757578AbaDXRat (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 13:30:49 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:62407 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757354AbaDXRas (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 13:30:48 -0400
Received: by mail-pb0-f52.google.com with SMTP id rq2so2203877pbb.11
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MaWaUG8B41g3KsgalK1vxiI2TD4OyRyOgxYcBIyEHMQ=;
        b=IbrqUX46QlW5mUyrDa+UX6lAYiuvK6SFbVZT8oRO8Yp7haUBXpC4gA8j5UfUUxCoDn
         tIL70CyANG0tNhQbcIcpWKqY2iF4S/yuiKd17Naz49ygOkfbHgVs21feUCDLbYiV4u6/
         kyWx7U10ZGU0V3wqtHk7Fe5v1v0XBaDAff3zCiE0OU+F5jp9tqUq7y3WCkncbxY0w9TD
         3xqrLO5wy1xhlUPYlyD4Os9DT7GMVKoYqaEA5tlRD2iK1aD1AJZS5o5VA8AqHVB5QyHr
         /sUBqjhKS1nO+tIkQon9X56W3at4dm1vMap41s1yzwV3GbqU6EueT8YC16yroAd8AuE1
         qQHw==
X-Received: by 10.68.221.42 with SMTP id qb10mr1446862pbc.65.1398360647914;
        Thu, 24 Apr 2014 10:30:47 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xr9sm23603587pab.5.2014.04.24.10.30.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Apr 2014 10:30:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1398331809-11309-4-git-send-email-mst@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246979>

Hi,

Michael S. Tsirkin wrote:

> Patch id changes if users
> 1. reorder file diffs that make up a patch
> or
> 2. split a patch up to multiple diffs that touch the same path
> (keeping hunks within a single diff ordered to make patch valid).
>
> As the result is functionally equivalent, a different patch id is
> surprising to many users.

Hm.

If the goal is that functionally equivalent patches are guaranteed to
produce the same patch-id, I wonder if we should be doing something
like the following:

 1. apply the patch in memory
 2. generate a new diff
 3. use that new diff to produce a patch-id

Otherwise issues like --diff-algorithm=patience versus =myers will
create trouble too.  I don't think that avoiding false negatives for
patch comparison without doing something like that is really possible.

On the other hand if someone reorders file diffs within a patch, that
is a potentially very common thing to do and something worth fixing.
In other words, while your (1) makes perfect sense to me, case (2)
seems less convincing.

The downside of allowing reordering hunks is that it can potentially
make different patches to be treated the same (for example if they
were making similar changes to different functions) when the ordering
previously caused them to be distinguished.  But that wasn't something
people could count on anyway, so I don't mind.

Should the internal patch-id computation used by commands like 'git
cherry' (see diff.c::diff_get_patch_id) get the same change?  (Not a
rhetorical question --- I don't know what the right choice would be
there.)

[...]
> The new behaviour is enabled
> - when patchid.stable is true
> - when --stable flag is present
>
> Using a new flag --unstable or setting patchid.stable to false force
> the historical behaviour.

Which is the default?

[...]
>  builtin/patch-id.c | 89 ++++++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 73 insertions(+), 16 deletions(-)

Documentation?  Tests?

Thanks,
Jonathan

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/7] revert: free revs->cmdline.rev
Date: Mon, 21 May 2012 15:39:41 -0500
Message-ID: <20120521203941.GB28331@burratino>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
 <20120521145610.1911.46356.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon May 21 22:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWZOT-0006Hj-Q2
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 22:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758361Ab2EUUjt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 16:39:49 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:34066 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754046Ab2EUUjs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 16:39:48 -0400
Received: by gglu4 with SMTP id u4so4763354ggl.19
        for <git@vger.kernel.org>; Mon, 21 May 2012 13:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ENPX+NHkg9J1Yf4mQHy+CjF4laJsMLP9IZJndKNcFsI=;
        b=nSxTe5TC+TAqf/gu2QmLIwQkOAvtD11QHevqGlR57HPxmAIF1lAjvjnVcJsyED1N/p
         PB8f21UQLXEDP6WJfpzXKjsPBWi7XPnhfB5jGhsANX4UMjkFQYxxBzV0hUeZLqYYPtM/
         TH3cXrIH35lBecLD/m31o+JIHZj8Osg+PJF+3lJf6ueI8joh/75vKjKfD0DD849YiZq6
         3fzz2Ogd8xShbhdcydR9e3FIWwrtI/z2sh032xxRszhaJBtSZMgWc/RP9qZ8Jr1+o3/n
         EZuImczfYqwLjQEeVlCCbsX8/Y9MZWaYFkXxf1SpNmpiiYpB9vZeD2ZPTm2bT0XCMYqN
         rZhw==
Received: by 10.50.149.132 with SMTP id ua4mr7869528igb.41.1337632787667;
        Mon, 21 May 2012 13:39:47 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ey7sm14498059igb.2.2012.05.21.13.39.46
        (version=SSLv3 cipher=OTHER);
        Mon, 21 May 2012 13:39:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120521145610.1911.46356.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198127>

Hi,

Christian Couder wrote:

> add_rev_cmdline() in revision.c is (re)allocating an array of
> struct rev_cmdline_entry. This patch releases it.
[...]
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -217,6 +217,8 @@ int cmd_revert(int argc, const char **argv, const char *prefix)
>  	git_config(git_default_config, NULL);
>  	parse_args(argc, argv, &opts);
>  	res = sequencer_pick_revisions(&opts);
> +	if (opts.revs)
> +		free(opts.revs->cmdline.rev);
>  	free(opts.revs);
>  	if (res < 0)
>  		die(_("revert failed"));

Quick thoughts:

This feels like a layering violation.  Avoidable?  Maybe revision.c
could gain a helper to allow this to be written like so:

	free_rev_info(opts.revs);
	free(opts.revs);

Since this is a one-time allocation it is probably worth mentioning in
the log message that this is a futureproofing/valgrind-cleanliness
measure and is not actually fixing a leak.

Micronit: it would feel slightly more comfortable if the free() were
after the die(), even though the die() should probably be changed to
exit().  That way someone wanting to add code after the die() that
continues to assume opts.revs is valid would be able to.

Of course I'd imagine the largest leak in cherry-pick is the
deliberately constantly growing object hash table.  It would be very
interesting to fix that --- do you know how libgit2 handles it?

Thanks much and hope that helps,
Jonathan

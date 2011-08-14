From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/7] revert: Make the argument parser responsible for
 setup_revisions
Date: Sun, 14 Aug 2011 07:52:23 -0500
Message-ID: <20110814125223.GE18466@elie.gateway.2wire.net>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 15:11:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsaTV-00014k-4r
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 15:11:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab1HNMwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 08:52:31 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:62246 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753309Ab1HNMwa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 08:52:30 -0400
Received: by gwaa12 with SMTP id a12so2797739gwa.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=jr+jTUCNZ/XI53wgIq3ngD2IX/RwuSdlN2TGHKhh6kY=;
        b=Oy07DMARZEcafvM+S4WE7S6b86ogUCQ5alK2HpWR1YYnORtrAQGZ8yU23puvSHgnxn
         yEsl5Z7rq8xhlTkx7MJgcBGruE34QSBcDbugGhRWDApddCSHSfaYWlKZJS2iaiS2hTRh
         BjA06GL7HlXZyA1f2Z33P8CBPEYZxIJo4KYb8=
Received: by 10.150.235.7 with SMTP id i7mr258067ybh.211.1313326349914;
        Sun, 14 Aug 2011 05:52:29 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-68-255-106-30.dsl.chcgil.sbcglobal.net [68.255.106.30])
        by mx.google.com with ESMTPS id g16sm3062292ybi.8.2011.08.14.05.52.28
        (version=SSLv3 cipher=OTHER);
        Sun, 14 Aug 2011 05:52:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313310789-10216-6-git-send-email-artagnon@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179322>

Ramkumar Ramachandra wrote:

> Currently, prepare_revs calls setup_revisions with the (argc, argv) in
> the opts structure filled in by parse_args.  As a result, prepare_revs
> has to take up the responsibility of erroring out and printing usage
> information when (argc, argv) is malformed.  Since parse_args is doing
> this for other kinds of parse errors anyway, give it the task of
> calling setup_revisions as well.

I'm having trouble understanding the above.  Are you saying that we
want to concentrate all usage() calls in a single function for some
reason and prepare_revs() goes against this?  Why would I (the reader)
care about that?

Presumably a simpler explanation is that it makes my life easier in
two ways:

 1. If I want to understand what commandline arguments are accepted
    by cherry-pick/revert, after this patch there is just one function
    to look at.

 2. If I want to ask the replay machinery to do something different,
    as a caller I can set my options in a "struct rev_info" instead
    of forging commandline arguments with the same effect.

> Based-on-patch-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Since I wrote the patch modulo the commit message and small
improvements, shouldn't I be blamed as the author?  (git log
--grep="[Oo]riginal patch" and git log --grep=jc: give some examples.)
You can have my sign-off if you'd like.

[...]
> +	if (opts->subcommand == REPLAY_NONE) {
> +		opts->revs = xmalloc(sizeof(*opts->revs));

My fault: this never gets freed.  As long as this is private to the
cherry-pick/revert builtin, it's a one-time tiny leak cleaned up by
_exit --- no harm done, but probably worth a comment.

From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: [PATCH] Get format-patch to show first commit after root commit
Date: Sat, 10 Jan 2009 14:36:42 +0300
Message-ID: <20090110113642.GA25723@myhost>
References: <1231536787-20685-1-git-send-email-nathan.panike@gmail.com> <7vmye0yohu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 10 12:38:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLcAa-0002a4-3s
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 12:38:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbZAJLgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 06:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752782AbZAJLgs
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 06:36:48 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:15978 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbZAJLgr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 06:36:47 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3608604fgg.17
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 03:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=aBwrVtYiKE5aBwyhARqw4ljWi1wthNznSApNhY+3eA8=;
        b=kHVMeWAT8AJRKLQmHfdbf3VI2kV9rzK2a549wT1Wydb7Z4hnEpUFdVG6bsnrcqSA4h
         f8s/6HvditawAaI/XL27wH++l0Jbo8DiG+w5A284a1kX4bD9qw8ThjTX/55X6Gmvu/0V
         h1yAo40PCgtMvceUsiUz/d305vkHnWpg3zXXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=tlBrks12YJLY9forltGCE+Xs3aCPfYCMVGxbqJV3mvAtDhtYxUhsxXKKr62JBnudMz
         k3WZ/evQ7e6VYupHVEnloe7u+sNDR29EG6g3BlF121s/UFUdpIf2wjbRfB6g8P4+cAfF
         mLDRnDW78JKEyEUVpaWq7an2zQMB5kg12iKAo=
Received: by 10.86.84.18 with SMTP id h18mr15429918fgb.69.1231587405762;
        Sat, 10 Jan 2009 03:36:45 -0800 (PST)
Received: from smtp.gmail.com (ppp83-237-189-185.pppoe.mtu-net.ru [83.237.189.185])
        by mx.google.com with ESMTPS id 4sm6753938fgg.44.2009.01.10.03.36.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jan 2009 03:36:41 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Sat, 10 Jan 2009 14:36:42 +0300
Content-Disposition: inline
In-Reply-To: <7vmye0yohu.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105094>

Hello, Junio!

> I think the attached would be a better patch.  We already have a
> configuration to control if we show the patch for a root commit by
> default, and we can use reuse it here.  The configuration defaults to true
> these days.
> 
> Because the code before the hunk must check if the user said "--root
> commit" or just "commit" from the command line and behave quite
> differently by looking at rev.show_root_diff, we cannot do this assignment
> before the command line parsing like other commands in the log family.

I think the problem was not only format-patch misbehaviour. If you use
"log.showroot = no", you still get an empty patch file, which is not
very good, because format-patch doesn't work very well, it creates
_corrupt_ patches! It's much better to not create the patch file at all
in this case.

However, it has nothing in common with your patch, but there's room for
another commit.

> 
>  builtin-log.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git c/builtin-log.c w/builtin-log.c
> index 4a02ee9..2d2c111 100644
> --- c/builtin-log.c
> +++ w/builtin-log.c
> @@ -935,6 +935,14 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>  		 * get_revision() to do the usual traversal.
>  		 */
>  	}
> +
> +	/*
> +	 * We cannot move this anywhere earlier because we do want to
> +	 * know if --root was given explicitly from the comand line.
> +	 */
> +	if (default_show_root)
> +		rev.show_root_diff = 1;
> +
>  	if (cover_letter) {
>  		/* remember the range */
>  		int i;

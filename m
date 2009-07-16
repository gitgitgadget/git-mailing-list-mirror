From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v3] Re: git-am: fix maildir support regression: accept
	email file as patch
Date: Thu, 16 Jul 2009 02:49:52 +0200
Message-ID: <20090716004952.GB12971@vidovic>
References: <1654b578a7e045b564c46df4abb6e2196422c2b2.1247696294.git.nicolas.s.dev@gmx.fr> <7v1voheevy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 02:50:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRFAj-0002eQ-8m
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 02:50:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbZGPAt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 20:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753609AbZGPAt5
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 20:49:57 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:37468 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752849AbZGPAt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jul 2009 20:49:57 -0400
Received: by ewy26 with SMTP id 26so4484204ewy.37
        for <git@vger.kernel.org>; Wed, 15 Jul 2009 17:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=zoXm5P8YfwOZkBnr6Qd85iGoZXCei460UcCTT/x1Czc=;
        b=WoPL+bj+otfUNHx/3eI9csc8CFsCH5cAgvnYqLEptsehc0XgGSCeJgLHWdFJzmnSob
         wEqfIv7vUntw+DwP2+mdl6VQAZJ9G8/fQ+n0wWSbLvK7//XYBArpX79/vdTGVO1A2Rzy
         0EdahYCMW5NkaogYPA8OA1+U5OpE2MX8+wSoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=iuZdTt+mbO5ghuJCLRkGQAw7asaD5VvfJ42wQTjtHcMRJ8uDhUxe7xR2dCQ3etWheR
         WJ14//nccG1ETEGMtWpACHKPXCQSGezro4Hw6qzNnOkAm1BmJAj5tbk8qhMWJG9mIvMF
         FqRrTKcxtCtgd+dLhHQF5Ei/Kgzpt3X1h2np8=
Received: by 10.210.35.10 with SMTP id i10mr10116895ebi.93.1247705395870;
        Wed, 15 Jul 2009 17:49:55 -0700 (PDT)
Received: from @ (91-164-136-30.rev.libertysurf.net [91.164.136.30])
        by mx.google.com with ESMTPS id 5sm1503886eyf.58.2009.07.15.17.49.54
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 15 Jul 2009 17:49:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1voheevy.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123348>

The 15/07/09, Junio C Hamano wrote:

> I think you did not understand the point of the three liner I sent you.
> 
> 	sed -e '/^$/q' -e '/^[ 	]/d' "$1" |

I'll change it to

 	sed -e '/^$/q' -e '/^[[:blank:]]/d' "$1" |

to conform to reality (and the paragraph 3.4.2 of the RFC 822).

>     The point of this is not to use the silly "we only look at the first
>     three lines" rule.  Instead, it ignores these l1/l2/l3, but grabs all
>     the header lines, but discards second and subsequent physical lines if
>     a logical line was folded.  Which means that the effect of this is to
>     pipe the whole header (again, without worrying about the indented
>     remainder of folded lines) to downsream, which is the grep -v below
> 
>         grep -v -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null ||
>
>     This checks if there is a line that does _NOT_ match the usual
>     e-mail header pattern.  If there is such a line, it means that the
>     file is not an e-mail message.  If there is no such line, we say...

I don't see the reason to have the option -v. It's only related to
what's printed to output and doesn't change the exit status which
tell us if an expression has matched.

This gives:

   grep -E -e '^[A-Za-z]+(-[A-Za-z]+)*:' >/dev/null &&
   patch_format=mbox

> One caveat is that the above logic alone won't catch a random file that
> does not have _any_ e-mail headers in it.  So you might need to do
> something like:
> 
> 	LF='
>         '
> 	case "$l1$LF$l2$LF$l3" in
>         *"$LF$LF"*)
>         	# has a completely empty line in there?
>                 # that means the message has only two headers at most;
>                 # that cannot be an email.
> 		;;

I think we can strip this part. The purpose is to accept what _may_ be a
patch. Any wrong patch or random file will be rejected later.

-- 
Nicolas Sebrecht

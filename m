From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 1.7.2 cycle will open soon
Date: Thu, 6 May 2010 01:44:28 -0500
Message-ID: <20100506064428.GA29360@progeny.tock>
References: <7vaaselxe8.fsf@alter.siamese.dyndns.org>
 <20100506055236.GA16151@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 06 08:44:16 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9uoh-0003cn-7v
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 08:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753331Ab0EFGn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 02:43:57 -0400
Received: from mail-yw0-f198.google.com ([209.85.211.198]:43261 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608Ab0EFGn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 02:43:56 -0400
Received: by ywh36 with SMTP id 36so2654410ywh.4
        for <git@vger.kernel.org>; Wed, 05 May 2010 23:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=sChX2PeTs7cxrscG7XYZ88I6DfqKuvhvm4L3Zr8zRs4=;
        b=J8jhXFCz7LYBxdNM5B2jdjDztfBM0HXl9yr6m2CJJGVGxVNe7RAmlY9c2q949MHbTQ
         QFlKqyjQQ2u7NryiCfs6wP8nbHrMEAEpvt2J9yaZs8zmr1lozoGXjyG8sfcuTCAox95N
         8uNimgO9ondYCl8b+pMqxLkYp2RvGGUDQsa1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=CbshB7P3VxoYrvUIbZruBGTMe7qkwZZef+1QvvGH4NfQbRYMcYhztZhren6CSP6rDZ
         AjZSxZLcdN4z+kYGwCqjqSfs0WNK/btS8d7OCuAlUkJHTpTnU4MaADMK2h654EXCmZDa
         1nq361KihhYGxW4AZJI0Yo+n8Q8YxhSLtCuU0=
Received: by 10.100.24.27 with SMTP id 27mr7442053anx.94.1273128235879;
        Wed, 05 May 2010 23:43:55 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm539423iwn.3.2010.05.05.23.43.54
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 05 May 2010 23:43:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100506055236.GA16151@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146446>

Jeff King wrote:

> FreeBSD's /bin/sh doesn't propagate $? over an eval

Thanks for tracking it down.

> Looking at that patch, I don't see any reason that eval_ret needs to be
> set inside the eval. If we have multiple test_when_finished calls, we
> keep setting and propagating eval_ret, which doesn't make much sense to
> me.  Why not just:
> 
>   test_run_ () {
>     test_cleanup=
>     eval >&3 2>&4 "$1"
>     eval_ret=$?
>     eval >&3 2>&4 "$test_cleanup"
>     return 0
>   }
> 
>   test_when_finished () {
>     test_cleanup="$*; $test_cleanup"
>   }
> 
> Am I missing something?

If cleanup fails, I want to catch it.  Would something like this do?

 test_run_ () {
	test_cleanup=:
	eval >&3 2>&4 "$1"
	eval_ret=$?
	eval >&3 2>&4 "$test_cleanup" && (exit "$eval_ret")
	eval_ret=$?
	return 0
 }

 test_when_finished () {
	test_cleanup="$* && $test_cleanup"
 }

To permit a line break at the end of a cleanup command, one can do

 test_when_finished () {
	test_cleanup="{ $*
		} && $test_cleanup"
 }

but that might not be worth the ugliness.

Jonathan

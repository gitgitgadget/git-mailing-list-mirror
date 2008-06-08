From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] provide a new "theirs" strategy, useful for rebase --onto
Date: Sun, 08 Jun 2008 16:06:33 -0700
Message-ID: <484C65F9.10007@gnu.org>
References: <E1K4a1Q-0002hq-QE@fencepost.gnu.org> <7vfxrqrwjm.fsf@gitster.siamese.dyndns.org> <484B49D5.8080708@gnu.org> <7vmylwl4t9.fsf@gitster.siamese.dyndns.org> <484BE0BE.1050102@gnu.org> <7vk5gziqxn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, s-beyer@gmx.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 01:07:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5Tz6-00054w-J6
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 01:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755717AbYFHXGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 19:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755745AbYFHXGm
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 19:06:42 -0400
Received: from ag-out-0708.google.com ([72.14.246.244]:45717 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755632AbYFHXGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 19:06:41 -0400
Received: by ag-out-0708.google.com with SMTP id 31so4622862agc.10
        for <git@vger.kernel.org>; Sun, 08 Jun 2008 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=bJl/XWhlmAnWahMP8eyiCpKOEWzQ+G7VlAmaIM5ojOQ=;
        b=iv8i1FPekmmNJYWH6/EEJ7aTSD1Fq95xBmAYnYcRGNpmJtMHNOWa6t2C3tOzEw6/oz
         0P+HJkA3h6K6a7cMvtMSGqYCXcexSQnHTm+E6J1cdLuspD1w3huWQYV8sQa4wmY+RbfK
         51jTvZI0o1AyVId54EFv+r0Pk5OROvNH7neoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=Ks1G2kQW0hDuEKgPXGK6ytvne09uy5R+6bF7qe7g3Pw9CO1Ccd2PJlts/9X59hgV/F
         ASzPFPeg1CKSVIjnuwmvgXznbsYuhnzwYPgYiF/nHoWby42yS6eX1GDcHRksxXh7YwAP
         DXxxEY5jGSZSyasbBqUrnpdm2LPvTfzhoU0dY=
Received: by 10.151.145.21 with SMTP id x21mr5083716ybn.66.1212966397625;
        Sun, 08 Jun 2008 16:06:37 -0700 (PDT)
Received: from scientist-2.local ( [66.78.193.43])
        by mx.google.com with ESMTPS id u62sm12388631pyb.23.2008.06.08.16.06.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Jun 2008 16:06:36 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <7vk5gziqxn.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84341>

Junio C Hamano wrote:
> Paolo Bonzini <bonzini@gnu.org> writes:
> 
>>    #! /bin/sh
>>    # git-merge-after-amend <branch>
>>    #
>>    # Makes it possible to do a fast-forward merge of <branch>
>>    # into HEAD, assuming that the first diverging commit of <branch>
>>    # is an --amend'ed version of the first diverging commit of HEAD.
> 
> Can this strong special case limitation "only the first one can be the
> amend" somehow be loosened?

Well, the point of the exercise is to split a *single* commit into a 
"base" commit (already available, possibly on another branch) and a 
"delta" (the amending, transformed into an independent commit whose 
parent is the "base").  Indeed you can do that for any commit.

The script uses the "git-merge-base" to compute the "base", and takes 
the following commit (on the path to HEAD) as the "delta".  That's what 
add the restriction.  You can definitely make a two-argument variation 
that, given arguments "B C" and history

     o--B     (it is irrelevant if B and C have common parents)

     o--o--C--D--E    HEAD

makes

     A--B--C'--D--E

Even in that case, I would make the script (which anyway is obviously 
not meant to be included in git, it's a commodity script) accept both 
variations: one-argument to do the special case, and two-arguments to 
generically split a commit into a base provided by the user + a delta.

Paolo

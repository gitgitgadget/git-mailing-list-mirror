From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v2 2/2] check-ignore.c, dir.c: fix segfault with '.'
 argument from repo root
Date: Wed, 20 Feb 2013 01:57:24 +0000
Message-ID: <20130220015723.GB7860@pacific.linksys.moosehall>
References: <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <1361301696-11307-1-git-send-email-git@adamspiers.org>
 <7vzjz03wid.fsf@alter.siamese.dyndns.org>
 <7vfw0s3qsq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Zoltan Klinger <zoltan.klinger@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 02:57:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7ywQ-0002fn-7m
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 02:57:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934153Ab3BTB50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 20:57:26 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:33723 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933578Ab3BTB5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 20:57:25 -0500
Received: from localhost (c.2.7.1.0.6.0.3.6.a.7.2.5.6.9.7.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:7965:27a6:3060:172c])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 9764C55AFA;
	Wed, 20 Feb 2013 01:57:24 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vfw0s3qsq.fsf@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216672>

On Tue, Feb 19, 2013 at 02:03:01PM -0800, Junio C Hamano wrote:
> I started to suspect that may be the right approach.  Why not do this?
> 
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Tue, 19 Feb 2013 11:56:44 -0800
> Subject: [PATCH] name-hash: allow hashing an empty string
> 
> Usually we do not pass an empty string to the function hash_name()
> because we almost always ask for hash values for a path that is a
> candidate to be added to the index. However, check-ignore (and most
> likely check-attr, but I didn't check) apparently has a callchain
> to ask the hash value for an empty path when it was given a "." from
> the top-level directory to ask "Is the path . excluded by default?"

According to a single gdb run, 'git check-attr -a .' does not hit
hash_name() for me.  However that naive experiment doesn't rule out
the possibility of it happening if the right attributes are set, but I
don't know enough about that code to comment.

> Make sure that hash_name() does not overrun the end of the given
> pathname even when it is empty.
> 
> Remove a sweep-the-issue-under-the-rug conditional in check-ignore
> that avoided to pass an empty string to the callchain while at it.
> It is a valid question to ask for check-ignore if the top-level is
> set to be ignored by default, even though the answer is most likely

Hmm, I see very little difference between the use of "most likely" and
the use of the words "much" and "typically" which you previously
considered "a sure sign that the design of the fix is iffy".

> no, if only because there is currently no way to specify such an
> entry in the .gitignore file. But it is an unusual thing to ask and
> it is not worth optimizing for it by special casing at the top level
> of the call chain.

Although I agree with your proposed patch's sentiment of avoiding
sweeping this corner case under the rug, 'check-ignore .' still
wouldn't match anything if for example './' was a supported mechanism
for ignoring the top level.  So, modulo the obvious advantages that
defensive coding in hash_name() bring, I'm struggling to see a
significant difference between any of the three patches proposed so
far.  All of them fix the segfault, and all would require the same
amount of extra work in order to support matching against './'.

But I don't have any strong objections either, so you have my approval
for whichever patch you prefer to take.  Thanks.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 2/2] Verify index file before we opportunistically update it
Date: Fri, 11 Apr 2014 21:19:57 -0700
Message-ID: <7vmwfrmb6a.fsf@alter.siamese.dyndns.org>
References: <1397081197-14803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397154681-31803-1-git-send-email-yiannis.marangos@gmail.com>
	<1397154681-31803-2-git-send-email-yiannis.marangos@gmail.com>
	<xmqqppkpvv9m.fsf@gitster.dls.corp.google.com>
	<CACsJy8A5VJM4gnJGazkzniv5YxRx0xR7YEFpQbU+kVGofQ1b_g@mail.gmail.com>
	<xmqqtx9zsm8p.fsf@gitster.dls.corp.google.com>
	<xmqqmwfrr3zw.fsf@gitster.dls.corp.google.com>
	<CACsJy8ASAvopmyhawmUkuFk4DjBd2opL1kxu_jtopTDr80BWPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yiannis Marangos <yiannis.marangos@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 06:18:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYpP2-0001Tx-2L
	for gcvg-git-2@plane.gmane.org; Sat, 12 Apr 2014 06:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbaDLESn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 00:18:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35504 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750930AbaDLES0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 00:18:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3D456F330;
	Sat, 12 Apr 2014 00:18:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5jo3XQqAANkZ9/3bkj5qLP0LIkg=; b=Q8O298
	AYs/NIs6EkS8DchFcMxSSRwDvTawEkTiPxldOWxuPK9CJGswAvFhhCHsCJmBAkvz
	wzq40W9wAU0P8pWHAef942/q8ByawfM432QeC761Tb3K85nNRrR0ikAioaWB90Vh
	gM7uJwlu2iYeetihO36fmlakUDyx3guozbBX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Z+zoPzEZb0GbdxujsXLTBMnuEyb/Bjta
	Kbx4Wn+2MOsiUs2Mc0l4j2OZWaGWt2g8FlcICwMRaDTIJlOVc55uDPt/pbHZppE4
	K8gEzYE+17s25iFwVUgW+WWDl71xppQPO8p+EBycDJkd7A3w8dEyQIhApzv+2u9H
	7R32sM2FGLk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EA3C6F32F;
	Sat, 12 Apr 2014 00:18:25 -0400 (EDT)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B64E6F32C;
	Sat, 12 Apr 2014 00:18:23 -0400 (EDT)
In-Reply-To: <CACsJy8ASAvopmyhawmUkuFk4DjBd2opL1kxu_jtopTDr80BWPg@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 12 Apr 2014 07:10:18 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 7D159992-C1F9-11E3-8B55-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246161>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Apr 12, 2014 at 3:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Having said that, nobody sane would be running two simultaneous
>> operations that are clearly write-oriented competing with each other
>> against the same index file.
>
> When it comes to racing, sanity does not matter much. People could
> just do it without thinking what exactly is happening behind the
> scene.

Well, "a race is a race is a race" would also be my knee-jerk
reaction when anybody utters the word "race", but you need to
realize that we are not talking about races like object creation
while "gc --auto" running in the background or two pushes trying to
update the same ref to different values, which are meaningful use
cases.

What is the race under discussion about?  It is about the index,
which corresponds one-to-one to the working tree, so in order for
the "race" to matter, you need to be racing against another process
that is not cooperating with you (e.g. a continuous and uncontrolled
"git add" updating the index while you are doing a real work),
mucking with the index in the same working tree.  How could such a
workflow any useful in the real life?

In the spectrum between useful and insane, there is a point where we
should just tell the insane: don't do it then.

Having said that...

>> So in that sense that can be done as a less urgent follow-up for this topic.
>
> Yeah if racing at refresh time is a real problem, sure we should solve it first.

... In order to solve the write-vs-write competition in a useful
way, you must serialize the competing accesses.  E.g. "git add"
would first take a write lock on the index before read_cache(), and
then do its operation and finally release the lock by the usual
write-to-lock-close-then-rename dance.

The lazy "read and refresh in-core first, hoping that we did not
compete with anybody, and then check just before writing out after
taking the lock" is a very good solution for the opportunistic
update codepath, because it is an option not to write the result out
when there actually was an update by somebody else.  But such an
opportunistic locking scheme does not work for write-vs-write
competition.  Upon a real conflict, you need to fail the entire
operation.

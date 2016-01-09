From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should notes handle replace commits?
Date: Fri, 08 Jan 2016 16:13:02 -0800
Message-ID: <xmqqvb73zk35.fsf@gitster.mtv.corp.google.com>
References: <20160108012830.GA2110@glandium.org>
	<xmqqh9in25py.fsf@gitster.mtv.corp.google.com>
	<20160108214939.GA22801@glandium.org>
	<xmqqziwfzl2s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sat Jan 09 01:13:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHh9y-0008Cy-9K
	for gcvg-git-2@plane.gmane.org; Sat, 09 Jan 2016 01:13:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752271AbcAIANH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Jan 2016 19:13:07 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58478 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750870AbcAIANF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jan 2016 19:13:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C19623A582;
	Fri,  8 Jan 2016 19:13:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=09lH1+uFeFI0fS0gg+lICoZdC6Q=; b=BU0ZF7
	n0/cvyUvxtdFuA8StS0tXQJo/N1WIVw1KHVm0EyRvJUd5WPvAU6oNce1ww3/cE8B
	urHQ2WaNFNUd2bccUikmtOdr9y5uTnrianqzlHZnWX3wgfAdhDod496SA4dyrjLM
	N9W9Q+HJyRwjhXL1AFMY2xqIvt2lhr89zKhxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NNFEA5msHtoLnSsvyH8KQxro1DRog0eC
	5dcbD0je45SeDgXFgEYx66LT1w+Xkj2+XIIOcdwZGqR7Z+Epl+B03ZFKDMfV0A++
	dy3K1R76yywALRJHeulWMbOSOZmjTt/GgfONuFkr7Ts86OVrXKmoZ4URbesDeP3r
	DCxsnq2JWG0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B88393A581;
	Fri,  8 Jan 2016 19:13:04 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 393F03A57F;
	Fri,  8 Jan 2016 19:13:04 -0500 (EST)
In-Reply-To: <xmqqziwfzl2s.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 08 Jan 2016 15:51:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C0840CB0-B665-11E5-A2DB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283590>

Junio C Hamano <gitster@pobox.com> writes:

> Perhaps you would see what is going on more clearly if you replace
> your "git log" with "git rev-list".
>
> If your pre-graft/pre-replace histories were
>
> 	A (first)  <--- B (second)  <--- C (third)	master
> 	X (rFirst) <--- Y (rSecond) <--- Z (rThird)	old
>
> then your "graft" tells Git "B's parent is Z, not A.  If you run
> "rev-list master", it will give you "C B Z Y X".  The discrepancy
> (relative to the true history) brought in by "grafting" is that
> nowhere in "cat-file commit B" you would find Z, even though "log"
> and "rev-list" pretends as if Z is a (and the) parent of B.
>
> Your "replace" tells Git "A records what Z records".  If you run
> "rev-list master", it will give you "C B A Y X".
>
> A fake history made by "replace" does not have the same discrepancy
> as "grafting"; "cat-file commit B" names A as its parent, and asking
> what A is gives what actually is in Z, i.e. "cat-file commit A"
> shows what "cat-file commit Z" would give you.  The discrepancy with
> the reality "replacing" gives you is that hashing what you got from
> "cat-file commit A" does not hash to A (it obviously has to hash to
> Z).
>
>> From my POV, replace is more about
>> "telling Git that this commit (and its parents) is really that one (and
>> its parents)".
>
> Your "POV" does not match reality; replace is about telling Git to
> give contents recorded for object Z when anybody asks the contents
> recorded for object A.

To put it differently, what you did in your two examples with graft
and replace are not equivalent.  With graft, you told commit B that
its parent is not commit A but commit Z.  If you wanted to do the
equivalent with replace, you would have replaced commit B with an
otherwise identical commit B' that records Z as its parent.  But you
didn't; instead, you replaced commit A with Z.

And if you did the equivalent with "replace", your "git rev-list"
would have shown "C B Z Y X" (instead of "C B A Y X"), and when "git
log" showed the second commit, it would have shown the contents of B'
_and_ because Git still thinks it is showing the original B, it
would have shown the notes for B.

Something like this (totally untested) would let you replace B with
an otherwise identical B' that has Z instead of A as its parent:

    $ Bprime=$(git cat-file commit master~ |
             sed -e "s/^parent .*/parent $(git rev-parse old)/" |
             git hash-object -w --stdin -t commit)

    $ git update-ref refs/replace/$(git rev-parse master~) $Bprime

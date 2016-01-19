From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issue when changing staged files in a pre-commit hook
Date: Tue, 19 Jan 2016 15:41:17 -0800
Message-ID: <xmqqwpr56ste.fsf@gitster.mtv.corp.google.com>
References: <CAPYEnzGfnRbajDQAwBTNE5XSaB0WbHKbf1heRV0bUgbq5w_A5g@mail.gmail.com>
	<CACsJy8DhiYiie7+Cw3PkPJpSX7CGp-r2Mu98mLp4OMhhGdsXgQ@mail.gmail.com>
	<xmqq1t9dbe9y.fsf@gitster.mtv.corp.google.com>
	<CACsJy8DxQnGV5JZnHuvA1Zbpf2BuGdmMF+YNiq51HNK+8vW56Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Niek van der Kooy <niekvanderkooy@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 00:41:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLfts-0000Fw-2q
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 00:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285AbcASXlV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 18:41:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60034 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756908AbcASXlT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 18:41:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3278A3DC46;
	Tue, 19 Jan 2016 18:41:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5pbv9harlJF0DImGeWrwva4JZnQ=; b=tNioLl
	okbk7k01W19ON3gkjM/IQmmir0TnogWW+p09nD0L8Oxt8Z6Xg4HbJvJqDKhnxw/V
	9dIil1TNHIN/OnGQeJC5Ap7i9gg+zqaeA8r2BOM4KD8uazTWtxdyQAjqqyBCI79v
	199lv90e1Sl/T2sfz69Fdf9X+JDoFTUnqnyCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mu6Te4sJUTITM11feG6nZvoTTcAEH18B
	r4wNPQgDhnaDJkJAUy4c4ytdzLrfjhaK7HTEH4up/ODScMcKQE4S1zeC9jZEfxDw
	zqw7LjMlxixKTRl3/HewrS0xj9DlJaeSeeEehFXD5hGnJLo9mADftEzLDHBCWejx
	hpERE2eWrMA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 29D1D3DC45;
	Tue, 19 Jan 2016 18:41:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A1FF53DC44;
	Tue, 19 Jan 2016 18:41:18 -0500 (EST)
In-Reply-To: <CACsJy8DxQnGV5JZnHuvA1Zbpf2BuGdmMF+YNiq51HNK+8vW56Q@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 20 Jan 2016 06:26:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 23402516-BF06-11E5-B5B1-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284400>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Jan 20, 2016 at 1:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> I think it's the intended behavior.
>>
>> Yeah, pre-commit was designed for inspecting and rejecting, not for
>> tweaking and munging.  Perhaps "git commit" can be tightened to make
>> sure that pre-commit that returns successfully did not muck with the
>> working tree and the index?
>
> That was my impression from the docs, but then I saw this comment,
>
> /*
> * Re-read the index as pre-commit hook could have updated it,
> * and write it out as a tree.  We must do this before we invoke
> * the editor and after we invoke run_status above.
> */
>
> which comes from 2888605 (builtin-commit: fix partial-commit support -
> 2007-11-18) that admits "the hook can modify it (the index)". And I
> was about to update the docs, but the other way around, about updating
> index and side effects.

I do not think the comment is wrong per-se, but the code we have,
either back then or even today, is insufficient to allow pre-commit
hook that mucks with the fake index that is shown to it.

Re-reading the in-core index at that point may help creating a
commit whose tree matches what the hook did, but the extra change
made by the hook is not ported forward in the real index that the
user will use after a partial commit (and there is no easy way to do
so cleanly--the change the hook makes may even overlap the change in
the real index that are added but left uncommitted, and you would
end up needing to run a threeway merge).

The only sensible thing we can do at that point in the code after
re-reading the index is to make sure that hasn't been changed by the
pre-commit hook and complain loudly to die if we find it modified, I
think.

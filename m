From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] unpack-trees: do not abort when overwriting an
 existing file with the same content
Date: Mon, 21 Jan 2013 17:45:05 -0800
Message-ID: <7vwqv6c7oe.fsf@alter.siamese.dyndns.org>
References: <1358594648-26851-1-git-send-email-pclouds@gmail.com>
 <1358768433-26096-1-git-send-email-pclouds@gmail.com>
 <20130121231515.GD17156@sigill.intra.peff.net>
 <CACsJy8AFKXYkHbUf4aqBpCg+v06oFsvHq_zxQFE4BOCzTDAqtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:45:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TxSvn-0000jQ-2m
	for gcvg-git-2@plane.gmane.org; Tue, 22 Jan 2013 02:45:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162Ab3AVBpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2013 20:45:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65004 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635Ab3AVBpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2013 20:45:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 547DCBC7D;
	Mon, 21 Jan 2013 20:45:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/fxmGtCdv0DsEe+HF2O2NjP6ur8=; b=LHyeKX
	qNbH7YYYmT3tf1MP/NMPsV3KCAMS21pePd3jeUAvU+YqBv8ElmIOOnrxaeeqOZjO
	+CPLNbTKKD2ps9xSrCoCJrcAvrMfqKJnV/58Y3z2PO0P6jS3rYPvVEpY8IDR2LRZ
	eD+ozXlMH3iyZlLoxdLpBZtTeWJ1e8iRAiE8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jc8pNAkZFVeCxffBbpzZdGoIuX2ah+56
	s21SiUNQP92p5Qk4c/Kpr//IVrgKqBGyPs9ZtPVMS6u7SRK08TR+XSXxec64vDKF
	TQhVU3hiGaYF8iYaXX2RfDOhO17wuTyQgzeO7De7XwIj/zMvBDu6cqkjT6OwGIDX
	aD/sUhqPHDA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 489A1BC7C;
	Mon, 21 Jan 2013 20:45:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EE63BC75; Mon, 21 Jan 2013
 20:45:07 -0500 (EST)
In-Reply-To: <CACsJy8AFKXYkHbUf4aqBpCg+v06oFsvHq_zxQFE4BOCzTDAqtg@mail.gmail.com> (Duy
 Nguyen's message of "Tue, 22 Jan 2013 07:59:01 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 59C3EBE2-6435-11E2-81FB-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214185>

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Jan 22, 2013 at 6:15 AM, Jeff King <peff@peff.net> wrote:
>> Can you elaborate on when this code is triggered?
>>
>> In the general case, shouldn't we already know the sha1 of what's on
>> disk in the index, and be able to just compare the hashes? And if we
>> don't, because the entry is start-dirty, should we be updating it
>> (possibly earlier, so we do not even get into the "need to write" code
>> path) instead of doing this ad-hoc byte comparison?

If the index knows what is in the working tree, I think I agree.

>> Confused...
>
> git reset HEAD~10
> # blah that was a mistake, undo it
> git checkout HEAD@{1}
>
> I hit it a few times, probably not with the exact recipe above though.

I've seen myself doing "git reset HEAD~10" by mistake (I wanted "--hard"),
but the recovery is to do "git reset --hard @{1}" and then come back
with "git reset --hard HEAD~10", so it hasn't been a real problem
for me.

A case similar to this is already covered by a special case of
two-tree read-tree where the index already matches the tree we are
checking out even though it is different from HEAD; in other words,
if you did this:

        git init
        date >file
        git add file; git commit -m 'has a file'
        git checkout -b side
        git rm file; git commit -m 'does not have the file'
        git checkout master file
	: now index has the file from 'master' and worktree is clean
        git checkout master

you shouldn't get any complaint, I think.

If you did "git rm --cached file" to lose it from the index,
immediately after "git checkout master file", then we wouldn't know
what we may be losing.  If the file in the working tree happens to
match the index and the HEAD after checking out the other branch
('master' in this case), it is _not_ losing information, so we might
be able to treat it as an extension of the existing special case.

I haven't thought things through to see if in a more general case
that this codepath triggers we might be losing a local changes that
we should be carrying forward while checking out a new branch,
though.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] fast-import: only store commit objects
Date: Fri, 03 May 2013 15:08:43 -0700
Message-ID: <7v61yzyavo.fsf@alter.siamese.dyndns.org>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
	<1367555502-4706-5-git-send-email-felipe.contreras@gmail.com>
	<87y5bw3q1s.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>, Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sat May 04 00:08:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYO9r-0004o3-2T
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 00:08:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934289Ab3ECWIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 18:08:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39725 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752034Ab3ECWIq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 18:08:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D2DE1C117;
	Fri,  3 May 2013 22:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3tW78nqm4qjLIiiY7sv2i0b0wM4=; b=EWBi59
	TMAu0k0KrVf0LVch0JAcnfxuoc6cx4+xJwWwYdzzLHGEQseZnV04cH564l1FHlh9
	9S7Abct942IxqyUeUI1ARfWGbgbyn+FgM1H9PokHpFj1l0ZyJwgWW9VoW5UhLLGH
	pyeInxdlJHi8HvDQ09usjoED1p3GFM0TsNzWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QJYvzxuC5oCepmXNvqIm8fmS/L5Dh9Yb
	wB5PpywbIRhN+3pEGRa76xlrfB7Qi6EjYZZwd1DVfGa9RsYPrE2wsJcIIXrHNPpf
	WwbSAZLXzaEiZeJLSsaJ3LSHP4LEIW98Uo5hbVkLZwHVRH9lzTzZwpXsjT7cVqjj
	g9/hiHcrLDk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8008D1C116;
	Fri,  3 May 2013 22:08:45 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1A871C115;
	Fri,  3 May 2013 22:08:44 +0000 (UTC)
In-Reply-To: <87y5bw3q1s.fsf@hexa.v.cablecom.net> (Thomas Rast's message of
	"Fri, 3 May 2013 19:56:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 058D710C-B43E-11E2-BDE2-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223327>

Thomas Rast <trast@inf.ethz.ch> writes:

> IIUC, you are unconditionally storing only marks to commit objects.
>
> Are you allowed to do that at this point?  I notice that
> git-fast-export(1) says
>
>    --export-marks=<file>
>        Dumps the internal marks table to <file> when complete. Marks are
>        written one per line as :markid SHA-1. Only marks for revisions
>        are dumped[...]
>
> But git-fast-import(1) says nothing of the sort; I would even claim that
>
>    --export-marks=<file>
>        Dumps the internal marks table to <file> when complete.
>
> means that the *full* marks table is dumped.
>
> How do we know that this doesn't break any users of fast-import?  Your
> comment isn't very reassuring:
>
>> the vast majority of them will never be used again
>
> So what's with the minority?
>
> In any case, if this does go in, please update the documentation to
> match, probably by copying the sentence from git-fast-export(1).

A safe and sane approach may be to teach these an option to tell
them to omit non-commits or to emit all kinds, and make remote-bzr
use that to exclude non-commits.  If the defaults is matched to the
current behaviour, nobody will get hurt, and Felipe's Emacs import,
knowing that it does not need marks to blobs, can take advantage of
the new feature.

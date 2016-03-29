From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 6/7] correct blame for files commited with CRLF
Date: Tue, 29 Mar 2016 13:50:18 -0700
Message-ID: <xmqq60w5vwj9.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1459257938-17389-1-git-send-email-tboegi@web.de>
	<xmqqa8lhyzbq.fsf@gitster.mtv.corp.google.com>
	<56FADCAB.1010201@web.de>
	<xmqqio05vxo9.fsf@gitster.mtv.corp.google.com>
	<xmqqa8lhvxd4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 29 22:50:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al0ap-0005r3-RI
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 22:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754314AbcC2UuX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 16:50:23 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:57892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753794AbcC2UuW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 16:50:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C74C050A5B;
	Tue, 29 Mar 2016 16:50:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=raaUPG9cy8FV
	gVPhelxnmRJL+0U=; b=D/y2rg4ZxWEFFAzhear2pyRLzeoRhQPdBVWez186wJVc
	cZVT7TpEJI15dzfZnRcq6ulM5WRt/CEG/Omh9deb0YW7hqhdqHJP2OdhOAol6LJi
	sKP4OfZdjZutdUd8hzedJ1rt1Wa4cQ8XN3N1h2lwr8cz929Kegl/IQF7DUbTNe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tdafgp
	9iHjDEOQfIom7ZbO7cfd55H6FH9Ba+8A28EklvX4g8ofpzuZ/h1FXEYM6gn7VStu
	zbwuh/UlRpG7tP8AZv1D2RqM3izthfaJ05Cxi2ou4noygD6bSOuj/AcgI3xnXVjW
	FVWdDlPAZLTuly6RxZx+RGlS6YmIV4ByRutWg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BE1A550A5A;
	Tue, 29 Mar 2016 16:50:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3F38E50A59;
	Tue, 29 Mar 2016 16:50:20 -0400 (EDT)
In-Reply-To: <xmqqa8lhvxd4.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 29 Mar 2016 13:32:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D9AE1072-F5EF-11E5-A724-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290193>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>
>>> If we had made the CRLF -> LF conversion, yes. But we don't do that=
=2E
>>> crlf_to_git() returns without touching the line endings.
>>
>> That sounds quite broken.  How would a user ever fix broken data in
>> the index then?  I know the commit that often appears in these
>> discussions claims to give us "safer CRLF" handling, but I have a
>> suspicion that perhaps we should rethink if that claim is really
>> true.  Isn't it giving us more problems than it is worth?
>
> Having said all that, within the context of the current codebase
> where autocrlf refuses to do the conversion, I agree that teaching
> blame to follow the same logic makes sense.  Let me review the
> series up to 6/7 with fresh eyes.

And for the same reason 7/7 may make sense (I didn't check the
implementation, but I think I understand your motivation well enough
to comment)--if crlf-to-git returns without actually converting upon
next "git add $path", in order to serve a preview of what change you
would be checking in and/or committing when you do "git add $path"
and/or "git commit $path", the _to_git() conversion "git diff" and
"git diff HEAD" do on the contents taken from the working tree
should follow the same logic.

"git diff $tree-ish" (of which "git diff HEAD" is a special case) is
a bit tricky to reason about, but I think using the "does index have
CR to cause us refuse conversion?" logic is a sensible thing to do
even in that case.  It is asking what difference you would have if
you committed the state in the working tree right now, and the "does
index have CR?" logic to kick in, even though the contents of the
index may not be something that was derived from the unrelated
$tree-ish, would kick in when you make the hypothetical commit to be
compared against $tree-ish.

Again, let me review 7/7 as well with fresh eyes.

Thanks.

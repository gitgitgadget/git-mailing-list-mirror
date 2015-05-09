From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t0025 weird behaviour on NonStop ksh/bash
Date: Fri, 08 May 2015 19:50:50 -0700
Message-ID: <xmqqbnhuihv9.fsf@gitster.dls.corp.google.com>
References: <003101d089e5$27347610$759d6230$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: "Randall S. Becker" <rsbecker@nexbridge.com>
X-From: git-owner@vger.kernel.org Sat May 09 04:51:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yquqx-000628-L4
	for gcvg-git-2@plane.gmane.org; Sat, 09 May 2015 04:51:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbbEICuy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 22:50:54 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751568AbbEICuy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 22:50:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5ECFA50E7A;
	Fri,  8 May 2015 22:50:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6meVxHkcmqMxMmtl6j2eS/WG/4E=; b=uGrr2i
	1HQLbeOTsnwW7tWQGu/apRFd7wH490Y2HHnzF8o26h+AKQ4DFm1uEfItGEfmDZbD
	jnvSis/8od/xr/tSD+B+v3+BaK1UerxIdxnZAo2Ak/Hlm2TUWmCbb0wt/rs1p2mZ
	rsV1kcuNsrmKl2raLLtAtm3lzhVz89kpuZ2ZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xr6boa7ncx1ES46wlmBgqTW+NfLHTskv
	wC1IBemzZzeSdN2IeCs9Hje/dn/TA2DnwnVpzL9K85gcAilCrdGTaCeozhZVvKYQ
	Pf+SUu0StOPkGTsKTfPOZJVZ/LBhsq7lZruyo1uin2qCYIt3hU2rz5GPQvts4kku
	9lzKEfxE/uM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 577B150E79;
	Fri,  8 May 2015 22:50:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE20550E78;
	Fri,  8 May 2015 22:50:52 -0400 (EDT)
In-Reply-To: <003101d089e5$27347610$759d6230$@nexbridge.com> (Randall
	S. Becker's message of "Fri, 8 May 2015 19:17:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 350A24C4-F5F6-11E4-9E8B-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268693>

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> Ok, I'm sure that this is not a git problem, but there is an assumption
> about echo behaviour in t0025 that may not be correct. When executed from a
> shell function on the HP NonStop platform under ksh and bash, the LFonly
> file annoyingly contains cr-lf not just lf. This causes sub-test 4 to fail.
> Weirdly, this does not happen from an interactive shell. My proposed
> solution, in t0025-crlf-auto.sh, to this is to make it explicit that bad
> behaviour on the part of echo should be dealt with severely, as in:
>
>         for w in Hello world how are you; do echo $w; done | tr -d '\r'
>>LFonly
>
> instead of 
>
>         for w in Hello world how are you; do echo $w; done >LFonly
>
> which is a no-op on platforms that behave themselves in this situation. Is
> this the proper approach?

Why on earth does "echo $w" that prints just ASCII alphabet and
nothing else (other than the end-of-line, of course) gives CRLF
in the first place?

Is stripping with "tr -d" a sane approach?  I am not sure if it is
tackling the right problem.

Because we use 'echo', expecting it to behave sensibly in many other
places, wouldn't it be the case that all your 'tr -d' here does is
to add an unnecessary pipe on sane platforms for this single test
script, while leaving all the other uses of 'echo' in other shell
scripts, including scripted Porcelains like 'git pull', broken on
your platform?

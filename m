From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Adding "--ignore-submodules" switch to git-describe
Date: Fri, 01 Mar 2013 09:46:26 -0800
Message-ID: <7v621bggi5.fsf@alter.siamese.dyndns.org>
References: <CAC9WiBjHEoX154Y2q1NxEB1my78Gqf__+v-KR5jNVqT-MN9ZaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 01 18:46:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBU2r-00036u-Bw
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 18:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656Ab3CARqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 12:46:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49614 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080Ab3CARq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 12:46:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A80B6AF11;
	Fri,  1 Mar 2013 12:46:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wmZNm6MMtTtcg8joHN4SrLYFZLE=; b=pJqmMx
	/U0HpG8wpJk1+8h2oB+r8w0vw9hKVYYZV85k5INN4w/NB/Qv21uBrPfpPEs2yalG
	7M0Q3BclsZ+huUpbxgD7DyDQmGvy+qxC7XM7+RyWu6tJwVu2SqLRy0sX2NLFkehW
	DOiJEs+rmUEoOxVhCGpM+Td2zOU6kGbqyXXaA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oj7RgzkJwJFALEzx54cSIyNmtCZ5Isy3
	Y9pqIuLfAajomldtaPzj0gDgmsMDutDxJb3yO8/INVbWu03azjP6imI5CMQNTAGB
	k7bUMRPGXPD1JL2R8IRketG2lb4arLH2S9V+jfAx8d1EtUocYZN2OHAFivLRgDqm
	UuxCExIYZUQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D13BAF10;
	Fri,  1 Mar 2013 12:46:28 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E88C6AF0F; Fri,  1 Mar 2013
 12:46:27 -0500 (EST)
In-Reply-To: <CAC9WiBjHEoX154Y2q1NxEB1my78Gqf__+v-KR5jNVqT-MN9ZaQ@mail.gmail.com> (Francis
 Moreau's message of "Fri, 1 Mar 2013 11:16:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F199EDB0-8297-11E2-B622-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217284>

Francis Moreau <francis.moro@gmail.com> writes:

> Would it make sense to add the option --ignore-submodules (currently
> available in git-status) to git-describe when the later is used with
> --dirty option ?

I think the spirit of "describe --dirty" is to allow people who
gives out binaries this assurance:

	The version string I got out of "describe --dirty" does not
	say dirty. If the recipient of the binary later reports
	issues, I should be able to reproduce the same binary by
	starting from a pristine checkout of the version (provided
	if I didn't screw up and depended on an untracked file when
	I initially created the binary, or used a custom build
	option, or lost the toolchain, ..., of course).

With that in mind, does --ignore-submodules make sense?

As we do not take untracked content at the superproject level into
account when deciding "--dirty"-ness, I think it is very sensible to
either do one of the following:

 (1) always ignore untracked files in submodule working trees; or

 (2) if we were to introduce some form of --ignore-submodules,
     ignore untracked files in the superproject working tree when we
     use that mechanism to ignore untracked files in submodule
     working trees.

Strictly speaking, (1) is a degenerate case of (2).

Using the same semantics of "--ignore-submodules" as "git status"
would not make much sense. "git status --ignore-submodules" does not
show modified submodules at all (e.g. the gitlink recorded in the
HEAD of the superproject being described does not match what is
checked out), so a clean output from the "describe --dirty" at the
superproject level does not give any assurance on the build
artifact.  It defeats the whole point of "describe --dirty".

I think what is missing from "--dirty" is not "--ignore-submodules",
but "--do-not-ignore-untracked" option [*1*].  "describe --dirty"
ignores untracked files in the superproject by default, and we
should ignore untracked files in submodule working trees, but the
current code does not.  Fixing that is (1) above.

And then when "--do-not-ignore-untracked" is in effect, we should
report a "dirty" revision when the working tree of the superproject
or any of the submodule working trees has untracked cruft.

You might want to argue, in the longer term, that the default should
be "--do-not-ignore-untracked" and people who want the current
toplevel behaviour should ask it with "--ignore-untracked".  I am
somewhat sympathetic to that position, but I do not think it is
practical.  People are not perfect and they do keep untracked and
unignored paths in the working tree; ignoring untracked paths does
have an excuse to be the default from practical point of view.

But when we ignore untracked paths in the superproject, we should
ignore untracked paths in submodule working trees consistently.


[Footnote]

*1* Ignoring any other kind of change in submodules (i.e. "none",
"dirty" or "all" for "git status --ignore-submodules=<when>") in the
context of "describe --dirty" in the superproject tree does not make
any sense, so

	BAD$ git describe --dirty --ignore-submodules=<when>

is not a right thing to do.

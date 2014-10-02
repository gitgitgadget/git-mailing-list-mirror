From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 0/5] add "unset.variable" for unsetting previously set variables
Date: Thu, 02 Oct 2014 12:58:18 -0700
Message-ID: <xmqqvbo2meg5.fsf@gitster.dls.corp.google.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jeff King <peff@peff.net>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 21:58:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZmW9-0007aY-JI
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 21:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999AbaJBT6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 15:58:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58748 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbaJBT6V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 15:58:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5F9B2407A2;
	Thu,  2 Oct 2014 15:58:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ijwHHZNEPPmYF/oKDDrjJ+QXtzY=; b=wBj+nY
	n2FHrdt2NVkp2eiISo4v0pguZV3GbEK1ZS10nfiOKDvDOAepeLoDFSN1b0aGEee0
	He6mgrzjSktUWezgdFMoUctH+VL0t0Q5WXP7ymDzkBnQ70mKAqHND1nC5Qra0Kfy
	iK/g3u/K3NNHKo8/ZpJaEor8TxSaJcnLznmuk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gxIvXjsim2opbCLTSxsAfP3oIv9yvGWq
	voaeMBMF2Wx4Dsgf5QCgPASFRAfMh/0RP+STkERKfmmVfzgUCuHOotMc7s250YAI
	BWUUs/bQHwDw1fOmnK8zGLE/REmBR010JbWtwqoUGrKO55hXPYCU96GXLPJvu5+4
	Nzp3OItYGeQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 544BB407A1;
	Thu,  2 Oct 2014 15:58:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CE28A407A0;
	Thu,  2 Oct 2014 15:58:19 -0400 (EDT)
In-Reply-To: <1412256292-4286-1-git-send-email-tanayabh@gmail.com> (Tanay
	Abhra's message of "Thu, 2 Oct 2014 06:24:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 750C4464-4A6E-11E4-8AF0-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257820>

Tanay Abhra <tanayabh@gmail.com> writes:

> 2> It affects both the C git_config() calls and, git config shell
> invocations. Due to this some variables may be absent from the git config -l
> result which might confuse the user.

I am not sure what you mean by this.  If you process variable
definitions as they come, and you read

	[some]
		variable = set to some value initially
                ...
	[unset]
		variable = some.variable
		...
	[some]
		variable = set to some other value

then a user might be able to see

	$ git config -l
        some.variable=set to some value initially
        !some.variable
	some.variable=set to some other value

(here, I am using an imaginary "!variable.name" to denote "this
variable is unset at this point in the reading sequence").

I would imagine if the result comes from a caching layer, the user
would see

	$ git config -l
	some.variable=set to some other value

and nothing else.  Is that what you are referring to?

I would think that the latter is probably desirable; otherwise we
would need to come up with a way to say "forget about everything we
said about this variable so far" (i.e. my "!some.variable" above)
and also the scripts that parse "git config -l" output need to code
the logic to forget and start afresh.

> 3> I also have an another implementation for this series which just marks the config
> variables instead of deleting them from the configset. This can be used to
> provide two versions of git_config(), one with filtered variables other without
> it.

I do not see a value in the filtered version.

What worries me _more_ is why people may want to put things in
system-wide global, and if it is a wise thing to do to allow users
to override.

We may later want to add ways to mark variables in various ways,
e.g. (thinking aloud)

 - "[config] sealed = section.variable" will prevent the variable
   from being reset, modified or appended.  If an administrator
   wants to enforce a certain setting in /etc/gitconfig, she may
   mark sensitive variables as cofnig.sealed at the end of the file:

	[security]
        	enforced = true
                ...
	[config]
        	sealed = security.enforced

   and we would ignore 

	[config]
        	unset = security.enforce
        [security]
		enforce = false

   written in .git/config or ~/.gitconfig, perhaps?

 - "[config] safeInclude = path" will allow a configuration file to
   be included safely from the project's working tree.  The path
   given as the value must be a relative path and it is relative to
   the top level of the project's working tree.

 - "[config] safe = section.variable" will list variables that can
   be included with the config.safeInclude mechanism.  Any variable
   that is not marked as config.safe that appears in the file
   included by the config.safeInclude mechanism will be ignored.

   The 'frotz' project might have a .frotz-gitconfig file at the
   root level of its working tree that stores this:

	[diff]
        	renames = true

   and your .git/config may have

	[config]
        	safe = diff.renames
                safeInclude = .frotz-gitconfig

   You will not have to worry about a malicious participant
   committing a

	[diff]
        	external = rm -fr .

   to .frotz-gitconfig and pushing it to the project because you do
   not mark diff.external as config.safe in your .git/config

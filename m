From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: git-p4 edit_template() and P4EDITOR w/options
Date: Mon, 04 May 2015 15:01:27 -0700
Message-ID: <xmqqh9rsovd4.fsf@gitster.dls.corp.google.com>
References: <5D2E2EAF-FFE7-437F-A716-E152E865E634@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Chris Lasell <chrisl@pixar.com>
X-From: git-owner@vger.kernel.org Tue May 05 00:01:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpOQh-00068m-6h
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 00:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbbEDWBb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 18:01:31 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57348 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750732AbbEDWB3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 18:01:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCEE64E393;
	Mon,  4 May 2015 18:01:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kVAP/pkI8tfARC4rCAWXbHpZqOo=; b=ntgelb
	86dm7pEgcFmNLOOiRhdb1fau6T+vZe0M0letorr0odu/8LT585qj/FlSy3LzSQrv
	blpUXudLb50TNlFJkG0+/7YTr2OdgEULFBDzmNNCLE5BqZJ+ukJEY634Q/pEtVmd
	rquj2RwAAM5nlhj3hIBaZHKOLkpYQhNlpo1ps=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=slr1WRBY7QKaDXuTv5EiHwlthkoCXaoc
	aABMRTtPvedXbBMhfVbPKWfz4Fz+ymG7qCadcnBRJDD7VsS5/Xa8XbHEuZntWoDd
	6w/+CN7/jnNHkSEixI3XyoeVDu/GC9VtxkmLNDR93qlCi+glsdRqtBpaIT+kxJrH
	YsX/rsJ7rzc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C65614E392;
	Mon,  4 May 2015 18:01:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 476B74E390;
	Mon,  4 May 2015 18:01:28 -0400 (EDT)
In-Reply-To: <5D2E2EAF-FFE7-437F-A716-E152E865E634@pixar.com> (Chris Lasell's
	message of "Mon, 4 May 2015 14:26:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1D4E8BF4-F2A9-11E4-8543-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268363>

Chris Lasell <chrisl@pixar.com> writes:

> PS: 'mate' is the CLI invocation of the TextMate GUI editor for OS
> X. The -w is required in this instance, or the 'mate' command
> would return instantly when the document opens. The -w causes it
> to wait until the document window is closed.
>
> I have noticed that the help output for mate says:
> =======
> By default mate will wait for files to be closed if the command name
> has a "_wait" suffix (e.g. via a symbolic link)
> =======
>
> and I have instructed my user to do just that for now.

I think that is not merely "for now" but is the way the command and
the environment variable are designed to be used.  A quick websearch
for [$EDITOR environment with parameter] found this one

  http://superuser.com/questions/521070/unix-environment-variables-with-arguments

which seems to be talking about a similar issue (unrelated to Git).

The relevant part of git-p4 is this:

        # invoke the editor
        if os.environ.has_key("P4EDITOR") and (os.environ.get("P4EDITOR") != ""):
            editor = os.environ.get("P4EDITOR")
        else:
            editor = read_pipe("git var GIT_EDITOR").strip()
        system([editor, template_file])

It grabs $EDITOR (or $GIT_EDITOR) and treats it as the path to the
editor executable, without letting shell to split that into words at
whitespace boundaries, so that you can say things like

	EDITOR="/User/me/My Programs/nano"

The way we spawn EDITOR in our core codepaths matches what git-p4
does, too:

	const char *args[] = { editor, real_path(path), NULL };
	struct child_process p = CHILD_PROCESS_INIT;
	int ret, sig;

	p.argv = args;
	p.env = env;
	p.use_shell = 1;
	if (start_command(&p) < 0)
		return error("unable to start editor '%s'", editor);
	...

So...

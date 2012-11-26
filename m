From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Third try at documenting command integration
 requirements.
Date: Mon, 26 Nov 2012 12:01:54 -0800
Message-ID: <7vzk24qgjx.fsf@alter.siamese.dyndns.org>
References: <20121126053557.E56434065F@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com (Eric S. Raymond)
X-From: git-owner@vger.kernel.org Mon Nov 26 21:02:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td4sg-0006MB-Nr
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 21:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755762Ab2KZUB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 15:01:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59159 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755654Ab2KZUB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 15:01:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B0C4DA1F4;
	Mon, 26 Nov 2012 15:01:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GcxU61OVc9YoNBGeC3CYe+5d8e4=; b=VSQrVh
	2O7WtHroYAwG1lY2bXF46T9dRB8GDoP0e+Fb6+ymDM/jPVQHCGC6Jw4AEYYIqN5Y
	irUFLLLPkrT2E0Bbiz6bifG7mDkx3L00fLdF6dkEFMrPn+2TkA98iZEyhKKqYy+S
	PseGL8Xn/BJKFYVNCPvCVNReUTni9uxn/Q17A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XN/In5Ko5eJNblaUVkJfNaMb36lDfkuA
	k6u/ZxqzthAoUlxDYTsQ7KwpGYSr5CG/KnoHPEChVYt6PipINfpbcpv92lAtC3Ld
	OHM7Ha7ptoje7GlSzECSdYvjZ08InfWfJwNqPV51v7WjpkNt5GmB1gRGDQkRBZ5J
	pVOmBL2XdKU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B93CA1F3;
	Mon, 26 Nov 2012 15:01:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D065FA1EF; Mon, 26 Nov 2012
 15:01:55 -0500 (EST)
In-Reply-To: <20121126053557.E56434065F@snark.thyrsus.com> (Eric S. Raymond's
 message of "Mon, 26 Nov 2012 00:35:57 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 20F6E790-3804-11E2-B526-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210475>

esr@thyrsus.com (Eric S. Raymond) writes:

> This document contains no new policies or proposals; it attempts
> to document established practices and interface requirements.
>
> Signed-off-by: Eric S. Raymond <esr@thyrsus.com>

I'll reword the title (readers of "git log" output 6 months down the
road will not care if this is the third try or the first one) and
tweak things here and there before queuing.

> diff --git a/Documentation/technical/api-command.txt b/Documentation/technical/api-command.txt
> new file mode 100644
> index 0000000..c1c1afb
> --- /dev/null
> +++ b/Documentation/technical/api-command.txt
> @@ -0,0 +1,91 @@
> += Integrating new subcommands =
> +
> +This is how-to documentation for people who want to add extension
> +commands to git.  It should be read alongside api-builtin.txt.
> +
> +== Runtime environment ==
> +
> +git subcommands are standalone executables that live in the git
> +execution directory, normally /usr/lib/git-core.  The git executable itself
> +is a thin wrapper that sets GIT_DIR and passes command-line arguments
> +to the subcommand.

    $ echo >$HOME/bin/git-showenv '#!/bin/sh
    exec env'
    $ chmod +x $HOME/bin/git-showenv
    $ git showenv | grep GIT_

gives me emptyness.  I rewrote the above to:

    git subcommands are standalone executables that live in the git exec
    path, normally /usr/lib/git-core.  The git executable itself is a
    thin wrapper that knows where the subcommands live, and runs them by
    passing command-line arguments to them.

FYI, a builtin command _can_ ask the git wrapper to set up the
execution environment by setting RUN_SETUP bit in its cmd_struct
entry, but it is not done by default.

> +== Implementation languages ==
> +
> +Most subcommands are written in C or shell.  A few are written in
> +Perl.  A tiny minority are written in Python.
> +
> +While we strongly encourage coding in portable C for portability, these
> +specific scripting languages are also acceptable. We won't accept more
> +without a very strong technical case, as we don't want to broaden the
> +git suite's required dependencies.
> +
> +Python is fine for import utilities, surgical tools, remote helpers
> +and other code at the edges of the git suite - but it should not yet
> +be used for core functions. This may change in the future; the problem
> +is that we need better Python integration in the git Windows installer
> +before we can be confident people in that environment won't
> +experience an unacceptably large loss of capability.

As Felipe and others said in the discussion, Python is not *that*
special over other languages (and I think we have a Go in contrib/).

I rewrote the above to:

    Most subcommands are written in C or shell.  A few are written in
    Perl.

    While we strongly encourage coding in portable C for portability,
    these specific scripting languages are also acceptable.  We won't
    accept more without a very strong technical case, as we don't want
    to broaden the git suite's required dependencies.  Import utilities,
    surgical tools, remote helpers and other code at the edges of the
    git suite are more lenient and we allow Python (and even Tcl/tk),
    but they should not be used for core functions.

    This may change in the future.  Especially Python is not allowed in
    core because we need better Python integration in the git Windows
    installer before we can be confident people in that environment
    won't experience an unacceptably large loss of capability.

> +C commands are normally written as single modules, named after the
> +command, that link a collection of functions called libgit.  Thus,
> +your command 'git-foo' would normally be implemented as a single
> +"git-foo.c"; this organization makes it easy for people reading the

    "git-foo.c" (or "builtin/foo.c" if it is to be linked to the main
    binary);

> +4. If your command has any dependency on a a particular version of
> +your language, document it in the INSTALL file.

    s/a a/a/;

> +6. When your patch is merged, remind the maintainer to add something
> +about it in the RelNotes file.

    6. Give the maintainer a one paragraph to include in the RelNotes
    file to describe the new feature; a good place to do so is in the
    cover letter [PATCH 0/n].

Thanks.

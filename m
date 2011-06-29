From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Encapsulating isatty(2) calls into new
 progress_is_desired()
Date: Wed, 29 Jun 2011 16:17:06 -0700
Message-ID: <7vboxgrzwt.fsf@alter.siamese.dyndns.org>
References: <3d6b6818cfc542a3acf7a7a43ac6842fd74ddcee.1309342095.git.sdaoden@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Daode Nurpmeso <sdaoden@gmail.com>
To: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jun 30 01:17:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qc40U-00032D-CJ
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 01:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734Ab1F2XRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jun 2011 19:17:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab1F2XRK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2011 19:17:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9D3D05AEC;
	Wed, 29 Jun 2011 19:19:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=trTe1i/qiW9rcmJ6WCSUCKbAyzU=; b=ndQs8A
	9W9/hJEsuYRTfCz+s2GxsXXIqnW7m+ninvjFqf2osZaYgBrVyq5k9gGaiPfq3Ily
	kuxcEMbKokaOtnTqfORlv60Ufbckzl67CfzcK41TSmmgehf1KkztzfukA7XiTiye
	mQ7EoVEH3BvJxpqTvMQaoL/Gs5pLAEk2UpPbM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l6eWiIeZadYUez/zdDho8tLj1WBPiH5S
	ewkdNSWUuo+yKXfmddeySCSvLyZJBwmVC5+sJVN3EcfNMQWxy1vGc6jr8ItBXnHG
	Rg2xBolCPbOTbiZgRvu8DhNLbpfsNLrlzmWjt8eMr2AX4KucOYxiaQcZ3gQqvTCt
	aR0bzQKvQCw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 95F925AEB;
	Wed, 29 Jun 2011 19:19:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9DF4A5AEA; Wed, 29 Jun 2011
 19:19:22 -0400 (EDT)
In-Reply-To: <3d6b6818cfc542a3acf7a7a43ac6842fd74ddcee.1309342095.git.sdaoden@gmail.com>
 (Steffen Daode Nurpmeso's message of "Wed, 29 Jun 2011 13:28:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 390D2F0A-A2A6-11E0-9939-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176463>

Steffen Daode Nurpmeso <sdaoden@googlemail.com> writes:

> Adds a progress_is_desired() function and replaces most calls of
> isatty(2) in the codebase with it.

Two comments, and perhaps a half.

One is trivial: want_progress() might be shorter and nicer.

The other is that we have isatty() for different file descriptors, and I
wonder if we want to consolidate them further and/or give them names, in a
separate patch. Here is a quick analysis.


* Most of the isatty(2) calls are indeed "want_progress()", except for one.

builtin/merge.c:	show_progress == -1 ? isatty(2) : show_progress;

	When "show_progress" is unset (denoted by -1), take the hint from
	stderr to decide if we show the progress output.

builtin/pack-objects.c:	progress = isatty(2);

	Default "progress" to 0 (no progress output) or 1 (give progress
	for the write-out phase only when sending the pack to
	filesystem). Later, command line parsing may update this variable.

builtin/unpack-objects.c:	quiet = !isatty(2);

	Default to give progress when connected to a tty.

remote-curl.c:	options.progress = !!isatty(2);

	Default to give progress when connected to a tty.

transport.c:	ret->progress = isatty(2);

	Default to give progress when connected to a tty.

transport.c:	transport->progress = force_progress || (verbosity >= 0 && isatty(2));
transport.c-}

	Default to give progress when connected to a tty.

pager.c:	if (isatty(2))
pager.c-		dup2(pager_process.in, 2);
pager.c-	close(pager_process.in);

	This should not be renamed to want_progress() even though it is
	isatty(2).


* Many places ask "Are we in a keyboard-interactive session?" using
  isatty(0) and change their behaviour accordingly. We might want a
  symbolic name for them.

builtin/commit.c:		if (isatty(0))
builtin/commit.c-			fprintf(stderr, _("(reading log message from standard input)\n"));

        This is to warn against "git commit -F -" that forgot to redirect
        an upstream pipe into the command;
        i.e. "script-to-generate-message | git commit -F -" is what the
        user probably wanted to.

builtin/pack-redundant.c:	if (!isatty(0)) {
builtin/pack-redundant.c-		while (fgets(buf, sizeof(buf), stdin)) {
builtin/pack-redundant.c-			sha1 = xmalloc(20);

	The command _can_ be fed a list of object names from the standard
	input, but we do not expect anybody typing the object names from
	the keyboard.

	Side note: I may be more consistent to do the "warn" thing commit
	does (see above) instead; I also suspect this command outlived its
	usefulness.

builtin/prune-packed.c:	int opts = isatty(2) ? VERBOSE : 0;

	Default to give progress when connected to a tty.

builtin/revert.c:	if (isatty(0))
builtin/revert.c-		edit = 1;

	"git revert" was designed to force you to edit the message to
	justify why reverting the given commit is the right thing, but
	in a non-interactive session, opening an editor is not a good
	thing to do.

builtin/shortlog.c:	if (!nongit && !rev.pending.nr && isatty(0))
builtin/shortlog.c-		add_head_to_pending(&rev);
builtin/shortlog.c-	if (rev.pending.nr == 0) {
builtin/shortlog.c:		if (isatty(0))
builtin/shortlog.c-			fprintf(stderr, _("(reading log message from standard input)\n"));
builtin/shortlog.c-		read_from_stdin(&log);

	"git shortlog" (without any revisions argument) can work as a
	filter to read "log" output (e.g. "git log ... | git shortlog")
	and condense it down, in which case it will not be reading from
	the terminal .  Without such an upstream process, "git shortlog"
	internally runs "git log HEAD" and gives its output.

* We decide to color the output when spitting out to a terminal using
  isatty(1).

builtin/config.c:			stdout_is_tty = isatty(1);
builtin/config.c-		return get_colorbool(argc != 0);

	This is to default for color output on terminal output, and is
	consistent with the one in color.c below.

color.c-	if (stdout_is_tty < 0)
color.c:		stdout_is_tty = isatty(1);
color.c-	if (stdout_is_tty || (pager_in_use() && pager_use_color)) {
color.c-		char *term = getenv("TERM");

	Default to give color output on a capable terminal when
	configruation says auto.

pager.c:	const char *pager = git_pager(isatty(1));

	Use pager on tty by default.


The remaining half is about various ways the "progress", "verbose" and
"quiet" are all mixed up (obviously "progress" is part of being "verbose",
but "verbose" can and do mean giving more information other than
progress), and they are different ways in which the values to give to the
internal variables are determined (some use isatty(2) to initialize the
default and then let option parser to update it, some run option parser
first and if the variable is unset use isatty(2) to give it default). We
might want to think about making them more uniform (or we may not).

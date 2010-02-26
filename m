From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Meta-variable naming convention in documentation
Date: Thu, 25 Feb 2010 21:42:02 -0800
Message-ID: <7vfx4oeeol.fsf@alter.siamese.dyndns.org>
References: <ca433831002252055l37292cf6v868cc407f0be7250@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 06:42:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nksxw-0001s5-38
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 06:42:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab0BZFmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 00:42:14 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622Ab0BZFmM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 00:42:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F1D579DEEB;
	Fri, 26 Feb 2010 00:42:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9GIG4oABplS4C0iDc3h3TF+5Fk8=; b=DljfQ8
	Bc7buNQ7eaSGfA5vgkFzED5F1DEkFkSiEOxgEbgQOttgDWTQnTOzjVhCNsViqBtT
	XETFFeM/QswNLIbI6P/MP70LN/e9jS8qb3/H/N0DkfEcTXim9TyouGgRPULZtJtp
	hb/7HiuSws/b2/6Oyj6Jhi7LmrIJrNP92O5LA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZPlqYj5F8w40HIFG3+NIB4TE5RQsDXvO
	daOIKOPGOgQwVAzyANWUpgwLlXRrBQCLSNitac6BKru/bjq1Nb7JPqqYXtweufum
	da6LdFFWzvVxmqgvsrRKhBaK0dKr4MNMJKsqKhKpKLwEE2UaXPcHO+tSKIJJDaW4
	yiQKoRc7dzU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CC6709DEEA;
	Fri, 26 Feb 2010 00:42:08 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 798E09DED7; Fri, 26 Feb
 2010 00:42:05 -0500 (EST)
In-Reply-To: <ca433831002252055l37292cf6v868cc407f0be7250@mail.gmail.com>
 (Mark Lodato's message of "Thu\, 25 Feb 2010 23\:55\:08 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ADF1F1C2-2299-11DF-A362-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141107>

Mark Lodato <lodatom@gmail.com> writes:

> The following accept exact filenames or directories.  If a directory,
> this matches all files within that directory recursively.
>
> 	git-archive		path			fdir
>
> 	git-bisect		<paths>/<pathspec>	fdir	(f)

What does the gap between these two mean?  Do you mean "bisect and later
are not in the 'exact filenames or directories' group"?

In general, unless the command takes only one filesystem entity (e.g. in
"format-patch -o <dir>", <dir> cannot be anything but a single directory;
in "blame <file>", <file> cannot be anything but a single file), you never
give a single "filename" to git command.  Even when you say "git add
Makefile", you are _not_ giving a filename that is "M' "a" "k" "e" ...;
you are giving a _pattern_ to be matched with files git would find by
traversing the filesystem.  In the case of "Makefile", it may happen to
match only one single file.

This pattern is called "pathspec", and commands that can take one pathspec
can always take more than one.

Unfortunately, for historical reasons, there are two semantics of
pathspec, and at least three implementations of pathspec logic.

 - diff family (diff, log, show, rev-list) does not support glob.  The
   pattern is matched either as a leading directory path, or exact name.

 - ls-files family (I think "clean" also uses the logic internally) does
   support glob.  The pattern is matched either as a leading directory
   path, exact name, or a glob.

 - grep implements the same logic as ls-files but uses a newer
   implementation better suited for optimized tree traversal.

And there are higher level commands that internally use logic from either
diff family or ls-files family.  You can guess which pathspec is used if
you think about how you would implement what they do.  For example:

 - "add <pathspec>" traverses the work tree using ls-files logic and adds
   found files to the index.

 - "add -u <pathspec>" compares the index and the work tree using
   diff-files logic and adds paths with differences to the index.

 - "status" uses "diff-index --cached" logic to come up with 'Changed to
   be committed' list, "diff-files" logic to come up with 'Changed but not
   updated' list, and "ls-files" logic to list 'Untracked' files.

Unifying the two different semantics of pathspecs is one of the suggested
topics for GSoC, by the way.

I think it would make sense to document which ones are concrete paths
(e.g. "blame takes a filename" vs "diff takes zero or more pathspecs"),
but it would not make much sense to document the two different pathspecs.
The effort is better spent at fixing the difference --- obviously we would
eventually want to be able to say "git diff 'lib/*.h'".

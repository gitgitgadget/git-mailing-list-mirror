From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git attributes ignored for root directory
Date: Wed, 05 Oct 2011 10:38:28 -0700
Message-ID: <7vd3eb8hkb.fsf@alter.siamese.dyndns.org>
References: <4E8B55FB.1050203@svario.it> <4E8C481A.1070808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gioele Barabucci <gioele@svario.it>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 05 19:38:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBVQS-0000x3-Me
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 19:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935123Ab1JERic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 13:38:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55770 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934662Ab1JERib (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 13:38:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D74E350D0;
	Wed,  5 Oct 2011 13:38:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sWAx6hJ7id4OkwrROcOdEm3D4UY=; b=E+IAJX
	nCQaZOvOxgRsuUC9IMHMkSMsnpEKKdO9FZCljF2vbOqH1cuGIbLQZ8Kno8XBpEoG
	eg05VOrtmlj2TWNq8St8NVhHMy/6gLniIsOnxZGZjOVhdnmUkzPwgBdu6syS47SW
	tcqp5PKivRSgWKY6CHODc+FpAbnPTz4ojyA1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZD1dZa1mr0NUoRFZ2/zqawyucyGmTz9i
	iL412wXPub8En+XQvy8c4lc3EoUGQmnQJTPUld8WlbbrGyx63Z/s+L4AxEuyHzMO
	qhkhSeScDHJEDEKGuFjlT3MzWwk69KISj9C6W4SFnKwphuK7wPYKQtKH0nxQAMay
	bGeV5HnAp8Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE30F50CF;
	Wed,  5 Oct 2011 13:38:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0296250CC; Wed,  5 Oct 2011
 13:38:29 -0400 (EDT)
In-Reply-To: <4E8C481A.1070808@alum.mit.edu> (Michael Haggerty's message of
 "Wed, 05 Oct 2011 14:05:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D6D08420-EF78-11E0-B734-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182865>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Indeed, your use case is broken by
>
> f5114a40c0d0276ce6ff215a3dc51eb19da5b420
>
> In fact the support for gitattributes using patterns involving "." was
> pretty spotty in v1.7.6 too.  For example,
> ...
> I conclude that this functionality was never really defined correctly,
> and you were pretty lucky that your case worked at all :-)

The attribute patterns (or exclude patterns for that matter) were never
designed to name "the current directory". The way to name "everything *in*
this directory" has always been to say "*" (the "* text=auto" example in
the documentation says it shows how to set the attribute "for all
files"). Admittedly the pattern may miss ".*" files.

I have to agree that things like "./" and "."  were outside the scope of
the design; in some cases undefined behaviour given to such patterns may
have made sense but that was mere accident.

If we were to give some defined behaviour to these patterns, updating the
"Pattern Format" section of Documentation/gitignore.txt is the first thing
to do. The text currently reads like this:

PATTERN FORMAT
--------------

 - A blank line matches no files, so it can serve as a separator
   for readability.

 - A line starting with # serves as a comment.

 - An optional prefix '!' which negates the pattern; any
   matching file excluded by a previous pattern will become
   included again.  If a negated pattern matches, this will
   override lower precedence patterns sources.

 - If the pattern ends with a slash, it is removed for the
   purpose of the following description, but it would only find
   a match with a directory.  In other words, `foo/` will match a
   directory `foo` and paths underneath it, but will not match a
   regular file or a symbolic link `foo` (this is consistent
   with the way how pathspec works in general in git).

 - If the pattern does not contain a slash '/', git treats it as
   a shell glob pattern and checks for a match against the
   pathname relative to the location of the `.gitignore` file
   (relative to the toplevel of the work tree if not from a
   `.gitignore` file).

 - Otherwise, git treats the pattern as a shell glob suitable
   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
   wildcards in the pattern will not match a / in the pathname.
   For example, "Documentation/{asterisk}.html" matches
   "Documentation/git.html" but not "Documentation/ppc/ppc.html"
   or "tools/perf/Documentation/perf.html".

 - A leading slash matches the beginning of the pathname.
   For example, "/{asterisk}.c" matches "cat-file.c" but not
   "mozilla-sha1/sha1.c".

I think adding the following before the 5th rule ("If the pattern does not
contain a slash") would be sufficient:

 - If the pattern is a single dot and nothing else, it matches everything
   in the current directory.

So "./" in .gitignore or .gitattributes at the toplevel would match all
the top-level directories and files but does not apply to the paths
contained in the matched directories. "." in .gitignore or .gitattributes
at the toplevel would match everything under the sun.

Personally I do not think it is an improvement. You can certainly say "we
have one less undefined case and are more consistent", but the downside of
that consistency is that it is very confusing and error prone for the end
users. Would it be sensible to assume that users would not be surprised if
". text=auto" meant that the attribute applies to every file in the
worktree?

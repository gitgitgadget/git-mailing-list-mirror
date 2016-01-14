From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 00/21] Peace with CRLF
Date: Thu, 14 Jan 2016 15:58:15 -0800
Message-ID: <1452815916-6447-1-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:58:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrmw-00037H-Rc
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755534AbcANX6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:58:41 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60397 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755389AbcANX6j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:58:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 152BF3CD56;
	Thu, 14 Jan 2016 18:58:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=mxHW
	10Pg/S1Yo/YhBwlpXz0dJ9g=; b=b7QqXMAe+djCRkrrnNGv0yT/kc96/PedVsju
	Gz176H0XFdwZnKqp6mjx0hurh9GPbeLXZNSMRbTrj1ny0bMftg/YFECZJtySLiH9
	4dAT9k+RwTcbqpiXudC3jTkM/0vLNJcCInpSt/lFePYdg57mOvTZzvCJijWmHGvd
	c2xxnM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	iaK51nAM3Q01UhJWLaCnG/ZFdBd1mzk8y6O1kc0hzcLWOA/XA/3Gl4AiyVwCyVAi
	dxFY5SoUlwiTcaa4XHu0YX5QUFt+wNTlFFbU1WVGUr1FYV7+72+jjkhPwGSlXTZu
	3WNENP3FZrsgR0kZEe/dcJRWIwsawpauDUzbDoZ3vOg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0BAD23CD55;
	Thu, 14 Jan 2016 18:58:38 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6A4253CD54;
	Thu, 14 Jan 2016 18:58:37 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452740590-16827-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BA56F384-BB1A-11E5-A10F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284104>

We have too many topics titled "War on something"; let's try to make
peace for a change.

This is a reroll of

  http://thread.gmane.org/gmane.comp.version-control.git/282614

which is a continuation to $gmane/275735, which is filed in the
archive under another mailing list:

  http://thread.gmane.org/gmane.comp.version-control.msysgit/21773

but with a larger clean-up whose early part was sent earlier, marked
with the "PREVIEW v3" label.

  http://thread.gmane.org/gmane.comp.version-control.git/284001

We read "text" files from filesystem (or from the standard input) in
various places in the code.  Some of them are written by us, but
others are often prepared by an editor driven by human user.  Even
though we write (and expect) lines in these text files to be
terminated with LF (not CRLF), the end-user's editor can be told to
use CRLF termination, and on some platforms that may be the default.

Typically, we use strbuf_getline() to read these "text" files, which
reads a single line up to the first LF into a buffer, discard that
LF at the end, and returns (an incomplete last line gets returned
as-is).  Lines from a file edited on Dossy systems hence may have
a CR at the end that the end-user did not intend to be a part of it.

Because many codepaths (e.g. commit log message) first pass the
contents of such a file through stripspace(), and as a side effect
of discarding the whitespace at the end of each line, lines
terminated with CRLF are normalized to LF terminated lines (but we
do not lose a lone CR in the middle of a non-blank string), when we
process what we read from these files, this is not a problem for
them, but not all of the codepaths are safe.

In these places that expect to read "text", we should be able to
update the logic to read a line up to the first LF, discard that LF,
together with a CR if one appears immediately before that LF,
without breaking anything.  That includes cases where the program
might want to treat a CR in the middle of a line as proper payload
the user intended to give us.  Such a variant of strbuf_getline()
already exists as strbuf_getline_crlf() and used in the "git am"
that was reimplemented in C recently.

The strbuf_getline() function takes a "line-termination" as its
third argument.  Its interface is overly broad in that it allows an
arbitrary byte to be used to mark the end of a line, but in
practice, no codepaths pass any byte other than LF or NUL.  In
theory, the callers that use LF as the line-termination are
expecting "text" input, so we could blindly replace them with
strbuf_getline_crlf() and not many things should break.  To be
conservative, however, this series converts only chosen ones after
auditing that such a conversion is safe.

To make the tree-wide change manageable, the early part of this
series first changes all callsites of strbuf_getline() to call one
of the two new thin wrapper functions, strbuf_getline_lf() and
strbuf_getline_nul(), depending on the value of "line-termination"
used by the caller.  This is done with Patches 1-9, which is
essentially the same as "PREVIEW v3" series posted earlier, with
small changes:

 - The update to mktree used "lf_lines" in the preview, but this
   version flips it to the same "nul_term_line" to match other two,
   even though I think the latter is a terrible variable name with
   bad taste.

 - The update to checkout-index kept "line_termination" in the
   preview, but this version no longer uses it and instead uses
   nul_term_line.

 - The definition of nul_term_line for the option parser uses
   OPT_BOOL(), as the possible values in it are true or false, not
   '\0' or '\n'.

 - The topic was rebased on v2.7.0; the bulk of builtin/mailinfo.c
   moved to mailinfo.c between the old base of the topic and v2.7.0,
   so the mechanical renaming done in Patch 3 was redone.

After Patch 9, all the original callers of strbuf_getline() that
used LF line ending call strbuf_getline_lf().  No caller calls
strbuf_getline() at that point, so strbuf_getline_crlf() takes over
the short and nice name strbuf_getline().

The callers of strbuf_getline_lf() are inspected by the remainder of
the series and updated to call strbuf_getline() instead when it
makes sense to do so.  They all had to be updated relative to the
previous round (v2), but the callsites that are updated haven't
changed.

This series converts only the callers of strbuf_getline() that would
misbehave when fed a file with CRLF-terminated lines and use the
data with an unwanted CR appended at the end.  With the update the
code should work as intended with such a file, without breaking the
expected behaviour when working on a file with LF-terminated lines.

Notes on the remaining strbuf_getline_lf() callers:

 * Those that expect to only read from our own output do not have to
   accommodate CRLF-terminated lines, but they can be updated to do
   so safely if we do not rely on the ability to express a payload
   that has CR at the end.  For example, the insn sheet "rebase -i"
   uses typically ends each line with a commit log summary that we
   ourselves do not read or use, so even if the end-user on a
   platform with LF lines deliberately does insert CR at the end of
   the line and strbuf_getline() removed that CR from the payload,
   no unexpected behaviour should happen.

   It may be a good GSoC microproject to convert them to use
   strbuf_getline().

 * Those that call strbuf_trim() immediately on the result before
   doing anything, or otherwise have logic that tolerates
   whitespaces at the end of the line, can continue using
   strbuf_getline_lf() and will not misbehave on CRLF-terminated
   lines.

   This series does not touch them; converting them to use
   strbuf_getline() would a good way to document them as dealing
   with "text".  While doing so, they can also lose their custom
   logic that happens to make CRLF-terminated lines work.

   It is a good GSoC microproject to convert them to use
   strbuf_getline().

 * Those that want to only ever see LF-terminated lines (in other
   words, "ABC\r\n" must be treated as a line with 4 bytes payload
   on it, A B C and CR), would be broken if we replace it with
   strbuf_getline().  This series does not touch them, and no
   follow-up series should, either.


Junio C Hamano (21):
  strbuf: miniscule style fix
  strbuf: make strbuf_getline_crlf() global
  strbuf: introduce strbuf_getline_{lf,nul}()
  mktree: there are only two possible line terminations
  check-attr: there are only two possible line terminations
  check-ignore: there are only two possible line terminations
  update-index: there are only two possible line terminations
  checkout-index: there are only two possible line terminations
  strbuf: give strbuf_getline() to the "most text friendly" variant
  hash-object: read --stdin-paths with strbuf_getline()
  revision: read --stdin with strbuf_getline()
  rev-parse: read parseopt spec with strbuf_getline()
  ident.c: read /etc/mailname with strbuf_getline()
  remote.c: read $GIT_DIR/remotes/* with strbuf_getline()
  clone/sha1_file: read info/alternates with strbuf_getline()
  transport-helper: read helper response with strbuf_getline()
  cat-file: read batch stream with strbuf_getline()
  column: read lines with strbuf_getline()
  send-pack: read list of refs with strbuf_getline()
  grep: read -f file with strbuf_getline()
  test-sha1-array: read command stream with strbuf_getline()

 bisect.c                   |  8 ++++----
 builtin/am.c               | 37 +++++++++++--------------------------
 builtin/cat-file.c         |  2 +-
 builtin/check-attr.c       |  7 ++++---
 builtin/check-ignore.c     |  7 ++++---
 builtin/check-mailmap.c    |  2 +-
 builtin/checkout-index.c   | 16 ++++++++--------
 builtin/clean.c            |  6 +++---
 builtin/clone.c            |  2 +-
 builtin/column.c           |  2 +-
 builtin/commit.c           |  2 +-
 builtin/fetch-pack.c       |  2 +-
 builtin/grep.c             |  2 +-
 builtin/hash-object.c      |  2 +-
 builtin/mktree.c           | 14 ++++++++------
 builtin/notes.c            |  2 +-
 builtin/pull.c             |  2 +-
 builtin/repack.c           |  2 +-
 builtin/rev-parse.c        |  4 ++--
 builtin/send-pack.c        |  2 +-
 builtin/update-index.c     | 27 ++++++++++++++++-----------
 compat/terminal.c          |  2 +-
 credential-cache--daemon.c |  4 ++--
 credential-store.c         |  2 +-
 credential.c               |  2 +-
 daemon.c                   |  2 +-
 fast-import.c              |  4 ++--
 ident.c                    |  2 +-
 mailinfo.c                 |  8 ++++----
 remote-curl.c              |  6 +++---
 remote-testsvn.c           |  4 ++--
 remote.c                   |  4 ++--
 revision.c                 |  9 ++-------
 sequencer.c                |  2 +-
 sha1_file.c                |  2 +-
 shell.c                    |  2 +-
 strbuf.c                   | 28 +++++++++++++++++++++++++---
 strbuf.h                   | 27 ++++++++++++++++++++++-----
 test-sha1-array.c          |  2 +-
 transport-helper.c         |  5 +++--
 walker.c                   |  2 +-
 wt-status.c                |  4 ++--
 42 files changed, 151 insertions(+), 122 deletions(-)

-- 
2.7.0-250-ge1b5ba3

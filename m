From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 00/17] Peace with CRLF
Date: Wed, 28 Oct 2015 15:25:44 -0700
Message-ID: <1446071161-15610-1-git-send-email-gitster@pobox.com>
References: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 23:33:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrZHl-0000NQ-8u
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 23:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbbJ1Wdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 18:33:33 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54263 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753581AbbJ1WdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 18:33:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 44D7E26A08;
	Wed, 28 Oct 2015 18:26:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4Frs
	uwwciPU6kQC/EsJjnQXjADU=; b=gDLK8NxgPj2BY0IbQYMvpjlUDJNZcTslu+Oe
	bMgK9KZpvEsd+0yBPzr3ogIHm9J3xBdULQtu2WH/J+Z3AadmqZW1ICED8ta+GSHY
	TSY448KYYBw6q+ztmx4004Y170FxZazFpOkxa47llqvt+7YviLBMqWSfRPlS0U4K
	IAInc7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=FYgdJX
	DiqGJixzQMv4CQ8P843erWqAFYC7LlZjtcIuixOiKD+mqTFF7oz63s9xj1gAMXh3
	Gw1k9trSClaYCtMU9PPtDLI4fbiQ/7zN7xBbHMoKg8uf2LvUTTLzb5Q1IVlyDyvv
	yw2wYgeDdeScjPdeQB1lulCQCJ78nUIdaPsY4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3CD8426A07;
	Wed, 28 Oct 2015 18:26:03 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9EA6326A05;
	Wed, 28 Oct 2015 18:26:02 -0400 (EDT)
X-Mailer: git-send-email 2.6.2-423-g5314b62
In-Reply-To: <xmqqtws5o4lp.fsf@gitster.dls.corp.google.com>
X-Pobox-Relay-ID: DF352166-7DC2-11E5-97E0-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280401>

We have too many topics titled "War on something"; let's try to make
peace for a change.

This is a continuation to $gmane/275735, which is filed in the
archive under another mailing list:

  http://thread.gmane.org/gmane.comp.version-control.msysgit/21773

We read "text" files from filesystem (or from the standard input) in
various places in the code.  Some of them are written by us, but
others are often prepared by an editor driven by human user.  Even
though we write (and expect) lines in these text files to be
terminated with LF (not CRLF), the end-user's editor can be told to
use CRLF termination, and on some platforms that may be the default.

Because many codepaths (e.g. commit log message) first pass the
contents of such a file through stripspace(), and as a side effect
of discarding the whitespace at the end of each line, lines
terminated with CRLF are normalized to LF terminated lines (but we
do not lose a lone CR in the middle of a non-blank string), this is
not a problem in many codepaths.  But not all of the codepaths are
safe.

Typically, we use strbuf_getline() to read these "text" files, which
reads a single line up to the first LF into a buffer, discard that
LF at the end, and returns (an incomplete last line gets returned
as-is).  In theory, these places that expect to read "text", we
should be able to update the lotic to read a line up to the first
LF, discard that LF, together with a CR if one appears immediately
before that LF, without breaking anything.

I inspected all the callsites of this function to see if it is safe
to use such an updated logic at these callsites, and did not find
anything problematic.  I could update strbuf_getline() in place, but
just to be extra careful, this series instead introduces another
helper, strbuf_gets(), that is aware of this CRLF business, and
convert the ones that are safe to update as we verify.

At the end of this message, you will find my notes while inspecting
the current codebase as of 37023ba3 (Seventh batch for 2.7,
2015-10-26).

 * This series converts only the callers of strbuf_getline() in the
   category [A], i.e. the current code would misbehave when fed a
   file with CRLF-terminated lines and use the data with an unwanted
   CR appended at the end, and with the update the code should work
   as intended with such a file, without breaking the expected
   behaviour when working on a file with LF-terminated lines.

 * Callers that expect to read from our own output do not have to
   accomodate CRLF-terminated lines, but they can be updated to do
   so safely if we do not rely on the ability to express a payload
   that has CR at the end.  For example, the insn sheet "rebase -i"
   uses typically end with commit log summary that we ourselves do
   not read or use, so even if the end-user on a platform with LF
   lines deliberately does insert \r at the end of the line and
   strbuf_gets() removed that \r from the payload, no unexpected
   behaviour should happen.  They are categorized as [B] in the
   attached notes (and this series does not touch them).

 * Some callers just strbuf_trim() or otherwise have logic that
   tolerates whitespaces at the end of the line.  For them, it does
   not make any difference whether strbuf_getline() or strbuf_gets()
   is used to read the lines to be processed.  They are caregorized
   as [C] in the attached notes (and this series does not touch
   them).

 * I haven't found a caller that wants to only see LF-terminated
   lines (in other words, "ABC\r\n" must be treated as a line with 4
   bytes payload on it, A B C and CR), but the survey reserves
   category name [X] for this empty set ;-).

Double-checking my classification for callers in [B] and [C] and
making them all use strbuf_gets() would be a good microproject for
GSoC in coming years ;-) If all callers with strbuf_getline() that
uses '\n' as the terminator disappears at the end, that would be
ideal.

Junio C Hamano (17):
  strbuf: add strbuf_gets()
  check-attr, check-ignore, checkout-index: read paths with strbuf_gets()
  update-index: read --index-info with strbuf_gets()
  update-index: read list of paths with strbuf_gets() under --stdin
  mktree: read textual tree representation with strbuf_gets()
  hash-object: read --stdin-paths with strbuf_gets()
  revision: read --stdin with strbuf_gets()
  rev-parse: read parseopt spec with strbuf_gets()
  ident.c: read /etc/mailname with strbuf_gets()
  remote.c: read $GIT_DIR/remotes/* with strbuf_gets()
  clone/sha1_file: read info/alternates with strbuf_gets()
  transport-helper: read helper response with strbuf_gets()
  cat-file: read batch stream with strbuf_gets()
  column: read lines with strbuf_gets()
  send-pack: read list of refs with strbuf_gets()
  grep: read -f file with strbuf_gets()
  test-sha1-array: read command stream with strbuf_gets()

 builtin/am.c             | 23 ++++-------------------
 builtin/cat-file.c       |  2 +-
 builtin/check-attr.c     |  4 +++-
 builtin/check-ignore.c   |  5 ++++-
 builtin/checkout-index.c |  4 +++-
 builtin/clone.c          |  2 +-
 builtin/column.c         |  2 +-
 builtin/grep.c           |  2 +-
 builtin/hash-object.c    |  2 +-
 builtin/mktree.c         |  4 +++-
 builtin/rev-parse.c      |  4 ++--
 builtin/send-pack.c      |  2 +-
 builtin/update-index.c   |  9 +++++++--
 ident.c                  |  2 +-
 remote.c                 |  2 +-
 revision.c               |  9 ++-------
 sha1_file.c              |  2 +-
 strbuf.c                 | 16 ++++++++++++++--
 strbuf.h                 |  7 +++++++
 test-sha1-array.c        |  2 +-
 transport-helper.c       |  2 +-
 21 files changed, 60 insertions(+), 47 deletions(-)

-- >8 -- survey of current strbuf_getline() callers -- >8 --

updating == "teaching strbuf_getline() to strip CR that comes
             immediately before the LF"

[A] may be problematic on CRLF systems, "updating" will help fixing.

[B] CRLF line ending may or may not appear, but "updating" does not hurt.

[C] CRLF line ending may appear, but the code is already safe.

[X] The caller cares about distinction between CRLF and LF, and "updating"
    introduce breakage.


bisect.c uses it to read from BISECT_NAMES, which is a text
file written by redirecting "rev-parse --sq-quote" into it. [B]

bisect.c uses it to read from BISECT_EXPECTED_REV, which is
a "ref-like" file written by update_ref(). [B]

*** This should be cleaned up to use read_ref() or something.

ident.c reads from /etc/mailname, which is a text file. [A]
*** mailnamebuf may want to be strbuf_strip()'ed, and doing so is
another way to fix this.

credential-cache--daemon.c uses it to read requests, which is a text
channel. [B]

credential-store.c uses it to read from the credential file, which is
a text file. However, it is parsed by credential_from_url() that is
not affected by an extra CR at the end. [C]

credential-store.c parrots the original in CRLF as CRLF with "store",
while writing a new one with LF.  This codepath will start normalizing
the resulting file to LF, which may not be a bad thing. [C]

credential.c uses it to read from the helper. [B]

daemon.c uses it to read from a child process's output in order to
save it to the log.  The current code may have sent string with CR at
the end to logerror(). [A]

fast-import.c uses it to read the command stream, which is text. [B]

remote-curl.c uses it as a transport helper to read commadn stream,
which is text [B]

remote-testsvn.c uses it as a transport helper to read commadn stream,
which is text [B]

remote.c uses it to read $GIT_DIR/remotes/* files, which is text. [A]

sequencer.c uses it to read $GIT_DIR/sequencer/head that it itself
writes. [B]

builtin/clone.c and sha1_file.c uses it to read from an alternates
file, which is text.  [A]

shell.c does end-user interactions ;-) [B]

test-sha1-array.c reads command stream, which is text [A].

transport-helper.c reads helper output, which is text [A].

walker.c reads from the standard input a <target> HT <ref> per line,
which is text [A].

wt-status.c reads from rebase-i insn, which is text, but it uses
strbuf_trim() on it [C].

wt-status.c also reads from various "ref-like" things, all of which
are internally generated by us [B].

builtin/am.c does a lot to process mail input. [A]

builtin/cat-file.c uses it to read --batch input, which is text [A].

builtin/checkout-index.c, builtin/check-attr.c and
builtin/check-ignore.c use it to read --stdin, which is text [A].

builtin/check-mailmap.c uses it to read --stdin, but the tail end of
the input line is not used [C].

builtin/clean.c does end-user interactions; it trims so it is safe [C].

builtin/column.c reads from standard input text. [A]

builtin/commit.c reads from MERGE_HEAD which is internally generated
[B].

builtin/fetch-pack.c reads list of refs with --stdin, which is
internally generated [B].

builtin/grep.c uses it to read patterns from a file with -f [A].

builtin/hash-object.c uses it with --stdin-paths [A].

mailinfo uses it to read from its input [B].

builtin/mktree.c reads etxt-formatted tree representation [A].

builtin/notes.c reads from the standard input upon "git notes copy";
the input is trimmed [C].

builtin/pull.c reads FETCH_HEAD which is internally generated [B].

builtin/repack.c reads the packname output by pack-objects which is
internally generated [B].

builtin/rev-parse.c uses it for its parseopt mode [A].

builtin/send-pack.c uses it to read the refs from --stdin [A].

builtin/update-index.c reads "--index-info" [A].

builtin/update-index.c reads paths from "--stdin" [A].

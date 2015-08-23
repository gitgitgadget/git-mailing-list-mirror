From: Jeff King <peff@peff.net>
Subject: [PATCH] rev-list: make it obvious that we do not support notes
Date: Sun, 23 Aug 2015 13:56:40 -0400
Message-ID: <20150823175640.GB24735@sigill.intra.peff.net>
References: <0LZlZ2-1Z1Zyn1mzk-00lZ3Z@mail.gmx.com>
 <20150823174309.GA24735@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 23 19:57:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTZVu-00058T-NO
	for gcvg-git-2@plane.gmane.org; Sun, 23 Aug 2015 19:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbbHWR4o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2015 13:56:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:48772 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752123AbbHWR4n (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2015 13:56:43 -0400
Received: (qmail 30931 invoked by uid 102); 23 Aug 2015 17:56:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Aug 2015 12:56:42 -0500
Received: (qmail 16396 invoked by uid 107); 23 Aug 2015 17:56:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 23 Aug 2015 13:56:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 23 Aug 2015 13:56:40 -0400
Content-Disposition: inline
In-Reply-To: <20150823174309.GA24735@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276417>

On Sun, Aug 23, 2015 at 01:43:09PM -0400, Jeff King wrote:

> I don't know how deeply anybody _cares_ about showing notes via
> rev-list. It has clearly never worked. But rather than silently
> accepting --show-notes (and not showing any notes!), perhaps we should
> tell the user that it does not work. Likewise, the "%N" --format
> specifier never expands in rev-list, and should probably be removed from
> the rev-list documentation.

I think that would look like this. IMHO this is a strict improvement on
the current state. I would be happier still if somebody wanted to plumb
the notes options through for rev-list, but I am not personally
interested in spending the time on that.

-- >8 --
Subject: rev-list: make it obvious that we do not support notes

The rev-list command does not have the internal
infrastructure to display notes. Running:

  git rev-list --notes HEAD

will silently ignore the "--notes" option. Running:

  git rev-list --notes --grep=. HEAD

will crash on an assert. Running:

  git rev-list --format=%N HEAD

will place a literal "%N" in the output (it does not even
expand to an empty string).

Let's have rev-list tell the user that it cannot fill the
user's request, rather than silently producing wrong data.
Likewise, let's remove mention of the notes options from the
rev-list documentation.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/pretty-formats.txt   | 2 ++
 Documentation/pretty-options.txt   | 2 ++
 Documentation/rev-list-options.txt | 2 ++
 builtin/rev-list.c                 | 3 +++
 4 files changed, 9 insertions(+)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index dc865cb..671cebd 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -139,7 +139,9 @@ The placeholders are:
 - '%f': sanitized subject line, suitable for a filename
 - '%b': body
 - '%B': raw body (unwrapped subject and body)
+ifndef::git-rev-list[]
 - '%N': commit notes
+endif::git-rev-list[]
 - '%GG': raw verification message from GPG for a signed commit
 - '%G?': show "G" for a Good signature, "B" for a Bad signature, "U" for a good,
   untrusted signature and "N" for no signature
diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 642af6e..8d6c5ce 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -42,6 +42,7 @@ people using 80-column terminals.
 	verbatim; this means that invalid sequences in the original
 	commit may be copied to the output.
 
+ifndef::git-rev-list[]
 --notes[=<ref>]::
 	Show the notes (see linkgit:git-notes[1]) that annotate the
 	commit, when showing the commit log message.  This is the default
@@ -73,6 +74,7 @@ being displayed. Examples: "--notes=foo" will show only notes from
 --[no-]standard-notes::
 	These options are deprecated. Use the above --notes/--no-notes
 	options instead.
+endif::git-rev-list[]
 
 --show-signature::
 	Check the validity of a signed commit object by passing the signature
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index a9b808f..f1c5220 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -58,9 +58,11 @@ endif::git-rev-list[]
 	more than one `--grep=<pattern>`, commits whose message
 	matches any of the given patterns are chosen (but see
 	`--all-match`).
+ifndef::git-rev-list[]
 +
 When `--show-notes` is in effect, the message from the notes is
 matched as if it were part of the log message.
+endif::git-rev-list[]
 
 --all-match::
 	Limit the commits output to ones that match all given `--grep`,
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index c0b4b53..d80d1ed 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -350,6 +350,9 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	    revs.diff)
 		usage(rev_list_usage);
 
+	if (revs.show_notes)
+		die(_("rev-list does not support display of notes"));
+
 	save_commit_buffer = (revs.verbose_header ||
 			      revs.grep_filter.pattern_list ||
 			      revs.grep_filter.header_list);
-- 
2.5.0.685.g0ca4974

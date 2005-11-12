From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT character codecs
Date: Sat, 12 Nov 2005 14:00:38 -0800
Message-ID: <7vzmo9edbt.fsf@assigned-by-dhcp.cox.net>
References: <20051112123712.75182.qmail@web26301.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 23:01:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb3QR-0007ea-ES
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 23:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964819AbVKLWAk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 17:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbVKLWAk
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 17:00:40 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:44252 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932353AbVKLWAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 17:00:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051112220005.EDOS4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Nov 2005 17:00:05 -0500
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20051112123712.75182.qmail@web26301.mail.ukl.yahoo.com> (Marco
	Costalba's message of "Sat, 12 Nov 2005 04:37:12 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11710>

Marco Costalba <mcostalba@yahoo.it> writes:

> I modified qgit to force the use of utf-8 codec instead of the local one, 
> in my case ISO-8859-15.

I suspect that trying to have a globa single encoding is a wrong
approach overall.  There are a handful issues to think about.

First the easiest one -- the commit log messages.  We encourage
use of UTF-8, because they hold people's names which are the
significant source of i18n needs.  Even if your project starts
out with just a group of people whose names can be spelled in
ASCII just fine, or all western european in which case you might
be tempted to do latin-1 or 8859-15, or all Japanese with
EUC-JP, your project _might_ someday have a member whose name
cannot be spelled if you pick one of these encodings [*2*].  So
we encourage use of UTF-8 and help people by having -u flag in
git-mailinfo, for example.

But we do not _enforce_ UTF-8.  I've never worked actively with
non-English free software projects, and I do not know if people
in, say, Japan write their commit log messages in Japanese.  I
however think it is a reasonable thing to do if the project is
local and exclusive (e.g. a company internal project).  And if
local encoding is more convenient to handle for users
(e.g. their "less" is configured to expect something non UTF-8),
it is perfectly reasonable to do all their commit log messages
in their local encoding, as long as the members understand that
is the project's policy.  And it is probably reasonable to
assume that within one project, a single encoding is used for
commit log messages, although it may not be UTF-8.

What this means for qgit is that it is often sufficient for its
log browser to support one encoding at a time, provided if it
allows the user to switch which encoding to use depending on
what project is being viewed.

The trouble you had is however not with commit messages, but
with the blob contents (i.e. user data).  First of all, the user
data is just any binary goo for git, and the interpretation of
it is left to the Porcelains and the users.  There are two
things to talk about here.

I imagine qgit has, in addition to diff-between-revisions
viewer, a blob viewer that lets your users browse a whole file
in a given revision.  The files in the Documentation directory
in git.git/ right now happens to be encoded in UTF-8 because
they are asciidoc sources.  But other projects may use different
encodings, and even a single project can have its i18n message
files in different encodings and charsets in different files.
Users probably want to be able to view all of them, even if they
only understand a couple of languages and not others.

What this means for qgit is that at least you should be able to
show a whole file in a single encoding, but if you show more
than two files at the same time, one in each window, these
windows may be showing its contents in different encodings and
charsets.  So you would need to give a way to your users to tell
you what encoding each file is in.  Using global locale as the
default and having a way to override that per file basis would
be sufficient.

A more interesting thing about user data is the diff between
revisions.  How should you show the diff between
git-pack-redundant documentation that changes Lukas' name
encoded from latin-1 to UTF-8?

First, git-diff ("diff" it calls) is encoding agnostic.  The
lines that come out from it are taken from its input files and
if two revisions you compared both store your words in Italian
encoded in iso-8859-15, the output would be iso-8859-15.  IOW,
diff would end up doing the right thing but without knowing it.

The Lukas' name encoding patch would be handled the same way.
Diff output would just say "these lines have different bytes",
and spit out '-' line encoded in latin-1 and '+' in UTF-8.

This is a mess in one sense but not necessarily so.  If we could
say "Mr diff, the first file is in latin-1 and the second one is
in UTF-8, so compare them accordingly, and by the way we would
like the output in UTF-8 please", then it would be interesting
and may be sometimes useful, but in this particular case it is
useless -- there would not be any diff.  And the reason _I_ ran
diff before committing that change was to make sure I did the
encoding conversion correctly, so noticing the byte-level
differences was the right thing to do.

What should qgit do about this?  This "encoding gotcha fix
patch" is a special case, so I think it is perfectly reasonable
if qgit did not do anything special about it.  So the "per-file
encoding override" I suggested for whole-file viewer would be
adequate.  For the special "encoding fix" case, as I discussed
above, the most useful output is "raw bytes", so maybe throw in
a special encoding "raw" as one of the choices and I think you
are done.


[Footnote]

*1* Some people may argue unicode cannot spell all names, but
let's pretend it can -- or at least it can cover wider character
sets than any single local encodings.  Some people further may
argue that iso-2022 does better, but let's not go there.

*2* We do not forbid you to store arbitrary binary blob in your
commit objects.

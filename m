From: Willy Tarreau <w@1wt.eu>
Subject: [PATCH] sequencer.c: fix detection of duplicate s-o-b
Date: Sat, 12 Mar 2016 14:08:44 +0100
Message-ID: <20160312130844.GA25639@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 12 14:13:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aejMU-00083D-RE
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 14:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbcCLNIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 08:08:48 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:8328 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbcCLNIs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 08:08:48 -0500
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id u2CD8ikf025652
	for git@vger.kernel.org; Sat, 12 Mar 2016 14:08:44 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288749>

Hi,

after I upgraded my machine, I switched from git 1.7.12.2 to 2.6.4
and experienced an annoying regression when dealing with stable
kernel backports.

I'm using a "dorelease" script which relies on git-cherry-pick's
ability to properly detect duplicate s-o-b to ensure that all merged
commits are properly signed in a release. Today while preparing the
last 2.6.32 release, I did a git log before pushing and found some
commits having two s-o-b lines with myself. I found that these ones
were always those containing some backporting notes between the s-o-b
lines (which we all do in stable branches to indicate what was changed
in the backport process).

I didn't feel brave enough to individually deal with each offending
patch by hand so instead I bisected the git changes and found that the
behaviour changed with commit bab4d10 ("sequencer.c: teach append_signoff
how to detect duplicate s-o-b").

The reason is that function has_conforming_footer() immediately stops
after the first non-conforming line without checking if there are
conforming lines after. But if someone added signed-off-by anywhere
after a non-conforming block, it should always be considered as part
of the footer. Thus I adjusted the logic to check till the end of the
footer and report the presence of valid rfc2822 or cherry-picked lines
after the last non-conformant one and now it correctly handles all types
of commits I had to deal with (ie: only adds s-o-b when it doesn't match
the last one and doesn't add an empty line after a conformant one). For
example, this footer :

    Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
    [bwh: Backported to 3.2:
     - Adjust numbering in the comment
     - Adjust filename]
    Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
    Cc: Byungchul Park <byungchul.park@lge.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Willy Tarreau <w@1wt.eu>

Used to be turned into this :

    Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
    [bwh: Backported to 3.2:
     - Adjust numbering in the comment
     - Adjust filename]
    Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
    Cc: Byungchul Park <byungchul.park@lge.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Willy Tarreau <w@1wt.eu>

    Signed-off-by: Willy Tarreau <w@1wt.eu>

And is now properly converted to :

    Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
    [bwh: Backported to 3.2:
     - Adjust numbering in the comment
     - Adjust filename]
    Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
    Cc: Byungchul Park <byungchul.park@lge.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Willy Tarreau <w@1wt.eu>
    Signed-off-by: Willy Tarreau <w@1wt.eu>

Also, cherry-picking the last commit above again would produce this
before :

    Signed-off-by: Mike Galbraith <umgwanakikbuti@gmail.com>
    [bwh: Backported to 3.2:
     - Adjust numbering in the comment
     - Adjust filename]
    Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
    Cc: Byungchul Park <byungchul.park@lge.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Willy Tarreau <w@1wt.eu>
    Signed-off-by: Willy Tarreau <w@1wt.eu>

    Signed-off-by: Willy Tarreau <w@1wt.eu>

And it now is properly left untouched since the last s-o-b line
is properly matched.

I'm appending the patch, please include it upstream.

Thanks!
Willy


>From be9624a0df4c649d452f898925953a81dc9163fc Mon Sep 17 00:00:00 2001
From: Willy Tarreau <w@1wt.eu>
Date: Sat, 12 Mar 2016 13:35:35 +0100
Subject: sequencer.c: fix detection of duplicate s-o-b

Commit bab4d10 ("sequencer.c: teach append_signoff how to detect
duplicate s-o-b") changed the method used to detect duplicate s-o-b,
but it introduced a regression for a case where some non-compliant
information are present in the footer. In maintenance branches, it's
very common to add some elements after the signed-off and to add your
s-o-b after. This is used a lot in the stable kernel series, for
example this commit backported from 3.2 to 2.6.32 :

    ALSA: usb-audio: avoid freeing umidi object twice

    commit 07d86ca93db7e5cdf4743564d98292042ec21af7 upstream.

    The 'umidi' object will be free'd on the error path by snd_usbmidi_free()
    when tearing down the rawmidi interface. So we shouldn't try to free it
    in snd_usbmidi_create() after having registered the rawmidi interface.

    Found by KASAN.

    Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
    Acked-by: Clemens Ladisch <clemens@ladisch.de>
    Signed-off-by: Takashi Iwai <tiwai@suse.de>
    Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
    [wt: file is sound/midi/usbmidi.c in 2.6.32]
    Signed-off-by: Willy Tarreau <w@1wt.eu>

Prior to the commit above, a cherry-pick -s would not append an extra s-o-b.
After this commit, a new line and a second s-o-b are added, making the footer
look like this :

    Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
    Acked-by: Clemens Ladisch <clemens@ladisch.de>
    Signed-off-by: Takashi Iwai <tiwai@suse.de>
    Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
    [wt: file is sound/midi/usbmidi.c in 2.6.32]
    Signed-off-by: Willy Tarreau <w@1wt.eu>

    Signed-off-by: Willy Tarreau <w@1wt.eu>

This patch improves the parsing of the footer by considering the
presence of a valid rfc2822 line after possibly non-conformant lines.
Indeed, if someone added an s-o-b or CC after some stuff, this line
must properly be considered as part of the footer and not of the body.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 sequencer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index e66f2fe..ab2c18d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -64,6 +64,8 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	int len = sb->len - ignore_footer;
 	const char *buf = sb->buf;
 	int found_sob = 0;
+	int found_valid = 0;
+	int found_other = 0;
 
 	/* footer must end with newline */
 	if (!len || buf[len - 1] != '\n')
@@ -96,15 +98,18 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 		if (found_rfc2822 && sob &&
 		    !strncmp(buf + i, sob->buf, sob->len))
 			found_sob = k;
-
-		if (!(found_rfc2822 ||
-		      is_cherry_picked_from_line(buf + i, k - i - 1)))
-			return 0;
+		else if (found_rfc2822 ||
+			 is_cherry_picked_from_line(buf + i, k - i - 1))
+			found_valid = k;
+		else
+			found_other = k;
 	}
 	if (found_sob == i)
 		return 3;
-	if (found_sob)
+	if (found_sob > found_other)
 		return 2;
+	if (found_other > found_valid)
+		return 0;
 	return 1;
 }
 
-- 
2.6.4

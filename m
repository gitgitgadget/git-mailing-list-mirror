From: Jeff King <peff@peff.net>
Subject: [PATCH] is_hfs_dotgit: loosen over-eager match of \u{..47}
Date: Tue, 23 Dec 2014 03:45:36 -0500
Message-ID: <20141223084536.GA25190@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 09:45:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3L6C-0006a2-P9
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 09:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbaLWIpj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2014 03:45:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:56567 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754896AbaLWIpi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 03:45:38 -0500
Received: (qmail 18516 invoked by uid 102); 23 Dec 2014 08:45:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Dec 2014 02:45:38 -0600
Received: (qmail 20144 invoked by uid 107); 23 Dec 2014 08:45:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Dec 2014 03:45:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Dec 2014 03:45:36 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261717>

Our is_hfs_dotgit function relies on the hackily-implemented
next_hfs_char to give us the next character that an HFS+
filename comparison would look at. It's hacky because it
doesn't implement the full case-folding table of HFS+; it
gives us just enough to see if the path matches ".git".

At the end of next_hfs_char, we use tolower() to convert our
32-bit code point to lowercase. Our tolower() implementation
only takes an 8-bit char, though; it throws away the upper
24 bits. This means we can't have any false negatives for
is_hfs_dotgit. We only care about matching 7-bit ASCII
characters in ".git", and we will correctly process 'G' or
'g'.

However, we _can_ have false positives. Because we throw
away the upper bits, code point \u{0147} (for example) will
look like 'G' and get downcased to 'g'. It's not known
whether a sequence of code points whose truncation ends up
as ".git" is meaningful in any language, but it does not
hurt to be more accurate here. We can just pass out the full
32-bit code point, and compare it manually to the upper and
lowercase characters we care about.

Signed-off-by: Jeff King <peff@peff.net>
---
I saw Linus ask about this on G+. I had done the "no false
negative" analysis when writing the patch, but didn't
consider the false positive.

Another way of accomplishing the same thing is for next_hfs_char to
continue folding case, but _only_ do so for 8-bit code points. Like:

  return (out & 0xffffff00) ? out : tolower(out);

I think the what's below is more obvious (and is actually
how I originally wrote it; I switched to using tolower()
during development to try to make it more readable).

 t/t1450-fsck.sh | 16 ++++++++++++++++
 utf8.c          | 17 ++++++++++++-----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 1f04b8a..3f5883d 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -349,6 +349,22 @@ dot-backslash-case .\\\\.GIT\\\\foobar
 dotgit-case-backslash .git\\\\foobar
 EOF
=20
+test_expect_success 'fsck allows .=C5=87it' '
+	(
+		git init not-dotgit &&
+		cd not-dotgit &&
+		echo content >file &&
+		git add file &&
+		git commit -m base &&
+		blob=3D$(git rev-parse :file) &&
+		printf "100644 blob $blob\t.\\305\\207it" >tree &&
+		tree=3D$(git mktree <tree) &&
+		git fsck 2>err &&
+		cat err &&
+		! test -s err
+	)
+'
+
 # create a static test repo which is broken by omitting
 # one particular object ($1, which is looked up via rev-parse
 # in the new repository).
diff --git a/utf8.c b/utf8.c
index 9a3f4ad..34a779e 100644
--- a/utf8.c
+++ b/utf8.c
@@ -606,7 +606,7 @@ static ucs_char_t next_hfs_char(const char **in)
 		 * but this is enough to catch anything that will convert
 		 * to ".git"
 		 */
-		return tolower(out);
+		return out;
 	}
 }
=20
@@ -614,10 +614,17 @@ int is_hfs_dotgit(const char *path)
 {
 	ucs_char_t c;
=20
-	if (next_hfs_char(&path) !=3D '.' ||
-	    next_hfs_char(&path) !=3D 'g' ||
-	    next_hfs_char(&path) !=3D 'i' ||
-	    next_hfs_char(&path) !=3D 't')
+	c =3D next_hfs_char(&path);
+	if (c !=3D '.')
+		return 0;
+	c =3D next_hfs_char(&path);
+	if (c !=3D 'g' && c !=3D 'G')
+		return 0;
+	c =3D next_hfs_char(&path);
+	if (c !=3D 'i' && c !=3D 'I')
+		return 0;
+	c =3D next_hfs_char(&path);
+	if (c !=3D 't' && c !=3D 'T')
 		return 0;
 	c =3D next_hfs_char(&path);
 	if (c && !is_dir_sep(c))
--=20
2.2.1.376.gec59d43

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/RFC] Document format of basic Git objects
Date: Wed, 15 Feb 2012 20:22:20 +0700
Message-ID: <1329312140-24089-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 14:15:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rxehi-0003vZ-Lw
	for gcvg-git-2@plane.gmane.org; Wed, 15 Feb 2012 14:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758172Ab2BONPH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Feb 2012 08:15:07 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34218 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756094Ab2BONPG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Feb 2012 08:15:06 -0500
Received: by pbcun15 with SMTP id un15so1385695pbc.19
        for <git@vger.kernel.org>; Wed, 15 Feb 2012 05:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=VYPFunybMl7fSBNdzxTS4VRo7AYZF1u9byeHNMtNns0=;
        b=aMC9IzlmfYv68k8h7p7qWCTZmvzAN0BrBR5cfbLfPrNvbFuPi1q4jYoFAn2kc5eXIW
         8hj125AACG983v41/qcrMzLWAHtry717+HUyi8ylDul5onu1b5ihlryW2PNO8R0xFeoI
         pVAnhqpjpIJAL0rAz3p+7BmM7cOooeydU9iH8=
Received: by 10.68.224.9 with SMTP id qy9mr3493805pbc.102.1329311705913;
        Wed, 15 Feb 2012 05:15:05 -0800 (PST)
Received: from tre ([115.74.57.120])
        by mx.google.com with ESMTPS id q8sm10709743pbi.1.2012.02.15.05.15.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 15 Feb 2012 05:15:04 -0800 (PST)
Received: by tre (sSMTP sendmail emulation); Wed, 15 Feb 2012 20:22:21 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190829>

Basic objects' format is pretty simple and (I think) well-known.
However it's good that we document them. At least we can keep track of
the evolution of an object format. The commit object, for example,
over the years has learned "encoding" and recently GPG signing.

This is just a draft text with a bunch of fixmes. But I'd like to hear
from the community if this is a worthy effort. If so, then whether
git-cat-file is a proper place for it. Or maybe we put relevant text
in commit-tree, write-tree and mktag, then refer to them in cat-file
because cat-file can show raw objects.

So comments?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 PS. This also makes me wonder if tag object supports "encoding".
 Haven't dug down in history yet.

 Documentation/git-cat-file.txt |   40 ++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-fil=
e.txt
index 2fb95bb..e3dd6d9 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -100,6 +100,46 @@ for each object specified on stdin that does not e=
xist in the repository:
 <object> SP missing LF
 ------------
=20
+OBJECT FORMAT
+-------------
+
+Tree object consists of a series of tree entries sorted in memcmp()
+order by entry name. Each entry consists of:
+
+- POSIX file mode encoded in octal ascii
+- One space character
+- Entry name terminated by one character NUL
+- 20 byte SHA-1 of the entry
+
+Tag object is ascii plain text in a format similar to email format
+(RFC 822). It consists of a header and a body, separated by a blank
+line. The header includes exactly four fields in the following order:
+
+1. "object" field, followed by SHA-1 in ascii of the tagged object
+2. "type" field, followed by the type in ascii of the tagged object
+   (either "commit", "tag", "blob" or "tree" without quotes,
+   case-sensitive)
+3. "tag" field, followed by the tag name
+4. "tagger" field, followed by the <XXX, to be named>
+
+The tag body contains the tag's message and possibly GPG signature.
+
+Commit object is in similar format to tag object. The commit body is
+in plain text of the chosen encoding (by default UTF-8). The commit
+header has the following fields in listed order
+
+1. One "tree" field, followed by the commit's tree's SHA-1 in ascii
+2. Zero, one or more "parent" field
+3. One "author" field, in <XXX to be named> format
+3. One "committer" field, in <XXX to be named> format
+4. Optionally one "encoding" field, followed by the encoding used for
+   commit body
+5. GPG signature (fixme)
+
+More headers after these fields are allowed. Unrecognized header
+fields must be kept untouched if the commit is rewritten. However, a
+compliant Git implementation produces the above header fields only.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
--=20
1.7.8.36.g69ee2

From: Alex Riesen <raa.lkml@gmail.com>
Subject: allow only a strictly defined set of references under .git/
Date: Fri, 16 Dec 2005 09:24:35 +0100
Message-ID: <81b0412b0512160024q47afe0b9v1b7f217a6cecfe68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1789_27983781.1134721475613"
X-From: git-owner@vger.kernel.org Fri Dec 16 09:24:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnAtM-0001Qv-1l
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 09:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVLPIYh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Dec 2005 03:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVLPIYh
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Dec 2005 03:24:37 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:26800 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932179AbVLPIYg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2005 03:24:36 -0500
Received: by nproxy.gmail.com with SMTP id m18so179946nfc
        for <git@vger.kernel.org>; Fri, 16 Dec 2005 00:24:35 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type;
        b=d2bp23cuyxdzzbb4lGrC6FR2ga7tHtL23P1BcNBc7XwKuak+Rcve/cGxJuzeL6QkC7xv25k9BtWW0uca2481mjbmrXB7umRVzzAqXACk7TX6J4je/NyO2RCiMjPX5f96fIALi+qpIihMKEmG6t9YfVTuHwt9GRNwbx6lVpFVwhM=
Received: by 10.48.199.4 with SMTP id w4mr131238nff;
        Fri, 16 Dec 2005 00:24:35 -0800 (PST)
Received: by 10.48.248.18 with HTTP; Fri, 16 Dec 2005 00:24:35 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13732>

------=_Part_1789_27983781.1134721475613
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The patch below reminded me of something:

  +               /* We want to allow .git/description file and
  +                * "description" branch to exist at the same time.
  +                * "git-rev-parse description" should silently skip
  +                * .git/description file as a candidate for
  +                * get_sha1().  However, having garbage file anywhere
  +                * under refs/ is not OK, and we would not have caught
  +                * ambiguous heads and tags with the above test.
  +                */
  +               else if (**p && !access(pathname, F_OK)) {
  +                       /* Garbage exists under .git/refs */
  +                       return error("garbage ref found '%s'", pathname);
  +               }

Maybe we should only allow only a strictly defined set of refnames
under $GIT_DIR? The directory is used pretty much for anything else
(temporary message files, config, description).

So, if we, say, allow only HEAD, ORIG_HEAD, and MERGE_HEAD to be
references in .git/ and ignore everything else. Then there will be no
ambiguity anymore and no need to parse "description" or "config"
reference (besides, I can very simply imagine a message file
containing "ref: refs/heads/foo").

Does it make sense or have I missed some very informative discussion
as to why we do allow references to be anywhere in .git?

------=_Part_1789_27983781.1134721475613
Content-Type: text/plain; 
	name=0001-The-patch-below-reminded-me-of-something.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="0001-The-patch-below-reminded-me-of-something.txt"

Subject: [PATCH] The patch below reminded me of something:

  +               /* We want to allow .git/description file and
  +                * "description" branch to exist at the same time.
  +                * "git-rev-parse description" should silently skip
  +                * .git/description file as a candidate for
  +                * get_sha1().  However, having garbage file anywhere
  +                * under refs/ is not OK, and we would not have caught
  +                * ambiguous heads and tags with the above test.
  +                */
  +               else if (**p && !access(pathname, F_OK)) {
  +                       /* Garbage exists under .git/refs */
  +                       return error("garbage ref found '%s'", pathname);
  +               }

Maybe we should only allow only a strictly defined set of refnames under $GIT_DIR? The directory is used pretty much for anything else (temporary message files, config, description).

So, if we, say, allow only HEAD, ORIG_HEAD, and MERGE_HEAD to be references in .git/ and ignore everything else. Then there will be no ambiguity anymore and no need to parse "description" or "config" reference (besides, I can very simply imagine a message file containing "ref: refs/heads/foo").

Does it make sense or have I missed some very informative discussion as to why we do allow references to be anywhere in .git?

---

 sha1_name.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

4a0ef1ed775d2311da7125257cb734d561fd2ef1
diff --git a/sha1_name.c b/sha1_name.c
index bf8f0f0..dce1574 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -247,7 +247,27 @@ static int get_sha1_basic(const char *st
 	if (ambiguous_path(str, len))
 		return -1;
 
-	for (p = prefix; *p; p++) {
+	p = prefix;
+	/* Check references _without_ leading directories */
+	if (!memchr(str, '/', len)) {
+		/* only these references can be directly in $GIT_DIR... */
+		static const char *git_refs[] = {
+			"HEAD",
+			"ORIG_HEAD",
+			"FETCH_HEAD",
+			"MERGE_HEAD",
+			NULL
+		};
+		const char **r;
+		for (r = git_refs; *r; ++r)
+			if (strlen(*r) == len && strncmp(*r, str, len) == 0)
+				break;
+		/* ...all the others have to be somewhere under .git/refs/ */
+		if ( !*r )
+			++p;
+	}
+
+	for (; *p; p++) {
 		char *pathname = git_path("%s/%.*s", *p, len, str);
 
 		if (!read_ref(pathname, sha1)) {
-- 
0.99.9.GIT

------=_Part_1789_27983781.1134721475613--

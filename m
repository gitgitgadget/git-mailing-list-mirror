From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] describe: Break annotated tag ties by tagger date
Date: Sat, 10 Apr 2010 18:54:33 -0700
Message-ID: <20100411015433.GB23075@spearce.org>
References: <0B8BD2B7-E6F9-4EFC-BCD6-2B2E876AD1FC@spy.net> <20100402183147.GA20007@spearce.org> <4BBB0377.8080007@op5.se> <20100411002825.GA23075@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Dustin Sallings <dustin@spy.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 03:54:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0mNn-0008JV-L0
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 03:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab0DKByi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 21:54:38 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:35393 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752517Ab0DKByh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 21:54:37 -0400
Received: by qyk9 with SMTP id 9so2721170qyk.1
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 18:54:36 -0700 (PDT)
Received: by 10.229.224.79 with SMTP id in15mr3240618qcb.76.1270950876615;
        Sat, 10 Apr 2010 18:54:36 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id v26sm4092360qce.1.2010.04.10.18.54.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 18:54:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100411002825.GA23075@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144624>

If more than one annotated tag points at the same commit, use the
tag whose tagger field has a more recent date stamp.  This resolves
non-deterministic cases where the maintainer has done:

  $ git tag -a -m "2.1-rc1" v2.1-rc1  deadbeef
  $ git tag -a -m "2.1"     v2.1      deadbeef

If the tag is an older-style annotated tag with no tagger date,
we assume a date stamp of 1 second after the UNIX epoch. This will
cause us to prefer an annotated tag that has a valid date, or to
simply avoid scanning the tag object again if a 3rd tag was found
for the same commit.

We could also try to consider the tag object chain, favoring a tag
that "includes" another one:

  $ git tag -a -m "2.1-rc0" v2.1-rc1  deadbeef
  $ git tag -a -m "2.1"     v2.1      v2.1-rc1

However traversing the tag's object chain looking for inclusion
is much more complicated.  Its already very likely that even in
these cases the v2.1 tag will have a more recent tagger date than
v2.1-rc1, so with this change describe should still resolve this
by selecting the more recent v2.1.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin/describe.c  |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 t/t6120-describe.sh |    8 ++++--
 2 files changed, 63 insertions(+), 4 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 71be2a9..cf98664 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -36,6 +36,7 @@ static const char *diff_index_args[] = {
 struct commit_name {
 	struct tag *tag;
 	int prio; /* annotated tag = 2, tag = 1, head = 0 */
+	unsigned long date;
 	unsigned char sha1[20];
 	char path[FLEX_ARRAY]; /* more */
 };
@@ -43,18 +44,74 @@ static const char *prio_names[] = {
 	"head", "lightweight", "annotated",
 };
 
+static unsigned long tag_date(const unsigned char *sha1)
+{
+	enum object_type type;
+	unsigned long size;
+	char *buf;
+	int offset = 0;
+	unsigned long time = 1;
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (buf && type == OBJ_TAG) {
+		while (offset < size && buf[offset] != '\n') {
+			int new_offset = offset + 1;
+			while (new_offset < size && buf[new_offset++] != '\n')
+				; /* do nothing */
+			if (!prefixcmp(buf + offset, "tagger ")) {
+				char *line = buf + offset + 7;
+				char *date;
+
+				buf[new_offset] = '\0';
+				date = strchr(line, '>');
+				if (date)
+					time = strtoul(date + 1, NULL, 10);
+				break;
+			}
+			offset = new_offset;
+		}
+	} else
+		error("missing tag %s", sha1_to_hex(sha1));
+	free(buf);
+	return time;
+}
+
+static int replace_name(struct commit_name *e,
+			       int prio,
+			       const unsigned char *sha1,
+			       unsigned long *date)
+{
+	if (!e || e->prio < prio)
+		return 1;
+
+	if (e->prio == 2 && prio == 2) {
+		/* Multiple annotated tags point to the same commit.
+		 * Select one to keep based upon their tagger date.
+		 */
+		if (!e->date)
+			e->date = tag_date(e->sha1);
+		*date = tag_date(sha1);
+		if (e->date < *date)
+			return 1;
+	}
+
+	return 0;
+}
+
 static void add_to_known_names(const char *path,
 			       struct commit *commit,
 			       int prio,
 			       const unsigned char *sha1)
 {
 	struct commit_name *e = commit->util;
-	if (!e || e->prio < prio) {
+	unsigned long date = 0;
+	if (replace_name(e, prio, sha1, &date)) {
 		size_t len = strlen(path)+1;
 		free(e);
 		e = xmalloc(sizeof(struct commit_name) + len);
 		e->tag = NULL;
 		e->prio = prio;
+		e->date = date;
 		hashcpy(e->sha1, sha1);
 		memcpy(e->path, path, len);
 		commit->util = e;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 065dead..876d1ab 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -8,7 +8,7 @@ test_description='test describe
  o----o----o----o----o----.    /
        \        A    c        /
         .------------o---o---o
-                     D   e
+                   D,R   e
 '
 . ./test-lib.sh
 
@@ -68,6 +68,8 @@ test_expect_success setup '
 	echo D >another && git add another && git commit -m D &&
 	test_tick &&
 	git tag -a -m D D &&
+	test_tick &&
+	git tag -a -m R R &&
 
 	test_tick &&
 	echo DD >another && git commit -a -m another &&
@@ -89,10 +91,10 @@ test_expect_success setup '
 
 check_describe A-* HEAD
 check_describe A-* HEAD^
-check_describe D-* HEAD^^
+check_describe R-* HEAD^^
 check_describe A-* HEAD^^2
 check_describe B HEAD^^2^
-check_describe D-* HEAD^^^
+check_describe R-* HEAD^^^
 
 check_describe c-* --tags HEAD
 check_describe c-* --tags HEAD^
-- 
1.7.1.rc1.232.gc76b8

-- 
Shawn.

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH RFC] commit: allow to commit even if there are intent-to-add entries
Date: Wed, 11 Jan 2012 13:01:47 +0700
Message-ID: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 07:02:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkrG8-0002Vf-At
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 07:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032Ab2AKGB6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 01:01:58 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:49041 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752303Ab2AKGB5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 01:01:57 -0500
Received: by obbup16 with SMTP id up16so399576obb.19
        for <git@vger.kernel.org>; Tue, 10 Jan 2012 22:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=K5d+3YRRrFlMQPt3r8tjELsE9x7IZzkcF4zTJKD7hVg=;
        b=g6isQyzYxXQN4iVjZy9Gv0lG2DU6/9RSgUQwkT5LvK0Nt10r6m5F5wGNJtp+B+jT13
         A15PJI1jE5DdYWeAhw46Yd+UQRx1bbo2JroE7TRykeCTUrqTAwVASCXzsDHgk8aJJ67s
         P5HGsV8OR5XhrzcyEa5SsXwAVz9RGLL6kbZ5M=
Received: by 10.50.236.67 with SMTP id us3mr5196986igc.14.1326261717309;
        Tue, 10 Jan 2012 22:01:57 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id rc7sm6991156igb.0.2012.01.10.22.01.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Jan 2012 22:01:56 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Wed, 11 Jan 2012 13:01:48 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188334>

This patch replaces the approach in 331fcb5 (git add --intent-to-add:
do not let an empty blob be committed by accident) regarding i-t-a
entries: instead of forbidding i-t-a entries at commit time, we can
simply ignore them.

We already ignore CE_REMOVE entries while updating cache-tree. Putting
CE_INTENT_TO_ADD ones in the same category should not cause any negativ=
e
effects regarding cache-tree.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 On the few chances I have to use "git add -N" it does not fit well
 with "git add -p; git diff --cached; git commit -m foo" style. I
 think this may be a good thing to do.

 builtin/commit.c      |    2 +-
 builtin/write-tree.c  |    2 +-
 cache-tree.c          |   14 +++++---------
 t/t2203-add-intent.sh |   10 +++++++++-
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index eba1377..767b78a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -871,7 +871,7 @@ static int prepare_to_commit(const char *index_file=
, const char *prefix,
 	discard_cache();
 	read_cache_from(index_file);
 	if (update_main_cache_tree(0)) {
-		error(_("Error building trees"));
+		error(_("Error building trees; the index is unmerged?"));
 		return 0;
 	}
=20
diff --git a/builtin/write-tree.c b/builtin/write-tree.c
index b223af4..68baa24 100644
--- a/builtin/write-tree.c
+++ b/builtin/write-tree.c
@@ -46,7 +46,7 @@ int cmd_write_tree(int argc, const char **argv, const=
 char *unused_prefix)
 		die("%s: error reading the index", me);
 		break;
 	case WRITE_TREE_UNMERGED_INDEX:
-		die("%s: error building trees", me);
+		die("%s: error building trees; the index is unmerged?", me);
 		break;
 	case WRITE_TREE_PREFIX_ERROR:
 		die("%s: prefix %s not found", me, prefix);
diff --git a/cache-tree.c b/cache-tree.c
index 8de3959..47defd1 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -158,19 +158,15 @@ static int verify_cache(struct cache_entry **cach=
e,
 	funny =3D 0;
 	for (i =3D 0; i < entries; i++) {
 		struct cache_entry *ce =3D cache[i];
-		if (ce_stage(ce) || (ce->ce_flags & CE_INTENT_TO_ADD)) {
+		if (ce_stage(ce)) {
 			if (silent)
 				return -1;
 			if (10 < ++funny) {
 				fprintf(stderr, "...\n");
 				break;
 			}
-			if (ce_stage(ce))
-				fprintf(stderr, "%s: unmerged (%s)\n",
-					ce->name, sha1_to_hex(ce->sha1));
-			else
-				fprintf(stderr, "%s: not added yet\n",
-					ce->name);
+			fprintf(stderr, "%s: unmerged (%s)\n",
+				ce->name, sha1_to_hex(ce->sha1));
 		}
 	}
 	if (funny)
@@ -338,8 +334,8 @@ static int update_one(struct cache_tree *it,
 				mode, sha1_to_hex(sha1), entlen+baselen, path);
 		}
=20
-		if (ce->ce_flags & CE_REMOVE)
-			continue; /* entry being removed */
+		if (ce->ce_flags & (CE_REMOVE | CE_INTENT_TO_ADD))
+			continue; /* entry being removed or just placeholder */
=20
 		strbuf_grow(&buffer, entlen + 100);
 		strbuf_addf(&buffer, "%o %.*s%c", mode, entlen, path + baselen, '\0'=
);
diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
index 2543529..65430e4 100755
--- a/t/t2203-add-intent.sh
+++ b/t/t2203-add-intent.sh
@@ -41,7 +41,15 @@ test_expect_success 'cannot commit with i-t-a entry'=
 '
 	echo frotz >nitfol &&
 	git add rezrov &&
 	git add -N nitfol &&
-	test_must_fail git commit -m initial
+	git commit -m initial &&
+	git ls-tree -r HEAD >actual &&
+	cat >expected <<EOF &&
+100644 blob ce013625030ba8dba906f756967f9e9ca394464a	elif
+100644 blob ce013625030ba8dba906f756967f9e9ca394464a	file
+100644 blob cf7711b63209d0dbc2d030f7fe3513745a9880e4	rezrov
+EOF
+	test_cmp expected actual &&
+	git reset HEAD^
 '
=20
 test_expect_success 'can commit with an unrelated i-t-a entry in index=
' '
--=20
1.7.3.1.256.g2539c.dirty

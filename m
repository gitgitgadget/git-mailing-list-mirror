From: Kevin Bracey <kevin@bracey.fi>
Subject: [PATCH 2/2] revision.c: treat A...B merge bases as if manually specified
Date: Mon, 13 May 2013 18:00:47 +0300
Message-ID: <1368457247-19822-3-git-send-email-kevin@bracey.fi>
References: <5190F806.6040207@bracey.fi>
 <1368457247-19822-1-git-send-email-kevin@bracey.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Kevin Bracey <kevin@bracey.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 13 17:01:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbuFW-00059M-Nv
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 17:01:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab3EMPBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 11:01:10 -0400
Received: from 13.mo5.mail-out.ovh.net ([87.98.182.191]:55874 "EHLO
	mo5.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754207Ab3EMPBH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 11:01:07 -0400
Received: from mail624.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with SMTP id BC7E4FFA5F8
	for <git@vger.kernel.org>; Mon, 13 May 2013 17:01:05 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 13 May 2013 17:01:24 +0200
Received: from 85-23-153-122.bb.dnainternet.fi (HELO asus-i7-debian.bracey.fi) (kevin@bracey.fi@85.23.153.122)
  by ns0.ovh.net with SMTP; 13 May 2013 17:01:21 +0200
X-Ovh-Mailout: 178.32.228.5 (mo5.mail-out.ovh.net)
X-Mailer: git-send-email 1.8.3.rc0.28.g4b02ef5
In-Reply-To: <1368457247-19822-1-git-send-email-kevin@bracey.fi>
X-Ovh-Tracer-Id: 18295874755989728
X-Ovh-Remote: 85.23.153.122 (85-23-153-122.bb.dnainternet.fi)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: -100
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrjeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeeifedrjeehucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224166>

The documentation assures users that "A...B" is defined as "A B --not
$(git merge-base --all A B)". This wasn't in fact quite true, because
the calculated merge bases were not sent to add_rev_cmdline().

The main effect of this was that although

  git rev-list --ancestry-path A B --not $(git merge-base --all A B)

worked, the simpler form

  git rev-list --ancestry-path A...B

failed with a "no bottom commits" error.

Other potential users of bottom commits could also be affected by this
problem, if they examine revs->cmdline_info; I came across the issue in
my proposed history traversal refinements series.

So ensure that the calculated merge bases are sent to add_rev_cmdline(),
flagged with new 'whence' enum value REV_CMD_MERGE_BASE.

Signed-off-by: Kevin Bracey <kevin@bracey.fi>
---
 revision.c                        | 17 +++++++++++++++++
 revision.h                        |  1 +
 t/t6019-rev-list-ancestry-path.sh |  2 +-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index a67b615..7f7a8ab 100644
--- a/revision.c
+++ b/revision.c
@@ -915,6 +915,19 @@ static void add_rev_cmdline(struct rev_info *revs,
 	info->nr++;
 }
 
+static void add_rev_cmdline_list(struct rev_info *revs,
+				 struct commit_list *commit_list,
+				 int whence,
+				 unsigned flags)
+{
+	while (commit_list) {
+		struct object *object = &commit_list->item->object;
+		add_rev_cmdline(revs, object, sha1_to_hex(object->sha1),
+				whence, flags);
+		commit_list = commit_list->next;
+	}
+}
+
 struct all_refs_cb {
 	int all_flags;
 	int warned_bad_reflog;
@@ -1092,6 +1105,7 @@ static void prepare_show_merge(struct rev_info *revs)
 	add_pending_object(revs, &head->object, "HEAD");
 	add_pending_object(revs, &other->object, "MERGE_HEAD");
 	bases = get_merge_bases(head, other, 1);
+	add_rev_cmdline_list(revs, bases, REV_CMD_MERGE_BASE, UNINTERESTING);
 	add_pending_commit_list(revs, bases, UNINTERESTING);
 	free_commit_list(bases);
 	head->object.flags |= SYMMETRIC_LEFT;
@@ -1179,6 +1193,9 @@ int handle_revision_arg(const char *arg_, struct rev_info *revs, int flags, unsi
 
 			if (symmetric) {
 				exclude = get_merge_bases(a, b, 1);
+				add_rev_cmdline_list(revs, exclude,
+						     REV_CMD_MERGE_BASE,
+						     flags_exclude);
 				add_pending_commit_list(revs, exclude,
 							flags_exclude);
 				free_commit_list(exclude);
diff --git a/revision.h b/revision.h
index 01bd2b7..878a555 100644
--- a/revision.h
+++ b/revision.h
@@ -35,6 +35,7 @@ struct rev_cmdline_info {
 			REV_CMD_PARENTS_ONLY,
 			REV_CMD_LEFT,
 			REV_CMD_RIGHT,
+			REV_CMD_MERGE_BASE,
 			REV_CMD_REV
 		} whence;
 		unsigned flags;
diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
index 5287f6a..dd5b0e5 100755
--- a/t/t6019-rev-list-ancestry-path.sh
+++ b/t/t6019-rev-list-ancestry-path.sh
@@ -81,7 +81,7 @@ test_expect_success 'rev-list F...I' '
 	test_cmp expect actual
 '
 
-test_expect_failure 'rev-list --ancestry-path F...I' '
+test_expect_success 'rev-list --ancestry-path F...I' '
 	for c in F H I; do echo $c; done >expect &&
 	git rev-list --ancestry-path --format=%s F...I |
 	sed -e "/^commit /d" |
-- 
1.8.3.rc0.28.g4b02ef5

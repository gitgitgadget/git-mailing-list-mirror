From: "Nick Edelen" <sirnot@gmail.com>
Subject: Re: [PATCH 7/6 (v4)] support for commit grafts, slight change to
 general mechanism
Date: Sun, 27 Sep 2009 23:44:13 +0100
Message-ID: <op.u0xtfzjrtdk399@sirnot.ed.ac.uk>
References: <op.uzv4dyuotdk399@sirnot.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
To: "Nick Edelen" <sirnot@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.n
X-From: git-owner@vger.kernel.org Mon Sep 28 00:45:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ms2Tl-0002Vf-Ms
	for gcvg-git-2@lo.gmane.org; Mon, 28 Sep 2009 00:44:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbZI0WoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Sep 2009 18:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751781AbZI0WoU
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Sep 2009 18:44:20 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:50508 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbZI0WoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Sep 2009 18:44:19 -0400
Received: by ewy7 with SMTP id 7so3978894ewy.17
        for <git@vger.kernel.org>; Sun, 27 Sep 2009 15:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:to:subject
         :references:date:mime-version:content-transfer-encoding:from
         :message-id:in-reply-to:user-agent;
        bh=ullfzD/00YseG+WkdtfK3e+vPxNifL2aQkvEh/FwJgs=;
        b=BlhUcgUN6GjrthaUP4YJRpBUwHBUZbW7sXp0PNVoVcwIGUkngUy44hsa29Kqcie/GT
         mJtuc9Evcb5cYSZfncqPH5b9R47HiKEzvOvWpcFrENtC1FHbkIa/gjWbA66V7C/yjRs7
         iNIMGJ4FFRJHYEQNmf+XY57IbelO+fuvkHzrA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:to:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        b=aHLEhR/CoSfHo6sUf5APcLDxgP+Kebbzjx5yhjYLi3loS5q/t0UjOoX2hdUv6XJs5h
         yUishQql68Ypj79ninUmzhfeT+vlB8nf2Xt/imM9hDBXPEyMxVMmbDt90+TSn8dMoj55
         rA//005MeoeNw9g4gEzLY3jU7rFABnceRgt0s=
Received: by 10.211.132.37 with SMTP id j37mr2931621ebn.76.1254091461920;
        Sun, 27 Sep 2009 15:44:21 -0700 (PDT)
Received: from sirnot.ed.ac.uk (cpat002.wlan.net.ed.ac.uk [129.215.5.254])
        by mx.google.com with ESMTPS id 24sm470395eyx.0.2009.09.27.15.44.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Sep 2009 15:44:21 -0700 (PDT)
In-Reply-To: <op.uzv4dyuotdk399@sirnot.private>
User-Agent: Opera Mail/10.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129220>

Adds support for graft commits in rev-cache (w/ test), and slightly alters
graft mechanism.  Before, parse_commit() checked the graft list on every
commit.  Now register_commit_graft() preemptively loads graft commits into
memory, and sets a new 'graft' flag in the object.  This allows awareness of
the commits' medical history without searching a (normally private) array upon
each commit.

Signed-off-by: Nick Edelen <sirnot@gmail.com>

---
In my infinite wisdom, I had forgotten to actually load the graft file in the
mechanism change.  This rectifies the error, fixing test t6001-rev-list-graft.
(this was the only test that I found rev-cache to break; if you find others
please tell me!)

  builtin-rev-cache.c       |   14 ++++++++++++--
  commit.c                  |   27 +++++++++++++++++++++++++--
  object.h                  |    3 ++-
  rev-cache.c               |   32 ++++++++++++++++++++++++++++++++
  t/t6017-rev-cache-list.sh |    6 ++++++
  5 files changed, 77 insertions(+), 5 deletions(-)

diff --git a/builtin-rev-cache.c b/builtin-rev-cache.c
index 4c1766d..b36bc39 100644
--- a/builtin-rev-cache.c
+++ b/builtin-rev-cache.c
@@ -102,8 +102,18 @@ static int test_rev_list(int argc, const char *argv[])
  			flags ^= UNINTERESTING;
  		else if (!strcmp(argv[i], "--objects"))
  			revs.tree_objects = revs.blob_objects = 1;
-		else
-			handle_revision_arg(argv[i], &revs, flags, 1);
+		else {
+			struct commit_graft graft;
+
+			if (argv[i][0] == ':') {
+				handle_revision_arg(argv[i] + 1, &revs, flags, 1);
+
+				hashcpy(graft.sha1, revs.pending.objects[revs.pending.nr - 1].item->sha1);
+				graft.nr_parent = -1;
+				register_commit_graft(&graft, 0);
+			} else
+				handle_revision_arg(argv[i], &revs, flags, 1);
+		}
  	}

  	setup_revisions(0, 0, &revs, 0);
diff --git a/commit.c b/commit.c
index b7485c4..dd0e3ca 100644
--- a/commit.c
+++ b/commit.c
@@ -99,6 +99,7 @@ static int commit_graft_pos(const unsigned char *sha1)

  int register_commit_graft(struct commit_graft *graft, int ignore_dups)
  {
+	struct commit *commit;
  	int pos = commit_graft_pos(graft->sha1);

  	if (0 <= pos) {
@@ -123,6 +124,12 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
  			(commit_graft_nr - pos - 1) *
  			sizeof(*commit_graft));
  	commit_graft[pos] = graft;
+
+	commit = lookup_commit(graft->sha1);
+	commit->object.graft = 1;
+	commit->object.parsed = 0;
+	parse_commit(commit); /* in case commit was already parsed */
+
  	return 0;
  }

@@ -221,6 +228,7 @@ int write_shallow_commits(int fd, int use_pack_protocol)

  int unregister_shallow(const unsigned char *sha1)
  {
+	struct commit *commit;
  	int pos = commit_graft_pos(sha1);
  	if (pos < 0)
  		return -1;
@@ -229,6 +237,12 @@ int unregister_shallow(const unsigned char *sha1)
  				sizeof(struct commit_graft *)
  				* (commit_graft_nr - pos - 1));
  	commit_graft_nr--;
+
+	commit = lookup_commit(sha1);
+	commit->object.graft = 0;
+	commit->object.parsed = 0;
+	parse_commit(commit);
+
  	return 0;
  }

@@ -255,7 +269,13 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
  	while (pop_commit(pptr))
  		; /* clear anything from cache */

-	graft = lookup_commit_graft(item->object.sha1);
+	/* make sure .graft flag is initialized */
+	prepare_commit_graft();
+	if (item->object.graft)
+		graft = lookup_commit_graft(item->object.sha1);
+	else
+		graft = 0;
+
  	while (bufptr + 48 < tail && !memcmp(bufptr, "parent ", 7)) {
  		struct commit *new_parent;

@@ -283,7 +303,10 @@ int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
  				continue;
  			pptr = &commit_list_insert(new_parent, pptr)->next;
  		}
-	}
+		item->object.graft = 1;
+	} else
+		item->object.graft = 0;
+
  	item->date = parse_commit_date(bufptr, tail);

  	return 0;
diff --git a/object.h b/object.h
index 89dd0c4..f848e0f 100644
--- a/object.h
+++ b/object.h
@@ -22,7 +22,7 @@ struct object_array {
  };

  #define TYPE_BITS   3
-#define FLAG_BITS  27
+#define FLAG_BITS  26

  /*
   * The object type is stored in 3 bits.
@@ -30,6 +30,7 @@ struct object_array {
  struct object {
  	unsigned parsed : 1;
  	unsigned used : 1;
+	unsigned graft : 1;
  	unsigned type : TYPE_BITS;
  	unsigned flags : FLAG_BITS;
  	unsigned char sha1[20];
diff --git a/rev-cache.c b/rev-cache.c
index 6c96297..f7b1cd2 100644
--- a/rev-cache.c
+++ b/rev-cache.c
@@ -664,9 +664,41 @@ static int traverse_cache_slice_1(struct rc_slice_header *head, unsigned char *m
  			}
  		} else if (!ipath_nr && co->date <= date)
  			slop--;
+		else if (!ipath_nr && !upath_nr)
+			break;
  		else
  			slop = SLOP;

+		/* before opening further topo-relations, check if the parenting has had medical attention */
+		if (obj->graft) {
+			struct commit_list *list;
+
+			parse_commit(co);
+			obj->flags &= ~FACE_VALUE;
+			last_objects[path] = 0;
+
+			/* we're only interested in its indirect influence */
+			for (list = co->parents; list; list = list->next) {
+				struct rc_index_entry *iep;
+				struct object *po = &list->item->object;
+
+				iep = search_index(po->sha1);
+				if (!iep || hashcmp(idx_caches + 20 * iep->cache_index, head->sha1)) {
+					if (!(obj->flags & UNINTERESTING) && !(po->flags & UNINTERESTING))
+						ioutside = 1;
+				}
+			}
+
+			/* an abrupt end */
+			myworkp = &commit_list_insert(co, myworkp)->next;
+			if (entry->uninteresting)
+				upath_nr--;
+			else
+				ipath_nr--;
+			paths[path] = 0;
+			continue;
+		}
+
  		/* open parents */
  		if (entry->merge_nr) {
  			int j, off = index + sizeof(struct rc_object_entry_ondisk);
diff --git a/t/t6017-rev-cache-list.sh b/t/t6017-rev-cache-list.sh
index 3286560..6ada7ac 100755
--- a/t/t6017-rev-cache-list.sh
+++ b/t/t6017-rev-cache-list.sh
@@ -92,6 +92,7 @@ git-rev-list --topo-order HEAD --not HEAD~2 >proper_commit_list_limited2
  git-rev-list --topo-order HEAD >proper_commit_list
  git-rev-list --objects HEAD >proper_object_list
  git-rev-list HEAD --max-age=$min_date --min-age=$max_date >proper_list_date_limited
+git-rev-cache test HEAD :HEAD~2 >proper_shallow_list

  cache_sha1=`git-rev-cache add HEAD 2>output.err`

@@ -252,4 +253,9 @@ test_expect_success 'test --ignore-size function in fuse' '
  	test -e .git/rev-cache/$cache_sha1
  '

+test_expect_success 'check graft handling' '
+	git-rev-cache test HEAD :HEAD~2 >list
+	test_cmp list proper_shallow_list
+'
+
  test_done
-- 
tg: (ceb0b39..) t/revcache/graft (depends on: t/revcache/names)

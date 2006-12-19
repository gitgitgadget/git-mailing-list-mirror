X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Protect commits recorded in reflog from pruning.
Date: Mon, 18 Dec 2006 17:22:49 -0800
Message-ID: <7vy7p4u1au.fsf@assigned-by-dhcp.cox.net>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
	<7vr6uxzgjb.fsf@assigned-by-dhcp.cox.net>
	<20061218140813.GA32446@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 01:23:56 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061218140813.GA32446@spearce.org> (Shawn Pearce's message of
	"Mon, 18 Dec 2006 09:08:13 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34781>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwTh0-0000dx-9h for gcvg-git@gmane.org; Tue, 19 Dec
 2006 02:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932616AbWLSBWv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 18 Dec 2006
 20:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbWLSBWv
 (ORCPT <rfc822;git-outgoing>); Mon, 18 Dec 2006 20:22:51 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:39177 "EHLO
 fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932616AbWLSBWu (ORCPT <rfc822;git@vger.kernel.org>); Mon, 18 Dec 2006
 20:22:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061219012250.XBZH20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Mon, 18
 Dec 2006 20:22:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id 0RN81W00b1kojtg0000000; Mon, 18 Dec 2006
 20:22:09 -0500
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> This teaches fsck-objects and prune to protect objects referred
>> to by reflog entries.
>
> Nice!
>
> But its not enough.
>
>   $ git-repack -a -d
>   $ git reset --hard HEAD^
>   $ git-repack -a -d
>   $ git reset --hard HEAD@{1}
>
> that last reset would fail now, wouldn't it?  pack-objects needs
> to know it should be pulling in the objects stuff reachable from
> reflogs too.

Sure.

-- >8 --
Teach git-repack to preserve objects referred to by reflog entries.

This adds a new option --reflog to pack-objects and revision
machinery; do not bother documenting it for now, since this is
only useful for local repacking.

When the option is passed, objects reachable from reflog entries
are marked as interesting while computing the set of objects to
pack.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---
 builtin-pack-objects.c |    3 +-
 git-repack.sh          |    2 +-
 revision.c             |   56 ++++++++++++++++++++++++++++++++++++++++++------
 3 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index a2dc7d1..928684b 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -19,7 +19,7 @@ static const char pack_usage[] = "\
 git-pack-objects [{ -q | --progress | --all-progress }] \n\
 	[--local] [--incremental] [--window=N] [--depth=N] \n\
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty] \n\
-	[--revs [--unpacked | --all]*] [--stdout | base-name] \n\
+	[--revs [--unpacked | --all]*] [--reflog] [--stdout | base-name] \n\
 	[<ref-list | <object-list]";
 
 struct object_entry {
@@ -1577,6 +1577,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		}
 		if (!strcmp("--unpacked", arg) ||
 		    !strncmp("--unpacked=", arg, 11) ||
+		    !strcmp("--reflog", arg) ||
 		    !strcmp("--all", arg)) {
 			use_internal_rev_list = 1;
 			if (ARRAY_SIZE(rp_av) - 1 <= rp_ac)
diff --git a/git-repack.sh b/git-repack.sh
index 067898f..375434b 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -62,7 +62,7 @@ case ",$all_into_one," in
 esac
 
 args="$args $local $quiet $no_reuse_delta$extra"
-name=$(git-pack-objects --non-empty --all $args </dev/null "$PACKTMP") ||
+name=$(git-pack-objects --non-empty --all --reflog $args </dev/null "$PACKTMP") ||
 	exit 1
 if [ -z "$name" ]; then
 	echo Nothing new to pack.
diff --git a/revision.c b/revision.c
index 993bb66..cbf1045 100644
--- a/revision.c
+++ b/revision.c
@@ -462,21 +462,59 @@ static void limit_list(struct rev_info *revs)
 	revs->commits = newlist;
 }
 
-static int all_flags;
-static struct rev_info *all_revs;
+struct all_refs_cb {
+	int all_flags;
+	struct rev_info *all_revs;
+	const char *name_for_errormsg;
+};
 
 static int handle_one_ref(const char *path, const unsigned char *sha1, int flag, void *cb_data)
 {
-	struct object *object = get_reference(all_revs, path, sha1, all_flags);
-	add_pending_object(all_revs, object, "");
+	struct all_refs_cb *cb = cb_data;
+	struct object *object = get_reference(cb->all_revs, path, sha1,
+					      cb->all_flags);
+	add_pending_object(cb->all_revs, object, "");
 	return 0;
 }
 
 static void handle_all(struct rev_info *revs, unsigned flags)
 {
-	all_revs = revs;
-	all_flags = flags;
-	for_each_ref(handle_one_ref, NULL);
+	struct all_refs_cb cb;
+	cb.all_revs = revs;
+	cb.all_flags = flags;
+	for_each_ref(handle_one_ref, &cb);
+}
+
+static int handle_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1, char *detail, void *cb_data)
+{
+	struct all_refs_cb *cb = cb_data;
+	struct object *object;
+
+	if (!is_null_sha1(osha1)) {
+		object = get_reference(cb->all_revs, cb->name_for_errormsg,
+				       osha1, cb->all_flags);
+		add_pending_object(cb->all_revs, object, "");
+	}
+	object = get_reference(cb->all_revs, cb->name_for_errormsg,
+			       nsha1, cb->all_flags);
+	add_pending_object(cb->all_revs, object, "");
+	return 0;
+}
+
+static int handle_one_reflog(const char *path, const unsigned char *sha1, int flag, void *cb_data)
+{
+	struct all_refs_cb *cb = cb_data;
+	cb->name_for_errormsg = path;
+	for_each_reflog_ent(path, handle_one_reflog_ent, cb_data);
+	return 0;
+}
+
+static void handle_reflog(struct rev_info *revs, unsigned flags)
+{
+	struct all_refs_cb cb;
+	cb.all_revs = revs;
+	cb.all_flags = flags;
+	for_each_ref(handle_one_reflog, &cb);
 }
 
 static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
@@ -803,6 +841,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				handle_all(revs, flags);
 				continue;
 			}
+			if (!strcmp(arg, "--reflog")) {
+				handle_reflog(revs, flags);
+				continue;
+			}
 			if (!strcmp(arg, "--not")) {
 				flags ^= UNINTERESTING;
 				continue;

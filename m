From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v2 2/2] blame: allow blame --reverse --first-parent when
 it makes sense
Date: Sun, 25 Oct 2015 14:43:38 +0200
Message-ID: <20151025124338.GA27615@wheezy.local>
References: <1445485872-21453-1-git-send-email-max@max630.net>
 <1445485872-21453-3-git-send-email-max@max630.net>
 <xmqqfv13ttq6.fsf@gitster.mtv.corp.google.com>
 <20151022145606.GD5722@wheezy.local>
 <xmqqvb9yra5g.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Max Kirillov <max@max630.net>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 13:44:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqKey-0007LU-Ob
	for gcvg-git-2@plane.gmane.org; Sun, 25 Oct 2015 13:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbbJYMnz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Oct 2015 08:43:55 -0400
Received: from p3plsmtpa12-02.prod.phx3.secureserver.net ([68.178.252.231]:47706
	"EHLO p3plsmtpa12-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750740AbbJYMny (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2015 08:43:54 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa12-02.prod.phx3.secureserver.net with 
	id ZQjg1r0095B68XE01Qjnic; Sun, 25 Oct 2015 05:43:49 -0700
Content-Disposition: inline
In-Reply-To: <xmqqvb9yra5g.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280141>

On Thu, Oct 22, 2015 at 12:11:23PM -0700, Junio C Hamano wrote:
> Max Kirillov <max@max630.net> writes:
>> On Wed, Oct 21, 2015 at 09:25:37PM -0700, Junio C Hamano wrote:
>>
>>> The logic you implemented feels solid to me, at least at a first
>>> glance.  What kind of gotchas are you worried about?
>>
>> The fact than arbitrary commit's children are unknown does
>> not seem reliable to me. It more fits the "works by chance"
>> description.
>
> That's sad.

How about this then? I could collect only children
along the first-parent chain. This makes sure that
no extra child entry appear in revs->children. Since the revs
structure is exclusive for cmd_blame() it is guaranteed
that no other command will affect or be affected by this
behavior.

This additionally forbids having several end commits
(git blame --reverse --first-parent ^A B C ...), but
this does not seem to have much practical use.

-- 
Max

8< ------------------
diff --git a/builtin/blame.c b/builtin/blame.c
index eb348f0..f66d0ae 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2401,16 +2401,11 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 	return commit;
 }
 
-static char *prepare_final(struct scoreboard *sb)
+static struct object_array_entry *find_single_final(struct rev_info *revs)
 {
 	int i;
-	const char *final_commit_name = NULL;
-	struct rev_info *revs = sb->revs;
+	struct object_array_entry *found = NULL;
 
-	/*
-	 * There must be one and only one positive commit in the
-	 * revs->pending array.
-	 */
 	for (i = 0; i < revs->pending.nr; i++) {
 		struct object *obj = revs->pending.objects[i].item;
 		if (obj->flags & UNINTERESTING)
@@ -2419,14 +2414,24 @@ static char *prepare_final(struct scoreboard *sb)
 			obj = deref_tag(obj, NULL, 0);
 		if (obj->type != OBJ_COMMIT)
 			die("Non commit %s?", revs->pending.objects[i].name);
-		if (sb->final)
+		if (found)
 			die("More than one commit to dig from %s and %s?",
 			    revs->pending.objects[i].name,
-			    final_commit_name);
-		sb->final = (struct commit *) obj;
-		final_commit_name = revs->pending.objects[i].name;
+			    found->name);
+		found = &(revs->pending.objects[i]);
+	}
+	return found;
+}
+
+static char *prepare_final(struct scoreboard *sb)
+{
+	struct object_array_entry *found = find_single_final(sb->revs);
+	if (found) {
+		sb->final = (struct commit *) found->item;
+		return xstrdup(found->name);
+	} else {
+		return NULL;
 	}
-	return xstrdup_or_null(final_commit_name);
 }
 
 static char *prepare_initial(struct scoreboard *sb)
@@ -2502,6 +2507,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	long dashdash_pos, lno;
 	char *final_commit_name = NULL;
 	enum object_type type;
+	struct commit *firstparent_chain_initial = NULL;
 
 	static struct string_list range_list;
 	static int output_option = 0, opt = 0;
@@ -2695,6 +2701,8 @@ parse_done:
 	else {
 		final_commit_name = prepare_initial(&sb);
 		sb.commits.compare = compare_commits_by_reverse_commit_date;
+		if (revs.first_parent_only)
+			revs.children.name = NULL;
 	}
 
 	if (!sb.final) {
@@ -2711,6 +2719,14 @@ parse_done:
 	else if (contents_from)
 		die("Cannot use --contents with final commit object name");
 
+	if (reverse && revs.first_parent_only) {
+		struct object_array_entry *entry = find_single_final(sb.revs);
+		if (!entry)
+			die("--reverse and --first-parent together require specified latest commit");
+		else
+			firstparent_chain_initial = (struct commit*) entry->item;
+	}
+
 	/*
 	 * If we have bottom, this will mark the ancestors of the
 	 * bottom commits we would reach while traversing as
@@ -2720,11 +2736,21 @@ parse_done:
 		die(_("revision walk setup failed"));
 
 	if (reverse && revs.first_parent_only) {
-		struct commit_list *final_children = lookup_decoration(&revs.children,
-								       &sb.final->object);
-		if (!final_children ||
-		    hashcmp(final_children->item->parents->item->object.sha1,
-			    sb.final->object.sha1))
+		struct commit *c = firstparent_chain_initial;
+
+		sb.revs->children.name = "children";
+		while (c->parents &&
+		       hashcmp(c->object.sha1, sb.final->object.sha1)) {
+			struct commit_list *l = xcalloc(1, sizeof(*l));
+
+			l->item = c;
+			if (add_decoration(&sb.revs->children,
+					   &c->parents->item->object, l))
+				die("BUG: not unique item in first-parent chain");
+			c = c->parents->item;
+		}
+
+		if (hashcmp(c->object.sha1, sb.final->object.sha1))
 			die("--reverse --first-parent together require range along first-parent chain");
 	}
 

X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Stupid Git question
Date: Fri, 24 Nov 2006 00:31:05 -0800
Message-ID: <7v3b89dz5i.fsf@assigned-by-dhcp.cox.net>
References: <89b129c60611211331r3bb286b6re3c2c8f65ec3896f@mail.gmail.com>
	<89b129c60611211341j71079633g53b0ec1d2e3193a5@mail.gmail.com>
	<ejvs65$vo8$1@sea.gmane.org>
	<89b129c60611220628l59e305b8h4d2196f7cf6498d4@mail.gmail.com>
	<871wnvxwg4.wl%cworth@cworth.org>
	<89b129c60611221328l333d22c6o3668aef2706f92c7@mail.gmail.com>
	<7vac2jp0g6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 08:31:44 +0000 (UTC)
Cc: "Sean Kelley" <sean.v.kelley@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vac2jp0g6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 22 Nov 2006 14:43:05 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32194>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnWSv-00052F-Pm for gcvg-git@gmane.org; Fri, 24 Nov
 2006 09:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757648AbWKXIbI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 03:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757651AbWKXIbI
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 03:31:08 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:33169 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1757648AbWKXIbG
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 03:31:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061124083105.EKGL5575.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Fri, 24
 Nov 2006 03:31:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qYXD1V01F1kojtg0000000; Fri, 24 Nov 2006
 03:31:13 -0500
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

>...
> The most straightforward extension of the above for ref deletion
> is to say:
>
>    $ git remote-admin $REPO delete-refs refs/heads/foo refs/tags/v1.0
>
> and that would be the simplest way to implement it if we were to
> go with "git remote-admin".  However, I think people would find
> it more natural if manipulation of refs were part of "git push".
>
> "git push $REPO $src:$dst" means "take what I have in $src in my
> local repository, and update the $REPO's $dst ref with that".
> So as a natural extension of that, we could make:
>
>    $ git push $REPO '':$dst
>
> to mean "store nothingness in $dst" and make that a way to
> express the desire to remove $dst ref.

And here is an attempt to do so.  Only lightly tested...

	Whenever I say "only lightly tested", I am hoping that
	interested people on the list to test it and possibly
	enhance it with follow-up patches.  Or at least respond
	with "Hey, that sucks" or "Ok, it seems to work for your
	test case but here is a breakage".

-- >8 --
[PATCH] Allow git push to delete remote ref.

This allows you to say

	git send-pack $URL :refs/heads/$branch

to delete the named remote branch.  The refspec $src:$dst means
replace the destination ref with the object known as $src on the
local side, so this is a natural extension to make an empty $src
mean "No object" to delete the target.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 connect.c            |   11 ++++++++++-
 receive-pack.c       |   45 ++++++++++++++++++++++++++++++++++-----------
 send-pack.c          |   41 ++++++++++++++++++++++++++++++-----------
 t/t5400-send-pack.sh |   10 ++++++++++
 4 files changed, 84 insertions(+), 23 deletions(-)

diff --git a/connect.c b/connect.c
index b9666cc..f7edba8 100644
--- a/connect.c
+++ b/connect.c
@@ -144,6 +144,7 @@ struct refspec {
  * +A:B means overwrite remote B with local A.
  * +A is a shorthand for +A:A.
  * A is a shorthand for A:A.
+ * :B means delete remote B.
  */
 static struct refspec *parse_ref_spec(int nr_refspec, char **refspec)
 {
@@ -240,6 +241,13 @@ static struct ref *try_explicit_object_n
 	unsigned char sha1[20];
 	struct ref *ref;
 	int len;
+
+	if (!*name) {
+		ref = xcalloc(1, sizeof(*ref) + 20);
+		strcpy(ref->name, "(delete)");
+		hashclr(ref->new_sha1);
+		return ref;
+	}
 	if (get_sha1(name, sha1))
 		return NULL;
 	len = strlen(name) + 1;
@@ -262,7 +270,8 @@ static int match_explicit_refs(struct re
 			break;
 		case 0:
 			/* The source could be in the get_sha1() format
-			 * not a reference name.
+			 * not a reference name.  :refs/other is a
+			 * way to delete 'other' ref at the remote end.
 			 */
 			matched_src = try_explicit_object_name(rs[i].src);
 			if (matched_src)
diff --git a/receive-pack.c b/receive-pack.c
index d56898c..1a141dc 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -14,7 +14,7 @@ static int deny_non_fast_forwards = 0;
 static int unpack_limit = 5000;
 static int report_status;
 
-static char capabilities[] = "report-status";
+static char capabilities[] = " report-status delete-refs ";
 static int capabilities_sent;
 
 static int receive_pack_config(const char *var, const char *value)
@@ -113,12 +113,14 @@ static int update(struct command *cmd)
 
 	strcpy(new_hex, sha1_to_hex(new_sha1));
 	strcpy(old_hex, sha1_to_hex(old_sha1));
-	if (!has_sha1_file(new_sha1)) {
+
+	if (!is_null_sha1(new_sha1) && !has_sha1_file(new_sha1)) {
 		cmd->error_string = "bad pack";
 		return error("unpack should have generated %s, "
 			     "but I can't find it!", new_hex);
 	}
-	if (deny_non_fast_forwards && !is_null_sha1(old_sha1)) {
+	if (deny_non_fast_forwards && !is_null_sha1(new_sha1) &&
+	    !is_null_sha1(old_sha1)) {
 		struct commit *old_commit, *new_commit;
 		struct commit_list *bases, *ent;
 
@@ -138,14 +140,22 @@ static int update(struct command *cmd)
 		return error("hook declined to update %s", name);
 	}
 
-	lock = lock_any_ref_for_update(name, old_sha1);
-	if (!lock) {
-		cmd->error_string = "failed to lock";
-		return error("failed to lock %s", name);
+	if (is_null_sha1(new_sha1)) {
+		if (delete_ref(name, old_sha1)) {
+			cmd->error_string = "failed to delete";
+			return error("failed to delete %s", name);
+		}
+		fprintf(stderr, "%s: %s -> deleted\n", name, old_hex);
+	}
+	else {
+		lock = lock_any_ref_for_update(name, old_sha1);
+		if (!lock) {
+			cmd->error_string = "failed to lock";
+			return error("failed to lock %s", name);
+		}
+		write_ref_sha1(lock, new_sha1, "push");
+		fprintf(stderr, "%s: %s -> %s\n", name, old_hex, new_hex);
 	}
-	write_ref_sha1(lock, new_sha1, "push");
-
-	fprintf(stderr, "%s: %s -> %s\n", name, old_hex, new_hex);
 	return 0;
 }
 
@@ -375,6 +385,16 @@ static void report(const char *unpack_st
 	packet_flush(1);
 }
 
+static int delete_only(struct command *cmd)
+{
+	while (cmd) {
+		if (!is_null_sha1(cmd->new_sha1))
+			return 0;
+		cmd = cmd->next;
+	}
+	return 1;
+}
+
 int main(int argc, char **argv)
 {
 	int i;
@@ -408,7 +428,10 @@ int main(int argc, char **argv)
 
 	read_head_info();
 	if (commands) {
-		const char *unpack_status = unpack();
+		const char *unpack_status = NULL;
+
+		if (!delete_only(commands))
+			unpack_status = unpack();
 		if (!unpack_status)
 			execute_commands();
 		if (pack_lockfile)
diff --git a/send-pack.c b/send-pack.c
index 4476666..328dbbc 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -271,6 +271,7 @@ static int send_pack(int in, int out, in
 	int new_refs;
 	int ret = 0;
 	int ask_for_status_report = 0;
+	int allow_deleting_refs = 0;
 	int expect_status_report = 0;
 
 	/* No funny business with the matcher */
@@ -280,6 +281,8 @@ static int send_pack(int in, int out, in
 	/* Does the other end support the reporting? */
 	if (server_supports("report-status"))
 		ask_for_status_report = 1;
+	if (server_supports("delete-refs"))
+		allow_deleting_refs = 1;
 
 	/* match them up */
 	if (!remote_tail)
@@ -299,9 +302,19 @@ static int send_pack(int in, int out, in
 	new_refs = 0;
 	for (ref = remote_refs; ref; ref = ref->next) {
 		char old_hex[60], *new_hex;
+		int delete_ref;
+
 		if (!ref->peer_ref)
 			continue;
-		if (!hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
+
+		delete_ref = is_null_sha1(ref->peer_ref->new_sha1);
+		if (delete_ref && !allow_deleting_refs) {
+			error("remote does not support deleting refs");
+			ret = -2;
+			continue;
+		}
+		if (!delete_ref &&
+		    !hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
 			if (verbose)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
 			continue;
@@ -321,9 +334,13 @@ static int send_pack(int in, int out, in
 		 *
 		 * (3) if both new and old are commit-ish, and new is a
 		 *     descendant of old, it is OK.
+		 *
+		 * (4) regardless of all of the above, removing :B is
+		 *     always allowed.
 		 */
 
 		if (!force_update &&
+		    !delete_ref &&
 		    !is_zero_sha1(ref->old_sha1) &&
 		    !ref->force) {
 			if (!has_sha1_file(ref->old_sha1) ||
@@ -347,12 +364,8 @@ static int send_pack(int in, int out, in
 			}
 		}
 		hashcpy(ref->new_sha1, ref->peer_ref->new_sha1);
-		if (is_zero_sha1(ref->new_sha1)) {
-			error("cannot happen anymore");
-			ret = -3;
-			continue;
-		}
-		new_refs++;
+		if (!delete_ref)
+			new_refs++;
 		strcpy(old_hex, sha1_to_hex(ref->old_sha1));
 		new_hex = sha1_to_hex(ref->new_sha1);
 
@@ -366,10 +379,16 @@ static int send_pack(int in, int out, in
 		else
 			packet_write(out, "%s %s %s",
 				     old_hex, new_hex, ref->name);
-		fprintf(stderr, "updating '%s'", ref->name);
-		if (strcmp(ref->name, ref->peer_ref->name))
-			fprintf(stderr, " using '%s'", ref->peer_ref->name);
-		fprintf(stderr, "\n  from %s\n  to   %s\n", old_hex, new_hex);
+		if (delete_ref)
+			fprintf(stderr, "deleting '%s'\n", ref->name);
+		else {
+			fprintf(stderr, "updating '%s'", ref->name);
+			if (strcmp(ref->name, ref->peer_ref->name))
+				fprintf(stderr, " using '%s'",
+					ref->peer_ref->name);
+			fprintf(stderr, "\n  from %s\n  to   %s\n",
+				old_hex, new_hex);
+		}
 	}
 
 	packet_flush(out);
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 8afb899..28744b3 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -64,6 +64,16 @@ test_expect_success \
 	cmp victim/.git/refs/heads/master .git/refs/heads/master
 '
 
+test_expect_success \
+        'push can be used to delete a ref' '
+	cd victim &&
+	git branch extra master &&
+	cd .. &&
+	test -f victim/.git/refs/heads/extra &&
+	git-send-pack ./victim/.git/ :extra master &&
+	! test -f victim/.git/refs/heads/extra
+'
+
 unset GIT_CONFIG GIT_CONFIG_LOCAL
 HOME=`pwd`/no-such-directory
 export HOME ;# this way we force the victim/.git/config to be used.
-- 
1.4.4.1.g77614


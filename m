From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] "git push": tellme-more protocol extension
Date: Thu, 20 Mar 2008 00:58:24 -0700
Message-ID: <7vd4ppyggv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 08:59:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcFg9-0007I6-Ct
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 08:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754171AbYCTH6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 03:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754004AbYCTH6c
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 03:58:32 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60118 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754240AbYCTH6a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 03:58:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 704B21FDC;
	Thu, 20 Mar 2008 03:58:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 61F4D1FDB; Thu, 20 Mar 2008 03:58:26 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77643>

The workflow git supports has always been biased towards the kernel style
"each developer has his own publishing repository only himself pushes
into, and others pull from it".  We have been fairly good at enhancing
support for the workflow at the other end of the spectrum, a shared
repository everybody clones and updates from and everybody also pushes
into.  However, if you look under the hood and study the native protocol
used for fetching and pushing, it becomes apparent that our origin is
really "pushing into owned publishing point" workflow.

The protocol between send-pack and receive-pack, which is used for "git
push", is much simpler than the protocol used on the "git fetch" side.

When the sender connects, the receiver first tells the sender what commits
its refs are pointing at, and then the sender figures out what revision
range to build a pack out of, based on the "here are my refs" information
it learned from the receiver and the set of refs it has.

This works well enough, if you assume that the sender always knows enough
about what the receiver has, and when the sender owns the receiving end
(i.e. he is the only one who pushes into it), by definition, all the
commits at the receiving end will be what the sender has pushed there, and
it already knows about them.

Also, because by default we do not accept a commit that does not
fast-forward the old ref when you are updating an existing branch, this
assumption often holds true even for shared repository workflow.  If your
push is blocked because it does not fast-forward, the first thing you
would do is to fetch from there, which makes you learn everything the
other end has.

But this breaks down in one case.  If you have a single branch shared
repository with two developers, and after one developer updates that
branch, if the second developer wants to push a new branch (fork) to the
shared repository:

 (0) First, an illustration of the situation.  Developer one and two
     cloned from the shared repository when its head was at commit A.
     Developer one built some changes and pushed it back.  The shared
     repository's "master" is now at commit B.

     ---o----o----o----A----o----o----B
                        \
                         o---o---o---C

     In the meantime, developer two hacked on top of A and his tip is at
     commit C.  He is not confident enough to push this back to "master"
     (and if he did so, he won't succeed because it wouldn't fast-forward),
     but wants to share it with co-workers by pushing it to a new "xprm"
     branch at the shared repository.  He says:

        $ git push origin master:refs/heads/xprm

     Now what happens?

 (1) The recieving end (i.e. the shared repository) will say "master is
     now at commit B".

 (2) The sending end, however, has not seen B.  All it knows is that there
     is no "xprm" over there yet, and it wants to send C.

 (3) Based on the available information, it ends up sending the whole
     history leading to C.  Oops.

This patch teaches the send-pack protocol a new extension, "tellme-more".

When both ends support this extension, the receiving end first says "I
support tellme-more, and here are my refs".  The sending side, when it
sees commits that it does not know about (e.g. "B" in the above example),
can then ask "I do not know about B, but it probably is related to what I
already have, so tell me more about it".

The receiving end then responds with list of commits that are ancestors of
"B", and in the above example, the sender will find out that the recieving
end also has "A".  After this exchange, the sending end can build a pack
that contains objects between A..C, instead of having to send the full
history leading to "C".

Without the protocol extension, the attached small test (t5407) ends up
transferring 39 objects, which exactly matches the above observation, and
with the patch it sends only 9.

There are a few obvious things that could be improved.

- Currently, there is a backoff mechanism to optimize responses to
  tellme-more requests by sending every N^2-th non-merge commit in a
  single-strand-of-pearls ancestry chain so that a very stale sender can
  find some common ancestor efficiently, but this backoff could be a bit
  too aggressive.

- There is no active defence against a malicious sender that asks
  tellme-more over and over to force the receiver do extra work, except
  the abovementioned backoff and the fact that the receiver stops working
  once it reaches the root commit.  Push is allowed to only trusted
  parties so hopefully this will not be such a big deal.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Obviously post 1.5.5 material.

 Documentation/technical/pack-protocol.txt |   29 ++++++-
 builtin-send-pack.c                       |  108 ++++++++++++++++++++++-
 receive-pack.c                            |  141 ++++++++++++++++++++++++++++-
 t/t5407-send-pack-shared.sh               |   59 ++++++++++++
 4 files changed, 332 insertions(+), 5 deletions(-)
 create mode 100755 t/t5407-send-pack-shared.sh

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index 9cd48b4..fc848b4 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -29,7 +29,7 @@ upload-pack (S) | fetch/clone-pack (C) protocol:
 send-pack | receive-pack protocol.
 
 	# Tell the pusher what commits we have and what their names are
-	C: SHA1 name
+	C: SHA1 name (capabilities)
 	C: ...
 	C: SHA1 name
 	C: # flush -- it's your turn
@@ -39,3 +39,30 @@ send-pack | receive-pack protocol.
 	S: ...
 	S: # flush -- done with the list
 	S: XXXXXXX --- packfile contents.
+
+When tellme-more extension is used:
+
+	# Tell the pusher what commits we have and what their names are
+	C: SHA1 name (capabilities)
+	C: ...
+	C: SHA1 name
+	C: # flush -- it's your turn
+	# Tell the puller what the pusher has
+	S: old-SHA1 new-SHA1 name
+	S: old-SHA1 new-SHA1 name
+	S: tellme-more old-SHA1	-- I do not know about this one,
+	S: tellme-more old-SHA1 -- give me ancestors of them.
+	S: # flush -- done with the list
+	# Tell the pusher more about history
+	C: SHA1 old-SHA1 -- This is ancestor of that, you might know
+	C: SHA1 old-SHA1
+	C: ...
+	C: # flush -- have you heard ehough?
+	S: tellme-more old-SHA1	-- I still want to know more about this one
+	S: # flush -- please give me more
+	C: SHA1 old-SHA1'
+	C: SHA1 old-SHA1'
+	C: ...
+	C: # flush -- have you heard ehough?
+	S: # flush -- yes, thanks, we've heard enough
+	S: XXXXXXX --- packfile contents.
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 930e0fb..1a125cf 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -15,6 +15,13 @@ static struct send_pack_args args = {
 	/* .receivepack = */ "git-receive-pack",
 };
 
+static struct additional_base {
+	unsigned char tip[20];
+	unsigned char last[20];
+	struct commit *commit;
+} *unknown;
+static int unknown_nr = 0, unknown_alloc = 0;
+
 /*
  * Make a pack stream and spit it out into file descriptor fd
  */
@@ -71,6 +78,23 @@ static int pack_objects(int fd, struct ref *refs)
 		refs = refs->next;
 	}
 
+	if (unknown) {
+		int i;
+		char buf[42];
+
+		for (i = 0; i < unknown_nr; i++) {
+			struct commit *c = unknown[i].commit;
+			if (!c)
+				continue;
+			memcpy(buf + 1, sha1_to_hex(c->object.sha1), 40);
+			buf[0] = '^';
+			buf[41] = '\n';
+			if (!write_or_whine(po.in, buf, 42,
+					    "send-pack: send additional base"))
+				break;
+		}
+	}
+
 	close(po.in);
 	if (finish_command(&po))
 		return error("pack-objects died with strange error");
@@ -373,6 +397,81 @@ static int refs_pushed(struct ref *ref)
 	return 0;
 }
 
+static void ask_for_more(int in, int out, struct ref *remote_refs)
+{
+	struct ref *refs;
+	int i;
+
+	for (refs = remote_refs; refs; refs = refs->next) {
+		struct commit *commit;
+
+		if (is_null_sha1(refs->old_sha1))
+			continue;
+		commit = lookup_commit_reference_gently(refs->old_sha1, 1);
+		if (!commit) {
+			ALLOC_GROW(unknown, unknown_nr+1, unknown_alloc);
+			hashcpy(unknown[unknown_nr].last, refs->old_sha1);
+			unknown[unknown_nr].commit = NULL;
+			unknown_nr++;
+		}
+	}
+	if (!unknown_nr) {
+		packet_flush(out);
+		return;
+	}
+
+	for (i = 0; i < 5; i++) {
+		int j, sent = 0;
+		for (j = 0; j < unknown_nr; j++) {
+			if (unknown[j].commit)
+				continue;
+			hashcpy(unknown[j].tip, unknown[j].last);
+			packet_write(out, "tellme-more %s\n",
+				     sha1_to_hex(unknown[j].tip));
+			sent++;
+		}
+		packet_flush(out);
+		if (!sent)
+			break;
+		sent = 0;
+		while (1) {
+			char line[1000];
+			unsigned char tip[20];
+			unsigned char last[20];
+			int len;
+			struct commit *commit;
+
+			len = packet_read_line(in, line, sizeof(line));
+			if (!len)
+				break;
+			sent++;
+			if (line[len-1] == '\n')
+				line[--len] = '\0';
+			if (len < 81 ||
+			    line[40] != ' ' ||
+			    get_sha1_hex(line, last) ||
+			    get_sha1_hex(line + 41, tip))
+				die("protocol error: got '%s'", line);
+			for (j = 0; j < unknown_nr; j++)
+				if (!hashcmp(unknown[j].tip, tip))
+					break;
+			if (unknown_nr <= j || unknown[j].commit)
+				continue;
+			hashcpy(unknown[j].last, last);
+			commit = lookup_commit_reference_gently(last, 1);
+			if (!commit)
+				continue;
+			unknown[j].commit = commit;
+		}
+
+		if (!sent) {
+			/* they do not have any more to tell us */
+			packet_flush(out);
+			break;
+		}
+	}
+}
+
 static int do_send_pack(int in, int out, struct remote *remote, const char *dest, int nr_refspec, const char **refspec)
 {
 	struct ref *ref;
@@ -380,6 +479,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 	int ask_for_status_report = 0;
 	int allow_deleting_refs = 0;
 	int expect_status_report = 0;
+	int can_ask_for_more = 0;
 	int flags = MATCH_REFS_NONE;
 	int ret;
 
@@ -397,6 +497,8 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		ask_for_status_report = 1;
 	if (server_supports("delete-refs"))
 		allow_deleting_refs = 1;
+	if (server_supports("tellme-more"))
+		can_ask_for_more = 1;
 
 	/* match them up */
 	if (!remote_tail)
@@ -495,7 +597,11 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 			REF_STATUS_OK;
 	}
 
-	packet_flush(out);
+	if (can_ask_for_more && new_refs)
+		ask_for_more(in, out, remote_refs);
+	else
+		packet_flush(out);
+
 	if (new_refs && !args.dry_run) {
 		if (pack_objects(out, remote_refs) < 0)
 			return -1;
diff --git a/receive-pack.c b/receive-pack.c
index f83ae87..0574e37 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -15,7 +15,7 @@ static int transfer_unpack_limit = -1;
 static int unpack_limit = 100;
 static int report_status;
 
-static char capabilities[] = " report-status delete-refs ";
+static char capabilities[] = " report-status delete-refs tellme-more ";
 static int capabilities_sent;
 
 static int receive_pack_config(const char *var, const char *value)
@@ -293,7 +293,23 @@ static void execute_commands(const char *unpacker_error)
 	}
 }
 
-static void read_head_info(void)
+static int parse_tellme_more(char *line, int len, struct commit_list **list)
+{
+	unsigned char sha1[20];
+	struct commit *c;
+
+	if (52 <= len &&
+	    !strncmp(line, "tellme-more ", 12) &&
+	    !get_sha1_hex(line + 12, sha1)) {
+		c = lookup_commit_reference_gently(sha1, 1);
+		if (c)
+			commit_list_insert(c, list);
+		return 1;
+	}
+	return 0;
+}
+
+static void read_head_info(struct commit_list **tellme_more)
 {
 	struct command **p = &commands;
 	for (;;) {
@@ -308,6 +324,8 @@ static void read_head_info(void)
 			break;
 		if (line[len-1] == '\n')
 			line[--len] = 0;
+		if (parse_tellme_more(line, len, tellme_more))
+			continue;
 		if (len < 83 ||
 		    line[40] != ' ' ||
 		    line[81] != ' ' ||
@@ -333,6 +351,118 @@ static void read_head_info(void)
 	}
 }
 
+static void sender_wants_more(struct commit_list **tellme_more)
+{
+	char line[1024];
+	int len;
+
+	while (1) {
+		len = packet_read_line(0, line, sizeof(line));
+		if (!len)
+			return;
+		if (line[len-1] == '\n')
+			line[--len] = '\0';
+		if (parse_tellme_more(line, len, tellme_more))
+			continue;
+		/* ignore other responses for future extension */
+	}
+}
+
+#define SHOWN_TO_SENDER (1<<20)
+static struct commit_list **add_parents(struct commit *commit, struct commit_list **tail, int round)
+{
+	struct commit_list *parents = commit->parents;
+
+	/*
+	 * In later rounds, we will send one commit for every N
+	 * commits in single parent chain to optimize for very stale
+	 * pushers.
+	 */
+	round *= round;
+	while (round--) {
+		if (!parents || (parents && parents->next))
+			break; /* do not skip merges */
+		if (parse_commit(parents->item))
+			return tail; /* oops */
+		if (!parents->item->parents)
+			break; /* do not skip root */
+		parents = parents->item->parents;
+	}
+
+	while (parents) {
+		commit = parents->item;
+		parents = parents->next;
+		if (commit->object.flags & SHOWN_TO_SENDER)
+			continue;
+		if (parse_commit(commit))
+			continue;
+		tail = &commit_list_insert(commit, tail)->next;
+	}
+	return tail;
+}
+
+#define BATCH 20
+static void send_ancestors(struct commit *commit, int round)
+{
+	struct commit_list *list = NULL;
+	struct commit_list **tail = &list;
+	int count = 0;
+
+	tail = &commit_list_insert(commit, tail)->next;
+	while (list && count < BATCH) {
+		struct commit_list *elem = list;
+		struct commit *c = elem->item;
+
+		list = list->next;
+		free(elem);
+		if (!list)
+			tail = &list;
+
+		if (c->object.flags & SHOWN_TO_SENDER)
+			continue;
+		if (parse_commit(c))
+			continue;
+		c->object.flags |= SHOWN_TO_SENDER;
+		if (c != commit) {
+			packet_write(1, "%s %s\n",
+				     sha1_to_hex(c->object.sha1),
+				     sha1_to_hex(commit->object.sha1));
+			count++;
+		}
+		tail = add_parents(c, tail, round);
+	}
+	clear_commit_marks(commit, SHOWN_TO_SENDER);
+	free_commit_list(list);
+}
+
+static void exchange_history(struct commit_list *list)
+{
+	int round = 0;
+
+	while (list) {
+		while (list) {
+			struct commit_list *elem = list;
+			struct commit *commit = elem->item;
+
+			list = list->next;
+			free(elem);
+
+			/*
+			 * The sender does not know about commit and asks its
+			 * ancestors to be sent.
+			 */
+			if (parse_commit(commit))
+				continue;
+
+			send_ancestors(commit, round);
+		}
+		packet_flush(1); /* have you heard enough? */
+
+		sender_wants_more(&list);
+		round++;
+	}
+}
+
 static const char *parse_pack_header(struct pack_header *hdr)
 {
 	switch (read_pack_header(0, hdr)) {
@@ -455,6 +585,7 @@ int main(int argc, char **argv)
 {
 	int i;
 	char *dir = NULL;
+	struct commit_list *tellme_more = NULL;
 
 	argv++;
 	for (i = 1; i < argc; i++) {
@@ -491,7 +622,11 @@ int main(int argc, char **argv)
 	/* EOF */
 	packet_flush(1);
 
-	read_head_info();
+	read_head_info(&tellme_more);
+
+	if (tellme_more)
+		exchange_history(tellme_more);
+
 	if (commands) {
 		const char *unpack_status = NULL;
 
diff --git a/t/t5407-send-pack-shared.sh b/t/t5407-send-pack-shared.sh
new file mode 100755
index 0000000..c31322c
--- /dev/null
+++ b/t/t5407-send-pack-shared.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+
+test_description='shared repository workflow, not sending too many'
+
+. ./test-lib.sh
+
+commit () {
+	test_tick &&
+	echo >file "$1" &&
+	git add file &&
+	git commit -m "$1"
+}
+
+test_expect_success setup '
+
+	test_create_repo shared &&
+	(
+		cd shared &&
+		for i in 1 2 3 4 5 6 7 8 9 10
+		do
+			commit $i || exit 1
+		done
+	) &&
+
+	git clone shared one &&
+	git clone shared two &&
+
+	(
+		cd one &&
+		for i in 11 12 13 14
+		do
+			commit $i || exit 1
+		done
+		git push origin master
+	) &&
+
+	(
+		cd shared &&
+		git fsck-objects --full &&
+		git prune
+	)
+'
+
+test_expect_success 'push from side' '
+
+	(
+		cd two &&
+		for i in 15 16 17
+		do
+			commit $i || exit 1
+		done
+		git push --verbose origin master:refs/heads/side 2>../log
+	) &&
+	tr "\015" "\012" < log >out &&
+	grep "^Total 9 " out
+
+'
+
+test_done
-- 
1.5.5.rc0.133.g7e207

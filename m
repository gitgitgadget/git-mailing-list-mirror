From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: grafts generalised
Date: Wed, 02 Jul 2008 14:49:37 -0700
Message-ID: <7vej6c7y8e.fsf@gitster.siamese.dyndns.org>
References: <20080702143519.GA8391@cuci.nl>
 <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com>
 <37fcd2780807021058r5ed820cfmdc98f98f36d5c8ae@mail.gmail.com>
 <20080702181021.GD16235@cuci.nl>
 <37fcd2780807021339u582f340dq2b2014951d5b7f63@mail.gmail.com>
 <7vlk0k7z99.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Stephen R. van den Berg" <srb@cuci.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 23:50:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEADy-0007Un-6c
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 23:50:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753115AbYGBVtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 17:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753805AbYGBVtv
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 17:49:51 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33419 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbYGBVtu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 17:49:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C802D9A01;
	Wed,  2 Jul 2008 17:49:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 93BAB99F9; Wed,  2 Jul 2008 17:49:42 -0400 (EDT)
In-Reply-To: <7vlk0k7z99.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 02 Jul 2008 14:27:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: CAE55228-4880-11DD-A122-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87196>

Junio C Hamano <gitster@pobox.com> writes:

> "Dmitry Potapov" <dpotapov@gmail.com> writes:
>
>> On Wed, Jul 2, 2008 at 10:10 PM, Stephen R. van den Berg <srb@cuci.nl> wrote:
>>>
>>> In that case, I will stick to extending git fsck to check grafts more
>>> rigorously and fix git clone to *refrain* from looking at grafts.
>>
>> Linus suggested that "git-fsck and repacking should just consider
>> it[grafts] to be an  _additional_ source of parenthood rather than
>> a _replacement_ source."
>>
>> http://article.gmane.org/gmane.comp.version-control.git/84686
>
> Yeah, thanks for a reminder.
>
>     http://thread.gmane.org/gmane.comp.version-control.git/37744/focus=37866
>
> is still on my "things to look at" list.

This shows how the "object transfer ignores grafts" side of the earlier
suggestion by Linus would look like to get people started.  Totally
untested.

I threw in for_each_commit_graft() in the patch so that updates to the
reachability walker can add otherwise hidden objects, but otherwise it is
not used yet.

 builtin-pack-objects.c |    5 +++++
 builtin-send-pack.c    |    3 ++-
 cache.h                |    1 +
 commit.c               |   10 ++++++++++
 commit.h               |    2 ++
 environment.c          |    1 +
 upload-pack.c          |    1 +
 7 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 28207d9..53b0b33 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -30,6 +30,7 @@ git-pack-objects [{ -q | --progress | --all-progress }] \n\
 	[--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n\
 	[--stdout | base-name] [--include-tag] \n\
 	[--keep-unreachable | --unpack-unreachable] \n\
+	[--ignore-graft] \n\
 	[<ref-list | <object-list]";
 
 struct object_entry {
@@ -2160,6 +2161,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 				die("bad %s", arg);
 			continue;
 		}
+		if (!strcmp(arg, "--ignore-graft")) {
+			honor_graft = 0;
+			continue;
+		}
 		usage(pack_usage);
 	}
 
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index d76260c..d932352 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -27,6 +27,7 @@ static int pack_objects(int fd, struct ref *refs)
 	 */
 	const char *argv[] = {
 		"pack-objects",
+		"--ignore-graft",
 		"--all-progress",
 		"--revs",
 		"--stdout",
@@ -36,7 +37,7 @@ static int pack_objects(int fd, struct ref *refs)
 	struct child_process po;
 
 	if (args.use_thin_pack)
-		argv[4] = "--thin";
+		argv[5] = "--thin";
 	memset(&po, 0, sizeof(po));
 	po.argv = argv;
 	po.in = -1;
diff --git a/cache.h b/cache.h
index 188428d..00858f9 100644
--- a/cache.h
+++ b/cache.h
@@ -435,6 +435,7 @@ extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern int auto_crlf;
 extern int fsync_object_files;
+extern int honor_graft;
 
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
diff --git a/commit.c b/commit.c
index e2d8624..62cf104 100644
--- a/commit.c
+++ b/commit.c
@@ -101,6 +101,13 @@ static int commit_graft_pos(const unsigned char *sha1)
 	return -lo - 1;
 }
 
+void for_each_commit_graft(void (*fn)(struct commit_graft *))
+{
+	int i;
+	for (i = 0; i < commit_graft_nr; i++)
+		fn(commit_graft[i]);
+}
+
 int register_commit_graft(struct commit_graft *graft, int ignore_dups)
 {
 	int pos = commit_graft_pos(graft->sha1);
@@ -196,7 +203,10 @@ static void prepare_commit_graft(void)
 struct commit_graft *lookup_commit_graft(const unsigned char *sha1)
 {
 	int pos;
+
 	prepare_commit_graft();
+	if (!honor_graft)
+		return NULL;
 	pos = commit_graft_pos(sha1);
 	if (pos < 0)
 		return NULL;
diff --git a/commit.h b/commit.h
index 2d94d41..8f76dd9 100644
--- a/commit.h
+++ b/commit.h
@@ -138,4 +138,6 @@ static inline int single_parent(struct commit *commit)
 	return commit->parents && !commit->parents->next;
 }
 
+void for_each_commit_graft(void (*fn)(struct commit_graft *));
+
 #endif /* COMMIT_H */
diff --git a/environment.c b/environment.c
index 4a88a17..eb8f36d 100644
--- a/environment.c
+++ b/environment.c
@@ -41,6 +41,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
+int honor_graft = 1;
 
 /* This is set by setup_git_dir_gently() and/or git_default_config() */
 char *git_work_tree_cfg;
diff --git a/upload-pack.c b/upload-pack.c
index b46dd36..d948d64 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -158,6 +158,7 @@ static void create_pack_file(void)
 		die("git-upload-pack: unable to fork git-rev-list");
 
 	argv[arg++] = "pack-objects";
+	argv[arg++] = "--ignore-graft";
 	argv[arg++] = "--stdout";
 	if (!no_progress)
 		argv[arg++] = "--progress";

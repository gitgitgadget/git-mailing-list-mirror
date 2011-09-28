From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFCv3 2/2] receive-pack: don't pass non-existent refs to
 post-{receive,update} hooks in push deletions
Date: Wed, 28 Sep 2011 16:09:07 -0700
Message-ID: <7voby4xo18.fsf@alter.siamese.dyndns.org>
References: <20110928153935.GA7800@myhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sitaram Chamarty <sitaramc@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Pang Yan Han <pangyanhan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 29 01:09:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R93Fk-0004nR-4X
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 01:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932892Ab1I1XJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Sep 2011 19:09:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63976 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932752Ab1I1XJL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Sep 2011 19:09:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 648366902;
	Wed, 28 Sep 2011 19:09:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eRC89fszcTMi4wpOwbW3CIDaxtE=; b=nxyq/A
	iROuCEQA/VMjNxfNMGXqRlYy2NbPJy9oz+zwC3mlyA7z9kRcDgM39OqmgGFRKKbl
	T89kH4VmuyPh95yhLK5M2gJFTDoYtZaStuzj+yejLnf8OkuC4CDzqdWLTITqGz/K
	ctB1n5UMiNc214xUU4CVkWfezELWYdzDk5s9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZmlBn9Fgvh3+dtPK37RKcULbnJ6tWs4y
	6S+bNmFQ4Runz9BM+hIN2dLcIT4akwjLS13o6U3P6Uvz+3JKBbBnCU1mAUEmC7ZM
	Gzd3U0NoYTvMivwFh28wQHAKFXjjL+zHT9MB813wxA9K+V/VWHbX30XKboZcd101
	kenu96BRQ4Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AC7A6901;
	Wed, 28 Sep 2011 19:09:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F22368FE; Wed, 28 Sep 2011
 19:09:08 -0400 (EDT)
In-Reply-To: <20110928153935.GA7800@myhost> (Pang Yan Han's message of "Wed,
 28 Sep 2011 23:39:35 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DE9DE500-EA26-11E0-9A22-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182369>

Here is a quick fix-up on top.

Points of interest:

 - Get rid of an unnecessary list; just a single bitfield is sufficient;
   while at it, make skip_update also a bitfield.

 - ref_exists(refname) calls resolve_ref() which wants "const char *",
   and does not touch refname itself. Make it to take "const char *",
   instead of casting const away in the new caller.

 - Properly indent test script.  Also:

   - Use "cmd <<-EOF" to allow indenting the here text with leading tabs;

   - Strip useless use of single quote around "cmd <<'EOF'" inside
     test_expect_success; they were only stepping out of the sq context
     while the third argument to test_expect_success was being parsed. A
     construct like this:

	cat >pre-receive.expect <<'EOF'
        $orgmaster $newmaster refs/heads/master
        EOF

     only misleads the readers as if the file is getting literal variable
     names without substitution, which is not what is going on.

I didn't fix this in this fix-up patch, but you also need to test the case
where _ONLY_ deletion of a non-existent ref is requested, in which case,
pre-receive and update should be told about it, but post-receive and
post-update should not be even run (i.e. test the absense of these
post-*.actual files).

 builtin/receive-pack.c |   41 ++++++---------------
 refs.c                 |    2 +-
 refs.h                 |    2 +-
 t/t5516-fetch-push.sh  |   90 ++++++++++++++++++++++++-----------------------
 4 files changed, 60 insertions(+), 75 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 8a0a9d2..b73f18a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -147,32 +147,13 @@ static void write_head_info(void)
 struct command {
 	struct command *next;
 	const char *error_string;
-	unsigned int skip_update;
+	unsigned int skip_update:1,
+		     did_not_exist:1;
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
 	char ref_name[FLEX_ARRAY]; /* more */
 };
 
-/* For invalid refs */
-static struct command **invalid_delete;
-static size_t invalid_delete_nr;
-static size_t invalid_delete_alloc;
-
-static void invalid_delete_append(struct command *cmd)
-{
-	ALLOC_GROW(invalid_delete, invalid_delete_nr + 1, invalid_delete_alloc);
-	invalid_delete[invalid_delete_nr++] = cmd;
-}
-
-static int is_invalid_delete(struct command *cmd)
-{
-	size_t i;
-	for (i = 0; i < invalid_delete_nr; i++)
-		if (invalid_delete[i] == cmd)
-			return 1;
-	return 0;
-}
-
 static const char pre_receive_hook[] = "hooks/pre-receive";
 static const char post_receive_hook[] = "hooks/post-receive";
 
@@ -235,7 +216,7 @@ static int run_receive_hook(struct command *commands, const char *hook_name)
 	int have_input = 0, code;
 
 	for (cmd = commands; !have_input && cmd; cmd = cmd->next) {
-		if (!cmd->error_string && !is_invalid_delete(cmd))
+		if (!cmd->error_string && !cmd->did_not_exist)
 			have_input = 1;
 	}
 
@@ -268,7 +249,7 @@ static int run_receive_hook(struct command *commands, const char *hook_name)
 	}
 
 	for (cmd = commands; cmd; cmd = cmd->next) {
-		if (!cmd->error_string && !is_invalid_delete(cmd)) {
+		if (!cmd->error_string && !cmd->did_not_exist) {
 			size_t n = snprintf(buf, sizeof(buf), "%s %s %s\n",
 				sha1_to_hex(cmd->old_sha1),
 				sha1_to_hex(cmd->new_sha1),
@@ -465,10 +446,13 @@ static const char *update(struct command *cmd)
 
 	if (is_null_sha1(new_sha1)) {
 		if (!parse_object(old_sha1)) {
-			rp_warning("Allowing deletion of corrupt ref.");
 			old_sha1 = NULL;
-			if (!ref_exists((char *) name))
-				invalid_delete_append(cmd);
+			if (ref_exists(name)) {
+				rp_warning("Allowing deletion of corrupt ref.");
+			} else {
+				rp_warning("Deleting a non-existent ref.");
+				cmd->did_not_exist = 1;
+			}
 		}
 		if (delete_ref(namespaced_name, old_sha1, 0)) {
 			rp_error("failed to delete %s", name);
@@ -499,7 +483,7 @@ static void run_update_post_hook(struct command *commands)
 	struct child_process proc;
 
 	for (argc = 0, cmd = commands; cmd; cmd = cmd->next) {
-		if (cmd->error_string || is_invalid_delete(cmd))
+		if (cmd->error_string || cmd->did_not_exist)
 			continue;
 		argc++;
 	}
@@ -510,7 +494,7 @@ static void run_update_post_hook(struct command *commands)
 
 	for (argc = 1, cmd = commands; cmd; cmd = cmd->next) {
 		char *p;
-		if (cmd->error_string || is_invalid_delete(cmd))
+		if (cmd->error_string || cmd->did_not_exist)
 			continue;
 		p = xmalloc(strlen(cmd->ref_name) + 1);
 		strcpy(p, cmd->ref_name);
@@ -888,6 +872,5 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
 	}
 	if (use_sideband)
 		packet_flush(1);
-	free(invalid_delete);
 	return 0;
 }
diff --git a/refs.c b/refs.c
index a615043..43e9225 100644
--- a/refs.c
+++ b/refs.c
@@ -1851,7 +1851,7 @@ int update_ref(const char *action, const char *refname,
 	return 0;
 }
 
-int ref_exists(char *refname)
+int ref_exists(const char *refname)
 {
 	unsigned char sha1[20];
 	return !!resolve_ref(refname, sha1, 1, NULL);
diff --git a/refs.h b/refs.h
index dfb086e..4431205 100644
--- a/refs.h
+++ b/refs.h
@@ -57,7 +57,7 @@ extern void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refn
  */
 extern void add_extra_ref(const char *refname, const unsigned char *sha1, int flags);
 extern void clear_extra_refs(void);
-extern int ref_exists(char *);
+extern int ref_exists(const char *);
 
 extern int peel_ref(const char *, unsigned char *);
 
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c0d8a0e..47db4b1 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -43,33 +43,34 @@ mk_test () {
 mk_test_with_hooks() {
 	mk_test "$@" &&
 	(
-	cd testrepo &&
-	mkdir .git/hooks &&
-	cd .git/hooks &&
+		cd testrepo &&
+		mkdir .git/hooks &&
+		cd .git/hooks &&
 
-	cat >pre-receive <<'EOF' &&
-#!/bin/sh
-cat - >>pre-receive.actual
-EOF
+		cat >pre-receive <<-'EOF' &&
+		#!/bin/sh
+		cat - >>pre-receive.actual
+		EOF
 
-	cat >update <<'EOF' &&
-#!/bin/sh
-printf "%s %s %s\n" "$@" >>update.actual
-EOF
-	cat >post-receive <<'EOF' &&
-#!/bin/sh
-cat - >>post-receive.actual
-EOF
+		cat >update <<-'EOF' &&
+		#!/bin/sh
+		printf "%s %s %s\n" "$@" >>update.actual
+		EOF
 
-	cat >post-update <<'EOF' &&
-#!/bin/sh
-for ref in "$@"
-do
-	printf "%s\n" "$ref" >>post-update.actual
-done
-EOF
+		cat >post-receive <<-'EOF' &&
+		#!/bin/sh
+		cat - >>post-receive.actual
+		EOF
 
-	chmod u+x pre-receive update post-receive post-update
+		cat >post-update <<-'EOF' &&
+		#!/bin/sh
+		for ref in "$@"
+		do
+			printf "%s\n" "$ref" >>post-update.actual
+		done
+		EOF
+
+		chmod +x pre-receive update post-receive post-update
 	)
 }
 
@@ -599,31 +600,32 @@ test_expect_success 'pushing valid refs triggers post-receive and post-update ho
 	orgnext=$(cd testrepo && git show-ref -s --verify refs/heads/next) &&
 	newnext=$_z40 &&
 	git push testrepo refs/heads/master:refs/heads/master :refs/heads/next &&
-	(cd testrepo/.git &&
-	cat >pre-receive.expect <<'EOF' &&
-$orgmaster $newmaster refs/heads/master
-$orgnext $newnext refs/heads/next
-EOF
+	(
+		cd testrepo/.git &&
+		cat >pre-receive.expect <<-EOF &&
+		$orgmaster $newmaster refs/heads/master
+		$orgnext $newnext refs/heads/next
+		EOF
 
-	cat >update.expect <<'EOF' &&
-refs/heads/master $orgmaster $newmaster
-refs/heads/next $orgnext $newnext
-EOF
+		cat >update.expect <<-EOF &&
+		refs/heads/master $orgmaster $newmaster
+		refs/heads/next $orgnext $newnext
+		EOF
 
-	cat >post-receive.expect <<'EOF' &&
-$orgmaster $newmaster refs/heads/master
-$orgnext $newnext refs/heads/next
-EOF
+		cat >post-receive.expect <<-EOF &&
+		$orgmaster $newmaster refs/heads/master
+		$orgnext $newnext refs/heads/next
+		EOF
 
-	cat >post-update.expect <<'EOF' &&
-refs/heads/master
-refs/heads/next
-EOF
+		cat >post-update.expect <<-EOF &&
+		refs/heads/master
+		refs/heads/next
+		EOF
 
-	test_cmp pre-receive.expect pre-receive.actual &&
-	test_cmp update.expect update.actual &&
-	test_cmp post-receive.expect post-receive.actual &&
-	test_cmp post-update.expect post-update.actual
+		test_cmp pre-receive.expect pre-receive.actual &&
+		test_cmp update.expect update.actual &&
+		test_cmp post-receive.expect post-receive.actual &&
+		test_cmp post-update.expect post-update.actual
 	)
 '
 
-- 
1.7.7.rc3.4.g8d714

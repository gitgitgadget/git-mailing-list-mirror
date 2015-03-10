From: Junio C Hamano <gitster@pobox.com>
Subject: [JFF] "-" and "@{-1}" on various programs
Date: Tue, 10 Mar 2015 13:20:18 -0700
Message-ID: <xmqqy4n4zjst.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 10 21:20:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVQdd-00033p-PM
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 21:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbbCJUUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 16:20:21 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53844 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752198AbbCJUUU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 16:20:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 054223F5CE;
	Tue, 10 Mar 2015 16:20:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=k
	13xpfLyX8+P3BE3c81m5xrvhGs=; b=mCDD9YnlIZp7ApSaT3w4eQO583tSYCYfJ
	+Bv96oVDHrhIlxElGUWrlAWuj9d7W6HP0woTlvtrgRdYuR9um0Du/uXGjayL8Sxw
	0cyasNmc1HmQPWf0LOfd8sBEd3NTskCV47vrGwTGWQNktca4nqHyktwM7VBQ2trv
	4sfrvPf0LI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=qWG
	VlySB369M16jZVafstnW10LrQhdtAF702ZmELgZeuTv9yIRlysQPG8BBOIiK8Ut/
	KKbYOpp/eQqtdqitEq7FGD1D62g63GuYUc+5WUn8Iabgy02kdeWqgcL6BigI7qny
	yozUW0bLVNa3cX8lbq1B9MPEptNqfqBrqT8mSXNs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F123D3F5CD;
	Tue, 10 Mar 2015 16:20:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 523AB3F5CC;
	Tue, 10 Mar 2015 16:20:19 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DF3562FA-C762-11E4-B165-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265260>

JFF stands for just for fun.

This is not meant to give out a model answer and is known to be
incomplete, but I was wondering if it would be a better direction to
allow "-" as a stand-in for "@{-1}" everywhere we allow a branch
name, losing workarounds at the surface level we have for checkout,
merge and revert.

The first three paths are to remove the surface workarounds that
become unnecessary.  The one in sha1_name.c is the central change.

The change in revision.c is to allow a single "-" to be recognized
as a potential revision name (without this change, what begins with
"-" is either an option or an unknown option).

So you could do things like "git reset - $path" but also things like
"git log -" after switching out of a branch.

What does not work are what needs further tweaking in revision.c
parser.  "git checkout master && git checkout next && git log -.."
should show what next has on top of master but I didn't touch the
range notation so it does not work, for example.

 builtin/checkout.c |  3 ---
 builtin/merge.c    |  3 +--
 builtin/revert.c   |  2 --
 revision.c         |  2 +-
 sha1_name.c        | 57 +++++++++++++++++++++++++++++++++---------------------
 5 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 7e2d144..8f52a92 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1169,9 +1169,6 @@ static int parse_branchname_arg(int argc, const char **argv,
 	else if (dash_dash_pos >= 2)
 		die(_("only one reference expected, %d given."), dash_dash_pos);
 
-	if (!strcmp(arg, "-"))
-		arg = "@{-1}";
-
 	if (get_sha1_mb(arg, rev)) {
 		/*
 		 * Either case (3) or (4), with <something> not being
diff --git a/builtin/merge.c b/builtin/merge.c
index 90dd5e6..569dda3 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1164,8 +1164,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 				argc = setup_with_upstream(&argv);
 			else
 				die(_("No commit specified and merge.defaultToUpstream not set."));
-		} else if (argc == 1 && !strcmp(argv[0], "-"))
-			argv[0] = "@{-1}";
+		}
 	}
 	if (!argc)
 		usage_with_options(builtin_merge_usage,
diff --git a/builtin/revert.c b/builtin/revert.c
index 56a2c36..dc98b4e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -170,8 +170,6 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		opts->revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
 		if (argc < 2)
 			usage_with_options(usage_str, options);
-		if (!strcmp(argv[1], "-"))
-			argv[1] = "@{-1}";
 		memset(&s_r_opt, 0, sizeof(s_r_opt));
 		s_r_opt.assume_dashdash = 1;
 		argc = setup_revisions(argc, argv, opts->revs, &s_r_opt);
diff --git a/revision.c b/revision.c
index e1321d5..17709a1 100644
--- a/revision.c
+++ b/revision.c
@@ -2195,7 +2195,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	read_from_stdin = 0;
 	for (left = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
-		if (*arg == '-') {
+		if (arg[0] == '-' && arg[1]) {
 			int opts;
 
 			opts = handle_revision_pseudo_opt(submodule,
diff --git a/sha1_name.c b/sha1_name.c
index 95f9f8f..7a621ba 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -483,6 +483,8 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 				break;
 			}
 		}
+	} else if (len == 1 && str[0] == '-') {
+		nth_prior = 1;
 	}
 
 	/* Accept only unambiguous ref paths. */
@@ -491,13 +493,16 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1,
 
 	if (nth_prior) {
 		struct strbuf buf = STRBUF_INIT;
-		int detached;
+		int status;
 
 		if (interpret_nth_prior_checkout(str, len, &buf) > 0) {
-			detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
+			if (get_sha1(buf.buf, sha1))
+				/* bad---the previous branch no longer exists? */
+				status = -1;
+			else
+				status = 0; /* detached */
 			strbuf_release(&buf);
-			if (detached)
-				return 0;
+			return status;
 		}
 	}
 
@@ -931,35 +936,43 @@ static int interpret_nth_prior_checkout(const char *name, int namelen,
 					struct strbuf *buf)
 {
 	long nth;
-	int retval;
+	int consumed;
 	struct grab_nth_branch_switch_cbdata cb;
-	const char *brace;
-	char *num_end;
 
-	if (namelen < 4)
-		return -1;
-	if (name[0] != '@' || name[1] != '{' || name[2] != '-')
-		return -1;
-	brace = memchr(name, '}', namelen);
-	if (!brace)
-		return -1;
-	nth = strtol(name + 3, &num_end, 10);
-	if (num_end != brace)
-		return -1;
-	if (nth <= 0)
-		return -1;
+	if (namelen == 1 && name[0] == '-') {
+		nth = 1;
+		consumed = 1;
+	} else {
+		const char *brace;
+		char *num_end;
+
+		if (namelen < 4)
+			return -1;
+		if (name[0] != '@' || name[1] != '{' || name[2] != '-')
+			return -1;
+		brace = memchr(name, '}', namelen);
+		if (!brace)
+			return -1;
+		nth = strtol(name + 3, &num_end, 10);
+		if (num_end != brace)
+			return -1;
+		if (nth <= 0)
+			return -1;
+		consumed = brace - name + 1;
+	}
+
 	cb.remaining = nth;
 	strbuf_init(&cb.buf, 20);
 
-	retval = 0;
 	if (0 < for_each_reflog_ent_reverse("HEAD", grab_nth_branch_switch, &cb)) {
 		strbuf_reset(buf);
 		strbuf_addbuf(buf, &cb.buf);
-		retval = brace - name + 1;
+	} else {
+		consumed = 0;
 	}
 
 	strbuf_release(&cb.buf);
-	return retval;
+	return consumed;
 }
 
 int get_sha1_mb(const char *name, unsigned char *sha1)

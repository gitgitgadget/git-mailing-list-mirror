From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] Add `[decorate]' configuration section.
Date: Wed, 17 Feb 2010 10:28:28 -0800
Message-ID: <7vd403vhrn.fsf@alter.siamese.dyndns.org>
References: <16c38171fc04cee7bdc607bb4c6586925b15278c.1266394059.git.sdrake@xnet.co.nz>
 <7vr5ojwy38.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Drake <sdrake@xnet.co.nz>
X-From: git-owner@vger.kernel.org Wed Feb 17 19:28:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhodh-0003yQ-O5
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 19:28:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079Ab0BQS2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 13:28:39 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58775 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323Ab0BQS2i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 13:28:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 93E4E9A306;
	Wed, 17 Feb 2010 13:28:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=icciJtAr4b9d4r7tnlD1QV6LzB4=; b=pC3v2dusObixFiGewFg7XCn
	T9rdzQJpHrJH3/R1xPF2qPGyA1yeFNF7Css/hWodZAx19J2r90THSmFCaOj3L6fB
	xIZ+6LRalWrgETw+K2oJ1NO9npnzTEAgG2lb791MbqHkhx857jt6rOc8ZqV1ronx
	FQKjaMZ0BeTVAJKYRH+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=QiLVbsutvELhl0hjWcNpmvzGRPEgjGd5/1z+by+hGyVpjuUf5
	D6djAEvs7NdkOML+EpwICW/PaLPSu4C6o7G6YxBftBI1nq+P5r8YB0u5tKPKTBAa
	SBZLLXEsm6hbUXDssHHpKDpVw61ovodg6+lELcDCFCVHW8YDU3lGtLp4Aw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 660179A301;
	Wed, 17 Feb 2010 13:28:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5B4999A300; Wed, 17 Feb
 2010 13:28:30 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 412AB9BE-1BF2-11DF-99E6-D83AEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140241>

Junio C Hamano <gitster@pobox.com> writes:

> I somehow find the older "log.decorate" much more natural and the changes
> from it to this version not worth it, but maybe it is just me.

I was looking at your previous one.  Here is a bit of clean-up on top of
yours.

-- >8 --
Subject: [PATCH] log.decorate: usability fixes

The configuration is meant to suppliment --decorate command line option
that can be used as a boolean to turn the feature on, so it is natural
to expect

	[log]
		decorate
		decorate = yes

to work.  The original commit would segfault with the first one, and
would not understand the second one.

Once a user has this configuration in ~/.gitconfig, there needs to be a
way to override it from the command line.  Add --no-decorate option to
log family and also allow --decorate=no to mean the same thing.  Since
we allow setting log.decorate to 'true', the command line also should
accept --decorate=yes and behave accordingly.

New tests in t4202 are designed to exercise the interaction between the
configuration variable and the command line option that overrides it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-log.txt |    3 +-
 builtin-log.c             |   35 +++++++++++++++++++++++---------
 t/t4202-log.sh            |   49 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 0e39bb6..64bb879 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -37,7 +37,8 @@ include::diff-options.txt[]
 	and <until>, see "SPECIFYING REVISIONS" section in
 	linkgit:git-rev-parse[1].
 
---decorate[=short|full]::
+--no-decorate::
+--decorate[=short|full|no]::
 	Print out the ref names of any commits that are shown. If 'short' is
 	specified, the ref name prefixes 'refs/heads/', 'refs/tags/' and
 	'refs/remotes/' will not be printed. If 'full' is specified, the
diff --git a/builtin-log.c b/builtin-log.c
index 3100dc0..0afba31 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -24,7 +24,7 @@
 static const char *default_date_mode = NULL;
 
 static int default_show_root = 1;
-static int decoration_style = 0;
+static int decoration_style;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
@@ -32,6 +32,23 @@ static const char * const builtin_log_usage =
 	"git log [<options>] [<since>..<until>] [[--] <path>...]\n"
 	"   or: git show [options] <object>...";
 
+static int parse_decoration_style(const char *var, const char *value)
+{
+	switch (git_config_maybe_bool(var, value)) {
+	case 1:
+		return DECORATE_SHORT_REFS;
+	case 0:
+		return 0;
+	default:
+		break;
+	}
+	if (!strcmp(value, "full"))
+		return DECORATE_FULL_REFS;
+	else if (!strcmp(value, "short"))
+		return DECORATE_SHORT_REFS;
+	return -1;
+}
+
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
@@ -74,12 +91,11 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 			decoration_style = DECORATE_SHORT_REFS;
 		} else if (!prefixcmp(arg, "--decorate=")) {
 			const char *v = skip_prefix(arg, "--decorate=");
-			if (!strcmp(v, "full"))
-				decoration_style = DECORATE_FULL_REFS;
-			else if (!strcmp(v, "short"))
-				decoration_style = DECORATE_SHORT_REFS;
-			else
+			decoration_style = parse_decoration_style(arg, v);
+			if (decoration_style < 0)
 				die("invalid --decorate option: %s", arg);
+		} else if (!strcmp(arg, "--no-decorate")) {
+			decoration_style = 0;
 		} else if (!strcmp(arg, "--source")) {
 			rev->show_source = 1;
 		} else if (!strcmp(arg, "-h")) {
@@ -253,10 +269,9 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "log.date"))
 		return git_config_string(&default_date_mode, var, value);
 	if (!strcmp(var, "log.decorate")) {
-		if (!strcmp(value, "full"))
-			decoration_style = DECORATE_FULL_REFS;
-		else if (!strcmp(value, "short"))
-			decoration_style = DECORATE_SHORT_REFS;
+		decoration_style = parse_decoration_style(var, value);
+		if (decoration_style < 0)
+			decoration_style = 0; /* maybe warn? */
 		return 0;
 	}
 	if (!strcmp(var, "log.showroot")) {
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 1dc224f..2230e60 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -387,5 +387,54 @@ test_expect_success 'log --graph with merge' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log.decorate configuration' '
+	git config --unset-all log.decorate || :
+
+	git log --oneline >expect.none &&
+	git log --oneline --decorate >expect.short &&
+	git log --oneline --decorate=full >expect.full &&
+
+	echo "[log] decorate" >>.git/config &&
+	git log --oneline >actual &&
+	test_cmp expect.short actual &&
+
+	git config --unset-all log.decorate &&
+	git config log.decorate true &&
+	git log --oneline >actual &&
+	test_cmp expect.short actual &&
+	git log --oneline --decorate=full >actual &&
+	test_cmp expect.full actual &&
+	git log --oneline --decorate=no >actual &&
+	test_cmp expect.none actual &&
+
+	git config --unset-all log.decorate &&
+	git config log.decorate no &&
+	git log --oneline >actual &&
+	test_cmp expect.none actual &&
+	git log --oneline --decorate >actual &&
+	test_cmp expect.short actual &&
+	git log --oneline --decorate=full >actual &&
+	test_cmp expect.full actual &&
+
+	git config --unset-all log.decorate &&
+	git config log.decorate short &&
+	git log --oneline >actual &&
+	test_cmp expect.short actual &&
+	git log --oneline --no-decorate >actual &&
+	test_cmp expect.none actual &&
+	git log --oneline --decorate=full >actual &&
+	test_cmp expect.full actual &&
+
+	git config --unset-all log.decorate &&
+	git config log.decorate full &&
+	git log --oneline >actual &&
+	test_cmp expect.full actual &&
+	git log --oneline --no-decorate >actual &&
+	test_cmp expect.none actual &&
+	git log --oneline --decorate >actual &&
+	test_cmp expect.short actual
+
+'
+
 test_done
 
-- 
1.7.0.54.gbe03aa

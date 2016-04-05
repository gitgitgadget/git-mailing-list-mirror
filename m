From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 0/4] Expanding tabs in "git log" output
Date: Mon,  4 Apr 2016 17:58:33 -0700
Message-ID: <1459817917-32078-1-git-send-email-gitster@pobox.com>
References: <1459293309-25195-1-git-send-email-gitster@pobox.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 02:58:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anFKP-0002NW-Ia
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 02:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbcDEA6l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 20:58:41 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751539AbcDEA6k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 20:58:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1377653080;
	Mon,  4 Apr 2016 20:58:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=uzpi
	Npm0xq0dy+ye5EQJ2IKan5M=; b=RjHCi6b2yxeRqDcocwjrQIm96Ax0+rAmXH7R
	AVzDa5WIFFkpkDBEvcYIyZjZxZm3SpkgvE1y4svBHFwrf/NQD1umuwdE1ihkQLq4
	3HRcOi6MT/p8VdUZTv4bP9AVXjLvAOch1I8SNQkML4x0cGKGqzTOZpgN2EElcVTU
	c8ZLy+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	upIV2p5ZD7iZlYNwgPXf82MY42GIIACOwb3n3q5/A8bu9si6g3kpuCRlVrbPXbJg
	sw0mZIs/Dn9LVrQB7NmfQ7lTY5T9aj/c12vovVux5148UGRXLKLb48sKuD9u63mj
	cfXBbNSLaWF+OzeEGoxiTd/A2BNR19hw2/RPEmvlZcQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0B2135307F;
	Mon,  4 Apr 2016 20:58:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6B4C25307E;
	Mon,  4 Apr 2016 20:58:38 -0400 (EDT)
X-Mailer: git-send-email 2.8.1-251-g9997610
In-Reply-To: <1459293309-25195-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 882AA83A-FAC9-11E5-9D2E-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290740>

So here is the fifth and hopefully the final try.  Previous round
are at $gmane/289694, $gmane/289166, $gmane/288987 and
$gmane/290222.

This round is different from v4 in the following ways.

 * wording changes, grammo- and typo-fixes in the documentation
   (thanks to Eric Sunshine and Jeff King).

 * v4 made --pretty=$fmt to override an earlier --expand-tabs=<n>;
   this round only allows --pretty=$fmt to set the default behaviour
   when an explicit --expand-tabs=<n> is given on the command line
   (thanks to Jeff King).
   
 * comes with a test.

See the end of this cover letter for an interdiff.

Junio C Hamano (3):
  pretty: enable --expand-tabs by default for selected pretty formats
  pretty: allow tweaking tabwidth in --expand-tabs
  pretty: test --expand-tabs

Linus Torvalds (1):
  pretty: expand tabs in indented logs to make things line up properly

 Documentation/pretty-options.txt | 14 ++++++
 builtin/log.c                    |  1 +
 commit.h                         |  1 +
 log-tree.c                       |  1 +
 pretty.c                         | 90 ++++++++++++++++++++++++++++++++----
 revision.c                       | 14 ++++++
 revision.h                       |  2 +
 t/t4201-shortlog.sh              |  2 +-
 t/t4213-log-tabexpand.sh         | 98 ++++++++++++++++++++++++++++++++++++++++
 9 files changed, 213 insertions(+), 10 deletions(-)
 create mode 100755 t/t4213-log-tabexpand.sh

-- 
2.8.1-251-g9997610


diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
index 8a944b1..93ad1cd 100644
--- a/Documentation/pretty-options.txt
+++ b/Documentation/pretty-options.txt
@@ -45,16 +45,16 @@ people using 80-column terminals.
 --expand-tabs=<n>::
 --expand-tabs::
 --no-expand-tabs::
-	Perform a tab expansion (replace each tab with enough number
-	of spaces to fill to the next display column that is
-	multiple of '<n>') in the log message before using the message
-	to show in the output.  `--expand-tabs` is a short-hand for
-	`--expand-tabs=8`, and `--no-expand-tabs` is a short-hand for
-	`--expand-tabs=0`, which disables tab expansion.
+	Perform a tab expansion (replace each tab with enough spaces
+	to fill to the next display column that is multiple of '<n>')
+	in the log message before showing it in the output.
+	`--expand-tabs` is a short-hand for `--expand-tabs=8`, and
+	`--no-expand-tabs` is a short-hand for `--expand-tabs=0`,
+	which disables tab expansion.
 +
 By default, tabs are expanded in pretty formats that indent the log
 message by 4 spaces (i.e.  'medium', which is the default, 'full',
-and "fuller').
+and 'fuller').
 
 ifndef::git-rev-list[]
 --notes[=<ref>]::
diff --git a/builtin/log.c b/builtin/log.c
index e00cea7..e5775ae 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1281,6 +1281,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
+	rev.expand_tabs_in_log_default = 0;
 	rev.verbose_header = 1;
 	rev.diff = 1;
 	rev.max_parents = 1;
diff --git a/commit.h b/commit.h
index 2185c8d..b06db4d 100644
--- a/commit.h
+++ b/commit.h
@@ -147,7 +147,7 @@ struct pretty_print_context {
 	int preserve_subject;
 	struct date_mode date_mode;
 	unsigned date_mode_explicit:1;
-	unsigned expand_tabs_in_log;
+	int expand_tabs_in_log;
 	int need_8bit_cte;
 	char *notes_message;
 	struct reflog_walk_info *reflog_info;
diff --git a/pretty.c b/pretty.c
index b340ecd..87c4497 100644
--- a/pretty.c
+++ b/pretty.c
@@ -173,7 +173,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 
 	rev->commit_format = commit_format->format;
 	rev->use_terminator = commit_format->is_tformat;
-	rev->expand_tabs_in_log = commit_format->expand_tabs_in_log;
+	rev->expand_tabs_in_log_default = commit_format->expand_tabs_in_log;
 	if (commit_format->format == CMIT_FMT_USERFORMAT) {
 		save_user_format(rev, commit_format->user_format,
 				 commit_format->is_tformat);
@@ -1722,6 +1722,9 @@ void pp_remainder(struct pretty_print_context *pp,
 		strbuf_grow(sb, linelen + indent + 20);
 		if (indent)
 			pp_handle_indent(pp, sb, indent, line, linelen);
+		else if (pp->expand_tabs_in_log)
+			strbuf_add_tabexpand(sb, pp->expand_tabs_in_log,
+					     line, linelen);
 		else
 			strbuf_add(sb, line, linelen);
 		strbuf_addch(sb, '\n');
diff --git a/revision.c b/revision.c
index 4f9ecbe..47e9ee7 100644
--- a/revision.c
+++ b/revision.c
@@ -1412,9 +1412,10 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->skip_count = -1;
 	revs->max_count = -1;
 	revs->max_parents = -1;
-	revs->expand_tabs_in_log = 8;
+	revs->expand_tabs_in_log = -1;
 
 	revs->commit_format = CMIT_FMT_DEFAULT;
+	revs->expand_tabs_in_log_default = 8;
 
 	init_grep_defaults();
 	grep_init(&revs->grep_filter, prefix);
@@ -2398,6 +2399,9 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->first_parent_only && revs->bisect)
 		die(_("--first-parent is incompatible with --bisect"));
 
+	if (revs->expand_tabs_in_log < 0)
+		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
+
 	return left;
 }
 
diff --git a/revision.h b/revision.h
index cf6615a..6cc36b4 100644
--- a/revision.h
+++ b/revision.h
@@ -148,7 +148,9 @@ struct rev_info {
 			linear:1;
 
 	struct date_mode date_mode;
-	unsigned int	expand_tabs_in_log;
+	int		expand_tabs_in_log; /* unset if negative */
+	int		expand_tabs_in_log_default;
+
 	unsigned int	abbrev;
 	enum cmit_fmt	commit_format;
 	struct log_info *loginfo;
diff --git a/t/t4213-log-tabexpand.sh b/t/t4213-log-tabexpand.sh
new file mode 100755
index 0000000..74ca03a
--- /dev/null
+++ b/t/t4213-log-tabexpand.sh
@@ -0,0 +1,98 @@
+#!/bin/sh
+
+test_description='log/show --expand-tabs'
+
+. ./test-lib.sh
+
+HT="	"
+title='tab indent at the beginning of the title line'
+body='tab indent on a line in the body'
+
+count_expand ()
+{
+	case " $* " in
+	*' --pretty=short '*)
+		line=$title ;;
+	*)
+		line=$body ;;
+	esac
+	expect=
+	count=$(( $1 + $2 )) ;# expected spaces
+	while test $count -gt 0
+	do
+		expect="$expect "
+		count=$(( $count - 1 ))
+	done
+	shift 2
+	count=$1 ;# expected tabs
+	while test $count -gt 0
+	do
+		expect="$expect$HT"
+		count=$(( $count - 1 ))
+	done
+	shift
+	{
+		echo "git show -s $*"
+		echo "$expect$line"
+	} | sed -e 's/ /./g' >expect
+
+	{
+		echo "git show -s $*"
+		git show -s "$@" |
+		sed -n -e "/$line\$/p"
+	} | sed -e 's/ /./g' >actual
+
+	test_cmp expect actual
+}
+
+test_expand ()
+{
+	fmt=$1
+	case "$fmt" in
+	*=raw | *=short | *=email)
+		default="0 1" ;;
+	*)
+		default="8 0" ;;
+	esac
+	case "$fmt" in
+	*=email)
+		in=0 ;;
+	*)
+		in=4 ;;
+	esac
+	test_expect_success "expand/no-expand${fmt:+ for $fmt}" '
+		count_expand $in $default $fmt &&
+		count_expand $in 8 0 $fmt --expand-tabs &&
+		count_expand $in 8 0 --expand-tabs $fmt &&
+		count_expand $in 8 0 $fmt --expand-tabs=8 &&
+		count_expand $in 8 0 --expand-tabs=8 $fmt &&
+		count_expand $in 0 1 $fmt --no-expand-tabs &&
+		count_expand $in 0 1 --no-expand-tabs $fmt &&
+		count_expand $in 0 1 $fmt --expand-tabs=0 &&
+		count_expand $in 0 1 --expand-tabs=0 $fmt &&
+		count_expand $in 4 0 $fmt --expand-tabs=4 &&
+		count_expand $in 4 0 --expand-tabs=4 $fmt
+	'
+}
+
+test_expect_success 'setup' '
+	test_tick &&
+	sed -e "s/Q/$HT/g" <<-EOF >msg &&
+	Q$title
+
+	Q$body
+	EOF
+	git commit --allow-empty -F msg
+'
+
+test_expand ""
+test_expand --pretty
+test_expand --pretty=short
+test_expand --pretty=medium
+test_expand --pretty=full
+test_expand --pretty=fuller
+test_expand --pretty=fuller
+test_expand --pretty=raw
+test_expand --pretty=email
+
+test_done

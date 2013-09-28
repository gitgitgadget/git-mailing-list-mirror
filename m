From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 44/44] request-pull: rewrite to C
Date: Sat, 28 Sep 2013 17:04:09 -0500
Message-ID: <1380405849-13000-45-git-send-email-felipe.contreras@gmail.com>
References: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 29 00:12:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQ2kN-0004Mv-O4
	for gcvg-git-2@plane.gmane.org; Sun, 29 Sep 2013 00:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405Ab3I1WMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Sep 2013 18:12:16 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:51819 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389Ab3I1WMN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Sep 2013 18:12:13 -0400
Received: by mail-ob0-f180.google.com with SMTP id wm4so4207243obc.11
        for <git@vger.kernel.org>; Sat, 28 Sep 2013 15:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PR+75XbtC7sYwwmpmr3X6P9PkvrsgEwSFpGu2Den36Q=;
        b=oC6cEDDy0PDWIQFAJyJBh+/yZtO3y+1KKnUMzt0xXRSUpYOTVJmj9JsSyKUMSp9BKw
         +1TSXy8zmJ55pjh7RClvVE3XpS8c3NmC1K3pNRmzdiZN39ceWG2TWBVYpwuhTrkayvtE
         frNYK51mXC0eYJ/vt6dyMFZzPof9aSB7LGYVnu7/JhT2Kth/I91G4zIRgpek+RMSZRwP
         Mxe4iVmktpWubP5hpGz4GZpY5YA7ztTxtvt4EiTxPOoTelfALqfTe8xxzLtRCuFdah8E
         y6bR4cmgwbUQpfoAz/mp11U2Twey9PNp6oznyPA0tPzyIThk97254waDh883V/TvkBEW
         NiKw==
X-Received: by 10.182.237.75 with SMTP id va11mr12554824obc.5.1380406332734;
        Sat, 28 Sep 2013 15:12:12 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm19553640obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 15:12:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1380405849-13000-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235564>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Makefile               |   3 +-
 builtin.h              |   1 +
 builtin/request-pull.c | 275 +++++++++++++++++++++++++++++++++++++++++++++++++
 git-request-pull.rb    | 199 -----------------------------------
 git.c                  |   1 +
 5 files changed, 278 insertions(+), 201 deletions(-)
 create mode 100644 builtin/request-pull.c
 delete mode 100755 git-request-pull.rb

diff --git a/Makefile b/Makefile
index 709c087..edbceea 100644
--- a/Makefile
+++ b/Makefile
@@ -492,9 +492,7 @@ SCRIPT_PYTHON += git-remote-testpy.py
 SCRIPT_PYTHON += git-p4.py
 
 SCRIPT_RUBY += git-rb-setup.rb
-SCRIPT_RUBY += git-request-pull.rb
 
-RUBY_PROGRAMS += git-request-pull$X
 PROGRAMS += $(RUBY_PROGRAMS)
 
 NO_INSTALL += git-remote-testgit
@@ -983,6 +981,7 @@ BUILTIN_OBJS += builtin/remote.o
 BUILTIN_OBJS += builtin/remote-ext.o
 BUILTIN_OBJS += builtin/remote-fd.o
 BUILTIN_OBJS += builtin/replace.o
+BUILTIN_OBJS += builtin/request-pull.o
 BUILTIN_OBJS += builtin/rerere.o
 BUILTIN_OBJS += builtin/reset.o
 BUILTIN_OBJS += builtin/rev-list.o
diff --git a/builtin.h b/builtin.h
index 8afa2de..7db356e 100644
--- a/builtin.h
+++ b/builtin.h
@@ -103,6 +103,7 @@ extern int cmd_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_remote_ext(int argc, const char **argv, const char *prefix);
 extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
 extern int cmd_repo_config(int argc, const char **argv, const char *prefix);
+extern int cmd_request_pull(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
diff --git a/builtin/request-pull.c b/builtin/request-pull.c
new file mode 100644
index 0000000..a8f7f04
--- /dev/null
+++ b/builtin/request-pull.c
@@ -0,0 +1,275 @@
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "revision.h"
+#include "refs.h"
+#include "remote.h"
+#include "transport.h"
+#include "branch.h"
+#include "shortlog.h"
+#include "diff.h"
+#include "log-tree.h"
+
+static const char *tag_name;
+
+static const char *const pull_request_usage[] = {
+	N_("git request-pull [options] start url [end]"),
+	NULL
+};
+
+static int describe_cb(const char *name, const unsigned char *sha1, int flags, void *cb_data)
+{
+	unsigned char peel_sha1[20];
+	if (prefixcmp(name, "refs/tags/"))
+		return 0;
+	peel_ref(name, peel_sha1);
+	if (hashcmp(peel_sha1, cb_data))
+		return 0;
+	tag_name = skip_prefix(name, "refs/tags/");
+	return 1;
+}
+
+const char *describe(const char *head)
+{
+	unsigned char sha1[20];
+	get_sha1(head, sha1);
+	for_each_ref(describe_cb, sha1);
+	return tag_name;
+}
+
+const char *abbr(const char *name)
+{
+	return name + (
+			!prefixcmp(name, "refs/heads/") ? 11 :
+			!prefixcmp(name, "refs/tags/") ? 5 :
+			0);
+}
+
+const char *get_ref(struct transport *transport, const char *head_ref, const unsigned char *head_id)
+{
+	const struct ref *refs, *e;
+	const char *found = NULL;
+	int deref;
+
+	refs = transport_get_remote_refs(transport);
+
+	for (e = refs; e; e = e->next) {
+		if (hashcmp(e->old_sha1, head_id))
+			continue;
+
+		deref = !suffixcmp(e->name, "^{}");
+		found = abbr(e->name);
+		if (deref && tag_name && !prefixcmp(e->name + 10, tag_name))
+			break;
+		if (head_ref && !strcmp(e->name, head_ref))
+			break;
+	}
+	if (!found)
+		return NULL;
+	return xstrndup(found, strlen(found) - (deref ? 3 : 0));
+}
+
+static const char *show_ident_date(const struct ident_split *ident,
+				   enum date_mode mode)
+{
+	unsigned long date = 0;
+	int tz = 0;
+
+	if (ident->date_begin && ident->date_end)
+		date = strtoul(ident->date_begin, NULL, 10);
+	if (ident->tz_begin && ident->tz_end)
+		tz = strtol(ident->tz_begin, NULL, 10);
+	return show_date(date, tz, mode);
+}
+
+static void parse_buffer(const char *buffer, const char **summary, const char **date)
+{
+	struct strbuf subject = STRBUF_INIT;
+	struct ident_split s;
+	const char *c, *e;
+
+	c = strstr(buffer, "\ncommitter ") + 11;
+	e = strchr(c, '\n');
+	if (!split_ident_line(&s, c, e - c))
+		*date = show_ident_date(&s, DATE_ISO8601);
+
+	c = strstr(c, "\n\n") + 2;
+	format_subject(&subject, c, " ");
+	*summary = strbuf_detach(&subject, NULL);
+}
+
+static void show_shortlog(const char *base, const char *head)
+{
+	struct commit *commit;
+	struct rev_info revs;
+	struct shortlog log;
+	const char *args[3];
+	struct strbuf tmp = STRBUF_INIT;
+
+	strbuf_addf(&tmp, "^%s", base);
+
+	args[1] = tmp.buf;
+	args[2] = head;
+
+	init_revisions(&revs, NULL);
+	setup_revisions(3, args, &revs, NULL);
+
+	strbuf_release(&tmp);
+
+	shortlog_init(&log);
+	prepare_revision_walk(&revs);
+	while ((commit = get_revision(&revs)))
+		shortlog_add_commit(&log, commit);
+	shortlog_output(&log);
+}
+
+static void show_diff(int patch, const unsigned char *base, const unsigned char *head)
+{
+	struct rev_info revs;
+	const char *args[3];
+	struct strbuf tmp = STRBUF_INIT;
+
+	strbuf_addf(&tmp, "^%s", sha1_to_hex(base));
+
+	args[1] = tmp.buf;
+	args[2] = sha1_to_hex(head);
+
+	init_revisions(&revs, NULL);
+	setup_revisions(3, args, &revs, NULL);
+	revs.diffopt.stat_width = -1;
+	revs.diffopt.stat_graph_width = -1;
+	revs.diffopt.output_format = patch ? DIFF_FORMAT_PATCH : DIFF_FORMAT_DIFFSTAT;
+	revs.diffopt.output_format |= DIFF_FORMAT_SUMMARY;
+	revs.diffopt.detect_rename = DIFF_DETECT_RENAME;
+	revs.diffopt.flags |= DIFF_OPT_RECURSIVE;
+
+	strbuf_release(&tmp);
+	diff_tree_sha1(base, head, "", &revs.diffopt);
+	log_tree_diff_flush(&revs);
+}
+
+int cmd_request_pull(int argc, const char **argv, const char *prefix)
+{
+	int patch;
+	const char *base, *url, *head;
+	char *head_ref;
+	char *branch_name = NULL;
+	struct strbuf branch_desc = STRBUF_INIT;
+	const char *ref;
+	int status = 0;
+	unsigned char head_id[20], base_id[20];
+	unsigned char *merge_base_id;
+	struct commit *base_commit, *head_commit, *merge_base_commit;
+	struct commit_list *merge_bases;
+	const char *merge_base_summary, *merge_base_date;
+	const char *head_summary, *head_date;
+	struct remote *remote;
+	struct transport *transport;
+
+	const struct option options[] = {
+		OPT_BOOL('p', NULL, &patch, N_("show patch text as well")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, options, pull_request_usage, 0);
+
+	base = argv[0];
+	url = argv[1];
+	head = argv[2] ? argv[2] : "HEAD";
+	status = 0;
+
+	if (!base || !url)
+		usage_with_options(pull_request_usage, options);
+
+	if (dwim_ref(head, strlen(head), head_id, &head_ref) == 1) {
+		if (!prefixcmp(head_ref, "refs/heads/")) {
+			branch_name = head_ref + 11;
+			if (read_branch_desc(&branch_desc, branch_name) || !branch_desc.len)
+				branch_name = NULL;
+		}
+	}
+
+	describe(head);
+
+	get_sha1(base, base_id);
+	base_commit = lookup_commit_reference(base_id);
+	if (!base_commit)
+		die("Not a valid revision: %s", base);
+
+	head_commit = lookup_commit_reference(head_id);
+	if (!head_commit)
+		die("Not a valid revision: %s", head);
+
+	merge_bases = get_merge_bases(base_commit, head_commit, 0);
+	if (!merge_bases)
+		die("No commits in common between %s and %s", base, head);
+
+	merge_base_commit = merge_bases->item;
+	merge_base_id = merge_base_commit->object.sha1;
+
+	remote = remote_get(url);
+	url = remote->url[0];
+	transport = transport_get(remote, url);
+	ref = get_ref(transport, strcmp(head_ref, "HEAD") ? head_ref : NULL, head_id);
+	transport_disconnect(transport);
+
+	parse_buffer(merge_base_commit->buffer, &merge_base_summary, &merge_base_date);
+	parse_buffer(head_commit->buffer, &head_summary, &head_date);
+
+	printf("The following changes since commit %s:\n"
+			"\n"
+			"  %s (%s)\n"
+			"\n"
+			"are available in the git repository at:\n"
+			"\n",
+			sha1_to_hex(merge_base_id), merge_base_summary, merge_base_date);
+	printf("  %s", url);
+	if (ref)
+		printf(" %s", ref);
+	printf("\n");
+	printf("\n"
+			"for you to fetch changes up to %s:\n"
+			"\n"
+			"  %s (%s)\n"
+			"\n"
+			"----------------------------------------------------------------\n",
+			sha1_to_hex(head_id), head_summary, head_date);
+
+	if (branch_name)
+		printf("(from the branch description for %s local branch)\n\n%s\n", branch_name, branch_desc.buf);
+
+	if (tag_name) {
+		void *buffer;
+		enum object_type type;
+		unsigned long size;
+		unsigned char sha1[20];
+		const char *begin, *end;
+
+		if (!ref || prefixcmp(ref, "tags/") || strcmp(ref + 5, tag_name)) {
+			fprintf(stderr, "warn: You locally have %s but it does not (yet)\n", tag_name);
+			fprintf(stderr, "warn: appear to be at %s\n", url);
+			fprintf(stderr, "warn: Do you want to push it there, perhaps?\n");
+		}
+		get_sha1(tag_name, sha1);
+		buffer = read_sha1_file(sha1, &type, &size);
+		begin = strstr(buffer, "\n\n") + 2;
+		end = strstr(begin, "-----BEGIN PGP ");
+		if (!end)
+			end = begin + strlen(begin);
+		printf("%.*s\n", (int)(end - begin), begin);
+	}
+
+	if (branch_name || tag_name)
+		puts("----------------------------------------------------------------");
+
+	show_shortlog(base, head);
+	show_diff(patch, merge_base_id, head_id);
+
+	if (!ref) {
+		fprintf(stderr, "warn: No branch of %s is at:\n", url);
+		fprintf(stderr, "warn:   %s: %s\n", find_unique_abbrev(head_id, DEFAULT_ABBREV), head_summary);
+		fprintf(stderr, "warn: Are you sure you pushed '%s' there?\n", head);
+		status = 1;
+	}
+	return status;
+}
diff --git a/git-request-pull.rb b/git-request-pull.rb
deleted file mode 100755
index 941ff72..0000000
--- a/git-request-pull.rb
+++ /dev/null
@@ -1,199 +0,0 @@
-#!git ruby
-
-require 'date'
-
-patch = nil
-
-def usage
-  puts <<EOF
-usage: git request-pull [options] start url [end]
-
-    -p                    show patch text as well
-
-EOF
-  exit 1
-end
-
-def read_branch_desc(name)
-  git_config() do |key, value|
-    return value if key == "branch.#{name}.description"
-  end
-  return nil
-end
-
-def describe(rev)
-  for_each_ref() do |name, sha1, flags|
-    next unless name.start_with?('refs/tags/')
-    next unless peel_ref(name) == get_sha1(rev)
-    return name.skip_prefix('refs/tags/')
-  end
-  return nil
-end
-
-def abbr(ref)
-  if (ref =~ %r{^refs/heads/(.*)} || ref =~ %r{^refs/(tags/.*)})
-    return $1
-  end
-  return ref
-end
-
-# $head is the token given from the command line, and $tag_name, if
-# exists, is the tag we are going to show the commit information for.
-# If that tag exists at the remote and it points at the commit, use it.
-# Otherwise, if a branch with the same name as $head exists at the remote
-# and their values match, use that instead.
-#
-# Otherwise find a random ref that matches $head_id.
-
-def get_ref(transport, head_ref, head_id, tag_name)
-  found = nil
-  transport.get_remote_refs().each do |e|
-    sha1 = e.old_sha1
-    next unless sha1 == head_id
-    ref, deref = e.name.scan(/^(\S+?)(\^\{\})?$/).first
-    found = abbr(ref)
-    break if (deref && ref == "refs/tags/#{tag_name}")
-    break if ref == head_ref
-  end
-  return found
-end
-
-def parse_buffer(buffer)
-  summary = []
-  date = msg = nil
-  header, body = buffer.split("\n\n", 2)
-  header.each_line do |line|
-    case line
-    when /^committer ([^<>]+) <(\S+)> (.+)$/
-      date = DateTime.strptime($3, '%s %z')
-    end
-  end
-  body.each_line do |l|
-    break if (l.strip.empty?)
-    summary << l.chomp
-  end
-  summary = summary.join(' ')
-  date = date.strftime('%F %T %z')
-  return [summary, date]
-end
-
-def show_shortlog(base, head)
-  rev = Git::RevInfo.setup(nil, ['^' + base, head], nil)
-  shortlog(rev.to_a)
-end
-
-def show_diff(patch, base, head)
-  rev = Git::RevInfo.setup(nil, ['^' + sha1_to_hex(base), sha1_to_hex(head)], nil)
-  rev.diffopt.stat_width = -1
-  rev.diffopt.stat_graph_width = -1
-  rev.diffopt.output_format = patch ? DIFF_FORMAT_PATCH : DIFF_FORMAT_DIFFSTAT
-  rev.diffopt.output_format |= DIFF_FORMAT_SUMMARY
-  rev.diffopt.detect_rename = DIFF_DETECT_RENAME
-  rev.diffopt.flags |= DIFF_OPT_RECURSIVE
-
-  diff_tree_sha1(base, head, "", rev.diffopt)
-  log_tree_diff_flush(rev)
-end
-
-until ARGV.empty?
-  case ARGV.first
-  when '-p'
-    patch = '-p'
-  when '--'
-    ARGV.shift
-    break
-  when /^-/
-    usage
-  else
-    break
-  end
-  ARGV.shift
-end
-
-base = ARGV[0]
-url = ARGV[1]
-head = ARGV[2] || 'HEAD'
-branch_name = branch_desc = nil
-
-usage unless base or url
-
-_, _, head_ref = dwim_ref(head)
-
-if head_ref.start_with?('refs/heads')
-  branch_name = head_ref[11..-1]
-  branch_desc = read_branch_desc(branch_name)
-  branch_name = nil if not branch_desc
-end
-
-tag_name = describe(head)
-
-base_id = get_sha1("#{base}^0")
-die "Not a valid revision: #{base}" unless base_id
-
-head_id = get_sha1("#{head}^0")
-die "Not a valid revision: #{head}" unless head_id
-
-base_commit = Git::Commit.get(base_id)
-head_commit = Git::Commit.get(head_id)
-
-merge_bases = get_merge_bases([base_commit, head_commit], 0);
-die "No commits in common between #{base} and #{head}" unless merge_bases
-
-merge_base_id = merge_bases.first.sha1
-merge_base_commit = Git::Commit.get(merge_base_id)
-
-remote = remote_get(url)
-transport = transport_get(remote, nil)
-
-ref = get_ref(transport, head_ref != "HEAD" ? head_ref : nil, head_id, tag_name)
-url = remote.url.first
-
-merge_base_summary, merge_base_date = parse_buffer(merge_base_commit.buffer)
-head_summary, head_date = parse_buffer(head_commit.buffer)
-
-puts "The following changes since commit %s:
-
-  %s (%s)
-
-are available in the git repository at:
-
-" % [merge_base_commit, merge_base_summary, merge_base_date]
-puts "  #{url}" + (ref ? " #{ref}" : "")
-puts "
-for you to fetch changes up to %s:
-
-  %s (%s)
-
-----------------------------------------------------------------
-" % [head_commit, head_summary, head_date]
-
-if branch_name
-  puts "(from the branch description for #{branch_name} local branch)"
-  puts
-  puts branch_desc
-end
-
-if tag_name
-  if ref != "tags/#{tag_name}"
-    $stderr.puts "warn: You locally have #{tag_name} but it does not (yet)"
-    $stderr.puts "warn: appear to be at #{url}"
-    $stderr.puts "warn: Do you want to push it there, perhaps?"
-  end
-  buffer, _ = read_sha1_file(get_sha1(tag_name))
-  puts buffer.scan(/(?:\n\n)(.+)(?:-----BEGIN PGP )?/m).first
-  puts
-end
-
-if branch_name || tag_name
-  puts "----------------------------------------------------------------"
-end
-
-show_shortlog(base, head)
-show_diff(patch, merge_base_id, head_id)
-
-if ! ref
-  $stderr.puts "warn: No branch of #{url} is at:"
-  $stderr.puts "warn:   %s: %s'" % [find_unique_abbrev(head_id, DEFAULT_ABBREV), head_summary]
-  $stderr.puts "warn: Are you sure you pushed '#{abbr(head_ref)}' there?"
-  exit 1
-end
diff --git a/git.c b/git.c
index 2025f77..d67d3fb 100644
--- a/git.c
+++ b/git.c
@@ -398,6 +398,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "remote-fd", cmd_remote_fd },
 		{ "replace", cmd_replace, RUN_SETUP },
 		{ "repo-config", cmd_repo_config, RUN_SETUP_GENTLY },
+		{ "request-pull", cmd_request_pull, RUN_SETUP_GENTLY },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
-- 
1.8.4-fc

From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 16/22] push: the beginning of "git push --signed"
Date: Fri,  5 Sep 2014 13:55:04 -0700
Message-ID: <1409950510-10209-17-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:55:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0Xz-0005bR-1V
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbaIEUzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:53 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50272 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbaIEUzu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4831A366C3;
	Fri,  5 Sep 2014 16:55:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=nLky
	QLGzpeWbONwK2vS8KVRTY4g=; b=XxJ/ZTwCpb83qqgGKcXktuPxCHH8dukDYO7w
	AfgyScS9Jikl499LG0m1e6kteFGU4XPJ7GB+jciYVuZV/OwQCQ4YmU29VPoRK2Q+
	acNzp1qIto7tS+11eQDiT6Qyh/Ah6nznMyO1r9yU1XAOzn0+I9TSMwrogY435KV3
	cl83dxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=o4sk5b
	n5dVe9k1UyUTMNm8qeIDl+lMEAIclnUw20qTnuDOU9V1mzf1aWr4T6FYiBAJSxNY
	Qj/lyrykpo/wuLGlo4YfioPpOprvbC8MbQtCp6Q6Pq0W09VIdMFbmVOJSHuyXY41
	jtfe2zKFaDVnNRuh4PkWSFeEhlG2tkKKNNPuo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3FF3F366C2;
	Fri,  5 Sep 2014 16:55:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0124F366C0;
	Fri,  5 Sep 2014 16:55:48 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 03C138DA-353F-11E4-8B9F-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256527>

While signed tags and commits assert that the objects thusly signed
came from you, who signed these objects, there is not a good way to
assert that you wanted to have a particular object at the tip of a
particular branch.  My signing v2.0.1 tag only means I want to call
the version v2.0.1, and it does not mean I want to push it out to my
'master' branch---it is likely that I only want it in 'maint', so
the signature on the object alone is insufficient.

The only assurance to you that 'maint' points at what I wanted to
place there comes from your trust on the hosting site and my
authentication with it, which cannot easily audited later.

Introduce a mechanism that allows you to sign a "push certificate"
(for the lack of better name) every time you push, asserting that
what object you are pushing to update which ref that used to point
at what other object.  Think of it as a cryptographic protection for
ref updates, similar to signed tags/commits but working on an
orthogonal axis.

The basic flow based on this mechanism goes like this:

 1. You push out your work with "git push --signed".

 2. The sending side learns where the remote refs are as usual,
    together with what protocol extension the receiving end
    supports.  If the receiving end does not advertise the protocol
    extension "push-cert", an attempt to "git push --signed" fails.

    Otherwise, a text file, that looks like the following, is
    prepared in core:

	certificate version 0.1
	pusher Junio C Hamano <gitster@pobox.com> 1315427886 -0700

	7339ca65... 21580ecb... refs/heads/master
	3793ac56... 12850bec... refs/heads/next

    The file begins with a few header lines, which may grow as we
    gain more experience.  The 'pusher' header records the name of
    the signer (the value of user.signingkey configuration variable,
    falling back to GIT_COMMITTER_{NAME|EMAIL}) and the time of the
    certificate generation.  After the header, a blank line follows,
    followed by a copy of the protocol message lines.

    Each line shows the old and the new object name at the tip of
    the ref this push tries to update, in the way identical to how
    the underlying "git push" protocol exchange tells the ref
    updates to the receiving end (by recording the "old" object
    name, the push certificate also protects against replaying).  It
    is expected that new command packet types other than the
    old-new-refname kind will be included in push certificate in the
    same way as would appear in the plain vanilla command packets in
    unsigned pushes.

    The user then is asked to sign this push certificate using GPG,
    formatted in a way similar to how signed tag objects are signed,
    and the result is sent to the other side (i.e. receive-pack).

    In the protocol exchange, this step comes immediately before the
    sender tells what the result of the push should be, which in
    turn comes before it sends the pack data.

 3. When the receiving end sees a push certificate, the certificate
    is written out as a blob.  The pre-receive hook can learn about
    the certificate by checking GIT_PUSH_CERT environment variable,
    which, if present, tells the object name of this blob, and make
    the decision to allow or reject this push.  Additionally, the
    post-receive hook can also look at the certificate, which may be
    a good place to log all the received certificates for later
    audits.

Because a push certificate carry the same information as the usual
command packets in the protocol exchange, we can omit the latter
when a push certificate is in use and reduce the protocol overhead.
This however is not included in this patch to make it easier to
review (in other words, the series at this step should never be
released without the remainder of the series, as it implements an
interim protocol that will be incompatible with the final one,
merely for reviewing purposes).  As such, the documentation update
for the protocol is left out of this step.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt           |  6 +++
 Documentation/git-push.txt         |  9 +++-
 Documentation/git-receive-pack.txt | 18 +++++++-
 builtin/push.c                     |  1 +
 builtin/receive-pack.c             | 52 +++++++++++++++++++++++
 send-pack.c                        | 64 ++++++++++++++++++++++++++++
 send-pack.h                        |  1 +
 t/t5534-push-signed.sh             | 85 ++++++++++++++++++++++++++++++++++++++
 transport.c                        |  4 ++
 transport.h                        |  5 +++
 10 files changed, 243 insertions(+), 2 deletions(-)
 create mode 100755 t/t5534-push-signed.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c55c22a..0d01e32 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2038,6 +2038,12 @@ rebase.autostash::
 	successful rebase might result in non-trivial conflicts.
 	Defaults to false.
 
+receive.acceptpushcert::
+	By default, `git receive-pack` will advertise that it
+	accepts `git push --signed`.  Setting this variable to
+	false disables it (this is a tentative variable that
+	will go away at the end of this series).
+
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
 	receiving data from git-push and updating refs.  You can stop
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 21cd455..21b3f29 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -10,7 +10,8 @@ SYNOPSIS
 --------
 [verse]
 'git push' [--all | --mirror | --tags] [--follow-tags] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
-	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose] [-u | --set-upstream]
+	   [--repo=<repository>] [-f | --force] [--prune] [-v | --verbose]
+	   [-u | --set-upstream] [--signed]
 	   [--force-with-lease[=<refname>[:<expect>]]]
 	   [--no-verify] [<repository> [<refspec>...]]
 
@@ -129,6 +130,12 @@ already exists on the remote side.
 	from the remote but are pointing at commit-ish that are
 	reachable from the refs being pushed.
 
+--signed::
+	GPG-sign the push request to update refs on the receiving
+	side, to allow it to be checked by the hooks and/or be
+	logged.  See linkgit:git-receive-pack[1] for the details
+	on the receiving end.
+
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
 	Path to the 'git-receive-pack' program on the remote
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index b1f7dc6..9c4d17c 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -53,6 +53,11 @@ the update.  Refs to be created will have sha1-old equal to 0\{40},
 while refs to be deleted will have sha1-new equal to 0\{40}, otherwise
 sha1-old and sha1-new should be valid objects in the repository.
 
+When accepting a signed push (see linkgit:git-push[1]), the signed
+push certificate is stored in a blob and an environment variable
+`GIT_PUSH_CERT` can be consulted for its object name.  See the
+description of `post-receive` hook for an example.
+
 This hook is called before any refname is updated and before any
 fast-forward checks are performed.
 
@@ -101,9 +106,13 @@ the update.  Refs that were created will have sha1-old equal to
 0\{40}, otherwise sha1-old and sha1-new should be valid objects in
 the repository.
 
+The `GIT_PUSH_CERT` environment variable can be inspected, just as
+in `pre-receive` hook, after accepting a signed push.
+
 Using this hook, it is easy to generate mails describing the updates
 to the repository.  This example script sends one mail message per
-ref listing the commits pushed to the repository:
+ref listing the commits pushed to the repository, and logs the push
+certificates of signed pushes to a file:
 
 	#!/bin/sh
 	# mail out commit update information.
@@ -119,6 +128,13 @@ ref listing the commits pushed to the repository:
 		fi |
 		mail -s "Changes to ref $ref" commit-list@mydomain
 	done
+	# log signed push certificate, if any
+	if test -n "${GIT_PUSH_CERT-}"
+	then
+		(
+			git cat-file blob ${GIT_PUSH_CERT}
+		) | mail -s "push certificate" push-log@mydomain
+	fi
 	exit 0
 
 The exit code from this hook invocation is ignored, however a
diff --git a/builtin/push.c b/builtin/push.c
index f50e3d5..ae56f73 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -506,6 +506,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "no-verify", &flags, N_("bypass pre-push hook"), TRANSPORT_PUSH_NO_HOOK),
 		OPT_BIT(0, "follow-tags", &flags, N_("push missing but relevant tags"),
 			TRANSPORT_PUSH_FOLLOW_TAGS),
+		OPT_BIT(0, "signed", &flags, N_("GPG sign the push"), TRANSPORT_PUSH_CERT),
 		OPT_END()
 	};
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index cbbad54..610b085 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -46,6 +46,9 @@ static void *head_name_to_free;
 static int sent_capabilities;
 static int shallow_update;
 static const char *alt_shallow_file;
+static int accept_push_cert = 1;
+static struct strbuf push_cert = STRBUF_INIT;
+static unsigned char push_cert_sha1[20];
 
 static enum deny_action parse_deny_action(const char *var, const char *value)
 {
@@ -129,6 +132,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "receive.acceptpushcert") == 0) {
+		accept_push_cert = git_config_bool(var, value);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
@@ -146,6 +154,8 @@ static void show_ref(const char *path, const unsigned char *sha1)
 			      "report-status delete-refs side-band-64k quiet");
 		if (prefer_ofs_delta)
 			strbuf_addstr(&cap, " ofs-delta");
+		if (accept_push_cert)
+			strbuf_addstr(&cap, " push-cert");
 		strbuf_addf(&cap, " agent=%s", git_user_agent_sanitized());
 		packet_write(1, "%s %s%c%s\n",
 			     sha1_to_hex(sha1), path, 0, cap.buf);
@@ -258,6 +268,25 @@ static int copy_to_sideband(int in, int out, void *arg)
 	return 0;
 }
 
+static void prepare_push_cert_sha1(struct child_process *proc)
+{
+	static int already_done;
+	struct argv_array env = ARGV_ARRAY_INIT;
+
+	if (!push_cert.len)
+		return;
+
+	if (!already_done) {
+		already_done = 1;
+		if (write_sha1_file(push_cert.buf, push_cert.len, "blob", push_cert_sha1))
+			hashclr(push_cert_sha1);
+	}
+	if (!is_null_sha1(push_cert_sha1)) {
+		argv_array_pushf(&env, "GIT_PUSH_CERT=%s", sha1_to_hex(push_cert_sha1));
+		proc->env = env.argv;
+	}
+}
+
 typedef int (*feed_fn)(void *, const char **, size_t *);
 static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_state)
 {
@@ -277,6 +306,8 @@ static int run_and_feed_hook(const char *hook_name, feed_fn feed, void *feed_sta
 	proc.in = -1;
 	proc.stdout_to_stderr = 1;
 
+	prepare_push_cert_sha1(&proc);
+
 	if (use_sideband) {
 		memset(&muxer, 0, sizeof(muxer));
 		muxer.proc = copy_to_sideband;
@@ -896,6 +927,27 @@ static struct command *read_head_info(struct sha1_array *shallow)
 				quiet = 1;
 		}
 
+		if (!strcmp(line, "push-cert")) {
+			int true_flush = 0;
+			char certbuf[1024];
+
+			for (;;) {
+				len = packet_read(0, NULL, NULL,
+						  certbuf, sizeof(certbuf), 0);
+				if (!len) {
+					true_flush = 1;
+					break;
+				}
+				if (!strcmp(certbuf, "push-cert-end\n"))
+					break; /* end of cert */
+				strbuf_addstr(&push_cert, certbuf);
+			}
+
+			if (true_flush)
+				break;
+			continue;
+		}
+
 		p = queue_command(p, line, linelen);
 	}
 	return commands;
diff --git a/send-pack.c b/send-pack.c
index bb13599..ef93f33 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -11,6 +11,7 @@
 #include "transport.h"
 #include "version.h"
 #include "sha1-array.h"
+#include "gpg-interface.h"
 
 static int feed_object(const unsigned char *sha1, int fd, int negative)
 {
@@ -210,6 +211,64 @@ static int ref_update_to_be_sent(const struct ref *ref, const struct send_pack_a
 	}
 }
 
+/*
+ * the beginning of the next line, or the end of buffer.
+ *
+ * NEEDSWORK: perhaps move this to git-compat-util.h or somewhere and
+ * convert many similar uses found by "git grep -A4 memchr".
+ */
+static const char *next_line(const char *line, size_t len)
+{
+	const char *nl = memchr(line, '\n', len);
+	if (!nl)
+		return line + len; /* incomplete line */
+	return nl + 1;
+}
+
+static void generate_push_cert(struct strbuf *req_buf,
+			       const struct ref *remote_refs,
+			       struct send_pack_args *args)
+{
+	const struct ref *ref;
+	char stamp[60];
+	char *signing_key = xstrdup(get_signing_key());
+	const char *cp, *np;
+	struct strbuf cert = STRBUF_INIT;
+	int update_seen = 0;
+
+	datestamp(stamp, sizeof(stamp));
+	strbuf_addf(&cert, "certificate version 0.1\n");
+	strbuf_addf(&cert, "pusher %s %s\n", signing_key, stamp);
+	strbuf_addstr(&cert, "\n");
+
+	for (ref = remote_refs; ref; ref = ref->next) {
+		if (!ref_update_to_be_sent(ref, args))
+			continue;
+		update_seen = 1;
+		strbuf_addf(&cert, "%s %s %s\n",
+			    sha1_to_hex(ref->old_sha1),
+			    sha1_to_hex(ref->new_sha1),
+			    ref->name);
+	}
+	if (!update_seen)
+		goto free_return;
+
+	if (sign_buffer(&cert, &cert, signing_key))
+		die(_("failed to sign the push certificate"));
+
+	packet_buf_write(req_buf, "push-cert\n");
+	for (cp = cert.buf; cp < cert.buf + cert.len; cp = np) {
+		np = next_line(cp, cert.buf + cert.len - cp);
+		packet_buf_write(req_buf,
+				 "%.*s", (int)(np - cp), cp);
+	}
+	packet_buf_write(req_buf, "push-cert-end\n");
+
+free_return:
+	free(signing_key);
+	strbuf_release(&cert);
+}
+
 int send_pack(struct send_pack_args *args,
 	      int fd[], struct child_process *conn,
 	      struct ref *remote_refs,
@@ -245,6 +304,8 @@ int send_pack(struct send_pack_args *args,
 		agent_supported = 1;
 	if (server_supports("no-thin"))
 		args->use_thin_pack = 0;
+	if (args->push_cert && !server_supports("push-cert"))
+		die(_("the receiving end does not support --signed push"));
 
 	if (!remote_refs) {
 		fprintf(stderr, "No refs in common and none specified; doing nothing.\n"
@@ -273,6 +334,9 @@ int send_pack(struct send_pack_args *args,
 	if (!args->dry_run)
 		advertise_shallow_grafts_buf(&req_buf);
 
+	if (!args->dry_run && args->push_cert)
+		generate_push_cert(&req_buf, remote_refs, args);
+
 	/*
 	 * Clear the status for each ref and see if we need to send
 	 * the pack data.
diff --git a/send-pack.h b/send-pack.h
index 8e84392..3555d8e 100644
--- a/send-pack.h
+++ b/send-pack.h
@@ -11,6 +11,7 @@ struct send_pack_args {
 		use_thin_pack:1,
 		use_ofs_delta:1,
 		dry_run:1,
+		push_cert:1,
 		stateless_rpc:1;
 };
 
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
new file mode 100755
index 0000000..58d9fa0
--- /dev/null
+++ b/t/t5534-push-signed.sh
@@ -0,0 +1,85 @@
+#!/bin/sh
+
+test_description='signed push'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-gpg.sh
+
+prepare_dst () {
+	rm -fr dst &&
+	test_create_repo dst &&
+
+	git push dst master:noop master:ff master:noff
+}
+
+test_expect_success setup '
+	# master, ff and noff branches pointing at the same commit
+	test_tick &&
+	git commit --allow-empty -m initial &&
+
+	git checkout -b noop &&
+	git checkout -b ff &&
+	git checkout -b noff &&
+
+	# noop stays the same, ff advances, noff rewrites
+	test_tick &&
+	git commit --allow-empty --amend -m rewritten &&
+	git checkout ff &&
+
+	test_tick &&
+	git commit --allow-empty -m second
+'
+
+test_expect_success 'unsigned push does not send push certificate' '
+	prepare_dst &&
+	mkdir -p dst/.git/hooks &&
+	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	if test -n "${GIT_PUSH_CERT-}"
+	then
+		git cat-file blob $GIT_PUSH_CERT >../push-cert
+	fi
+	EOF
+
+	git push dst noop ff +noff &&
+	! test -f dst/push-cert
+'
+
+test_expect_success 'talking with a receiver without push certificate support' '
+	prepare_dst &&
+	mkdir -p dst/.git/hooks &&
+	git -C dst config receive.acceptpushcert no &&
+	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	if test -n "${GIT_PUSH_CERT-}"
+	then
+		git cat-file blob $GIT_PUSH_CERT >../push-cert
+	fi
+	EOF
+
+	git push dst noop ff +noff &&
+	! test -f dst/push-cert
+'
+
+test_expect_success 'push --sign fails with a receiver without push certificate support' '
+	prepare_dst &&
+	mkdir -p dst/.git/hooks &&
+	git -C dst config receive.acceptpushcert no &&
+	test_must_fail git push --signed dst noop ff +noff 2>err &&
+	test_i18ngrep "the receiving end does not support" err
+'
+
+test_expect_success GPG 'signed push sends push certificate' '
+	prepare_dst &&
+	mkdir -p dst/.git/hooks &&
+	write_script dst/.git/hooks/post-receive <<-\EOF &&
+	if test -n "${GIT_PUSH_CERT-}"
+	then
+		git cat-file blob $GIT_PUSH_CERT >../push-cert
+	fi
+	EOF
+
+	git push --signed dst noop ff +noff &&
+	grep "$(git rev-parse noop ff) refs/heads/ff" dst/push-cert &&
+	grep "$(git rev-parse noop noff) refs/heads/noff" dst/push-cert
+'
+
+test_done
diff --git a/transport.c b/transport.c
index 662421b..07fdf86 100644
--- a/transport.c
+++ b/transport.c
@@ -480,6 +480,9 @@ static int set_git_option(struct git_transport_options *opts,
 				die("transport: invalid depth option '%s'", value);
 		}
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_PUSH_CERT)) {
+		opts->push_cert = !!value;
+		return 0;
 	}
 	return 1;
 }
@@ -823,6 +826,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 	args.progress = transport->progress;
 	args.dry_run = !!(flags & TRANSPORT_PUSH_DRY_RUN);
 	args.porcelain = !!(flags & TRANSPORT_PUSH_PORCELAIN);
+	args.push_cert = !!(flags & TRANSPORT_PUSH_CERT);
 
 	ret = send_pack(&args, data->fd, data->conn, remote_refs,
 			&data->extra_have);
diff --git a/transport.h b/transport.h
index 02ea248..3e0091e 100644
--- a/transport.h
+++ b/transport.h
@@ -12,6 +12,7 @@ struct git_transport_options {
 	unsigned check_self_contained_and_connected : 1;
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
+	unsigned push_cert : 1;
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
@@ -123,6 +124,7 @@ struct transport {
 #define TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND 256
 #define TRANSPORT_PUSH_NO_HOOK 512
 #define TRANSPORT_PUSH_FOLLOW_TAGS 1024
+#define TRANSPORT_PUSH_CERT 2048
 
 #define TRANSPORT_SUMMARY_WIDTH (2 * DEFAULT_ABBREV + 3)
 #define TRANSPORT_SUMMARY(x) (int)(TRANSPORT_SUMMARY_WIDTH + strlen(x) - gettext_width(x)), (x)
@@ -156,6 +158,9 @@ struct transport *transport_get(struct remote *, const char *);
 /* Accept refs that may update .git/shallow without --depth */
 #define TRANS_OPT_UPDATE_SHALLOW "updateshallow"
 
+/* Send push certificates */
+#define TRANS_OPT_PUSH_CERT "pushcert"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
2.1.0-399-g2df620b

From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v2] pass transport verbosity down to git_connect
Date: Sat, 30 Jan 2016 08:50:56 +0000
Message-ID: <20160130085056.GA20118@dcvr.yhbt.net>
References: <20160128225123.GA20045@dcvr.yhbt.net>
 <xmqqegd1l13l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 09:51:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPRFH-0000Fm-OA
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 09:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752947AbcA3Iu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 03:50:58 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:50897 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278AbcA3Iu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 03:50:57 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id A41BA63380A;
	Sat, 30 Jan 2016 08:50:56 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqqegd1l13l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285107>

Junio C Hamano <gitster@pobox.com> wrote:
> Nice.  Can we demonstrate and protect this fix with simple tests?

I just added the tests to t5570 since we don't use git://
much in the tests and I didn't want to introduce potential
port conflicts.

----------------8<----------------
Subject: [PATCH] pass transport verbosity down to git_connect

While working in connect.c to perform non-blocking connections,
I noticed calling "git fetch -v" was not causing the progress
messages inside git_tcp_connect_sock to be emitted as I
expected.

Looking at history, it seems connect_setup has never been called
with the verbose parameter.  Since transport already has a
"verbose" field, use that field instead of another parameter
in connect_setup.

v2: add "-v" tests for clone/fetch/pull to t5570-git-daemon.sh

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 t/t5570-git-daemon.sh | 25 +++++++++++++++++++++++--
 transport.c           | 11 ++++++-----
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
index b7e2832..678c8ba 100755
--- a/t/t5570-git-daemon.sh
+++ b/t/t5570-git-daemon.sh
@@ -6,6 +6,13 @@ test_description='test fetching over git protocol'
 . "$TEST_DIRECTORY"/lib-git-daemon.sh
 start_git_daemon
 
+check_verbose_connect () {
+	grep -qF "Looking up 127.0.0.1 ..." stderr &&
+	grep -qF "Connecting to 127.0.0.1 (port " stderr &&
+	grep -qF "done." stderr &&
+	rm stderr
+}
+
 test_expect_success 'setup repository' '
 	git config push.default matching &&
 	echo content >file &&
@@ -24,18 +31,32 @@ test_expect_success 'create git-accessible bare repository' '
 '
 
 test_expect_success 'clone git repository' '
-	git clone "$GIT_DAEMON_URL/repo.git" clone &&
+	git clone -v "$GIT_DAEMON_URL/repo.git" clone 2>stderr &&
 	test_cmp file clone/file
 '
 
+test_expect_success 'clone -v stderr is as expected' check_verbose_connect
+
 test_expect_success 'fetch changes via git protocol' '
 	echo content >>file &&
 	git commit -a -m two &&
 	git push public &&
-	(cd clone && git pull) &&
+	(cd clone && git pull -v) 2>stderr &&
 	test_cmp file clone/file
 '
 
+test_expect_success 'pull -v stderr is as expected' check_verbose_connect
+
+test_expect_success 'no-op fetch -v stderr is as expected' '
+	(cd clone && git fetch -v) 2>stderr &&
+	check_verbose_connect
+'
+
+test_expect_success 'no-op fetch without "-v" is quiet' '
+	(cd clone && git fetch) 2>stderr &&
+	! test -s stderr
+'
+
 test_expect_success 'remote detects correct HEAD' '
 	git push public master:other &&
 	(cd clone &&
diff --git a/transport.c b/transport.c
index 67f3666..9ae7184 100644
--- a/transport.c
+++ b/transport.c
@@ -481,9 +481,10 @@ static int set_git_option(struct git_transport_options *opts,
 	return 1;
 }
 
-static int connect_setup(struct transport *transport, int for_push, int verbose)
+static int connect_setup(struct transport *transport, int for_push)
 {
 	struct git_transport_data *data = transport->data;
+	int flags = transport->verbose > 0 ? CONNECT_VERBOSE : 0;
 
 	if (data->conn)
 		return 0;
@@ -491,7 +492,7 @@ static int connect_setup(struct transport *transport, int for_push, int verbose)
 	data->conn = git_connect(data->fd, transport->url,
 				 for_push ? data->options.receivepack :
 				 data->options.uploadpack,
-				 verbose ? CONNECT_VERBOSE : 0);
+				 flags);
 
 	return 0;
 }
@@ -501,7 +502,7 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	struct git_transport_data *data = transport->data;
 	struct ref *refs;
 
-	connect_setup(transport, for_push, 0);
+	connect_setup(transport, for_push);
 	get_remote_heads(data->fd[0], NULL, 0, &refs,
 			 for_push ? REF_NORMAL : 0,
 			 &data->extra_have,
@@ -536,7 +537,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.update_shallow = data->options.update_shallow;
 
 	if (!data->got_remote_heads) {
-		connect_setup(transport, 0, 0);
+		connect_setup(transport, 0);
 		get_remote_heads(data->fd[0], NULL, 0, &refs_tmp, 0,
 				 NULL, &data->shallow);
 		data->got_remote_heads = 1;
@@ -812,7 +813,7 @@ static int git_transport_push(struct transport *transport, struct ref *remote_re
 
 	if (!data->got_remote_heads) {
 		struct ref *tmp_refs;
-		connect_setup(transport, 1, 0);
+		connect_setup(transport, 1);
 
 		get_remote_heads(data->fd[0], NULL, 0, &tmp_refs, REF_NORMAL,
 				 NULL, &data->shallow);
-- 
EW

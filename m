From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH v2 2/4] run-command: introduce child_process_init()
Date: Tue, 19 Aug 2014 21:10:48 +0200
Message-ID: <53F3A138.4000009@web.de>
References: <53EFE15B.7030805@web.de> <53F05DE2.5080806@kdbg.org>	<20140817084832.GL23808@peff.net> <xmqq61hpybs9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:11:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJoot-0005Mn-2E
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 21:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753592AbaHSTLn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 15:11:43 -0400
Received: from mout.web.de ([212.227.15.3]:52761 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753510AbaHSTLm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 15:11:42 -0400
Received: from [192.168.178.27] ([79.250.174.3]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0MNt8d-1XGowp0SmB-007WK3; Tue, 19 Aug 2014 21:11:40
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqq61hpybs9.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:R3k9lojYMQb8v//KID5S22MvcCzzT1UQ9NdLir0TnMlQeFoZ7Iw
 DUf22CvS4H6z/KrVZg6Fq3kPvFrGy2wMW7WKJxUqmv6/7a1GdzcDm7oHIPhW+1ubdLsTA3P
 kt5BfBzdCdhWUbqjYQsXKrg2yvxchstLoc3DbhF6BGjlV/QUqw+Ej0oSUyeYREKSr58khFp
 tSpUADpo6jSEIrTrhmd0Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255509>

Add a helper function for initializing those struct child_process
variables for which the macro CHILD_PROCESS_INIT can't be used.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/technical/api-run-command.txt | 8 ++++++--
 connect.c                                   | 6 ++++--
 run-command.c                               | 6 ++++++
 run-command.h                               | 1 +
 transport-helper.c                          | 5 +++--
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-run-command.txt b/Documentation/technical/api-run-command.txt
index ca066bf..842b838 100644
--- a/Documentation/technical/api-run-command.txt
+++ b/Documentation/technical/api-run-command.txt
@@ -13,6 +13,10 @@ produces in the caller in order to process it.
 Functions
 ---------
 
+`child_process_init`
+
+	Initialize a struct child_process variable.
+
 `start_command`::
 
 	Start a sub-process. Takes a pointer to a `struct child_process`
@@ -96,8 +100,8 @@ command to run in a sub-process.
 
 The caller:
 
-1. allocates and clears (memset(&chld, 0, sizeof(chld)); or
-   using CHILD_PROCESS_INIT) a struct child_process variable;
+1. allocates and clears (using child_process_init() or
+   CHILD_PROCESS_INIT) a struct child_process variable;
 2. initializes the members;
 3. calls start_command();
 4. processes the data;
diff --git a/connect.c b/connect.c
index f5b930a..87b5202 100644
--- a/connect.c
+++ b/connect.c
@@ -537,7 +537,8 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 
 	get_host_and_port(&host, &port);
 
-	proxy = xcalloc(1, sizeof(*proxy));
+	proxy = xmalloc(sizeof(*proxy));
+	child_process_init(proxy);
 	argv_array_push(&proxy->args, git_proxy_command);
 	argv_array_push(&proxy->args, host);
 	argv_array_push(&proxy->args, port);
@@ -694,7 +695,8 @@ struct child_process *git_connect(int fd[2], const char *url,
 			     target_host, 0);
 		free(target_host);
 	} else {
-		conn = xcalloc(1, sizeof(*conn));
+		conn = xmalloc(sizeof(*conn));
+		child_process_init(conn);
 
 		strbuf_addstr(&cmd, prog);
 		strbuf_addch(&cmd, ' ');
diff --git a/run-command.c b/run-command.c
index a29a34f..47ab21b 100644
--- a/run-command.c
+++ b/run-command.c
@@ -8,6 +8,12 @@
 # define SHELL_PATH "/bin/sh"
 #endif
 
+void child_process_init(struct child_process *child)
+{
+	memset(child, 0, sizeof(*child));
+	argv_array_init(&child->args);
+}
+
 struct child_to_clean {
 	pid_t pid;
 	struct child_to_clean *next;
diff --git a/run-command.h b/run-command.h
index 5484400..1b135d1 100644
--- a/run-command.h
+++ b/run-command.h
@@ -45,6 +45,7 @@ struct child_process {
 };
 
 #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT }
+void child_process_init(struct child_process *);
 
 int start_command(struct child_process *);
 int finish_command(struct child_process *);
diff --git a/transport-helper.c b/transport-helper.c
index 3d8fe7d..080a7a6 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -118,7 +118,8 @@ static struct child_process *get_helper(struct transport *transport)
 	if (data->helper)
 		return data->helper;
 
-	helper = xcalloc(1, sizeof(*helper));
+	helper = xmalloc(sizeof(*helper));
+	child_process_init(helper);
 	helper->in = -1;
 	helper->out = -1;
 	helper->err = 0;
@@ -395,7 +396,7 @@ static int get_importer(struct transport *transport, struct child_process *fasti
 	struct child_process *helper = get_helper(transport);
 	struct helper_data *data = transport->data;
 	int cat_blob_fd, code;
-	memset(fastimport, 0, sizeof(*fastimport));
+	child_process_init(fastimport);
 	fastimport->in = helper->out;
 	argv_array_push(&fastimport->args, "fast-import");
 	argv_array_push(&fastimport->args, debug ? "--stats" : "--quiet");
-- 
2.1.0

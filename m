From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Implement git clone -v
Date: Thu,  9 Oct 2008 01:40:32 +0200
Message-ID: <1223509232-3520-1-git-send-email-vmiklos@frugalware.org>
References: <20081008060257.GA15240@spearce.org>
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 09 01:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kniej-0005Br-3t
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 01:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754718AbYJHXkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 19:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754599AbYJHXkO
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 19:40:14 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46827 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbYJHXkN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 19:40:13 -0400
Received: from vmobile.example.net (catv-89-132-129-234.catv.broadband.hu [89.132.129.234])
	by yugo.frugalware.org (Postfix) with ESMTPA id 84713149C60;
	Thu,  9 Oct 2008 01:40:10 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id CAD6619D922; Thu,  9 Oct 2008 01:40:32 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <20081008060257.GA15240@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97811>

The new -v option forces the progressbar, even in case the output is not
a terminal.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Tue, Oct 07, 2008 at 11:02:57PM -0700, "Shawn O. Pearce" <spearce@spearce.org> wrote:
> You may be able to just test the size of the file:
>
>       git fetch -v ... >out 2>err &&
>       test -s err

Here is an updated patch, now with testcases.

 Documentation/git-clone.txt |    5 +++++
 builtin-clone.c             |    4 ++++
 t/t5702-clone-options.sh    |   13 +++++++++++++
 transport.c                 |    2 +-
 transport.h                 |    2 ++
 5 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 0e14e73..95f08b9 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -90,6 +90,11 @@ then the cloned repository will become corrupt.
 	Operate quietly.  This flag is also passed to the `rsync'
 	command when given.
 
+--verbose::
+-v::
+	Display the progressbar, even in case the standard output is not
+	a terminal.
+
 --no-checkout::
 -n::
 	No checkout of HEAD is performed after the clone is complete.
diff --git a/builtin-clone.c b/builtin-clone.c
index 49d2eb9..df71b23 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -38,9 +38,11 @@ static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin = NULL;
 static char *option_upload_pack = "git-upload-pack";
+static int option_verbose;
 
 static struct option builtin_clone_options[] = {
 	OPT__QUIET(&option_quiet),
+	OPT__VERBOSE(&option_verbose),
 	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
 		    "don't create a checkout"),
 	OPT_BOOLEAN(0, "bare", &option_bare, "create a bare repository"),
@@ -506,6 +508,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 		if (option_quiet)
 			transport->verbose = -1;
+		else if (option_verbose)
+			transport->progress = 1;
 
 		if (option_upload_pack)
 			transport_set_option(transport, TRANS_OPT_UPLOADPACK,
diff --git a/t/t5702-clone-options.sh b/t/t5702-clone-options.sh
index 328e4d9..27825f5 100755
--- a/t/t5702-clone-options.sh
+++ b/t/t5702-clone-options.sh
@@ -19,4 +19,17 @@ test_expect_success 'clone -o' '
 
 '
 
+test_expect_success 'redirected clone' '
+
+	git clone "file://$(pwd)/parent" clone-redirected >out 2>err &&
+	test ! -s err
+
+'
+test_expect_success 'redirected clone -v' '
+
+	git clone -v "file://$(pwd)/parent" clone-redirected-v >out 2>err &&
+	test -s err
+
+'
+
 test_done
diff --git a/transport.c b/transport.c
index 5110c56..1c510a3 100644
--- a/transport.c
+++ b/transport.c
@@ -644,7 +644,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.include_tag = data->followtags;
 	args.verbose = (transport->verbose > 0);
 	args.quiet = (transport->verbose < 0);
-	args.no_progress = args.quiet || !isatty(1);
+	args.no_progress = args.quiet || (!transport->progress && !isatty(1));
 	args.depth = data->depth;
 
 	for (i = 0; i < nr_heads; i++)
diff --git a/transport.h b/transport.h
index d0b5205..6bbc1a8 100644
--- a/transport.h
+++ b/transport.h
@@ -25,6 +25,8 @@ struct transport {
 	int (*disconnect)(struct transport *connection);
 	char *pack_lockfile;
 	signed verbose : 2;
+	/* Force progress even if the output is not a tty */
+	unsigned progress : 1;
 };
 
 #define TRANSPORT_PUSH_ALL 1
-- 
1.6.0.2

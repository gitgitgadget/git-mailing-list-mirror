From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Implement git clone -v
Date: Tue,  7 Oct 2008 00:19:50 +0200
Message-ID: <1223331590-22138-1-git-send-email-vmiklos@frugalware.org>
References: <81b0412b0810041442i3aa29628lf66ef9b188fe8ce7@mail.gmail.com>
Cc: Constantine Plotnikov <constantine.plotnikov@gmail.com>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 00:21:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmyRR-0003Cw-JM
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 00:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbYJFWT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 18:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbYJFWT0
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 18:19:26 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:37693 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbYJFWT0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 18:19:26 -0400
Received: from vmobile.example.net (dsl5401CAE3.pool.t-online.hu [84.1.202.227])
	by yugo.frugalware.org (Postfix) with ESMTPA id 00FE6149C60;
	Tue,  7 Oct 2008 00:19:23 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id E64FA19E7C3; Tue,  7 Oct 2008 00:19:50 +0200 (CEST)
X-Mailer: git-send-email 1.6.0.2
In-Reply-To: <81b0412b0810041442i3aa29628lf66ef9b188fe8ce7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97639>

The new -v option forces the progressbar, even in case the output is not
a terminal.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sat, Oct 04, 2008 at 11:42:15PM +0200, Alex Riesen <raa.lkml@gmail.com> wrote:
> 2008/10/3 Constantine Plotnikov <constantine.plotnikov@gmail.com>:
> > Is there a way to force a progress output on stderr for git clone
> > preferably using options or environment variables?
>
> No, but "-v" option is not used for anything yet, so you are free to
> implement it.

Something like this?

 Documentation/git-clone.txt |    5 +++++
 builtin-clone.c             |    4 ++++
 transport.c                 |    2 +-
 transport.h                 |    2 ++
 4 files changed, 12 insertions(+), 1 deletions(-)

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

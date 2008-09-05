X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Mention the fact that 'git annotate' is only for
 backward compatibility.
Date: Fri, 05 Sep 2008 00:56:15 -0700
Message-ID: <7vod33vxeo.fsf@gitster.siamese.dyndns.org>
References: <bd6139dc0809040216v40914e82h6a4032941cf65996@mail.gmail.com>
 <1220529652-24050-1-git-send-email-Matthieu.Moy@imag.fr>
 <20080904123046.GX10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 5 Sep 2008 07:56:37 +0000 (UTC)
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
In-Reply-To: <20080904123046.GX10544@machine.or.cz> (Petr Baudis's message of
 "Thu, 4 Sep 2008 14:30:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21099A98-7B20-11DD-99AC-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95000>
Received: from vger.kernel.org ([209.132.176.167]) by lo.gmane.org with esmtp
 (Exim 4.50) id 1KbWC9-0005hr-OT for gcvg-git-2@gmane.org; Fri, 05 Sep 2008
 09:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752481AbYIEH4X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Sep 2008
 03:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbYIEH4X
 (ORCPT <rfc822;git-outgoing>); Fri, 5 Sep 2008 03:56:23 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60131 "EHLO
 sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751042AbYIEH4W (ORCPT <rfc822;git@vger.kernel.org>); Fri, 5 Sep 2008
 03:56:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1]) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 751967476A; Fri,  5
 Sep 2008 03:56:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 38F4A74769; Fri,  5 Sep 2008 03:56:16 -0400 (EDT)
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> I'm also curious about
> ...
> in builtin-blame.c. Junio, you introduced this in e68989a739d - why
> do you use a separate flag instead of OUTPUT_ANNOTATE_COMPAT?

Let's do this.  Still passes t8001 and t9400.

-- >8 --
"blame -c" should be compatible with "annotate"

There is no reason to have a separate variable cmd_is_annotate;
OUTPUT_ANNOTATE_COMPAT option is supposed to produce the compatibility
output, and we should produce the same output even when the command was
not invoked as "annotate" but as "blame -c".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-blame.c                 |    9 +++++----
 t/t9400-git-cvsserver-server.sh |   13 +++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git i/builtin-blame.c w/builtin-blame.c
index d2fc68c..9bc901c 100644
--- i/builtin-blame.c
+++ w/builtin-blame.c
@@ -38,7 +38,6 @@ static int show_root;
 static int reverse;
 static int blank_boundary;
 static int incremental;
-static int cmd_is_annotate;
 static int xdl_opts = XDF_NEED_MINIMAL;
 static struct string_list mailmap;
 
@@ -1686,7 +1685,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 		if (suspect->commit->object.flags & UNINTERESTING) {
 			if (blank_boundary)
 				memset(hex, ' ', length);
-			else if (!cmd_is_annotate) {
+			else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
 				length--;
 				putchar('^');
 			}
@@ -2317,8 +2316,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	};
 
 	struct parse_opt_ctx_t ctx;
-
-	cmd_is_annotate = !strcmp(argv[0], "annotate");
+	int cmd_is_annotate = !strcmp(argv[0], "annotate");
 
 	git_config(git_blame_config, NULL);
 	init_revisions(&revs, NULL);
@@ -2346,6 +2344,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 parse_done:
 	argc = parse_options_end(&ctx);
 
+	if (cmd_is_annotate)
+		output_option |= OUTPUT_ANNOTATE_COMPAT;
+
 	if (DIFF_OPT_TST(&revs.diffopt, FIND_COPIES_HARDER))
 		opt |= (PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE |
 			PICKAXE_BLAME_COPY_HARDER);
diff --git i/t/t9400-git-cvsserver-server.sh w/t/t9400-git-cvsserver-server.sh
index 4b91f8d..c1850d2 100755
--- i/t/t9400-git-cvsserver-server.sh
+++ w/t/t9400-git-cvsserver-server.sh
@@ -488,4 +488,17 @@ test_expect_success 'cvs co -c (shows module database)' '
     ! grep -v "^master[	 ]\+master$" < out
 '
 
+#------------
+# CVS ANNOTATE
+#------------
+
+cd "$WORKDIR"
+test_expect_success 'cvs annotate' '
+    cd cvswork &&
+    GIT_CONFIG="$git_config" cvs annotate merge >../out &&
+    sed -e "s/ .*//" ../out >../actual &&
+    for i in 3 1 1 1 1 1 1 1 2 4; do echo 1.$i; done >../expect &&
+    test_cmp ../expect ../actual
+'
+

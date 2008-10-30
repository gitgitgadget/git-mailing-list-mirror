From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git show <tree>: show mode and hash, and handle -r
Date: Thu, 30 Oct 2008 14:15:19 -0700
Message-ID: <7vtzatdbtk.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0810290207330.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, schacon@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Oct 30 22:17:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvetM-0007Ft-FH
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 22:17:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756005AbYJ3VPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 17:15:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755262AbYJ3VPn
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 17:15:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510AbYJ3VPm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 17:15:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D01F576B56;
	Thu, 30 Oct 2008 17:15:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 898D876B35; Thu, 30 Oct 2008 17:15:26 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0810290207330.22125@pacific.mpi-cbg.de.mpi-cbg.de> (Johannes
 Schindelin's message of "Wed, 29 Oct 2008 02:09:55 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E7C90A42-A6C7-11DD-8090-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99524>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now, git show <tree> shows some more information, and with the -r option,
> it recurses into subdirectories.
>
> Requested by Scott Chacon.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
> 	The only quirk is the command line parsing for -r: we cannot use 
> 	DIFF_OPT_TST(&rev.diffopt, RECURSIVE), because that is switched 
> 	on not only by cmd_log_init(), but implicitly by 
> 	diff_setup_done(), because FORMAT_PATCH is selected by git-show.

That's a rather large quirk with an ugly workaround if you ask me.

I also notice that there is:

    int cmd_log_reflog(int argc, const char **argv, const char *prefix)
    {
            struct rev_info rev;
            ...
            /*
             * This means that we override whatever commit format the user gave
             * on the cmd line.  Sad, but cmd_log_init() currently doesn't
             * allow us to set a different default.
             */

I wonder if it would help breaking down cmd_log_init() a bit like this.

 builtin-log.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff --git c/builtin-log.c w/builtin-log.c
index 2efe593..0fcc28a 100644
--- c/builtin-log.c
+++ w/builtin-log.c
@@ -50,18 +50,23 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	return 0;
 }
 
-static void cmd_log_init(int argc, const char **argv, const char *prefix,
-		      struct rev_info *rev)
+static void cmd_log_init_0(int argc, const char **argv, const char *prefix,
+			   struct rev_info *rev,
+			   int default_abbrev,
+			   int default_commit_format,
+			   int default_verbose_header,
+			   int default_recursive)
 {
 	int i;
 	int decorate = 0;
 
-	rev->abbrev = DEFAULT_ABBREV;
-	rev->commit_format = CMIT_FMT_DEFAULT;
+	rev->abbrev = default_abbrev;
+	rev->commit_format = default_commit_format;
 	if (fmt_pretty)
 		get_commit_format(fmt_pretty, rev);
-	rev->verbose_header = 1;
-	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
+	rev->verbose_header = default_verbose_header;
+	if (default_recursive)
+		DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
 
@@ -88,6 +93,16 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	}
 }
 
+static void cmd_log_init(int argc, const char **argv, const char *prefix,
+			 struct rev_info *rev)
+{
+	cmd_log_init_0(argc, argv, prefix, rev,
+		       DEFAULT_ABBREV,
+		       CMIT_FMT_DEFAULT,
+		       1,
+		       1);
+}
+
 /*
  * This gives a rough estimate for how many commits we
  * will print out in the list.

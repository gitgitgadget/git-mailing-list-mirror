From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-format-patch: add --output-directory long option again
Date: Tue, 06 Jun 2006 08:46:23 -0700
Message-ID: <7vwtbuthgw.fsf@assigned-by-dhcp.cox.net>
References: <20060606141946.G59b8a1fd@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 17:47:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FndlX-0007HS-Lf
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 17:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWFFPq2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 11:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWFFPq2
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 11:46:28 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:13033 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751333AbWFFPq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 11:46:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606154625.BCPS19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 11:46:25 -0400
To: Dennis Stosberg <dennis@stosberg.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <20060606141946.G59b8a1fd@leonov.stosberg.net> (Dennis Stosberg's
	message of "Tue, 6 Jun 2006 16:19:46 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21382>

Dennis Stosberg <dennis@stosberg.net> writes:

> Additionally this fixes two minor issues:

Thanks.

> -		else if (!strcmp(argv[i], "-o")) {
> -			if (argc < 3)
> -				die ("Which directory?");

Oops.

> +	if (output_directory && !stdout) {
> +		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
> +			die("Could not create directory %s",
> +			    output_directory);
> +	}
> +

This code couldn't have been tested -- you meant to say
"use_stdout" here, not "stdout".

How about this instead?

-- >8 --
[PATCH] git-format-patch: add --output-directory long option again

Additionally notices and complains to an -o option without
directory or a duplicated -o option, -o and --stdout given
together.  Also delays the creation of directory until all
arguments are parsed, so that the command does not leave an
empty directory behind when it exits after seeing an unrelated
invalid option.

[Originally from Dennis Stosberg but with minor fixes.]

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-log.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 6612f4c..29a8851 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -103,7 +103,7 @@ static int git_format_config(const char 
 
 
 static FILE *realstdout = NULL;
-static char *output_directory = NULL;
+static const char *output_directory = NULL;
 
 static void reopen_stdout(struct commit *commit, int nr, int keep_subject)
 {
@@ -206,14 +206,14 @@ int cmd_format_patch(int argc, const cha
 			keep_subject = 1;
 			rev.total = -1;
 		}
-		else if (!strcmp(argv[i], "-o")) {
-			if (argc < 3)
-				die ("Which directory?");
-			if (mkdir(argv[i + 1], 0777) < 0 && errno != EEXIST)
-				die("Could not create directory %s",
-						argv[i + 1]);
-			output_directory = strdup(argv[i + 1]);
+		else if (!strcmp(argv[i], "--output-directory") ||
+			 !strcmp(argv[i], "-o")) {
 			i++;
+			if (argc <= i)
+				die("Which directory?");
+			if (output_directory)
+				die("Two output directories?");
+			output_directory = argv[i];
 		}
 		else if (!strcmp(argv[i], "--signoff") ||
 			 !strcmp(argv[i], "-s")) {
@@ -243,6 +243,14 @@ int cmd_format_patch(int argc, const cha
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
+	if (output_directory) {
+		if (use_stdout)
+			die("standard output, or directory, which one?");
+		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
+			die("Could not create directory %s",
+			    output_directory);
+	}
+
 	if (rev.pending_objects && rev.pending_objects->next == NULL) {
 		rev.pending_objects->item->flags |= UNINTERESTING;
 		add_head(&rev);
@@ -293,8 +301,6 @@ int cmd_format_patch(int argc, const cha
 		if (!use_stdout)
 			fclose(stdout);
 	}
-	if (output_directory)
-		free(output_directory);
 	free(list);
 	return 0;
 }
-- 
1.4.0.rc1-dirty

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit: Fix git-commit honoring status.color
Date: Sun, 18 Nov 2007 11:55:41 -0800
Message-ID: <7vejenuy4i.fsf@gitster.siamese.dyndns.org>
References: <1195405834-1469-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 20:56:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItqFT-0008Hz-2G
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 20:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283AbXKRTzt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 14:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752261AbXKRTzt
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 14:55:49 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:44394 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbXKRTzs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 14:55:48 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6704C2EF;
	Sun, 18 Nov 2007 14:56:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B3D229727C;
	Sun, 18 Nov 2007 14:56:04 -0500 (EST)
In-Reply-To: <1195405834-1469-1-git-send-email-pkufranky@gmail.com> (Ping
	Yin's message of "Mon, 19 Nov 2007 01:10:34 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65386>

Ping Yin <pkufranky@gmail.com> writes:

> status.color shouldn't be honored when committing since the run-status
> output is fed to the editor.
> ---
>  builtin-commit.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-commit.c b/builtin-commit.c
> index 8db74ed..4396e7d 100644
> --- a/builtin-commit.c
> +++ b/builtin-commit.c
> @@ -45,6 +45,7 @@ static int quiet, verbose, untracked_files, no_verify;
>  static int no_edit, initial_commit, in_merge;
>  const char *only_include_assumed;
>  struct strbuf message;
> +extern int wt_status_use_color;
>  
>  static int opt_parse_m(const struct option *opt, const char *arg, int unset)
>  {
> @@ -325,6 +326,7 @@ static int prepare_log_message(const char *index_file, const char *prefix)
>  	if (only_include_assumed)
>  		fprintf(fp, "# %s\n", only_include_assumed);
>  
> +	wt_status_use_color = 0;
>  	commitable = run_status(fp, index_file, prefix);
>  
>  	fclose(fp);

Although I admit I do not care much about the "status color", I
suspect this patch is not quite right.

When prepare_log_message() returns "no committable changes" and
we are not in merge, the calling cmd_commit() does another
run_status() to show the status of the index and the work tree
to the stdout, and at that point, we _do_ want to honor the
configuration setting you are discarding with this assignment.

---

 builtin-commit.c |    5 ++++-
 wt-status.h      |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 4e2f4aa..058cd32 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -300,7 +300,7 @@ static const char sign_off_header[] = "Signed-off-by: ";
 static int prepare_log_message(const char *index_file, const char *prefix)
 {
 	struct stat statbuf;
-	int commitable;
+	int commitable, saved_color_setting;
 	struct strbuf sb;
 	char *buffer;
 	FILE *fp;
@@ -383,7 +383,10 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 	if (only_include_assumed)
 		fprintf(fp, "# %s\n", only_include_assumed);
 
+	saved_color_setting = wt_status_use_color;
+	wt_status_use_color = 0;
 	commitable = run_status(fp, index_file, prefix);
+	wt_status_use_color = saved_color_setting;
 
 	fclose(fp);
 
diff --git a/wt-status.h b/wt-status.h
index f58ebcb..225fb4d 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -27,6 +27,7 @@ struct wt_status {
 };
 
 int git_status_config(const char *var, const char *value);
+int wt_status_use_color;
 void wt_status_prepare(struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 

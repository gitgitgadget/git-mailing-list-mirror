From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] clone: --dissociate option to mark that reference is
 only temporary
Date: Wed, 15 Oct 2014 21:44:08 +0200
Message-ID: <543ECE88.7050703@kdbg.org>
References: <xmqqa94yzap8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 21:44:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeUUb-0002AL-49
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 21:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751583AbaJOToN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 15:44:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:51816 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751183AbaJOToM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 15:44:12 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3jJ3w15DMQz5tlG;
	Wed, 15 Oct 2014 21:43:45 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 87CEE19F72B;
	Wed, 15 Oct 2014 21:44:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
In-Reply-To: <xmqqa94yzap8.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 14.10.2014 um 21:57 schrieb Junio C Hamano:
> +static void dissociate_from_references(void)
> +{
> +	struct child_process cmd;
> +
> +	memset(&cmd, 0, sizeof(cmd));

We have CHILD_PROCESS_INIT these days.

> +	argv_array_pushl(&cmd.args, "repack", "-a", "-d", NULL);
> +	cmd.git_cmd = 1;
> +	cmd.out = -1;

This requests a pipe, but you don't use it nor need it.

> +	cmd.no_stdin = 1;
> +	if (run_command(&cmd))
> +		die(_("cannot repack to clean up"));
> +	if (unlink(git_path("objects/info/alternates")) && errno != ENOENT)
> +		die_errno(_("cannot unlink temporary alternates file"));
> +}

Unless you have a secret plan, you can do it even shorter with our
helpers:

diff --git a/builtin/clone.c b/builtin/clone.c
index 8649090..81efb07 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -743,14 +743,9 @@ static void write_refspec_config(const char *src_ref_prefix,
 
 static void dissociate_from_references(void)
 {
-	struct child_process cmd;
-
-	memset(&cmd, 0, sizeof(cmd));
-	argv_array_pushl(&cmd.args, "repack", "-a", "-d", NULL);
-	cmd.git_cmd = 1;
-	cmd.out = -1;
-	cmd.no_stdin = 1;
-	if (run_command(&cmd))
+	static const char* argv[] = { "repack", "-a", "-d", NULL };
+
+	if (run_command_v_opt(argv, RUN_GIT_CMD|RUN_COMMAND_NO_STDIN))
 		die(_("cannot repack to clean up"));
 	if (unlink(git_path("objects/info/alternates")) && errno != ENOENT)
 		die_errno(_("cannot unlink temporary alternates file"));

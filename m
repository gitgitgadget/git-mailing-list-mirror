From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] imap-send: Use parse options API to determine verbosity
Date: Wed, 05 Nov 2014 16:30:26 -0800
Message-ID: <xmqq7fz9i319.fsf@gitster.dls.corp.google.com>
References: <545AAA60.3040207@raz.or.at>
	<xmqqbnoli4e0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Thu Nov 06 01:33:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmB1N-0002G7-2e
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 01:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbaKFAab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2014 19:30:31 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750860AbaKFAaa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2014 19:30:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DF5D1C2C5;
	Wed,  5 Nov 2014 19:30:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+SX0H3Md9+DiYPWZzslWJYirY7c=; b=kqed8O
	wpnC1I4SkU7KKt5w8YhQEvP/8y8kAUEe+szczNBENrmcR1bjgcpxoo8FpjsW5TpS
	9bLtXfgC2RPfQ+Lw/oQU+lJ98ZozclLm1HGU1T+1va2SAebzQbe8JAyirfEoEgJw
	XGePUvn8bUzvI0122piALqfJtEG+p8hSRLj10=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nvB0og/XdHHNYeSv+hQK6+MAoyJNDdFH
	Fe5Q2xq6VS1p3gnSUtBysxXlpDJRro1YiFLdfB09eV6HzGwKTMmz78j56oYPaXI1
	l1G5pnLIW8kgKUTdEnZpqIhxmaKpZCMVyFMrUNWqZSYHVVbRUY99TxefcDkDkOBq
	RjkRgXSrXa4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 626A81C2C4;
	Wed,  5 Nov 2014 19:30:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B97B51C2C3;
	Wed,  5 Nov 2014 19:30:27 -0500 (EST)
In-Reply-To: <xmqqbnoli4e0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 05 Nov 2014 16:01:11 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1B4A0210-654C-11E4-B375-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thanks.  This version looks more sensible.
>
>> -	if (argc != 1)
>> -		usage(imap_send_usage);
>> -
>>  	setup_git_directory_gently(&nongit_ok);
>>  	git_imap_config();
>>  
>> + argc = parse_options(argc, (const char **)argv, "",
>> imap_send_options, imap_send_usage, 0);
>> +
>
> ... except we might want to check argc here and say something about
> missing or excess parameters, which was lost in the change in this
> hunk.  I think (without giving it a real thought, though ;-) you
> would expect that nothing remains on the command line after
> parse_options() has done its thing, no?
>
>
>>  	if (!server.port)
>>  		server.port = server.use_ssl ? 993 : 143;

So here is what I ended up queuing for now.  I think the new check
on argc is correct but I wouldn't be surprised if I had off-by-one
error or something silly like that ;-).

-- >8 --
From: Bernhard Reiter <ockham@raz.or.at>
Date: Wed, 5 Nov 2014 15:29:21 +0100
Subject: [PATCH] imap-send: use parse options API to determine verbosity

The -v/-q options were sort-of supported but without using the
parse-options API, and were not documented.

Signed-off-by: Bernhard Reiter <ockham@raz.or.at>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-imap-send.txt | 14 +++++++++++++-
 imap-send.c                     | 28 ++++++++++++++++++----------
 2 files changed, 31 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index c7c0d21..0897131 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -9,7 +9,7 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
 SYNOPSIS
 --------
 [verse]
-'git imap-send'
+'git imap-send' [-v] [-q]
 
 
 DESCRIPTION
@@ -26,6 +26,18 @@ Typical usage is something like:
 git format-patch --signoff --stdout --attach origin | git imap-send
 
 
+OPTIONS
+-------
+
+-v::
+--verbose::
+	Be verbose.
+
+-q::
+--quiet::
+	Be quiet.
+
+
 CONFIGURATION
 -------------
 
diff --git a/imap-send.c b/imap-send.c
index 70bcc7a..7f9d30e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -26,11 +26,19 @@
 #include "credential.h"
 #include "exec_cmd.h"
 #include "run-command.h"
+#include "parse-options.h"
 #ifdef NO_OPENSSL
 typedef void *SSL;
 #endif
 
-static const char imap_send_usage[] = "git imap-send < <mbox>";
+static int verbosity;
+
+static const char * const imap_send_usage[] = { "git imap-send [-v] [-q] < <mbox>", NULL };
+
+static struct option imap_send_options[] = {
+	OPT__VERBOSITY(&verbosity),
+	OPT_END()
+};
 
 #undef DRV_OK
 #define DRV_OK          0
@@ -38,8 +46,6 @@ static const char imap_send_usage[] = "git imap-send < <mbox>";
 #define DRV_BOX_BAD     -2
 #define DRV_STORE_BAD   -3
 
-static int Verbose, Quiet;
-
 __attribute__((format (printf, 1, 2)))
 static void imap_info(const char *, ...);
 __attribute__((format (printf, 1, 2)))
@@ -418,7 +424,7 @@ static int buffer_gets(struct imap_buffer *b, char **s)
 			if (b->buf[b->offset + 1] == '\n') {
 				b->buf[b->offset] = 0;  /* terminate the string */
 				b->offset += 2; /* next line */
-				if (Verbose)
+				if (0 < verbosity)
 					puts(*s);
 				return 0;
 			}
@@ -433,7 +439,7 @@ static void imap_info(const char *msg, ...)
 {
 	va_list va;
 
-	if (!Quiet) {
+	if (0 <= verbosity) {
 		va_start(va, msg);
 		vprintf(msg, va);
 		va_end(va);
@@ -445,7 +451,7 @@ static void imap_warn(const char *msg, ...)
 {
 	va_list va;
 
-	if (Quiet < 2) {
+	if (-2 < verbosity) {
 		va_start(va, msg);
 		vfprintf(stderr, msg, va);
 		va_end(va);
@@ -522,7 +528,7 @@ static struct imap_cmd *issue_imap_cmd(struct imap_store *ctx,
 				  cmd->tag, cmd->cmd, cmd->cb.dlen,
 				  CAP(LITERALPLUS) ? "+" : "");
 
-	if (Verbose) {
+	if (0 < verbosity) {
 		if (imap->num_in_progress)
 			printf("(%d in progress) ", imap->num_in_progress);
 		if (!starts_with(cmd->cmd, "LOGIN"))
@@ -1352,12 +1358,14 @@ int main(int argc, char **argv)
 
 	git_setup_gettext();
 
-	if (argc != 1)
-		usage(imap_send_usage);
-
 	setup_git_directory_gently(&nongit_ok);
 	git_imap_config();
 
+	argc = parse_options(argc, (const char **)argv, "", imap_send_options, imap_send_usage, 0);
+
+	if (argc)
+		usage_with_options(imap_send_usage, imap_send_options);
+
 	if (!server.port)
 		server.port = server.use_ssl ? 993 : 143;
 
-- 
2.2.0-rc0-55-gac00a8d

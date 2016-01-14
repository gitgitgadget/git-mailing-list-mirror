From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 08/21] checkout-index: there are only two possible line terminations
Date: Thu, 14 Jan 2016 15:58:23 -0800
Message-ID: <1452815916-6447-9-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrn5-0003Dl-Rp
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbcANX6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:58:54 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755579AbcANX6w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:58:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 88BB23CD76;
	Thu, 14 Jan 2016 18:58:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=4fD1
	72MWBeef3wAZYNjrlKtwkpM=; b=WFsURjwZSvCLTR/jQpa7NAPpRCTtRPpR+NvT
	Sam2YmUeZ7QnRjpRdOJb7Cqwn4FqlO3uh+xDfYAwK2i+MfdaRsKuHdtOA0YztIUJ
	kwtVLYGq0aDOjCtYJGbPnPC60/8S74MBK92rz2D/M0XpQ+7doJjYiF00k5Vkx/A4
	TghezzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ARDzi1pe37o6P46J2LTcBHR9GNfRb854L+1ytK1Cae2/T1Ygzw+7Tf8q65xVQ+HW
	Hw5suyY8TTvIwABgJLk18b/NmMC3k0p/RvND7fbW24zjk3xJgG+VTdpmuC5wNsxQ
	OTQul37PPiIElmR0yXVMapFPkJO8etQh+DK5sgBEIF0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 801C93CD75;
	Thu, 14 Jan 2016 18:58:51 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E758E3CD74;
	Thu, 14 Jan 2016 18:58:50 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C264AD50-BB1A-11E5-B802-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284105>

The program by default reads LF terminated lines, with an option to
use NUL terminated records.  Instead of pretending that there can be
other useful values for line_termination, use a boolean variable,
nul_term_line, to tell if NUL terminated records are used, and
switch between strbuf_getline_{lf,nul} based on it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout-index.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 8028c37..ed888a5 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -11,7 +11,7 @@
 #include "parse-options.h"
 
 #define CHECKOUT_ALL 4
-static int line_termination = '\n';
+static int nul_term_line;
 static int checkout_stage; /* default to checkout stage0 */
 static int to_tempfile;
 static char topath[4][TEMPORARY_FILENAME_LENGTH + 1];
@@ -35,7 +35,8 @@ static void write_tempfile_record(const char *name, const char *prefix)
 		fputs(topath[checkout_stage], stdout);
 
 	putchar('\t');
-	write_name_quoted_relative(name, prefix, stdout, line_termination);
+	write_name_quoted_relative(name, prefix, stdout,
+				   nul_term_line ? '\0' : '\n');
 
 	for (i = 0; i < 4; i++) {
 		topath[i][0] = 0;
@@ -144,10 +145,7 @@ static int option_parse_u(const struct option *opt,
 static int option_parse_z(const struct option *opt,
 			  const char *arg, int unset)
 {
-	if (unset)
-		line_termination = '\n';
-	else
-		line_termination = 0;
+	nul_term_line = !unset;
 	return 0;
 }
 
@@ -254,13 +252,15 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 
 	if (read_from_stdin) {
 		struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
+		strbuf_getline_fn getline_fn;
 
 		if (all)
 			die("git checkout-index: don't mix '--all' and '--stdin'");
 
-		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+		getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
+		while (getline_fn(&buf, stdin) != EOF) {
 			char *p;
-			if (line_termination && buf.buf[0] == '"') {
+			if (!nul_term_line && buf.buf[0] == '"') {
 				strbuf_reset(&nbuf);
 				if (unquote_c_style(&nbuf, buf.buf, NULL))
 					die("line is badly quoted");
-- 
2.7.0-250-ge1b5ba3

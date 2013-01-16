From: Antoine Pelisse <apelisse@gmail.com>
Subject: [PATCH 2/2] fix clang -Wtautological-compare with unsigned enum
Date: Wed, 16 Jan 2013 23:47:23 +0100
Message-ID: <1358376443-7404-2-git-send-email-apelisse@gmail.com>
References: <20130116182449.GA4881@sigill.intra.peff.net>
 <1358376443-7404-1-git-send-email-apelisse@gmail.com>
Cc: git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: John Keeping <john@keeping.me.uk>, Max Horn <max@quendi.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 23:48:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tvbma-00081i-HI
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 23:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758024Ab3APWsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 17:48:10 -0500
Received: from mail-wi0-f169.google.com ([209.85.212.169]:41877 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757722Ab3APWsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 17:48:09 -0500
Received: by mail-wi0-f169.google.com with SMTP id hq12so4060432wib.2
        for <git@vger.kernel.org>; Wed, 16 Jan 2013 14:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=3RXOYUHtccTGa79eNyBS196Ir6T/ye8tsv3bdehrsPA=;
        b=Tx6x3oAai7qUjK9hsj2Bg7j23YPcNc7z+EpLTDDHsw3o7TnB2I8lIRfDZ7CNJYNSik
         WNso5azuOj+Z+jLCdol+GHze8+hHo8ApCpzt9ZsYsEL/zqN35GPM/awGepraQxdwuJex
         aF02RzgQVLsFjVsTqI+ZQjt90XuJx7vTMYTHvlRi8aWnkqgfR2qZxZtPtJUPQJCl7mzg
         yT23XC4/fAkVkfNZrAHM1zn1vc/lgxYd2ZF5SwR7P+lFltk/lQ8NnnuPasGYprXH/Vcf
         tFOaxyF91r4nw48bnf99qs4VLqHdE7vmebAmEO8Qc3MyX7t4DpAwnSOeS/nKZihPaQxI
         k6Tg==
X-Received: by 10.194.109.10 with SMTP id ho10mr5090192wjb.16.1358376488392;
        Wed, 16 Jan 2013 14:48:08 -0800 (PST)
Received: from localhost.localdomain (freepel.fr. [82.247.80.218])
        by mx.google.com with ESMTPS id hu8sm10435375wib.6.2013.01.16.14.48.06
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 16 Jan 2013 14:48:07 -0800 (PST)
X-Mailer: git-send-email 1.8.1.1.435.g20d29be.dirty
In-Reply-To: <1358376443-7404-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213817>

Create a GREP_HEADER_FIELD_MIN so we can check that the field value is
sane and silent the clang warning.

Clang warning happens because the enum is unsigned (this is
implementation-defined, and there is no negative fields) and the check
is then tautological.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
---
I tried to consider discussion [1] and this [2] discussion on clang's list

With these two patches and the patch from Max Horne, I'm finally able to
compile with CC=clang CFLAGS=-Werror.

 [1]: http://thread.gmane.org/gmane.comp.version-control.git/184908
 [2]: http://clang-developers.42468.n3.nabble.com/Possibly-invalid-enum-tautology-warning-td3233140.html

 grep.c | 3 ++-
 grep.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 4bd1b8b..bb548ca 100644
--- a/grep.c
+++ b/grep.c
@@ -625,7 +625,8 @@ static struct grep_expr *prep_header_patterns(struct grep_opt *opt)
 	for (p = opt->header_list; p; p = p->next) {
 		if (p->token != GREP_PATTERN_HEAD)
 			die("bug: a non-header pattern in grep header list.");
-		if (p->field < 0 || GREP_HEADER_FIELD_MAX <= p->field)
+		if (p->field < GREP_HEADER_FIELD_MIN ||
+		    GREP_HEADER_FIELD_MAX <= p->field)
 			die("bug: unknown header field %d", p->field);
 		compile_regexp(p, opt);
 	}
diff --git a/grep.h b/grep.h
index 8fc854f..e4a1df5 100644
--- a/grep.h
+++ b/grep.h
@@ -28,7 +28,8 @@ enum grep_context {
 };

 enum grep_header_field {
-	GREP_HEADER_AUTHOR = 0,
+	GREP_HEADER_FIELD_MIN = 0,
+	GREP_HEADER_AUTHOR = GREP_HEADER_FIELD_MIN,
 	GREP_HEADER_COMMITTER,
 	GREP_HEADER_REFLOG,

--
1.8.1.1.435.g20d29be.dirty

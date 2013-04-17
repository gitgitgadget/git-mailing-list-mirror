From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] blame: handle broken commit headers gracefully
Date: Wed, 17 Apr 2013 20:33:54 +0200
Message-ID: <516EEB12.5050209@lsrfire.ath.cx>
References: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com> <516D93C4.1000100@lsrfire.ath.cx> <7v61zml0ow.fsf@alter.siamese.dyndns.org> <516DBE2E.4060201@lsrfire.ath.cx> <7vzjwyi0ba.fsf@alter.siamese.dyndns.org> <7vli8hhgmn.fsf@alter.siamese.dyndns.org> <20130417063942.GA27703@sigill.intra.peff.net> <516EE300.7020200@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Ivan Lyapunov <dront78@gmail.com>,
	Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 17 20:34:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USXBD-0006SX-2F
	for gcvg-git-2@plane.gmane.org; Wed, 17 Apr 2013 20:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966330Ab3DQSd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 14:33:58 -0400
Received: from india601.server4you.de ([85.25.151.105]:48205 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966029Ab3DQSd6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 14:33:58 -0400
Received: from [192.168.2.105] (p4FFD858B.dip.t-dialin.net [79.253.133.139])
	by india601.server4you.de (Postfix) with ESMTPSA id 6F9574B5;
	Wed, 17 Apr 2013 20:33:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <516EE300.7020200@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221561>

split_ident_line() can leave us with the pointers date_begin, date_end,
tz_begin and tz_end all set to NULL.  Check them before use and supply
the same fallback values as in the case of a negative return code from
split_ident_line().

The "(unknown)" is not actually shown in the output, though, because it
will be converted to a number (zero) eventually.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Minimal patch, test case missing.  It's a bit sad that the old commit
parser of blame handled Ivan's specific corruption (extra "-<>" after
email) gracefully because it used the spaces as cutting points instead
of "<" and ">".

 builtin/blame.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 86100e9..7770781 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1375,10 +1375,15 @@ static void get_ac_line(const char *inbuf, const char *what,
 	maillen = ident.mail_end - ident.mail_begin;
 	mailbuf = ident.mail_begin;
 
-	*time = strtoul(ident.date_begin, NULL, 10);
+	if (ident.date_begin && ident.date_end)
+		*time = strtoul(ident.date_begin, NULL, 10);
+	else
+		*time = 0;
 
-	len = ident.tz_end - ident.tz_begin;
-	strbuf_add(tz, ident.tz_begin, len);
+	if (ident.tz_begin && ident.tz_end)
+		strbuf_add(tz, ident.tz_begin, ident.tz_end - ident.tz_begin);
+	else
+		strbuf_addstr(tz, "(unknown)");
 
 	/*
 	 * Now, convert both name and e-mail using mailmap
-- 
1.8.2.1

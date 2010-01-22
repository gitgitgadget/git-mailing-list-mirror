From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Handle double slashes in make_relative_path()
Date: Fri, 22 Jan 2010 09:36:13 +0100
Message-ID: <4B59637D.4090503@viscovery.net>
References: <379d55c6a4110736aadb8ace3b050de879a9deab.1264118830.git.trast@student.ethz.ch> <7vpr52gbmu.fsf@alter.siamese.dyndns.org> <7vmy06et5c.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 09:36:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYF0L-0005P3-KR
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 09:36:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab0AVIgU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 03:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969Ab0AVIgU
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 03:36:20 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:39591 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab0AVIgT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 03:36:19 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NYF02-0007Ge-Eg; Fri, 22 Jan 2010 09:36:14 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2F09F1660F;
	Fri, 22 Jan 2010 09:36:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <7vmy06et5c.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137746>

Junio C Hamano schrieb:
> Credit for test script, motivation and initial patch goes to Thomas Rast,
> but the bugs in the implementation of this patch are mine..

And with this squashed in it has fewer of them ;-) and is more portable.
The bug was that /foo was incorrectly stripped from /foobar.

-- Hannes

diff --git a/path.c b/path.c
index 78ab54a..3cb19c7 100644
--- a/path.c
+++ b/path.c
@@ -396,15 +396,15 @@ const char *make_relative_path(const char *abs, const char *base)
 	static char buf[PATH_MAX + 1];
 	int i = 0, j = 0;

-	if (!base)
+	if (!base || !base[0])
 		return abs;
 	while (base[i]) {
-		if (base[i] == '/') {
-			if (abs[j] != '/')
+		if (is_dir_sep(base[i])) {
+			if (!is_dir_sep(abs[j]))
 				return abs;
-			while (base[i] == '/')
+			while (is_dir_sep(base[i]))
 				i++;
-			while (abs[j] == '/')
+			while (is_dir_sep(abs[j]))
 				j++;
 			continue;
 		} else if (abs[j] != base[i]) {
@@ -413,7 +413,14 @@ const char *make_relative_path(const char *abs, const char *base)
 		i++;
 		j++;
 	}
-	while (abs[j] == '/')
+	if (
+	    /* "/foo" is a prefix of "/foo" */
+	    abs[j] &&
+	    /* "/foo" is not a prefix of "/foobar" */
+	    !is_dir_sep(base[i-1]) && !is_dir_sep(abs[j])
+	   )
+		return abs;
+	while (is_dir_sep(abs[j]))
 		j++;
 	if (!abs[j])
 		strcpy(buf, ".");

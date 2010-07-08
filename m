From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] rerere: fix overeager gc
Date: Thu, 08 Jul 2010 08:27:00 +0200
Message-ID: <4C356FB4.6060308@viscovery.net>
References: <1277811498-17288-1-git-send-email-szeder@ira.uka.de> <7vy6dx90uk.fsf@alter.siamese.dyndns.org> <4C2AE04E.9090901@viscovery.net> <7v1vbn417d.fsf@alter.siamese.dyndns.org> <4C2D7DF7.8030408@viscovery.net> <7vmxu923up.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 08:27:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWkZt-00084J-6M
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 08:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673Ab0GHG1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 02:27:09 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:60641 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753583Ab0GHG1G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 02:27:06 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OWkZZ-0004YR-31; Thu, 08 Jul 2010 08:27:01 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id CC7941660F;
	Thu,  8 Jul 2010 08:27:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <7vmxu923up.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150540>

Instead of this series, I'll use this for a while; i.e., check the
timestamp of thisimage, and if it does not exist, check the directory's
timestamp. It doesn't pass t4200.20 because the test doesn't set the
timestamps of thisimage and the directory into the past.

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 980d542..49fcbf7 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -13,10 +13,14 @@ static const char git_rerere_usage[] =
 static int cutoff_noresolve = 15;
 static int cutoff_resolve = 60;
 
-static time_t rerere_created_at(const char *name)
+static time_t rerere_last_used_at(const char *name)
 {
 	struct stat st;
-	return stat(rerere_path(name, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
+	if (!stat(rerere_path(name, "thisimage"), &st))
+		return st.st_mtime;
+	if (errno == ENOENT && !stat(rerere_path(name, "."), &st))
+		return st.st_mtime;
+	return (time_t) 0;
 }
 
 static void unlink_rr_item(const char *name)
@@ -53,7 +57,7 @@ static void garbage_collect(struct string_list *rr)
 	while ((e = readdir(dir))) {
 		if (is_dot_or_dotdot(e->d_name))
 			continue;
-		then = rerere_created_at(e->d_name);
+		then = rerere_last_used_at(e->d_name);
 		if (!then)
 			continue;
 		cutoff = (has_rerere_resolution(e->d_name)

From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] log: add load_ref_decorations()
Date: Thu, 04 Sep 2008 23:38:08 +0200
Message-ID: <48C05540.5070204@lsrfire.ath.cx>
References: <alpine.LNX.1.10.0809032036270.32295@pollux> <20080903191217.GA31195@coredump.intra.peff.net> <7v4p4xat3v.fsf@gitster.siamese.dyndns.org> <20080903203616.GB32223@coredump.intra.peff.net> <7vsksh9c9m.fsf@gitster.siamese.dyndns.org> <48BF0A5A.2040502@lsrfire.ath.cx> <20080904035139.GA28123@sigill.intra.peff.net> <48C002FB.9010401@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Thu Sep 04 23:39:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbMXu-0000Xa-T6
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 23:39:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753987AbYIDViM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 17:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbYIDViM
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 17:38:12 -0400
Received: from india601.server4you.de ([85.25.151.105]:47254 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753913AbYIDViL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 17:38:11 -0400
Received: from [10.0.1.200] (p57B7E7FB.dip.t-dialin.net [87.183.231.251])
	by india601.server4you.de (Postfix) with ESMTPSA id 74B762F8045;
	Thu,  4 Sep 2008 23:38:09 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <48C002FB.9010401@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94960>

Move the loading of all ref names for decoration into its own function.
A static variable prevents loading twice, because it's quite expensive.
We can do it this way because we currently never unload decorations.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 builtin-log.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 1d3c5cb..0f16462 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -50,6 +50,15 @@ static int add_ref_decoration(const char *refname, const unsigned char *sha1, in
 	return 0;
 }
 
+void load_ref_decorations(void)
+{
+	static int loaded;
+	if (!loaded) {
+		loaded = 1;
+		for_each_ref(add_ref_decoration, NULL);
+	}
+}
+
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
@@ -80,8 +89,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (!strcmp(arg, "--decorate")) {
-			if (!decorate)
-				for_each_ref(add_ref_decoration, NULL);
+			load_ref_decorations();
 			decorate = 1;
 		} else
 			die("unrecognized argument: %s", arg);
-- 
1.6.0.1.161.g7f314

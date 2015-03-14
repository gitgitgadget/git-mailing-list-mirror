From: epilys <epilys@norn.io>
Subject: [GSoC][PATCH v2] log: forbid log --graph --no-walk
Date: Sun, 15 Mar 2015 01:33:07 +0200
Message-ID: <5504C533.7060304@norn.io>
References: <md5:Tyvg1g0l6oUcTR3FnSDstw==>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: me@ikke.info, gitster@pobox.com, peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 15 00:32:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWvXh-0006rI-L6
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 00:32:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbbCNXcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 19:32:03 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:54506 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbbCNXcC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 19:32:02 -0400
Received: from mfilter30-d.gandi.net (mfilter30-d.gandi.net [217.70.178.161])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 5C07C41C060;
	Sun, 15 Mar 2015 00:32:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter30-d.gandi.net
Received: from relay5-d.mail.gandi.net ([217.70.183.197])
	by mfilter30-d.gandi.net (mfilter30-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id zd7FoAZb3wip; Sun, 15 Mar 2015 00:31:59 +0100 (CET)
X-Originating-IP: 5.54.110.208
Received: from [192.168.2.2] (ppp005054110208.access.hol.gr [5.54.110.208])
	(Authenticated sender: epilys@norn.io)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 9B38F41C05C;
	Sun, 15 Mar 2015 00:31:55 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <md5:Tyvg1g0l6oUcTR3FnSDstw==>
X-Forwarded-Message-Id: <md5:Tyvg1g0l6oUcTR3FnSDstw==>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265466>

In git-log, --graph shows a graphical representation of a continuous
commit history, and --no-walk shows discrete specified commits without
continuity. Using both doesn't make sense, so we forbid the combined use
of these flags.

Signed-off-by: Manos Pitsidianakis <epilys@norn.io>
---
 builtin/log.c  | 2 ++
 t/t4202-log.sh | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index dd8f3fc..0194133 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -155,6 +155,8 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	memset(&w, 0, sizeof(w));
 	userformat_find_requirements(NULL, &w);
 
+    if (rev->graph && rev->no_walk)
+        die("--graph and --no-walk are incompatible");
 	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
 		rev->show_notes = 1;
 	if (rev->show_notes)
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 5f2b290..4dd939b 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -887,4 +887,8 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	grep "^| | gpg: Good signature" actual
 '
 
+test_expect_success 'forbid log --graph --no-walk' '
+    test_must_fail git log --graph --no-walk
+'
+
 test_done
-- 
2.1.4

From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: [PATCH] rev-list: fix --pretty=oneline with empty message
Date: Sun, 21 Mar 2010 15:40:16 +0100
Message-ID: <1269182416-4156-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 15:40:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtMKN-0004hX-RH
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 15:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101Ab0CUOk0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 10:40:26 -0400
Received: from mail-ew0-f216.google.com ([209.85.219.216]:53688 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822Ab0CUOkZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 10:40:25 -0400
Received: by ewy8 with SMTP id 8so436257ewy.28
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=1vJB0zgJNW5IVyobL7oVORbsp9lFCcd+DzWbfEn0tPQ=;
        b=TplZa8uprF3IiYXnipnR1izm/qdJv+YF9aanYIOVA0vrr54HTFzEtjM1bhjta+Vuxy
         FmeDDNYwaWATuuQgpNppU0cdS2o+wgWiwxyzOANrHxEYK6kXGuP/cmukpBYkdEdCZP2g
         ajaQdEvdH692FI2JE4WNmpNx5Jnq3kOeJMjaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TjumPzliqsByYzHguCkxhjFl4drRCc1zmq7dzwIZYUTaXu5QKLoFYpa5S4Fs/wpD0a
         i+YBIxP5cepaFNWeRVN9AttK/5YvtyNdsqdQ2tJ/1y54FMsI8j5sblZ0Fz/+m8Ndp0cg
         /Sa7Hhfl0iltj6vf2ht4Sfu2tZP2bNGM6mMEw=
Received: by 10.213.113.79 with SMTP id z15mr4405076ebp.78.1269182423597;
        Sun, 21 Mar 2010 07:40:23 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id 14sm1457077ewy.2.2010.03.21.07.40.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Mar 2010 07:40:23 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.456.g1a43b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142829>

55246aa (Dont use "<unknown>" for placeholders and suppress printing
of empty user formats) introduced a check to prevent empty
user-formats from being printed. This test didn't take empty commit
messages into account, and prevented the line-termination from being
output. This lead to multiple commits on a single line.

Correct it by guarding the check with a check for user-format. A
similar correction for the --graph code-path has been included.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

Adjusted as suggested by Junio.

 builtin/rev-list.c         |    5 ++++-
 t/t6006-rev-list-format.sh |    9 +++++++++
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 5679170..1db4b4c 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -133,9 +133,12 @@ static void show_commit(struct commit *commit, void *data)
 				 */
 				if (graph_show_remainder(revs->graph))
 					putchar('\n');
+				if (revs->commit_format == CMIT_FMT_ONELINE)
+					putchar('\n');
 			}
 		} else {
-			if (buf.len)
+			if (revs->commit_format != CMIT_FMT_USERFORMAT ||
+			    buf.len)
 				printf("%s%c", buf.buf, info->hdr_termination);
 		}
 		strbuf_release(&buf);
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index b0047d3..d24ca5c 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -209,4 +209,13 @@ test_expect_success '%gd shortens ref name' '
 	test_cmp expect.gd-short actual.gd-short
 '
 
+test_expect_success 'oneline with empty message' '
+	git commit -m "dummy" --allow-empty &&
+	git commit -m "dummy" --allow-empty &&
+	git filter-branch --msg-filter "sed -e s/dummy//" HEAD^^.. &&
+	git rev-list --oneline HEAD > /tmp/test.txt &&
+	test $(git rev-list --oneline HEAD | wc -l) -eq 5 &&
+	test $(git rev-list --oneline --graph HEAD | wc -l) -eq 5
+'
+
 test_done
-- 
1.7.0.2.456.g1a43b.dirty

From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/2] rebase-interactive: suppress whitespace preceding item count
Date: Wed,  4 Mar 2015 02:53:04 -0500
Message-ID: <1425455585-30186-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Onno Kortmann <onno@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 08:53:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT47o-0007hm-R7
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 08:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934568AbbCDHxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 02:53:44 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:42533 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933244AbbCDHx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 02:53:29 -0500
Received: by iecvy18 with SMTP id vy18so1143472iec.9
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 23:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=gKQ20E9A6szYwGcP7FR9Z9rZs4AW6+o8xD/l/pGcLfg=;
        b=YzfZp5pewIAf1I6ifVyN86cTox1o1CbSw7CuDsvZI9LI09x7Nyyke2FhGJMuCmuvfw
         Y/bM2sl7Hc7/JKEStuew4p1pe9WuVlUXIVKrTIf/X34+LzBIM0Zjh1zI+g8IrOJDWwE6
         4LO4ukqeMfic2TmYX//aGeGn0NWvJU1UFH9F2N0l0y9NV6IYxi6GLI0zdYM42Em6eapS
         o/nS8/DskSu34DhYL3TRRWr5fd4H2s5VWdKTJTaMqZaLG6+XR5as7pXfBThMA4FU6KYn
         +hsF1x06EMEkAjl9mDfdz6lPh2mjruvLy4SkbrZXTwtF51M9ySvYvxdQIgnpSXJJJJQu
         II7Q==
X-Received: by 10.50.222.70 with SMTP id qk6mr34958735igc.47.1425455608673;
        Tue, 03 Mar 2015 23:53:28 -0800 (PST)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id n12sm2488999igi.3.2015.03.03.23.53.27
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2015 23:53:28 -0800 (PST)
X-Mailer: git-send-email 2.3.1.340.gf490742
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264732>

97f05f43 (Show number of TODO items for interactive rebase, 2014-12-10)
taught rebase-interactive to compute an item count with 'wc -l' and
display it in the instruction list comments:

    # Rebase 46640c6..5568fd5 onto 46640c6 (4 TODO item(s))

On Mac OS X, however, it renders as:

    # Rebase 46640c6..5568fd5 onto 46640c6 (       4 TODO item(s))

since 'wc -l' indents its output with leading spaces. Fix this.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Consistent with existing tests in t3404, the new test uses plain 'grep'
rather than 'test_i18ngrep'.

 git-rebase--interactive.sh    | 1 +
 t/t3404-rebase-interactive.sh | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index c96b984..ab98b13 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -1030,6 +1030,7 @@ test -n "$autosquash" && rearrange_squash "$todo"
 test -n "$cmd" && add_exec_commands "$todo"
 
 todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
+todocount=${todocount##* }
 
 cat >>"$todo" <<EOF
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index a31f7e0..034eb35 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1046,4 +1046,13 @@ test_expect_success 'respect core.abbrev' '
 	test 4 = $(grep -c "pick [0-9a-f]\{12,\}" todo-list)
 '
 
+test_expect_success 'todo count' '
+	write_script dump-raw.sh <<-\EOF &&
+		cat "$1"
+	EOF
+	test_set_editor "$(pwd)/dump-raw.sh" &&
+	git rebase -i HEAD~4 >actual &&
+	grep "^# Rebase ..* onto ..* ([0-9]" actual
+'
+
 test_done
-- 
2.3.1.340.gf490742

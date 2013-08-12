From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/3] t3404: restore specialized rebase-editor following commentchar test
Date: Mon, 12 Aug 2013 00:07:37 -0400
Message-ID: <1376280459-55188-2-git-send-email-sunshine@sunshineco.com>
References: <1376280459-55188-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	David <bouncingcats@gmail.com>,
	Diogo de Campos <campos@esss.com.br>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Yann Dirson <dirson@bertin.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 12 06:08:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8jR5-0006R1-Lq
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 06:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504Ab3HLEIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 00:08:41 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:65161 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab3HLEI2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 00:08:28 -0400
Received: by mail-ie0-f181.google.com with SMTP id x14so7473271ief.40
        for <git@vger.kernel.org>; Sun, 11 Aug 2013 21:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4GXpf3XC3LZQPYzxDi2+SXFIoQbsLHGqIzWjLIhNxRs=;
        b=kfOZ3euQT50tOKgbHVh2mROE+3DunaJtCtZtPpm+5Vo5yM8/kX165dnSsoDMzr1BUM
         lUNwJZjjkppuM4y6dbXdNoQ40L5u/PYqTpM53vKpoAYtQpa5jZh6cb4fFGmjrUOR2WoD
         r22VHFG073n+TA3j5Pg4xQRE/rMSL7sTXlfQNO9EnqI+so/NQTap2nPJ8yqEx3p8xfXX
         GQaOgF8on020sExvogeob6Ou21yNXbQ5pGleGKIsIBDhr93JKWPE3wZ1zLaJYcfOXBxV
         oe3f9uHJLWh0LOU+IueqVLfye6xa6GOJupWr3H6i6mI6KG8XJOROQcuwuAHoQKb8OR76
         /wZQ==
X-Received: by 10.42.213.194 with SMTP id gx2mr8918739icb.48.1376280507760;
        Sun, 11 Aug 2013 21:08:27 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id x2sm11986256igw.0.2013.08.11.21.08.25
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 11 Aug 2013 21:08:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc2.460.ga591f4a
In-Reply-To: <1376280459-55188-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232147>

At start of script, t3404 installs a specialized test-editor ($EDITOR)
upon which many of the interactive rebase tests depend.  Late in t3404,
test "rebase -i respects core.commentchar" installs its own custom
editor but neglects to restore the specialized editor when finished.
This oversight will cause later tests, which require the specialized
editor, to fail.  (There are no such tests presently, but a subsequent
patch will introduce one.)  Fix this problem.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t3404-rebase-interactive.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 49ccb38..af141be 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -949,6 +949,7 @@ test_expect_success 'rebase -i respects core.commentchar' '
 	sed -e "2,\$s/^/\\\\/" "$1" >"$1.tmp" &&
 	mv "$1.tmp" "$1"
 	EOF
+	test_when_finished "set_fake_editor" &&
 	test_set_editor "$(pwd)/remove-all-but-first.sh" &&
 	git rebase -i B &&
 	test B = $(git cat-file commit HEAD^ | sed -ne \$p)
-- 
1.8.4.rc2.460.ga591f4a

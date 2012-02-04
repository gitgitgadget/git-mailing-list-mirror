From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/3] blame: fix email output with mailmap
Date: Sat,  4 Feb 2012 21:50:22 +0200
Message-ID: <1328385024-6955-2-git-send-email-felipe.contreras@gmail.com>
References: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"Brian Gianforcaro" <b.gianfo@gmail.com>,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Junio C Hamano" <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 20:51:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtleN-0005Zw-Ic
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 20:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab2BDTva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 14:51:30 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34029 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754439Ab2BDTvY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Feb 2012 14:51:24 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so2380696lag.19
        for <git@vger.kernel.org>; Sat, 04 Feb 2012 11:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=413dZqNbrSj3N4Hkj21BBmceZriMgU/eVETP2k3J3sI=;
        b=Zn1gtYEhD4q5UJi2A1sq9wI121KWyVZen7UTtwNgvCcOQ3obeHyHowUJRyLt7PoW7Y
         4R9YP2KLgiGs9pfiWI2h83yHAdvdAeJagx4QVaLLaax67/rs20kPVbmj9cEQ3lRavz+H
         9ZRONgPnbbd83ttH51rUXIN+1C2lSi/tw2Dvs=
Received: by 10.152.109.135 with SMTP id hs7mr6237524lab.14.1328385084190;
        Sat, 04 Feb 2012 11:51:24 -0800 (PST)
Received: from localhost (a91-153-253-80.elisa-laajakaista.fi. [91.153.253.80])
        by mx.google.com with ESMTPS id e7sm7838053lba.0.2012.02.04.11.51.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 04 Feb 2012 11:51:23 -0800 (PST)
X-Mailer: git-send-email 1.7.9.1.g97f7d
In-Reply-To: <1328385024-6955-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189897>

An extra '>' is added in some cases (<spearce@spearce.org>>), for
example:

 % git blame -e -L 947,+7 contrib/completion/git-completion.bash v1.7.9

The current code assumes map_user() *always* returns plain emails, but
that's not true; when there's no email substitution (only name),
map_user() would return 1, but don't touch the mail.

Also, add some tests.

This got broken by d20d654[1].

[1] Change current mailmap usage to do matching on both name and email
    of author/committer.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/blame.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 5a67c20..dd69e51 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1403,10 +1403,13 @@ static void get_ac_line(const char *inbuf, const char *what,
 	 * Now, convert both name and e-mail using mailmap
 	 */
 	if (map_user(&mailmap, mail+1, mail_len-1, person, tmp-person-1)) {
-		/* Add a trailing '>' to email, since map_user returns plain emails
-		   Note: It already has '<', since we replace from mail+1 */
+		/*
+		 * Add a trailing '>' to email, since map_user returns plain
+		 * emails when it finds a matching mail.
+		 * Note: It already has '<', since we replace from mail + 1
+		 */
 		mailpos = memchr(mail, '\0', mail_len);
-		if (mailpos && mailpos-mail < mail_len - 1) {
+		if (mailpos && mailpos-mail < mail_len - 1 && *(mailpos - 1) != '>') {
 			*mailpos = '>';
 			*(mailpos+1) = '\0';
 		}
-- 
1.7.9.1.g97f7d

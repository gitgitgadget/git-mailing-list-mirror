From: Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] i18n: Not add stripped contents for translation
Date: Mon,  5 Mar 2012 09:21:34 +0800
Message-ID: <1330910494-17216-1-git-send-email-worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 02:22:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4Mcq-0002zn-8W
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 02:22:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab2CEBWD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 20:22:03 -0500
Received: from mail-pz0-f52.google.com ([209.85.210.52]:59335 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065Ab2CEBWB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 20:22:01 -0500
Received: by dadp12 with SMTP id p12so4325950dad.11
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 17:22:01 -0800 (PST)
Received-SPF: pass (google.com: domain of worldhello.net@gmail.com designates 10.68.129.162 as permitted sender) client-ip=10.68.129.162;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of worldhello.net@gmail.com designates 10.68.129.162 as permitted sender) smtp.mail=worldhello.net@gmail.com; dkim=pass header.i=worldhello.net@gmail.com
Received: from mr.google.com ([10.68.129.162])
        by 10.68.129.162 with SMTP id nx2mr42971189pbb.94.1330910521015 (num_hops = 1);
        Sun, 04 Mar 2012 17:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=7s+3eaJ0PhTev4nyOoKb3bnrsRMqbjxqoEEZei4qsBM=;
        b=ShJvAnmQ8m2tEbDznsCMNwTW6nAjxvOBipw5P7QV62hr2Nen5fiJh/EH0npJotVQoz
         VX/WjC1sg9Q1TdAuMYQ4R98Y0QqyXwqw0024EZ8XEbDs5irkHW2AmRixt7W4oiPyZkTI
         IklVBNsMv685jjRiFVXc6UDtnMgJ3bwVDOs5DDxvMmaStsQ2UjQa5y/t8OWHZBJpDkZz
         WQNYPmbLZ1hySD1PZHsyL1utb9GR9cIQ2uRzUKhYouOS/9/Qz/ZIp3BF0qaAC11NpPjL
         3fSGvDjBvOxIpQEQ9MN9OeC3VpTm0wB6828S78N0B4ZmjvHp0uKvkiHStRJ8kSqXK4xy
         HgbQ==
Received: by 10.68.129.162 with SMTP id nx2mr36785280pbb.94.1330910520914;
        Sun, 04 Mar 2012 17:22:00 -0800 (PST)
Received: from localhost.foo.bar ([123.116.251.201])
        by mx.google.com with ESMTPS id f8sm11794568pbe.42.2012.03.04.17.21.55
        (version=SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 17:22:00 -0800 (PST)
X-Mailer: git-send-email 1.7.9.2.330.g152e4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192185>

The last two chars of the concatenate str from the i18n marked strings
(", ") will be stripped out by strbuf_setlen.

        before: "new commits, modified content, "
        end:    "new commits, modified content"

If the translations won't end with COMMA+SPACE, will break the integrit=
y
of the concatenate string. As for Chinese, COMMA+SPACE may translated t=
o
"=EF=BC=8C" -- a 3-byte UTF-8 Chinese comma character.

Signed-off-by: Jiang Xin <worldhello.net@gmail.com>
---
 wt-status.c |    6 +++---
 1 =E4=B8=AA=E6=96=87=E4=BB=B6=E8=A2=AB=E4=BF=AE=E6=94=B9=EF=BC=8C=E6=8F=
=92=E5=85=A5 3 =E8=A1=8C(+)=EF=BC=8C=E5=88=A0=E9=99=A4 3 =E8=A1=8C(-)

diff --git a/wt-status.c b/wt-status.c
index 9ffc535..0042dbc 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -245,11 +245,11 @@ static void wt_status_print_change_data(struct wt=
_status *s,
 		if (d->new_submodule_commits || d->dirty_submodule) {
 			strbuf_addstr(&extra, " (");
 			if (d->new_submodule_commits)
-				strbuf_addf(&extra, _("new commits, "));
+				strbuf_addf(&extra, "%s, ", _("new commits"));
 			if (d->dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-				strbuf_addf(&extra, _("modified content, "));
+				strbuf_addf(&extra, "%s, ", _("modified content"));
 			if (d->dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-				strbuf_addf(&extra, _("untracked content, "));
+				strbuf_addf(&extra, "%s, ", _("untracked content"));
 			strbuf_setlen(&extra, extra.len - 2);
 			strbuf_addch(&extra, ')');
 		}
--=20
1.7.9.2.330.g152e4.dirty

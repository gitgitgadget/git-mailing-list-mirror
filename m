From: Renee Margaret McConahy <nepella@gmail.com>
Subject: [PATCH v2] am: configure gpg at startup
Date: Wed, 30 Sep 2015 13:49:44 -0400
Message-ID: <560c3c62.65086b0a.538a7.328a@mx.google.com>
References: <560c2efb.894f320a.d43ae.4338@mx.google.com>
    <xmqqtwqb7lqn.fsf@gitster.mtv.corp.google.com>
Cc: Paul Tan <pyokagan@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 21:47:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhNM0-0002j7-Px
	for gcvg-git-2@plane.gmane.org; Wed, 30 Sep 2015 21:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbbI3Trt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2015 15:47:49 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36799 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbbI3Trs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2015 15:47:48 -0400
Received: by igcrk20 with SMTP id rk20so110841764igc.1
        for <git@vger.kernel.org>; Wed, 30 Sep 2015 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:from:date:subject:to:cc:in-reply-to:references;
        bh=3KwOZHLtwkzFEO/fI628n69wPOSQacXani0u2J0vzJg=;
        b=Z2x4KDiFB7e+ZV/CKkXtGa3dNWcU7luZAk2tp5kRCEIn+jI+fc0mjQZ9B9tjv4uc/7
         4Jg3pJuRb1UKn8YVSAVWiUtvP1pyF4nME8FOj0kjPRcYHmOTKel4/l4lh9KYSGMkE77P
         tW97efHFfO0/xo1H/gZEj0XmwRAdo8MPevm7y/sYxXuVsN+0YfpHeXmvMHJK9l9TD3Me
         t4fc0K3BR9gF3oy8SHz3PYNE1nm/RCoD6fRW4Q4kSZSCP3Lj/Wb81NbTH7U6ObXHY6WV
         OdslYxPt+I4r6hWFbn2NsemA005R69l8uc6Pn0IkNm4IyaP6gdNvTIn1b1ggSqyy2Iv5
         pc0A==
X-Received: by 10.50.92.9 with SMTP id ci9mr7351634igb.2.1443642467420;
        Wed, 30 Sep 2015 12:47:47 -0700 (PDT)
Received: from localhost (69-89-111-67.dhcp-elns.acd.net. [69.89.111.67])
        by smtp.gmail.com with ESMTPSA id 98sm975247ioi.22.2015.09.30.12.47.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Sep 2015 12:47:46 -0700 (PDT)
In-Reply-To: <xmqqtwqb7lqn.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278862>

The new builtin am ignores the user.signingkey variable: gpg is being
called with the committer details as the key ID, which may not be
correct. git_gpg_config is responsible for handling that variable and is
expected to be called on initialization by any modules that use gpg.

Perhaps git_gpg_config's functionality ought to be merged into
git_default_config, but this is simpler and in keeping with the current
practice.

Signed-off-by: Renee Margaret McConahy <nepella@gmail.com>
---
Oops, my bad. Thanks.

 builtin/am.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4f77e07..3bd4fd7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2208,6 +2208,17 @@ enum resume_mode {
 	RESUME_ABORT
 };
 
+static int git_am_config(const char *k, const char *v, void *cb)
+{
+	int status;
+
+	status = git_gpg_config(k, v, NULL);
+	if (status)
+		return status;
+
+	return git_default_config(k, v, NULL);
+}
+
 int cmd_am(int argc, const char **argv, const char *prefix)
 {
 	struct am_state state;
@@ -2308,7 +2319,7 @@ int cmd_am(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
+	git_config(git_am_config, NULL);
 
 	am_state_init(&state, git_path("rebase-apply"));
 
-- 
2.5.3

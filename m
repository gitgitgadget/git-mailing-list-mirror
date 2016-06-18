Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1EDE20189
	for <e@80x24.org>; Sat, 18 Jun 2016 12:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbcFRMZe (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 08:25:34 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35822 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbcFRMZd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 08:25:33 -0400
Received: by mail-pa0-f68.google.com with SMTP id hf6so7545444pac.2
        for <git@vger.kernel.org>; Sat, 18 Jun 2016 05:25:33 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ferd1vbZCrWAdVbFHi93WtZe4p1w0N06zpeQf60Asps=;
        b=GXcNhG4HpHKjmhD3lhz30+77uxkqbEKxx3yJGIGiPy8wdj89JkWI58LIlgD6L7wPKj
         P3uKC2IMDFu7nC91Aq30Nwl7PwbWioZae/UwAuJ+B1VNRX50rkKylzaDoddZiIeSSmpF
         Y3eTNrKUxJWAv9d/lMU/Tv03KoyW3Wnkz6Mk8PSUjpRWeDN4qB2MbVxjk1oC/pSJj5K4
         nUEItzmWhUFDIRMkb7AD9AGEGnakzeBdR3jvQ4YVJKTJU9rLcFiG5cOYpVQKW43ed/fv
         XcbWggyi3zVaMQM1jyJzUrNGSswIRY918UqLWXh26JCcYqxu734RwJGug9puA/DCdqFR
         xzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ferd1vbZCrWAdVbFHi93WtZe4p1w0N06zpeQf60Asps=;
        b=UwzSGMr3x4ltAlbJO3pXc/e+TcknEzoqzEVnD57vUzIGn6ojVfiMgpIm58MY5ev7rt
         9hh5YdUibBZEhd1CsZGMc7BXRrYyl4/x/KvrLSlkfflwXgTLrMRV6eQ2dUYEkUUJX6Pz
         RvVd+P29FWjX1NJ7l+xJ8yJ+EkdbwcEd44W1sHWuI7BuKwXYuK9791OZba49mZTuSsnt
         gH8Bo3yu1qd3jSrGxrzgja5gog42X849F/ss0IW4L1pukygcz+cRwiA4GnyTzACaYYO+
         270H5+S9jk9RRLqc8Rc/ZcwwGjfFExJM0eptsLx2YrZ8Umyd0HwnbvgN6dPhQVJ1CBra
         aT0g==
X-Gm-Message-State: ALyK8tJb/YSeXp+fj78Fj9unIaUpW+SxRJTGqgwGMif3L//L79QJmdcU1w7e5VOD2F4Xzg==
X-Received: by 10.66.161.41 with SMTP id xp9mr8593624pab.78.1466252733007;
        Sat, 18 Jun 2016 05:25:33 -0700 (PDT)
Received: from localhost.localdomain ([223.176.148.194])
        by smtp.gmail.com with ESMTPSA id y63sm48966279pfb.13.2016.06.18.05.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Jun 2016 05:25:32 -0700 (PDT)
From:	Mehul Jain <mehul.jain2029@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v2 1/2] log: add "--no-show-signature" command line option
Date:	Sat, 18 Jun 2016 17:55:09 +0530
Message-Id: <20160618122510.5105-2-mehul.jain2029@gmail.com>
X-Mailer: git-send-email 2.9.0.rc0.dirty
In-Reply-To: <20160618122510.5105-1-mehul.jain2029@gmail.com>
References: <20160618122510.5105-1-mehul.jain2029@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

If an user creates an alias with "--show-signature" in command line,
e.g.
	[alias] logss = log --show-signature

then there is no way to countermand it through command line.

Teach git-log and related commands about "--no-show-signature" command
line option. This will make "git logss --no-show-signature" run
without showing GPG signature.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 revision.c     |  2 ++
 t/t4202-log.sh | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/revision.c b/revision.c
index d30d1c4..3546ff9 100644
--- a/revision.c
+++ b/revision.c
@@ -1871,6 +1871,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->notes_opt.use_default_notes = 1;
 	} else if (!strcmp(arg, "--show-signature")) {
 		revs->show_signature = 1;
+	} else if (!strcmp(arg, "--no-show-signature")) {
+		revs->show_signature = 0;
 	} else if (!strcmp(arg, "--show-linear-break") ||
 		   starts_with(arg, "--show-linear-break=")) {
 		if (starts_with(arg, "--show-linear-break="))
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 128ba93..02384a3 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -890,6 +890,16 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	grep "^| | gpg: Good signature" actual
 '
 
+test_expect_success GPG '--no-show-signature overrides --show-signature' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	git checkout -b nosign master &&
+	echo foo >foo &&
+	git add foo &&
+	git commit -S -m signed_commit &&
+	git log -1 --show-signature --no-show-signature nosign >actual &&
+	! grep "^gpg:" actual
+'
+
 test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
-- 
2.9.0.rc0.dirty


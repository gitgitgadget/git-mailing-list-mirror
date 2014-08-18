From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH] make config --add behave correctly for empty and NULL values
Date: Mon, 18 Aug 2014 03:17:57 -0700
Message-ID: <1408357077-4745-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 18 12:24:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJK6i-0002yM-TG
	for gcvg-git-2@plane.gmane.org; Mon, 18 Aug 2014 12:24:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbaHRKTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2014 06:19:01 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:32855 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbaHRKTA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2014 06:19:00 -0400
Received: by mail-pd0-f172.google.com with SMTP id y13so7211519pdi.31
        for <git@vger.kernel.org>; Mon, 18 Aug 2014 03:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=XzZ/DeGjnYW90Qpzc9+rpJ8qtWHI5KqDt1IvDWQ2ziU=;
        b=vWymEqLT3X8PwSr2tBe3l4smvDYAwb1BmmsoV8CLx3PQpI4oCeJAAKIziyI0VIU2iL
         IWOgdM76Me/y3ERBjfL22cZ7AXE8EwDF1TAvHMXdNiqpsMA5Up/WjxLLHOfZV5Ji4UO2
         JPTdpOiaYBtzKqQPc/ZxAUERgAdbB0OOgXWl2/lIPhWAITodqVntzHPrJ/Nwd/ofOgLv
         ryb/HsqrCI2/LQIne3OtjOYczIWJ/y+BWRmI3LleUoLSBG08Mmsx+kca2sqXWbxSUAwv
         YhXcN1xVDUDtgM7vg5/t8ePgeaXtVRn1w0WWD4q6t8q0F74ADU9js1Uom+SvUS9T9vDM
         YXRg==
X-Received: by 10.66.219.42 with SMTP id pl10mr34127713pac.22.1408357133534;
        Mon, 18 Aug 2014 03:18:53 -0700 (PDT)
Received: from localhost.localdomain ([117.254.223.75])
        by mx.google.com with ESMTPSA id bu2sm15771995pbc.19.2014.08.18.03.18.48
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 18 Aug 2014 03:18:52 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255383>

Currently if we have a config file like,
[foo]
        baz
        bar =

and we try something like, "git config --add foo.baz roll", Git will
segfault. Moreover, for "git config --add foo.bar roll", it will
overwrite the original value instead of appending after the existing
empty value.

The problem lies with the regexp used for simulating --add in
`git_config_set_multivar_in_file()`, "^$", which in ideal case should
not match with any string but is true for empty strings. Instead use a
regexp like "a^" which can not be true for any string, empty or not.

For removing the segfault add a check for NULL values in `matches()` in
config.c.

Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
---
 builtin/config.c        |  2 +-
 config.c                |  2 +-
 t/t1303-wacky-config.sh | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index fcd8474..b9e7dce 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -586,7 +586,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		check_argc(argc, 2, 2);
 		value = normalize_value(argv[0], argv[1]);
 		return git_config_set_multivar_in_file(given_config_source.file,
-						       argv[0], value, "^$", 0);
+						       argv[0], value, "a^", 0);
 	}
 	else if (actions == ACTION_REPLACE_ALL) {
 		check_write();
diff --git a/config.c b/config.c
index 058505c..67a7729 100644
--- a/config.c
+++ b/config.c
@@ -1231,7 +1231,7 @@ static int matches(const char *key, const char *value)
 	return !strcmp(key, store.key) &&
 		(store.value_regex == NULL ||
 		 (store.do_not_match ^
-		  !regexec(store.value_regex, value, 0, NULL, 0)));
+		  (value && !regexec(store.value_regex, value, 0, NULL, 0))));
 }
 
 static int store_aux(const char *key, const char *value, void *cb)
diff --git a/t/t1303-wacky-config.sh b/t/t1303-wacky-config.sh
index 3a2c819..3b92083 100755
--- a/t/t1303-wacky-config.sh
+++ b/t/t1303-wacky-config.sh
@@ -111,4 +111,24 @@ test_expect_success 'unset many entries' '
 	test_must_fail git config section.key
 '
 
+test_expect_success '--add appends new value after existing empty value' '
+	cat >expect <<-\EOF &&
+
+
+	fool
+	roll
+	EOF
+	cp .git/config .git/config.old &&
+	test_when_finished "mv .git/config.old .git/config" &&
+	cat >.git/config <<-\EOF &&
+	[foo]
+		baz
+		baz =
+		baz = fool
+	EOF
+	git config --add foo.baz roll &&
+	git config --get-all foo.baz >output &&
+	test_cmp expect output
+'
+
 test_done
-- 
1.9.0.GIT

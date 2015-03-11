From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 0/4] git-credential-store: XDG user-specific config file support
Date: Wed, 11 Mar 2015 14:49:09 +0800
Message-ID: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Paul Tan <pyokagan@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 11 07:50:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVaTj-0007mc-3L
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 07:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbbCKGuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 02:50:35 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:43374 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbbCKGue (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 02:50:34 -0400
Received: by pablj1 with SMTP id lj1so8871036pab.10
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 23:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=GAJZVJfCH+r0PKEKZKLwu4GPUqxjMJlaeVbxF745T9Y=;
        b=leYC7SWVq7CZiYrFzgcWQmRkKi2ZynZ9X9kBjDLPRQDFZYxKQDwGefvHU+HrLI/ETp
         IL3DowA8xojQSPXPS/JsCOSu/MFjRyXMgUg57AdVWIUovcoU2xoGecioMjyLSRh2ycY/
         s5t2jX1HCFK90VwmJS32oK+Yz5Y7jE4Jj7DhM+ocA/BD3jAgAV/ddVUVXv0VFFxsjhBj
         8qh2yLqlPqQNBrXnYpSC1NMhun5jI8058XbZbmGeoTp8bV1cOE6LMOlc8FQ4frONlkC7
         rCQHfaGP7tYy+NNJiy3xHvKGIciuf08JNFf3h9QqZllIY8y5XsYnzktdh/UJwyUHcuf3
         yO6w==
X-Received: by 10.70.95.200 with SMTP id dm8mr72375481pdb.14.1426056633927;
        Tue, 10 Mar 2015 23:50:33 -0700 (PDT)
Received: from yoshi.chippynet.com ([101.127.143.183])
        by mx.google.com with ESMTPSA id mi9sm4329612pab.3.2015.03.10.23.50.32
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2015 23:50:32 -0700 (PDT)
Received: from pyokagan by yoshi.chippynet.com with local (Exim 4.84)
	(envelope-from <pyokagan@yoshi.chippynet.com>)
	id 1YVaTN-0002eS-Si; Wed, 11 Mar 2015 14:50:29 +0800
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265305>

The previous patch series can be found at [1].

[1] http://thread.gmane.org/gmane.comp.version-control.git/265042

The changes for "git-credential-store: support multiple credential files" are
as follows:

* store_credential(), instead of taking an index to the string_list for the
default filename, takes a filename string instead as it leads to a more
flexible API.

The changes for "t0302: test credential-store support for XDG_CONFIG_HOME" are
as follows:

* Corrected code style violations: All tests are now separated by newlines.

* After $XDG_CONFIG_HOME is set to "$HOME/xdg", use $XDG_CONFIG_HOME directly
for all paths instead of "$HOME/xdg".

Thanks Matthieu for the code review.

The diff between the previous patch series is as follows:

diff --git a/credential-store.c b/credential-store.c
index 7b22a3a..b00f80f 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -88,7 +88,7 @@ static void store_credential_file(const char *fn, struct credential *c)
 }
 
 static void store_credential(const struct string_list *fns, struct credential *c,
-			     unsigned int default_index)
+			     const char *default_fn)
 {
 	struct string_list_item *fn;
 
@@ -107,8 +107,9 @@ static void store_credential(const struct string_list *fns, struct credential *c
 			store_credential_file(fn->string, c);
 			return;
 		}
-	/* Write credential to the filename at default_index, creating it */
-	store_credential_file(fns->items[default_index].string, c);
+	/* Write credential to default_fn, thus creating it */
+	if (default_fn)
+		store_credential_file(default_fn, c);
 }
 
 static void remove_credential(const struct string_list *fns, struct credential *c)
@@ -182,7 +183,7 @@ int main(int argc, char **argv)
 	else if (!strcmp(op, "erase"))
 		remove_credential(&fns, &c);
 	else if (!strcmp(op, "store"))
-		store_credential(&fns, &c, 0);
+		store_credential(&fns, &c, fns.items[0].string);
 	else
 		; /* Ignore unknown operation. */
 
diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
index 7fe832d..34752ea 100755
--- a/t/t0302-credential-store.sh
+++ b/t/t0302-credential-store.sh
@@ -5,41 +5,53 @@ test_description='credential-store tests'
 . "$TEST_DIRECTORY"/lib-credential.sh
 
 helper_test store
+
 test_expect_success '~/.git-credentials is written to when xdg credentials file does not exist' '
 	test -s "$HOME/.git-credentials"
 '
+
 test_expect_success 'xdg credentials file will not be created if it does not exist' '
 	test_path_is_missing "$HOME/.config/git/credentials"
 '
+
 test_expect_success 'create $XDG_CONFIG_HOME/git/credentials file' '
 	test_might_fail rm "$HOME/.git-credentials" &&
 	mkdir -p "$HOME/.config/git" &&
 	>"$HOME/.config/git/credentials"
 '
+
 helper_test store
+
 test_expect_success 'xdg credentials file will be written to if it exists' '
 	test -s "$HOME/.config/git/credentials"
 '
+
 test_expect_success '~/.git-credentials will not be created if xdg credentials file exists' '
 	test_path_is_missing "$HOME/.git-credentials"
 '
+
 test_expect_success 'set up custom XDG_CONFIG_HOME credential file' '
 	XDG_CONFIG_HOME="$HOME/xdg" && export XDG_CONFIG_HOME &&
-	mkdir -p "$HOME/xdg/git" &&
-	>"$HOME/xdg/git/credentials" &&
+	mkdir -p "$XDG_CONFIG_HOME/git" &&
+	>"$XDG_CONFIG_HOME/git/credentials" &&
 	>"$HOME/.config/git/credentials"
 '
+
 helper_test store
+
 test_expect_success 'custom XDG_CONFIG_HOME credentials file will be written to if it exists' '
-	unset XDG_CONFIG_HOME &&
-	test -s "$HOME/xdg/git/credentials"
+	test_when_finished "unset XDG_CONFIG_HOME" &&
+	test -s "$XDG_CONFIG_HOME/git/credentials"
 '
+
 test_expect_success '~/.config/git/credentials file will not be written to if a custom XDG_CONFIG_HOME is set' '
 	test_must_be_empty "$HOME/.config/git/credentials"
 '
+
 test_expect_success '~/.git-credentials will not be created if xdg credentials file exists' '
 	test_path_is_missing "$HOME/.git-credentials"
 '
+
 test_expect_success 'get: return credentials from home file if matches are found in both home and xdg files' '
 	mkdir -p "$HOME/.config/git" &&
 	echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
@@ -55,6 +67,7 @@ test_expect_success 'get: return credentials from home file if matches are found
 	--
 	EOF
 '
+
 test_expect_success 'get: return credentials from xdg file if the home files do not have them' '
 	mkdir -p "$HOME/.config/git" &&
 	>"$HOME/.git-credentials" &&
@@ -70,6 +83,7 @@ test_expect_success 'get: return credentials from xdg file if the home files do
 	--
 	EOF
 '
+
 test_expect_success 'get: return credentials from home file if xdg files are unreadable' '
 	mkdir -p "$HOME/.config/git" &&
 	echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
@@ -86,6 +100,7 @@ test_expect_success 'get: return credentials from home file if xdg files are unr
 	--
 	EOF
 '
+
 test_expect_success 'erase: erase matching credentials from both xdg and home files' '
 	mkdir -p "$HOME/.config/git" &&
 	echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&

Paul Tan (4):
  git-credential-store: support multiple credential files
  git-credential-store: support XDG_CONFIG_HOME
  docs/git-credential-store: document XDG file and precedence
  t0302: test credential-store support for XDG_CONFIG_HOME

 Documentation/git-credential-store.txt |  37 +++++++++++-
 credential-store.c                     |  87 ++++++++++++++++++---------
 t/t0302-credential-store.sh            | 107 +++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+), 29 deletions(-)

-- 
2.1.4

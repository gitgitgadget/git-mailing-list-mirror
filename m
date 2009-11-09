From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 3/5] Add the configuration option skipFetchAll
Date: Mon, 09 Nov 2009 21:11:06 +0100
Message-ID: <4AF8775A.5050301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 21:11:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7aa7-0000AE-CS
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 21:11:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbZKIULH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 15:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753923AbZKIULH
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 15:11:07 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:43790 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbZKIULF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 15:11:05 -0500
Received: by ewy3 with SMTP id 3so3512911ewy.37
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 12:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=Y101kGKTzbJmMKb4sW/XjzibBUb4qOTM/f2TIBVzcKI=;
        b=sslRH0cFdj5RVSYOoZGybpB6ercN7NYfhujKRFFI6kAWKOBGKIzNefvwDjzPXICV+V
         5KFp30yw3xWLIWKCSUQVRyWg1nO4Gj7DOx1qGpV1/FjQcl6qWLLJ5/7MdI5oNR+i+Lp3
         J9XmzwcpsyTthI4p7OYkjYLOrWCEy4l7Ki28Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=FMAyFKQwmfBUcrMByMtdM7ieTsx/QiOOf2WqM6DY2/CIVVSyA/6P94LlGSBGJFzL03
         DhdGieCMHPn4J8y7yJayw7Bs2wybzwMHb/17f1VxFJlK3eaWsJoAiY1qd7i4FmWkkisl
         LHicUy7g20JEW7iHBlCKVIyV7KibrQp9S+KAU=
Received: by 10.213.104.78 with SMTP id n14mr1279758ebo.22.1257797469894;
        Mon, 09 Nov 2009 12:11:09 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 10sm81953eyz.3.2009.11.09.12.11.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 12:11:07 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132516>

Implement the configuration skipFetchAll option to allow
certain remotes to be skipped when doing 'git fetch --all' and
'git remote update'. The existing skipDefaultUpdate variable
is still honored (by 'git fetch --all' and 'git remote update').
(If both are set in the configuration file with different values,
the value of the last occurrence will be used.)

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/config.txt  |    8 +++++++-
 builtin-fetch.c           |    3 ++-
 remote.c                  |    3 ++-
 t/t5514-fetch-multiple.sh |   40 +++++++++++++++++++++++++++++++++++++=
---
 4 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d1e2120..348b367 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1394,7 +1394,13 @@ remote.<name>.mirror::
=20
 remote.<name>.skipDefaultUpdate::
 	If true, this remote will be skipped by default when updating
-	using the update subcommand of linkgit:git-remote[1].
+	using linkgit:git-fetch[1] or the `update` subcommand of
+	linkgit:git-remote[1].
+
+remote.<name>.skipFetchAll::
+	If true, this remote will be skipped by default when updating
+	using linkgit:git-fetch[1] or the `update` subcommand of
+	linkgit:git-remote[1].
=20
 remote.<name>.receivepack::
 	The default program to execute on the remote side when pushing.  See
diff --git a/builtin-fetch.c b/builtin-fetch.c
index a5a70a0..945dfd8 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -690,7 +690,8 @@ static void set_option(const char *name, const char=
 *value)
 static int get_one_remote_for_fetch(struct remote *remote, void *priv)
 {
 	struct string_list *list =3D priv;
-	string_list_append(remote->name, list);
+	if (!remote->skip_default_update)
+		string_list_append(remote->name, list);
 	return 0;
 }
=20
diff --git a/remote.c b/remote.c
index 73d33f2..beaf9fb 100644
--- a/remote.c
+++ b/remote.c
@@ -396,7 +396,8 @@ static int handle_config(const char *key, const cha=
r *value, void *cb)
 		remote->mirror =3D git_config_bool(key, value);
 	else if (!strcmp(subkey, ".skipdefaultupdate"))
 		remote->skip_default_update =3D git_config_bool(key, value);
-
+	else if (!strcmp(subkey, ".skipfetchall"))
+		remote->skip_default_update =3D git_config_bool(key, value);
 	else if (!strcmp(subkey, ".url")) {
 		const char *v;
 		if (git_config_string(&v, key, value))
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 69c64ab..b737332 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -94,9 +94,6 @@ test_expect_success 'git fetch --multiple (but only o=
ne remote)' '
 cat > expect << EOF
   one/master
   one/side
-  origin/HEAD -> origin/master
-  origin/master
-  origin/side
   two/another
   two/master
   two/side
@@ -105,6 +102,7 @@ EOF
 test_expect_success 'git fetch --multiple (two remotes)' '
 	(git clone one test4 &&
 	 cd test4 &&
+	 git remote rm origin &&
 	 git remote add one ../one &&
 	 git remote add two ../two &&
 	 git fetch --multiple one two &&
@@ -117,4 +115,40 @@ test_expect_success 'git fetch --multiple (bad rem=
ote names)' '
 	 test_must_fail git fetch --multiple four)
 '
=20
+
+test_expect_success 'git fetch --all (skipFetchAll)' '
+	(cd test4 &&
+	 for b in $(git branch -r)
+	 do
+		git branch -r -d $b || break
+	 done &&
+	 git remote add three ../three &&
+	 git config remote.three.skipFetchAll true &&
+	 git fetch --all &&
+	 git branch -r > output &&
+	 test_cmp ../expect output)
+'
+
+cat > expect << EOF
+  one/master
+  one/side
+  three/another
+  three/master
+  three/side
+  two/another
+  two/master
+  two/side
+EOF
+
+test_expect_success 'git fetch --multiple (ignoring skipFetchAll)' '
+	(cd test4 &&
+	 for b in $(git branch -r)
+	 do
+		git branch -r -d $b || break
+	 done &&
+	 git fetch --multiple one two three &&
+	 git branch -r > output &&
+	 test_cmp ../expect output)
+'
+
 test_done
--=20
1.6.5.1.69.g36942

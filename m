From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [PATCH 2/5] Teach the --multiple option to 'git fetch'
Date: Mon, 09 Nov 2009 21:10:32 +0100
Message-ID: <4AF87738.8010205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 21:10:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7aZW-0008JV-PE
	for gcvg-git-2@lo.gmane.org; Mon, 09 Nov 2009 21:10:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbZKIUKb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Nov 2009 15:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753824AbZKIUKb
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Nov 2009 15:10:31 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:8825 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbZKIUKa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2009 15:10:30 -0500
Received: by ey-out-2122.google.com with SMTP id 4so42138eyf.19
        for <git@vger.kernel.org>; Mon, 09 Nov 2009 12:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=5A+H+MWiDTwFVZaf8oE6M7RqswvRZ0FwKLzuQGYnkpU=;
        b=Rx9L8Qpr3URgwz9NW/il4GdW+7u7NsvdTHT+O8zKofjkVDudLfWC/jtdMz8xCn/7qP
         A2MzuMOMky1/97jWBzcrflCa6ctrxxJKLDKYvHYdJGXEfDxQoMyKzA9/6E015CvTPX7+
         vTT1aKlUhLUAUHe10cA+ffgrib9OEEYoniB04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=HKyK4JEbbMRsjKEx+CwXT3YMShS873VNDKW5GcLCx7mDAXNXzFppeINqGn+MlJwskv
         nH/VQXyomV4h08pS+gQFfh4cQxXFt4GkSmawXB+A9IVpI3phdLFWyi7Kj8+52JrrUIaB
         +viAEJvnLDBGMikvZ8Qw+Hf1p6SAavuCrMT6E=
Received: by 10.213.26.140 with SMTP id e12mr3917193ebc.0.1257797434915;
        Mon, 09 Nov 2009 12:10:34 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 7sm71258eyg.25.2009.11.09.12.10.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 09 Nov 2009 12:10:33 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132515>

Add the --multiple option to specify that all arguments are either
groups or remotes. The primary reason for adding this option is
to allow us to re-implement 'git remote update' using fetch.

It would have been nice if this option was not needed, but since
the colon in a refspec is optional, it is in general not possible
to know whether a single, colon-less argument is a remote or a
refspec.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 Documentation/fetch-options.txt |    6 +++++
 Documentation/git-fetch.txt     |    2 +
 builtin-fetch.c                 |   11 ++++++++-
 t/t5514-fetch-multiple.sh       |   44 +++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 62 insertions(+), 1 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 93d73c3..8b0cf58 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -24,6 +24,12 @@
 --keep::
 	Keep downloaded pack.
=20
+ifndef::git-pull[]
+--multiple::
+	Allow several <repository> and <group> arguments to be
+	specified. No <refspec>s may be specified.
+endif::git-pull[]
+
 ifdef::git-pull[]
 --no-tags::
 endif::git-pull[]
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 3616466..9b9e568 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -12,6 +12,8 @@ SYNOPSIS
=20
 'git fetch' <options> <group>
=20
+'git fetch' --multiple <options> [<repository> | <group>]...
+
 'git fetch' --all <options>
=20
=20
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 2bf51cc..a5a70a0 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -15,6 +15,7 @@
 static const char * const builtin_fetch_usage[] =3D {
 	"git fetch [options] [<repository> <refspec>...]",
 	"git fetch [options] <group>",
+	"git fetch --multiple [options] [<repository> | <group>]...",
 	"git fetch --all [options]",
 	NULL
 };
@@ -25,7 +26,7 @@ enum {
 	TAGS_SET =3D 2
 };
=20
-static int all, append, force, keep, update_head_ok, verbosity;
+static int all, append, force, keep, multiple, update_head_ok, verbosi=
ty;
 static int tags =3D TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -42,6 +43,8 @@ static struct option builtin_fetch_options[] =3D {
 		   "path to upload pack on remote end"),
 	OPT_BOOLEAN('f', "force", &force,
 		    "force overwrite of local branch"),
+	OPT_BOOLEAN('m', "multiple", &multiple,
+		    "fetch from multiple remotes"),
 	OPT_SET_INT('t', "tags", &tags,
 		    "fetch all tags and associated objects", TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
@@ -839,6 +842,12 @@ int cmd_fetch(int argc, const char **argv, const c=
har *prefix)
 		/* No arguments -- use default remote */
 		remote =3D remote_get(NULL);
 		result =3D fetch_one(remote, argc, argv);
+	} else if (multiple) {
+		/* All arguments are assumed to be remotes or groups */
+		for (i =3D 0; i < argc; i++)
+			if (!add_remote_or_group(argv[i], &list))
+				die("No such remote or remote group: %s", argv[i]);
+		result =3D fetch_multiple(&list);
 	} else {
 		/* Single remote or group */
 		(void) add_remote_or_group(argv[0], &list);
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 25244bf..69c64ab 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -73,4 +73,48 @@ test_expect_success 'git fetch --all does not allow =
non-option arguments' '
 	 test_must_fail git fetch --all origin master)
 '
=20
+cat > expect << EOF
+  origin/HEAD -> origin/master
+  origin/master
+  origin/side
+  three/another
+  three/master
+  three/side
+EOF
+
+test_expect_success 'git fetch --multiple (but only one remote)' '
+	(git clone one test3 &&
+	 cd test3 &&
+	 git remote add three ../three &&
+	 git fetch --multiple three &&
+	 git branch -r > output &&
+	 test_cmp ../expect output)
+'
+
+cat > expect << EOF
+  one/master
+  one/side
+  origin/HEAD -> origin/master
+  origin/master
+  origin/side
+  two/another
+  two/master
+  two/side
+EOF
+
+test_expect_success 'git fetch --multiple (two remotes)' '
+	(git clone one test4 &&
+	 cd test4 &&
+	 git remote add one ../one &&
+	 git remote add two ../two &&
+	 git fetch --multiple one two &&
+	 git branch -r > output &&
+	 test_cmp ../expect output)
+'
+
+test_expect_success 'git fetch --multiple (bad remote names)' '
+	(cd test4 &&
+	 test_must_fail git fetch --multiple four)
+'
+
 test_done
--=20
1.6.5.1.69.g36942

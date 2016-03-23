From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] sha1_name.c: add an option to abort on ambiguous refs
Date: Wed, 23 Mar 2016 20:30:40 +0700
Message-ID: <1458739840-15855-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 23 14:31:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiism-0006T9-Al
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 14:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754988AbcCWNb3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Mar 2016 09:31:29 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:33417 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074AbcCWNb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 09:31:27 -0400
Received: by mail-pf0-f174.google.com with SMTP id 4so28344259pfd.0
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 06:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZqEe/M/1HnVIriESkbCujM2MhR1HG5LqqnhKRUjNr8=;
        b=ufuz2bIYqGkp4/zGoXyoszcxJKf/jVNwgtCBNJZhJRGU4btzdUqK3DOHglKqxaqxW/
         X5Uaile+roxJIVrbdqR6dJD1jhnf5pro8kuFhGgovv9qACPpnz8dzqtPFOMhAdn6YFiv
         wtVEuEhgcZ5nSHy/RllAgOVWwu8mxJ0Hb/SfEqeHg1A/UUju+dHtAkHL4kMgRT1O+rSw
         ZTgMjkIa3/St/HRicuKZzeBZTJuswTzCmpUIJGSnDLF33VGexNpO/i+Ix4vpnrAOwmVl
         vM93Iltou8jVXezk+jJO32JxzpTdcx/lfnRO9VSrnNX7H8CbkDtobljxSdM/Q3Zzvd0X
         t6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eZqEe/M/1HnVIriESkbCujM2MhR1HG5LqqnhKRUjNr8=;
        b=JksozoVWuIX2JiCTT9fo9M8DIEblhMJMIoGJDFpt4qxzojE2XGc/9rRAsZVkdn3at7
         dsnUGoIYpx7occsS856Z000ghF5+p/e3NNbeJ1XGjf7oiPXmdAOO7XFJpd3BbAyIR5Em
         lnCfDOOQ15EcbrTsWMKKIR4iH3afpAOdFobgR1uFgNl6XsrJM5YA+eSfxevAf4i/OZNI
         7l352Zu5G12yNoh4PwQn3H5HUsVS7F1+NwWiOHtYU8xlrzi74BiKdCKWWrdAblrHfFcG
         WEDlNlBGN2XSa+FHDoAN23nu0zrMtaJ8oX/su7fYVXyt9heWDSuHDmIJfPeHXJJYiecS
         rKIw==
X-Gm-Message-State: AD7BkJJs6faez/gpg6b29veZG3kOj5w22Ip4nOed1OkKofZPQg4im9wwbFtmrwx5kiBjKw==
X-Received: by 10.98.9.83 with SMTP id e80mr4366067pfd.34.1458739841861;
        Wed, 23 Mar 2016 06:30:41 -0700 (PDT)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id i9sm4442220pfi.95.2016.03.23.06.30.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Mar 2016 06:30:40 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 23 Mar 2016 20:30:53 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289655>

There are cases when a warning on ambiguous refs may go unnoticed
(e.g. git-log filling up the whole screen). There are also cases when
people want to catch ambiguity early (e.g. it happens deep in some
script). In either case, aborting the program would accomplish it.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/config.txt |  3 ++-
 config.c                 |  5 ++++-
 sha1_name.c              | 10 ++++++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 2cd6bdd..4172f59 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -522,7 +522,8 @@ core.sharedRepository::
=20
 core.warnAmbiguousRefs::
 	If true, Git will warn you if the ref name you passed it is ambiguous
-	and might match multiple refs in the repository. True by default.
+	and might match multiple refs in the repository. If set to "fatal",
+	the program will abort on ambiguous refs. True by default.
=20
 core.compression::
 	An integer -1..9, indicating a default compression level.
diff --git a/config.c b/config.c
index 9ba40bc..79f1ea5 100644
--- a/config.c
+++ b/config.c
@@ -738,7 +738,10 @@ static int git_default_core_config(const char *var=
, const char *value)
 	}
=20
 	if (!strcmp(var, "core.warnambiguousrefs")) {
-		warn_ambiguous_refs =3D git_config_bool(var, value);
+		if (!strcasecmp(value, "fatal"))
+			warn_ambiguous_refs =3D 2;
+		else
+			warn_ambiguous_refs =3D git_config_bool(var, value);
 		return 0;
 	}
=20
diff --git a/sha1_name.c b/sha1_name.c
index 3acf221..a0f0ab9 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -480,6 +480,8 @@ static int get_sha1_basic(const char *str, int len,=
 unsigned char *sha1,
 				warning(warn_msg, len, str);
 				if (advice_object_name_warning)
 					fprintf(stderr, "%s\n", _(object_name_msg));
+				if (warn_ambiguous_refs > 1)
+					die(_("cannot continue with ambiguous refs"));
 			}
 			free(real_ref);
 		}
@@ -537,8 +539,12 @@ static int get_sha1_basic(const char *str, int len=
, unsigned char *sha1,
=20
 	if (warn_ambiguous_refs && !(flags & GET_SHA1_QUIETLY) &&
 	    (refs_found > 1 ||
-	     !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY)))
-		warning(warn_msg, len, str);
+	     !get_short_sha1(str, len, tmp_sha1, GET_SHA1_QUIETLY))) {
+		if (warn_ambiguous_refs > 1)
+			die(warn_msg, len, str);
+		else
+			warning(warn_msg, len, str);
+	}
=20
 	if (reflog_len) {
 		int nth, i;
--=20
2.8.0.rc0.210.gd302cd2

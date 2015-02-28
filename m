From: Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 2/5] upload-pack: support out of band client capability requests
Date: Fri, 27 Feb 2015 17:01:55 -0800
Message-ID: <1425085318-30537-3-git-send-email-sbeller@google.com>
References: <CAGZ79ka8Zg86qqvWByNiP3F6a9QggO-bNY3ZZ9g+A-MdKYQ7NQ@mail.gmail.com>
 <1425085318-30537-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pclouds@gmail.com, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 28 02:02:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRVnJ-0003Vv-MC
	for gcvg-git-2@plane.gmane.org; Sat, 28 Feb 2015 02:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316AbbB1BCI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2015 20:02:08 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:43335 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbbB1BCE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2015 20:02:04 -0500
Received: by igbhn18 with SMTP id hn18so4922051igb.2
        for <git@vger.kernel.org>; Fri, 27 Feb 2015 17:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=sAwYt5NQpt5Uv0pm6Oz71e0kGcRosBnO/XlBs0KKEQA=;
        b=Dyb2wBYWpbXFo6czVlPvXFtTeTE7cQR/M66baF6OP9tXi39XtV6MOWh5R/FHFuDKxg
         kdI4LG4m25bCZ9qbogXUdYKmElaXMkPUbmofvOHZilw0bH8lbiRBvfXZ5QeOdfvPy0Ty
         GIhKeb9P0oz0ZASWiamdYRc4nFzBoUI9XI1PaRxCjBfnyJNzg6PA/lRgkirAsDZqmLyM
         2HBs3/s6Y8nnXJ7egcuexCMqIONOP5YfU3mlryStGq21Q87v5rrtUgcZBzlw447AeS8F
         a3kG40vELCNnUoNTnvKRLhRXWpzzqEeyhtAZF08xEq2fkRnAwwj9Urd9ztZ5sqnbRNOg
         Aymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=sAwYt5NQpt5Uv0pm6Oz71e0kGcRosBnO/XlBs0KKEQA=;
        b=ExfVUp9Nx/h+BGw1MlWGRTwY/frgCvYvec6hGRqHwtM38ipl8CdmHAne4DsV7E3N5b
         yxPqZ/EX4DXgR8niaYflXnm2QjsqrtTfpfWkIIbzWRMZNtf2b3HIdxM6TZlrj+KFlMmn
         8pmChVgveryOg8MGyjrTd+2yyz7cJn/oFDJT6m9ltXIaVhweVTSN3WwvA4JBdc5lY1LT
         Q/taBGUiZOE4Sx+zhanG+Db5U+qIaLxQ+36XGgb8FWlp09bsJmvwpo87z7RmNuPGLMNz
         BEM9dhMob7QsVAvB3v2ktHw+r23wPfBCoElI4BGLqNLatLKoqqAaM3VSJkWGFh6eviJl
         2+Hg==
X-Gm-Message-State: ALoCoQmcUhlT2/4hkpKmHLUZ6GVW8xmYUjGijSR2mZoFmYPv78CDDM4WOthjkOXc/gxftx6lGAsD
X-Received: by 10.107.132.16 with SMTP id g16mr21861225iod.62.1425085323694;
        Fri, 27 Feb 2015 17:02:03 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:700c:d3d2:5834:b5cc])
        by mx.google.com with ESMTPSA id c4sm2281813igt.19.2015.02.27.17.02.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 27 Feb 2015 17:02:03 -0800 (PST)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <1425085318-30537-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264519>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

The only difference from the original protocol client capabilities are
negotiated before initial refs advertisment.

Client capabilities are sent out of band (upload-pack receives it as
the second command line argument). The server sends one pkt-line back
advertising its capabilities.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    v1:
    I am still undecided if the client should then accept/resend
    the capabilities to confirm them, which would make the client the
    ultimate decider which capabilities are used.
   =20
    My gut feeling is to rather let the server make the final decision
    for the capabilities, as it will use some requested capabilities
    already to not send out all the refs.

 Documentation/git-upload-pack.txt | 10 +++++++++-
 upload-pack.c                     | 42 +++++++++++++++++++++++++++----=
--------
 2 files changed, 38 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-uplo=
ad-pack.txt
index 0abc806..ad3a89d 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -9,7 +9,7 @@ git-upload-pack - Send objects packed back to git-fetch=
-pack
 SYNOPSIS
 --------
 [verse]
-'git-upload-pack' [--strict] [--timeout=3D<n>] <directory>
+'git-upload-pack' [--strict] [--timeout=3D<n>] <directory> [<capabilit=
ies>]
=20
 DESCRIPTION
 -----------
@@ -34,6 +34,14 @@ OPTIONS
 <directory>::
 	The repository to sync from.
=20
+capabilities::
+	Historically the capabilities were exchanged inside the protocol of
+	'git-upload-pack' talking to 'git-fetch-pack'. It turned out this was
+	too late as 'git-upload-pack' already did work, which may have been
+	avoided. This allows to pass in the capabilities the client wants to
+	use as one argument. The capabilites are separated by space.
+	See technical/protocol-capabilities.txt (TODO: how to make it a link?=
)
+
 SEE ALSO
 --------
 linkgit:gitnamespaces[7]
diff --git a/upload-pack.c b/upload-pack.c
index d9230ba..2e62c3f 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -31,6 +31,11 @@ static const char upload_pack_usage[] =3D "git uploa=
d-pack [--strict] [--timeout=3D<
=20
 static unsigned long oldest_have;
=20
+/**
+ * client capabilities presented as program arguments, dissallow furth=
er
+ * capabilities sent by client
+ */
+static int capabilities_first;
 static int multi_ack;
 static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
@@ -597,11 +602,14 @@ static void receive_needs(void)
 			die("git upload-pack: protocol error, "
 			    "expected to get sha, not '%s'", line);
=20
-		if (first_want) {
-			parse_features(line + 45);
-			first_want =3D 0;
-		} else if (line[45])
-			die("garbage at the end of 'want' line %s", line + 45);
+		if (!capabilities_first) {
+			if (first_want) {
+				parse_features(line + 45);
+				first_want =3D 0;
+			} else if (line[45]) {
+				die("garbage at the end of 'want' line %s", line + 45);
+			}
+		}
=20
 		o =3D parse_object(sha1_buf);
 		if (!o)
@@ -840,17 +848,25 @@ int main(int argc, char **argv)
 		}
 	}
=20
-	if (i !=3D argc-1)
-		usage(upload_pack_usage);
+	switch (argc - i) {
+		case 2:
+			capabilities_first =3D 1;
+			parse_features(argv[i + 1]);
+			/* fall through*/
+		case 1:
+			setup_path();
=20
-	setup_path();
+			dir =3D argv[i];
=20
-	dir =3D argv[i];
+			if (!enter_repo(dir, strict))
+				die("'%s' does not appear to be a git repository", dir);
=20
-	if (!enter_repo(dir, strict))
-		die("'%s' does not appear to be a git repository", dir);
+			git_config(upload_pack_config, NULL);
+			upload_pack();
+			break;
+		default:
+			usage(upload_pack_usage);
+	}
=20
-	git_config(upload_pack_config, NULL);
-	upload_pack();
 	return 0;
 }
--=20
2.3.0.81.gc37f363

From: Michael Heemskerk <mheemskerk@atlassian.com>
Subject: [PATCH v2] upload-pack: ignore 'shallow' lines with unknown obj-ids
Date: Fri,  3 May 2013 00:56:07 +1000
Message-ID: <1367506567-36828-1-git-send-email-mheemskerk@atlassian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Heemskerk <mheemskerk@atlassian.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 02 16:57:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXuwQ-0005MG-Jb
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 16:57:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756652Ab3EBO46 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 May 2013 10:56:58 -0400
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:50513 "HELO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751834Ab3EBO45 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 May 2013 10:56:57 -0400
Received: from mail-pb0-f72.google.com ([209.85.160.72]) (using TLSv1) by na3sys009aob118.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUYJ+rO2iEPifTfnzfl/zP6hrNzxEL3tW@postini.com; Thu, 02 May 2013 07:56:57 PDT
Received: by mail-pb0-f72.google.com with SMTP id mc17so743961pbc.3
        for <git@vger.kernel.org>; Thu, 02 May 2013 07:56:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:x-received:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=GX5aKhK4KB1GYwepYtgM6FEGPpLd6gAnDon5y+dE7es=;
        b=SLhEeCX60SbHfk1/TfqR9xfzNguv3UjBOpGpDqgIFjtCQd2c3Pi3WT3VGfzzM1hFUl
         1RDKvky0GoSDOFoc/9tGVVFm7o9tRO6GEzd9e/JFq6M6+pXti2hZtieNfJLy+dW1rtV5
         JR8KfLph1Oo4zcn0wcz40dxy/2NhNDz3V87mJXLjtFSLHol0m2xNAOFpOKZwJSg3U/Ve
         6kY4+svdZke/uQbOJPK5YjzHC16dmgVS/De+108vfNFGmKR33Yy0xJEPrzYtu9HAlZTw
         K1jVb8rnZ1bLNKspR3XdK9csyyblXFakLDi8e97WHVVPUFSATOzxQsP5V0Xj2ke04sy/
         G2Yg==
X-Received: by 10.66.178.5 with SMTP id cu5mr10429993pac.16.1367506594108;
        Thu, 02 May 2013 07:56:34 -0700 (PDT)
X-Received: by 10.66.178.5 with SMTP id cu5mr10429986pac.16.1367506594051;
        Thu, 02 May 2013 07:56:34 -0700 (PDT)
Received: from ogre.local.com (124-171-48-129.dyn.iinet.net.au. [124.171.48.129])
        by mx.google.com with ESMTPSA id aa8sm8577229pad.14.2013.05.02.07.56.30
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 07:56:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.0.2
X-Gm-Message-State: ALoCoQmSasaW0TTaotHydmLkhJXlRTG/3KpnU8A9rMnWPVZ39711FqQ5VlVNUou/xyc0aQxuyDBuc2G8/p5gXDsnrzxQVyv7Uuoqv8dJIdyYsp2CW1l7UEHF+CP8+azbxFKyKlJnMuXq0iZGMljjqnb6bLZUklmofA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223210>

When the client sends a 'shallow' line for an object that the server do=
es
not have, the server currently dies with the error: "did not find objec=
t
for shallow <obj-id>".  The client may have truncated the history at
the commit by fetching shallowly from a different server, or the commit
may have been garbage collected by the server. In either case, this
unknown commit is not relevant for calculating the pack that is to be
sent and can be safely ignored, and it is not used when recomputing whe=
re
the updated history of the client is cauterised.

The documentation in technical/pack-protocol.txt has been updated to
remove the restriction that "Clients MUST NOT mention an obj-id which i=
t
does not know exists on the server". This requirement is not realistic
because clients cannot know whether an object has been garbage collecte=
d
by the server.

Signed-off-by: Michael Heemskerk <mheemskerk@atlassian.com>
Reviewed-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/pack-protocol.txt |  3 +--
 t/t5500-fetch-pack.sh                     | 13 +++++++++++++
 upload-pack.c                             |  2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/=
technical/pack-protocol.txt
index f1a51ed..b898e97 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -228,8 +228,7 @@ obtained through ref discovery.
 The client MUST write all obj-ids which it only has shallow copies
 of (meaning that it does not have the parents of a commit) as
 'shallow' lines so that the server is aware of the limitations of
-the client's history. Clients MUST NOT mention an obj-id which
-it does not know exists on the server.
+the client's history.
=20
 The client now sends the maximum commit history depth it wants for
 this transaction, which is the number of commits it wants from the
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index d574085..3f0ca10 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -373,6 +373,19 @@ test_expect_success 'clone shallow with packed ref=
s' '
 	test_cmp count8.expected count8.actual
 '
=20
+test_expect_success 'fetch in shallow repo unreachable shallow objects=
' '
+	(
+		git clone --bare --branch B --single-branch "file://$(pwd)/." no-ref=
log &&
+		git clone --depth 1 "file://$(pwd)/no-reflog" shallow9 &&
+		cd no-reflog &&
+		git tag -d TAGB1 TAGB2 &&
+		git update-ref refs/heads/B B~~ &&
+		git gc --prune=3Dnow &&
+		cd ../shallow9 &&
+		git fetch origin
+	)
+'
+
 test_expect_success 'setup tests for the --stdin parameter' '
 	for head in C D E F
 	do
diff --git a/upload-pack.c b/upload-pack.c
index bfa6279..127e59a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -592,7 +592,7 @@ static void receive_needs(void)
 				die("invalid shallow line: %s", line);
 			object =3D parse_object(sha1);
 			if (!object)
-				die("did not find object for %s", line);
+				continue;
 			if (object->type !=3D OBJ_COMMIT)
 				die("invalid shallow object %s", sha1_to_hex(sha1));
 			if (!(object->flags & CLIENT_SHALLOW)) {
--=20
1.8.0.2

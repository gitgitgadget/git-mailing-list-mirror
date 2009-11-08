From: =?UTF-8?B?QmrDtnJuIEd1c3RhdnNzb24=?= <bgustavsson@gmail.com>
Subject: [RFC/PATCH 2/4] Teach the --multiple option to 'git fetch'
Date: Sun, 08 Nov 2009 16:46:38 +0100
Message-ID: <4AF6E7DE.1020201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 08 16:46:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N79yd-0002WL-LM
	for gcvg-git-2@lo.gmane.org; Sun, 08 Nov 2009 16:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbZKHPqh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Nov 2009 10:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753025AbZKHPqg
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Nov 2009 10:46:36 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:36134 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbZKHPqf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2009 10:46:35 -0500
Received: by ewy3 with SMTP id 3so2430012ewy.37
        for <git@vger.kernel.org>; Sun, 08 Nov 2009 07:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=jnbu9JlFofZn6jEU3PmmmiIm/qviK0/InSLa8/IM6fY=;
        b=ghOGqkjDYuoK+zVxxcvLwpxcc6altQnrDo+129srjgOjSx4QsGbfGFHmLH1gWNWeNO
         bb2Iw2a2d+LMT2Y4XYsaF4LtH/whBmbzNTO4ucxPlg6iFG9cx1DKTUXyrx7tWRRomFyc
         aBF6A6WuLw4KSfre9U91sG8l0Chum1OiEifo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=jcRjaKNuSoQ6DBZORq31zSuopEZcahiz3IIkzoqbto8l/KlXEQJkIP1yk76xc7+8OD
         XZd7KIDHNmla6X3gJtQUWdADyX3vcMqMboY8719+OYgtHHiNSqT//l4G2iQTVqzp38kM
         cBUv+JtNiIDPoekijw0agZFj5eTDak2Rsf2Ho=
Received: by 10.213.0.135 with SMTP id 7mr2020445ebb.64.1257695200004;
        Sun, 08 Nov 2009 07:46:40 -0800 (PST)
Received: from ?10.0.1.10? (81-234-150-173-no94.tbcn.telia.com [81.234.150.173])
        by mx.google.com with ESMTPS id 23sm3816719eya.44.2009.11.08.07.46.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Nov 2009 07:46:39 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Macintosh/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132405>

Add the --multiple option to specify that all arguments are either
groups or remotes. The primary reason for adding this option is
to allow us to re-implement 'git remote update' using fetch.

Signed-off-by: Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>
---
 builtin-fetch.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/builtin-fetch.c b/builtin-fetch.c
index a520c1b..7926658 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -24,7 +24,7 @@ enum {
 	TAGS_SET =3D 2
 };
=20
-static int all, append, force, keep, update_head_ok, verbosity;
+static int all, append, force, keep, multiple, update_head_ok, verbosi=
ty;
 static int tags =3D TAGS_DEFAULT;
 static const char *depth;
 static const char *upload_pack;
@@ -41,6 +41,8 @@ static struct option builtin_fetch_options[] =3D {
 		   "path to upload pack on remote end"),
 	OPT_BOOLEAN('f', "force", &force,
 		    "force overwrite of local branch"),
+	OPT_BOOLEAN('m', "multiple", &multiple,
+		    "fetch from multiple remotes"),
 	OPT_SET_INT('t', "tags", &tags,
 		    "fetch all tags and associated objects", TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
@@ -838,6 +840,12 @@ int cmd_fetch(int argc, const char **argv, const c=
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
--=20
1.6.5.1.69.g36942

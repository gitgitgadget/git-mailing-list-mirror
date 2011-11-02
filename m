From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] branch -m: handle no arg properly
Date: Thu, 3 Nov 2011 00:17:12 +0800
Message-ID: <20111103001712.000024b9@unknown>
References: <4EB153B4.6070404@atlas-elektronik.com>
 <1320246098-6912-1-git-send-email-rctay89@gmail.com>
 <4EB15D20.1060107@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"Junio C. Hamano" <gitster@pobox.com>
To: Stefan =?ISO-8859-1?Q?N=E4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Wed Nov 02 17:17:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLdVH-0007r2-9v
	for gcvg-git-2@lo.gmane.org; Wed, 02 Nov 2011 17:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932431Ab1KBQRW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Nov 2011 12:17:22 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:37114 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369Ab1KBQRW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Nov 2011 12:17:22 -0400
Received: by ggnb2 with SMTP id b2so294165ggn.19
        for <git@vger.kernel.org>; Wed, 02 Nov 2011 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=kGAEFyfBjMHUM3tJPvOwo4CHpnIMco86Q3iStionjI4=;
        b=QPY0wtMQKyes0aWZbrS6CxMVfjq1DbfeqWyYUgFBuO4a6ggkmq5uHdbQQv9wDaXhOr
         WZnle251TunccDlc/mNCtM5rF+ex/N//vEpbEEX/t+M6C5PqpRM0jn00hG3BIzncaIal
         oEMIi/6I2xD/eHsCweUsMooSHBe15e8jspRzU=
Received: by 10.150.72.26 with SMTP id u26mr6185719yba.62.1320250641537;
        Wed, 02 Nov 2011 09:17:21 -0700 (PDT)
Received: from unknown (nusnet-207-177.dynip.nus.edu.sg. [137.132.207.177])
        by mx.google.com with ESMTPS id a31sm8495277ana.17.2011.11.02.09.17.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Nov 2011 09:17:19 -0700 (PDT)
In-Reply-To: <4EB15D20.1060107@atlas-elektronik.com>
X-Mailer: Claws Mail 3.7.8cvs47 (GTK+ 2.16.6; i586-pc-mingw32msvc)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184638>

On Wed, 02 Nov 2011 16:09:20 +0100
Stefan N=E4we <stefan.naewe@atlas-elektronik.com> wrote:

> Am 02.11.2011 16:01, schrieb Tay Ray Chuan:
> > Modify the option parsing heuristic to handle all -m (rename) cases=
,
> > including the no-arg case. Previously, this "fell through" to the a=
rgc
> > <=3D 2 case.
> >=20
> > Add a regression test in t3200-branch.sh while we're at it.
>=20
> Great. I just sent a patch for t3200 as well...

Hmm, yeah, printing usage is a good idea.

Popped my change to t3200 as well, yours looks better. :)

-->8--

Subject: [PATCH] branch -m: handle no arg properly

Modify the option parsing heuristic to handle all -m (rename) cases,
including the no-arg case. Previously, this "fell through" to the argc
<=3D 2 case.

Reported-by: Stefan N=E4we <stefan.naewe@atlas-elektronik.com>
Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 builtin/branch.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 009b713..51ca6a0 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -719,11 +719,14 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
 	else if (list)
 		return print_ref_list(kinds, detached, verbose, abbrev,
 				      with_commit, argv);
-	else if (rename && (argc =3D=3D 1))
-		rename_branch(head, argv[0], rename > 1);
-	else if (rename && (argc =3D=3D 2))
-		rename_branch(argv[0], argv[1], rename > 1);
-	else if (argc <=3D 2) {
+	else if (rename) {
+		if (argc =3D=3D 1)
+			rename_branch(head, argv[0], rename > 1);
+		else if (argc =3D=3D 2)
+			rename_branch(argv[0], argv[1], rename > 1);
+		else
+			usage_with_options(builtin_branch_usage, options);
+	} else if (argc <=3D 2) {
 		if (kinds !=3D REF_LOCAL_BRANCH)
 			die(_("-a and -r options to 'git branch' do not make sense with a b=
ranch name"));
 		create_branch(head, argv[0], (argc =3D=3D 2) ? argv[1] : head,
--=20
1.7.7.1.599.g03eec



--
Cheers,
Ray Chuan

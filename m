From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 0/5] Revamping "git status"
Date: Wed, 5 Aug 2009 19:37:34 +0200
Message-ID: <200908051937.36255.trast@student.ethz.ch>
References: <1249463746-21538-1-git-send-email-gitster@pobox.com> <200908051149.40980.trast@student.ethz.ch> <7vbpmub3la.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 19:37:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYkR4-0000EY-Ks
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 19:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbZHERhu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 13:37:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750933AbZHERhu
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 13:37:50 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:50142 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750786AbZHERht convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 13:37:49 -0400
Received: from CAS02.d.ethz.ch (129.132.178.236) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 5 Aug
 2009 19:37:48 +0200
Received: from thomas.localnet (84.74.103.245) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.1.375.2; Wed, 5 Aug
 2009 19:37:48 +0200
User-Agent: KMail/1.12.0 (Linux/2.6.27.25-0.1-default; KDE/4.2.98; x86_64; ; )
In-Reply-To: <7vbpmub3la.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124929>

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
>=20
> > I also tried finding out which exact commit was causing this, but 4=
/5
> > still segfaults and 1-3 don't even compile:
> >
> >   builtin-commit.c: In function =E2=80=98show_unmerged=E2=80=99:   =
                              =20
> >   builtin-commit.c:827: error: dereferencing pointer to incomplete =
type          =20
> >   builtin-commit.c: In function =E2=80=98show_status=E2=80=99:     =
                              =20
> >   builtin-commit.c:854: error: dereferencing pointer to incomplete =
type
> >   [etc]
> >
> > These are referring to use of a 'struct wt_status_change_data *', b=
ut
> > the struct declaration is only in 4/5.  Am I missing something?
>=20
> I suspect you have a botched patch application.

You're right, sorry.  I indeed had the patches applied in the wrong
order (through a pilot error with KMail), resulting in 5/5 being first
in the topic.  So it is no wonder the intermediate states never
compiled.

> I've applied what came back on the list on top of 07a4a3b (Fix typos =
on
> pt_BR/gittutorial.txt translation, 2009-07-31) and all five states co=
mpile
> just fine.
>=20
>     $ git rev-list 07a4a3b.. |
>       while read sha1
>       do
>             git rev-parse $sha1^{tree}
>       done
>     86363b25b84041cf14110dcc3136f56915778f71
>     4625f5bbc43e1158d00aca8b2356047606c0babd
>     895698143b2c29af8bfe0cdf6c3f57de3bf080d8
>     3c565041ba6e432ff9064a1d8302f49ef33c2605
>     c0c2b9c2a55e3df9cce448d59e5d557d07d78a4b

I did exactly that, and our trees now agree.  However, I'm still
seeing a crash with this test:

-- 8< --
diff --git i/t/t7060-wtstatus.sh w/t/t7060-wtstatus.sh
index 5ad2cd1..2cc0833 100755
--- i/t/t7060-wtstatus.sh
+++ w/t/t7060-wtstatus.sh
@@ -28,4 +28,17 @@ test_expect_success 'Report new path with conflict' =
'
 	test_cmp expect actual
 '
=20
+test_expect_failure 'M/D conflict does not segfault' '
+	mkdir mdconflict &&
+	cd mdconflict &&
+	git init &&
+	test_commit initial foo '' &&
+	test_commit modify foo foo &&
+	git checkout -b side HEAD^ &&
+	git rm foo &&
+	git commit -m delete &&
+	git merge master &&
+	git status
+'
+
 test_done
-- >8 --

--=20
Thomas Rast
trast@{inf,student}.ethz.ch

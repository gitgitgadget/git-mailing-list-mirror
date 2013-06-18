From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: send-email adds redundant From: lines to message body
Date: Tue, 18 Jun 2013 15:36:53 +0300
Message-ID: <20130618123653.GE26857@redhat.com>
References: <20130618110904.GA20052@goldbirke>
 <20130618114207.GD26857@redhat.com>
 <20130618114800.GB20052@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Jun 18 14:36:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uov9A-0001tN-DG
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 14:36:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250Ab3FRMgY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jun 2013 08:36:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15271 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932121Ab3FRMgW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 08:36:22 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r5ICa6Nv014132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 18 Jun 2013 08:36:06 -0400
Received: from redhat.com (vpn1-5-182.ams2.redhat.com [10.36.5.182])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r5ICa48C030548;
	Tue, 18 Jun 2013 08:36:05 -0400
Content-Disposition: inline
In-Reply-To: <20130618114800.GB20052@goldbirke>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228222>

On Tue, Jun 18, 2013 at 01:48:00PM +0200, SZEDER G=E1bor wrote:
> On Tue, Jun 18, 2013 at 02:42:07PM +0300, Michael S. Tsirkin wrote:
> > On Tue, Jun 18, 2013 at 01:09:04PM +0200, SZEDER G=E1bor wrote:
> > > Hi,
> > >=20
> > > 'git send-email' recently started to add redundant From: lines to=
 my
> > > messages, see e.g.
> > >=20
> > >   http://article.gmane.org/gmane.comp.version-control.git/228132
> >=20
> > Can you please show what do commits point to?
> > E.g. push to some public tree?
>=20
> Sure.
>=20
>   https://github.com/szeder/git.git bash-prompt-speedup

I see. The From line looks like this:
	From: =3D?UTF-8?q?SZEDER=3D20G=3DC3=3DA1bor?=3D <szeder@ira.uka.de>
which is why it didn't match.

I added a test like this and sure enough, it fails.
Will look into a fix now.

--->
send-email: add test for duplicate utf8 name

Verify that author name is not duplicated if it matches
sender, even if it is in utf8.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 9f46f22..cef884f 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -956,6 +956,19 @@ test_expect_success $PREREQ 'utf8 author is correc=
tly passed on' '
 	grep "^From: F=FC=F1n=FD N=E2m=E9 <odd_?=3Dmail@example.com>" msgtxt1
 '
=20
+test_expect_success $PREREQ 'utf8 sender is not duplicated' '
+	clean_fake_sendmail &&
+	test_commit weird_sender &&
+	test_when_finished "git reset --hard HEAD^" &&
+	git commit --amend --author "F=FC=F1n=FD N=E2m=E9 <odd_?=3Dmail@examp=
le.com>" &&
+	git format-patch --stdout -1 >funny_name.patch &&
+	git send-email --from=3D"F=FC=F1n=FD N=E2m=E9 <odd_?=3Dmail@example.c=
om>" \
+	  --to=3Dnobody@example.com \
+	  --smtp-server=3D"$(pwd)/fake.sendmail" \
+	  funny_name.patch &&
+	test `grep "^From:" msgtxt1|wc -l` -eq 1
+'
+
 test_expect_success $PREREQ 'sendemail.composeencoding works' '
 	clean_fake_sendmail &&
 	git config sendemail.composeencoding iso-8859-1 &&

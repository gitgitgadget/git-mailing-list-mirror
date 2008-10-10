From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: [PATCH] git-status: Detect copies as well as renames
Date: Fri, 10 Oct 2008 18:08:04 +0200
Message-ID: <20081010160804.GA24515@atjola.homenet>
References: <7vabdcmp4n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Michael P. Soulier" <msoulier@digitaltorque.ca>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 10 18:11:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoKYT-0005xH-3T
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 18:09:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753809AbYJJQIL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Oct 2008 12:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753097AbYJJQIK
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 12:08:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:53675 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753121AbYJJQIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 12:08:09 -0400
Received: (qmail invoked by alias); 10 Oct 2008 16:08:06 -0000
Received: from i577B8FB1.versanet.de (EHLO atjola.local) [87.123.143.177]
  by mail.gmx.net (mp012) with SMTP; 10 Oct 2008 18:08:06 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18bfo1DfRMbkmjwC/2LWUbACFQ3C3Bmt75QFbjnJ2
	10eQxXDEI5UrXp
Content-Disposition: inline
In-Reply-To: <7vabdcmp4n.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.46
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97945>

Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
---
On 2008.10.10 08:44:08 -0700, Junio C Hamano wrote:
> "Michael P. Soulier" <msoulier@digitaltorque.ca> writes:
>=20
> > #       renamed:    templates/scrc/index.html -> templates/scrc/cre=
s_taps.html
> > #       modified:   templates/scrc/index.html
> >
> > Looking at the last two lines here, there is obviously an issue.
>=20
> I am puzzled.
>=20
> Looking at wt-status.c "renamed: A -> B" will be shown only when A an=
d
> B are similar enough *and* there is no A remaining in the final
> result, and in such a case, "modified: A" should not be shown.
> Because git does not care how you created B (IOW, it does not matter
> if B was typed from scratch with copying and pasting, or created by
> copying and editing), the "renamed: A -> B" entry itself is not
> surprising nor look like a bug at all, but its presense at the same
> time as "modified: A" does feel very fishy.

Maybe something like this is required? The "1" meant that only renames
were to be detected, so I'm quite puzzled why it detects copies in some
cases at all. At least some trivial:

cp Makefile Makefile2
echo 123 >> Makefile
git add Makefile*

Now correctly shows the Makefile2 being a copy of Makefile, while the
old behaviour was to simply show it as a new file. _BUT_ when you also
did:

git mv Makefile Makefile3

You see a rename of Makefile and a copy of Makefile. Even though we
didn't request copy detection... Hu?

I feel like stabbing in the dark though, so I intentionally left out a
description in the commit message that tells why this change is good. I
simply have no idea, it just _felt_ better. ;-)

Bj=F6rn

 wt-status.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 889e50f..3d645b9 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -210,7 +210,7 @@ static void wt_status_print_updated(struct wt_statu=
s *s)
 	rev.diffopt.output_format |=3D DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback =3D wt_status_print_updated_cb;
 	rev.diffopt.format_callback_data =3D s;
-	rev.diffopt.detect_rename =3D 1;
+	rev.diffopt.detect_rename =3D DIFF_DETECT_COPY;
 	rev.diffopt.rename_limit =3D 200;
 	rev.diffopt.break_opt =3D 0;
 	run_diff_index(&rev, 1);
@@ -310,7 +310,7 @@ static void wt_status_print_verbose(struct wt_statu=
s *s)
 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev, s->reference);
 	rev.diffopt.output_format |=3D DIFF_FORMAT_PATCH;
-	rev.diffopt.detect_rename =3D 1;
+	rev.diffopt.detect_rename =3D DIFF_DETECT_COPY;
 	rev.diffopt.file =3D s->fp;
 	rev.diffopt.close_file =3D 0;
 	run_diff_index(&rev, 1);
--=20
1.6.0.2.307.gc427.dirty

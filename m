From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v6 15/16] remote-svn: add marks-file regeneration
Date: Sat, 25 Aug 2012 20:55:05 +0200
Message-ID: <002401cd82f3$24a465f0$6ded31d0$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <ramsay@ramsay1.demon.co.uk>,
	"Junio C Hamano" <gitster@pobox.com>
To: <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 20:56:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T5LWk-0006lw-AX
	for gcvg-git-2@plane.gmane.org; Sat, 25 Aug 2012 20:56:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756954Ab2HYSzV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Aug 2012 14:55:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:51704 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756862Ab2HYSzT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2012 14:55:19 -0400
Received: from DualCore (dsdf-4d0a03be.pool.mediaWays.net [77.10.3.190])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0McWDw-1TN0vF2lVI-00Hgzi; Sat, 25 Aug 2012 20:55:18 +0200
X-Mailer: Microsoft Outlook 14.0
Thread-Index: Ac2C2gLvAb1n8HILTy6eFwlSeL6x8AAGKhDw
Content-Language: de
X-Provags-ID: V02:K0:G2+Yn6jOcRHHSPLQfJwrlkWGQM2AcSFx+psn/97PBE/
 snMR01l941BmYwvl3vCBEKiQ+sI3vGA/FQl7ZWdCtJr+51j037
 6ZPgW34YMxf7SUCrn9YK7Q5ZF6TZnzprR9TRjYl5R3Y3yfOM0z
 h32NWUPOxK62gJcL7H9lowUDR1Cb/rX02KkJqQDgp4vFEcBZv3
 7V9Gv2xOpjSIOCio3QhP+NKdsG6E09mNR5xUHXC6C4/Za7Gud3
 qI4wTyxhpJsiZDjekFglI7JuKyoS+MMrwGkQ5GUUBL8uUFiuHi
 48RNLeVFoNkwURn/DRGWv+huYVP4dpXzv0/mq/w1/Jw8T4RJsV
 neWpRQElNSBHE1B4B4Sb7FEsffgiTP1QLzqdVEXZC29w1eKXyz
 fDwYg5nrFonNw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204280>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Saturday, August 25, 2012 5:55 PM
> To: 'florian.achleitner.2.6.31@gmail.com'
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH v6 15/16] remote-svn: add marks-file regeneration
> 
> "Florian Achleitner" <florian.achleitner.2.6.31@gmail.com> schrieb im Newsbeitrag news:<1345662961-9587-16-git-send-email-
> florian.achleitner.2.6.31@gmail.com>...
> > fast-import mark files are stored outside the object database and are
> > therefore not fetched and can be lost somehow else.  marks provide a
> > svn revision --> git sha1 mapping, while the notes that are attached
> > to each commit when it is imported provide a git sha1 --> svn revision
> > mapping.
> >
> > If the marks file is not available or not plausible, regenerate it by
> > walking through the notes tree.  , i.e.  The plausibility check tests
> > if the highest revision in the marks file matches the revision of the
> > top ref. It doesn't ensure that the mark file is completely correct.
> > This could only be done with an effort equal to unconditional
> > regeneration.
> >
> > Signed-off-by: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  remote-testsvn.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 68 insertions(+)
> >
> > diff --git a/remote-testsvn.c b/remote-testsvn.c
> > index e90d221..09dc304 100644
> > --- a/remote-testsvn.c
> > +++ b/remote-testsvn.c
> ...
> > +static void check_or_regenerate_marks(int latestrev) {
> > +	FILE *marksfile;
> > +	char *line = NULL;
> > +	size_t linelen = 0;
> > +	struct strbuf sb = STRBUF_INIT;
> > +	int found = 0;
> > +
> > +	if (latestrev < 1)
> > +		return;
> > +
> > +	init_notes(NULL, notes_ref, NULL, 0);
> > +	marksfile = fopen(marksfilename, "r");
> > +	if (!marksfile) {
> > +		regenerate_marks();
> > +		marksfile = fopen(marksfilename, "r");
> > +		if (!marksfile)
> > +			die_errno("cannot read marks file %s!", marksfilename);
> > +		fclose(marksfile);
> > +	} else {
> > +		strbuf_addf(&sb, ":%d ", latestrev);
> > +		while (getline(&line, &linelen, marksfile) != -1) {
> 
> getline() is not available to anybody, e.g. it is not in HP NonStop.

I'd like to confirm that Ramsey's patch works for me too, so I second his request.
(Subject: [PATCH 1/3] remote-testsvn.c: Avoid the getline() GNU extension function)

Bye, Jojo

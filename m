From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: fix quoting TRIED revs when "bad" commit is also "skip"ped
Date: Fri, 27 Feb 2009 07:30:55 +0100
Message-ID: <200902270730.56998.chriscool@tuxfamily.org>
References: <20090226082918.6adbc565.chriscool@tuxfamily.org> <7v63ixwpnm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 07:33:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcwHz-0002zL-6T
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 07:33:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753576AbZB0Gbu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2009 01:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753456AbZB0Gbu
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 01:31:50 -0500
Received: from smtp1-g21.free.fr ([212.27.42.1]:45376 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbZB0Gbt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 01:31:49 -0500
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 4026094000A;
	Fri, 27 Feb 2009 07:31:40 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 4DDDF940055;
	Fri, 27 Feb 2009 07:31:37 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7v63ixwpnm.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111633>

Le jeudi 26 f=E9vrier 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Before this patch, when the "bad" commit was also "skip"ped and
> > when more than one commit was skipped, the "filter_skipped" functio=
n
> > would have printed something like:
>
> Everybody knows that the problem description that comes at the beginn=
ing
> of the commit log message talks about the state of the code before th=
e
> patch is applied.
>
> Try reading the first sentence without "Before this patch, ".  It sti=
ll
> makes perfect sense and more importantly, it is much more readable.

Ok, I will drop that.

> > bisect_rev=3D<hash1>|<hash2>
> >
> > (where <hash1> and <hash2> are hexadecimal sha1 hashes)
> >
> > and this would have been evaled later as piping "bisect_rev=3D<hash=
1>"
> > into "<hash2>", which would have failed.
>
> I am a bit worried why this "would have failed" was not noticed.

Perhaps because people do not often use "skip" and "bad" on the same co=
mmit.
There is an eval error printed on STDERR when this happens.

> > So this patch makes the "filter_skipped" function properly quote
> > what it outputs, so that it will print something like:
> >
> > bisect_rev=3D"<hash1>|<hash2>"
> >
> > which will be properly evaled later.
> >
> > A test case is added to the test suite.
>
> Thanks.  Fixes before the 1.6.2 release are very much welcomed.
>
> > And while at it, we also remove a spurious space where the
> > "exit_if_skipped_commits" function is defined.
>
> Looking at:
>
> $ git grep '^[a-z_A-Z][a-z_A-Z0-9]* *() *{' -- '*.sh' |
>   sed -e 's/^[^ (]*/X/' | sort | uniq -c
>
> and then doing the same for only git-bisect.sh, i.e.
>
> $ git grep '^[a-z_A-Z][a-z_A-Z0-9]* *() *{' -- 'git-bisect.sh' |
>   sed -e 's/^[^ (]*/X/' | sort | uniq -c
>
> you will notice that git-bisect is an odd-man out that uses 3 "func (=
) {"
> and 13 "func() {".  Majority of functions have one SP after the funct=
ion
> name.
>
> If we were to standardize on one style, we should consistently have S=
P
> there.

Ok, I dropped the related change in the series I will send just after t=
his=20
email.

> > diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain=
=2Esh
> > index dd7eac8..b5da16f 100755
> > --- a/t/t6030-bisect-porcelain.sh
> > +++ b/t/t6030-bisect-porcelain.sh
> > @@ -224,6 +224,31 @@ test_expect_success 'bisect skip: cannot tell
> > between 2 commits' ' fi
> >  '
> >
> > +# $HASH1 is good, $HASH4 is both skipped and bad, we skip $HASH3
> > +# and $HASH2 is good,
> > +# so we should not be able to tell the first bad commit
> > +# among $HASH3 and $HASH4
> > +test_expect_success 'bisect skip: with commit both bad and skipped=
' '
> > +	git bisect start &&
> > +	git bisect skip &&
> > +	git bisect bad &&
> > +	git bisect good $HASH1 &&
> > +	git bisect skip &&
> > +	if git bisect good > my_bisect_log.txt
>
> An unpatched "git-bisect" seems to say "32a594a3 was both good and ba=
d"
> in its my_bisect_log.txt .

Yes, but there is also an error printed on STDERR.

> This makes me suspect that we are forgetting=20
> to check return status after we eval the output from filter_skipped
> function. Shouldn't the function should string its commands together =
with
> "&&" to protect it from a breakage like this?

Right, that would be an improvement. I put it in another patch though,=20
because it is not really needed to fix a breakage.

> Also, VARS, FOUND and TRIED are not initialized anywhere.  We should
> protect ourselves from environment variables the user may have with t=
hese
> names before starting bisect to break the logic of this code.

Yeah I noticed that, I put that change in the first patch.

> Back to the test script.
>
> > +		grep "first bad commit could be any of" my_bisect_log.txt &&
> > +		test_must_fail grep $HASH1 my_bisect_log.txt &&
> > +		test_must_fail grep $HASH2 my_bisect_log.txt &&
>
> These two are easier to read with ! not test_must_fail; we do not exp=
ect
> grep to be buggy and dump core ;-)

Ok, there is now "!" in the first patch.

> So perhaps the big loop should be better written like this...

Yeah, it will look more or less like that.

Thanks,
Christian.

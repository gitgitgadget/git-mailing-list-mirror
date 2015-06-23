From: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Subject: Re: [PATCHv6 1/3] git-rebase -i: add command "drop" to remove a
 commit
Date: Tue, 23 Jun 2015 22:08:30 +0200 (CEST)
Message-ID: <122907552.733385.1435090110363.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <1435009369-11496-1-git-send-email-remi.galan-alfonso@ensimag.grenoble-inp.fr> <xmqqwpyucjj1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 22:06:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7USv-0003Gv-8H
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 22:06:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933207AbbFWUGh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Jun 2015 16:06:37 -0400
Received: from zm-etu-ensimag-2.grenet.fr ([130.190.244.118]:33386 "EHLO
	zm-etu-ensimag-2.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932648AbbFWUGg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 16:06:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 4A3612838;
	Tue, 23 Jun 2015 22:06:34 +0200 (CEST)
Received: from zm-smtpout-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id poJc4vXVkxDi; Tue, 23 Jun 2015 22:06:34 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-2.grenet.fr (Postfix) with ESMTP id 340B22826;
	Tue, 23 Jun 2015 22:06:34 +0200 (CEST)
In-Reply-To: <xmqqwpyucjj1.fsf@gitster.dls.corp.google.com>
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF38 (Linux)/8.0.9_GA_6191)
Thread-Topic: git-rebase -i: add command "drop" to remove a commit
Thread-Index: UtP/zwUB/bihNsAXeOlfZGOuOJ6VrA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272491>

Junio C Hamano <gitster@pobox.com> writes:
> > Galan R=C3=A9mi  <remi.galan-alfonso@ensimag.grenoble-inp.fr> write=
s:
> >=20
> > > +test_rebase_end () {
> > > +        test_when_finished "git checkout master &&
> > > +        git branch -D $1 &&
> >=20
> > Is this one guaranteed to succeed?  Do we want to consider it a
> > failure to remove "$1" (e.g. dropTest)?
> >=20
> >     $ git branch -D no-such-branch ; echo $?
> >     error: branch 'no-such-branch' not found.
> >     1
> >=20
> > If dropTest branch did not exist before the test that begins with
> > a call to this function, what happens?
>=20

Since the function is
> 	test_when_finished "git checkout master &&
> 		git branch -D $1 &&
> 		test_might_fail git rebase --abort" &&
> 	git checkout -b $1 master
If $1 doesn't exist, then it means that 'git checkout -b $1 master'
failed, thus the test would fail before reaching the part in
'test_when_finished'.
However I guess there are more reasons that could cause 'git branch -D
$1' to fail so I'll add a 'test_might_fail' in front of it.

> Besides, a function that must be called at the beginning of a test
> piece has a name that ends with _end?  That sounds funny, no?

I see your point but I'm not really sure how to call it, considering
that what it does is creating a branch to test on it, and taking care
of the cleaning at the end of the test.
Maybe something more generic like "setup_and_clean" ?
=20
> > +        test_might_fail git rebase --abort" &&
> > +        git checkout -b $1 master
> > +}
>=20
> I'm wondering if this is not sufficient.
>=20
>         test_rebase_i_drop_prepare () {
>                 git reset --hard &&
>                 git checkout -B "$1" master
>         }
>=20
> I am guessing that you named _end because it has when_finished, but
> as far as I can tell, even after these three patches, the tests do
> not really rely on the fact that it is on 'master' branch.  More
> importantly, just being on 'master' branch is not a sufficient
> cleanliness for the next test (and that is why you added these
> "branch -D" and "might-fail rebase --abort" to this function in the
> first place), it seems.  So...

I removed the branch in case someone used the same name when creating
a branch in a future test. However he would notice it when writing the
test and it's not something that would suddenly break when modifying
the code, so it might not be necessary.
The "might-fail rebase --abort" is there in case this test fails in
the middle (because of a future modification of rebase for example) to
avoid failling all the following tests that use rebase.

The name "test_rebase_i_drop_prepare" wouldn't be accurate since 2/3
and 3/3 uses the function as well and don't really have much to do
with 'drop'.

Thanks,
R=C3=A9mi

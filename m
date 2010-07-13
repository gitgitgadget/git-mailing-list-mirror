From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/2] revert: refactor code that prints success or failure message
Date: Tue, 13 Jul 2010 23:02:58 +0200
Message-ID: <201007132302.59324.chriscool@tuxfamily.org>
References: <20100712115455.12251.53947.chriscool@tuxfamily.org> <20100712163043.GA1531@burratino>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 23:03:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYmdD-0005gv-Mq
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 23:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756056Ab0GMVDF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jul 2010 17:03:05 -0400
Received: from smtp2f.orange.fr ([80.12.242.151]:18436 "EHLO smtp2f.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791Ab0GMVDE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 17:03:04 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id 53FDD80008F5;
	Tue, 13 Jul 2010 23:03:00 +0200 (CEST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id 46DE680009AE;
	Tue, 13 Jul 2010 23:03:00 +0200 (CEST)
Received: from style.localnet (ANantes-156-1-132-89.w90-12.abo.wanadoo.fr [90.12.251.89])
	by mwinf2f14.orange.fr (SMTP Server) with ESMTP id F247E80008F5;
	Tue, 13 Jul 2010 23:02:59 +0200 (CEST)
X-ME-UUID: 20100713210259992.F247E80008F5@mwinf2f14.orange.fr
User-Agent: KMail/1.13.2 (Linux/2.6.32-23-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <20100712163043.GA1531@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150914>

On Monday 12 July 2010 18:30:43 Jonathan Nieder wrote:
> Hi,
>=20
> Christian Couder wrote:
> > This patch refactors the code that prints a message like
> > "Automatic cherry-pick failed. <help message>".
>=20
> From the point of view of refactoring, it does not seem
> so promising: the patch adds more code than it removes.
>=20
>  $ git diff --numstat HEAD^
>  29	22	builtin/revert.c
>  25	 1	t/t3508-cherry-pick-many-commits.sh
>=20
> So I am hoping there is some other reason.

If it makes the code easier to maintain it's still a refactoring even i=
f it=20
adds some lines, but anyway as I say below I will improve the commit me=
ssage.
=20
> > To do that, now do_recursive_merge() returns an int to signal
> > success or failure. And in case of failure we just return 1
> > from do_pick_commit() instead of doing "exit(1)" from either
> > do_recursive_merge() or do_pick_commit().
>=20
> This part sounds like libification...

Yes, but it's just because it's needed for the refactoring.

> > In case of successful merge, do_recursive_merge() used to print
> > something like "Finished one cherry-pick." but nothing was
> > printed in case a special strategy like "resolve" was used.
> > Now in this case a message like "Finished one cherry-pick with
> > strategy resolve." is printed.
> >=20
> > So the command behavior should be more consistent wether we are
> > using a special strategy or not.
>=20
> This part sounds like improving output in the cherry-pick --strategy
> success case.

Yes.

> > 	I also wonder why messages like "Finished one cherry-pick."
> > 	are printed on stderr instead of stdout.
>=20
> Progress reports tend to go to stderr, since they are not what the
> user wanted to learn from the command but side-effects.  In other
> words, I think the general principle is that
>=20
>  $ git <foo> 2>/dev/null
>=20
> should output whatever a traditional Unix command would (usually
> nothing).

Ok.

> > 	And while at making a backward incompatible change, maybe
> > 	we could change the message to something like:
> > =09
> > 	"Finished cherry-pick <sha1>"
>=20
> Does <sha1> represent the old commit or the new one?

The old one.

> I can=E2=80=99t come up with a reason to worry about backward compati=
bility in
> this case.  Messages to stderr from porcelain are not guaranteed to b=
e
> stable.

Ok, so I think I will propose a patch to do that.

> > +++ b/builtin/revert.c
> > @@ -357,14 +356,9 @@ static void do_recursive_merge(struct commit *=
base,
> > struct commit *next,
> >=20
> >  					i++;
> >  		=09
> >  			}
> >  	=09
> >  		}
> >=20
> > -		write_message(msgbuf, defmsg);
> > -		fprintf(stderr, "Automatic %s failed.%s\n",
> > -			me, help_msg());
> > -		rerere(allow_rerere_auto);
> > -		exit(1);
> >=20
> >  	}
> >=20
> > -	write_message(msgbuf, defmsg);
> > -	fprintf(stderr, "Finished one %s.\n", me);
> > +
> > +	return !clean;
> >=20
> >  }
>=20
> The return value is 1 if dirty, 0 if clean.  In any other
> situation (e.g., the index locking or the merge machinery breaks)
> it will still die, so this is not about libification.  Is it
> is for unification with the try_merge_command case?

Yes.

> > @@ -470,30 +466,41 @@ static int do_pick_commit(void)
>=20
> [...]
>=20
> > +	if (res) {
> > +		fprintf(stderr, "Automatic %s failed.%s\n",
> > +			mebuf.buf, help_msg());
> > +		rerere(allow_rerere_auto);
> > +	} else {
> > +		fprintf(stderr, "Finished one %s.\n", mebuf.buf);
> > +	}
> > +
> > +	strbuf_release(&mebuf);
>=20
> Yep, looks like it is.

Right.

> [...]
>=20
> > --- a/t/t3508-cherry-pick-many-commits.sh
> > +++ b/t/t3508-cherry-pick-many-commits.sh
> > @@ -23,12 +23,36 @@ test_expect_success setup '
>=20
> New tests for the success output.
>=20
> >  '
> > =20
> >  test_expect_success 'cherry-pick first..fourth works' '
> >=20
> > +	cat <<-EOF > expected &&
> > +	Finished one cherry-pick.
> > +	Finished one cherry-pick.
> > +	Finished one cherry-pick.
> > +	EOF
> > +
> > +	git checkout -f master &&
> > +	git reset --hard first &&
> > +	test_tick &&
> > +	git cherry-pick first..fourth 2>actual &&
> > +	git diff --quiet other &&
> > +	git diff --quiet HEAD other &&
> > +	test_cmp expected actual &&
>=20
> This breaks test runs with sh -x or GIT_TRACE=3D1 (I am not sure
> whether we support them, but I think it is worth avoiding
> problems where possible).  Maybe:

I don't know about sh -x but there is this code in test-lib.sh to warn =
about=20
GIT_TRACE use:

case $(echo $GIT_TRACE |tr "[A-Z]" "[a-z]") in
	1|2|true)
		echo "* warning: Some tests will not work if GIT_TRACE" \
			"is set as to trace on STDERR ! *"
		echo "* warning: Please set GIT_TRACE to something" \
			"other than 1, 2 or true ! *"
		;;
esac

> 	...
> 	grep "Finished one cherry-pick\." actual >filtered &&
> 	n=3D$(wc -l <filtered) &&
> 	... &&
> 	test $n -eq 3
>=20
> Summary: I was misled by the commit message.  Maybe something
> like
>=20
> 	Subject: cherry-pick --strategy: report success
>=20
> 	"git cherry-pick foo" has always reported success
> 	with "Finished one cherry-pick" and cherry-pick
> 	--strategy is starting to feel left out.  Move the
> 	code to write that message from do_recursive_merge
> 	to do_cherry_pick so other strategies can share it.
>=20
> would have set me straight.

Ok, I will improve it.

Thanks,
Christian.

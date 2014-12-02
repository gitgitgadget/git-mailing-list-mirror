From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 2/2] receive-pack: support push-to-checkout hook
Date: Tue, 02 Dec 2014 14:03:16 +0100
Message-ID: <547DB894.4040609@drmicha.warpmail.net>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <xmqqh9yag6mt.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info> <xmqq1tpbawqe.fsf@gitster.dls.corp.google.com> <xmqq389qam25.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info> <xmqqzjbw47vr.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info> <xmqqh9y32e36.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411131850510.13845@s15462909.onlinehome-server.info> <xmqq4mu2285w.fsf@gitster.dls.corp.google.com> <xmqqzjbuzu6t.fsf@gitster.dls.corp.google.com> <xmqq1tp643yb.fsf@gitster.dls.corp.google.com> <xmqqa9
 36ohs3.fsf@gitster.dls.corp.google.com> <xmqq61duohq7.fsf_-_@gitster.dls.corp.google.com> <alpine.DEB.1.00.1412020929420.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 14:03:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xvn6x-0002tg-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 02 Dec 2014 14:03:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932909AbaLBNDT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Dec 2014 08:03:19 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:52458 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932605AbaLBNDS (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2014 08:03:18 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A97DF20748
	for <git@vger.kernel.org>; Tue,  2 Dec 2014 08:03:17 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 02 Dec 2014 08:03:17 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=CMzMXOdx49yPZq9vnZ3arg
	xUecI=; b=kFWRe8e6AAPEhCn80jGpocSBeKx9v2tiZ7DJN4ghHKQjk2ZyFlPr5r
	PjpplPgCl6dwQkdoeuZwosBwzkTw0PkcxxNQvihpG8v2/iF3N+UEfq5zbExwg74D
	P1mPAPKbK7F8pmCMQmguaR1WkAXQZghdMEeVB9+o1tgV8rxsKcdf4=
X-Sasl-enc: nWpbNrP0uzplx6A1UA0jY2YViuBGw5Xif0tBiXoDbsQJ 1417525397
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id D9596C0027D;
	Tue,  2 Dec 2014 08:03:16 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <alpine.DEB.1.00.1412020929420.13845@s15462909.onlinehome-server.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260567>

Johannes Schindelin schrieb am 02.12.2014 um 09:47:
> Hi Junio,
>=20
> On Mon, 1 Dec 2014, Junio C Hamano wrote:
>=20
>> When receive.denyCurrentBranch is set to updateInstead, this hook
>> can be used to override the built-in "push-to-deploy" logic, which
>> insists that the working tree and the index must be unchanged
>> relative to HEAD.  The hook receives the commit with which the
>> tip of the current is going to be updated, and is responsible to
>> make any necessary changes to the working tree and to the index to
>> bring them to the desired state when the tip of the current branch
>> is updated to the new commit.
>>
>> For example, the hook can simply run "git read-tree -u -m HEAD $1"
>> to the workflow to emulate "'git fetch' going in the reverse
>> direction with 'git push'" better than the push-to-deploy logic, as
>> the two-tree form of "read-tree -u -m" is essentially the same as
>> "git checkout" that switches branches while keeping the local
>> changes in the working tree that do not interfere with the
>> difference between the branches.
>=20
> I like it.
>=20
> The only sad part is that the already huge test suite is enlarged by =
yet
> another extensive set of test cases (and those tests might not really
> need to be that extensive because they essentially only need to make =
sure
> that the hook is run successfully *instead* of trying to update the
> working directory, i.e. a simple 'touch yep' hook would have been eno=
ugh).
> It starts to be painful to run the complete test suite, not only on
> Windows (where this has been a multi-hour endeavor for me for ages
> already). BuildHive (CloudBees' very kind offer of Jenkins CI for Ope=
n
> Source, integrated conveniently with GitHub) already takes over an ho=
ur to
> run the Git test suite =E2=80=93 and BuildHive runs on Linux, not Win=
dows!
>=20
> That means that everytime I push into a GitHub Pull Request, I have t=
o
> wait for a full hour to know whether everything is groovy.
>=20
> Worse: when Git for Windows contributors (yes! they exist!) push into
> their Pull Requests, I have to wait for a full hour before I can merg=
e,
> unless I want to merge something that the test suite did not validate=
!
>=20
> So maybe it is time to start thinking about conciser tests that verif=
y the
> bare minimum, especially for rarely exercised functionality? I mean,
> testing is always a balance between too much and too little. And at t=
his
> point, I am afraid that several well-intended, but overly extensive t=
ests
> increase the overall runtime of "make test" to a point where develope=
rs
> *avoid* running it, costing more time in the long run than necessary.
>=20
> In this particular case, I think that we really, really *just* need t=
o
> verify that the presence of the hook switches off the default behavio=
r of
> updateInstead. *Nothing* else is needed to verify that this particula=
r
> functionality hasn't regressed. I.e. something like:
>=20
> +test_expect_success 'updateInstead with push-to-checkout hook' '
> +	rm -fr testrepo &&
> +	git clone . testrepo &&
> +	(
> +		cd testrepo &&
> +		echo unclean > path1 &&
> +		git config receive.denyCurrentBranch updateInstead &&
> +		echo 'touch yep' | write_script .git/hooks/push-to-checkout
> +	) &&
> +	git push testrepo HEAD^:refs/heads/master &&
> +	test unclean =3D $(cat testrepo/path1) &&
> +	test -f testrepo/yep
> +'
>=20
> would be more appropriate (although it probably has one or three bugs=
,
> given that I wrote this in the mailer).
>=20
> Ciao,
> Johannes
>=20

How about reusing the prerequisites feature for that? We could either
mark the minimal tests, or mark the others similar to how we do with th=
e
(extra) expensive tests. Your config.mk would then determine which test=
s
are executed.

Michael

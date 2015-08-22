From: Ivan Chernyavsky <camposer@yandex.ru>
Subject: Re: Which branch(es) contain certain commits? (was Re: (unknown))
Date: Sat, 22 Aug 2015 12:19:13 +0300
Message-ID: <2689531440235153@web22m.yandex.ru>
References: <349031438778845@web22j.yandex.ru>
	<CACsJy8Be-kY49CxAJTx2R2XG-c_WeuU=yLFT8-XSoaDkTScPGg@mail.gmail.com>
	<xmqqh9nxerfv.fsf@gitster.dls.corp.google.com>
	<5570041440192599@web21j.yandex.ru> <xmqqio88466l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 11:28:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZT56d-0002BL-IA
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 11:28:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbbHVJ2u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Aug 2015 05:28:50 -0400
Received: from forward3m.mail.yandex.net ([37.140.138.3]:55113 "EHLO
	forward3m.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320AbbHVJ2t (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 05:28:49 -0400
X-Greylist: delayed 544 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Aug 2015 05:28:48 EDT
Received: from web22m.yandex.ru (web22m.yandex.ru [IPv6:2a02:6b8:0:2519::222])
	by forward3m.mail.yandex.net (Yandex) with ESMTP id 53D786B601FC;
	Sat, 22 Aug 2015 12:19:15 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web22m.yandex.ru (Yandex) with ESMTP id 7A962760752;
	Sat, 22 Aug 2015 12:19:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1440235154; bh=mbt4MMzeOt0KjDlRvvIczTtByabG8mpufRdKOS0adgU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=U46YBKo5LgXE/dFWS3eGhO1vwh8uQ/bUNvxx0/CJV+BMUxQRRyeSKpcAfsXCbaMVx
	 BY0xikzHch43tB2Du9lcJY2EOdvMqZDLShYXd1hQTOfIY90pqJtXs0xvVRnwA3U5a7
	 EjR1O2Ob7n+ILbGe2/FgmOCzrK2vXd6hwsOKvgXc=
Received: by web22m.yandex.ru with HTTP;
	Sat, 22 Aug 2015 12:19:13 +0300
In-Reply-To: <xmqqio88466l.fsf@gitster.dls.corp.google.com>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276386>



22.08.2015, 01:39, "Junio C Hamano" <gitster@pobox.com>:
> =9AIvan Chernyavsky <camposer@yandex.ru> writes:
>
>> =9A=9AAnother problem is that builtin/branch.c currently does not us=
e
>> =9A=9Asetup_revisions(), so I'll have to hook it there as well.
>
> =9AHeh, you say "problem" above, but I do not think it is a "problem"
> =9Aper-se. If you want to teach branch some preprocessing based on th=
e
> =9Arevision traversal API, you naturally need to call setup_revisions=
().

I meant "my problem" mostly ;) Yes I see git-branch currently has it's =
own way of doing things, I assume it avoids more heavy machinery from g=
it-rev-list and friends.

> =9AThe outlined steps above all feel sensible; one thing you did not
> =9Amention is that you may probably have to clear object flags after
> =9Ayou are done with the initial "--grep" revision traversal, as some
> =9Afeatures of branch may want to use the object flags (e.g. --merged
> =9Awould use in_merge_bases()). Other than that, all of it sounds
> =9Aeasily implementable.

I still need to understand a lot how it all works. Any hint on where to=
 look is appreciated. (I started from looking on builtin/shortlog.c jus=
t because it's one of the shortest ones using setup_revisions().)

One thing I'm worried about is that git-branch already has option --all=
=2E So we'll get a semantics conflict with setup_revisions() ("all bran=
ches" vs "all refs"). This will have to be treated carefully, e.g. retr=
ace and fix effects of --all after setup_revisions() to include just br=
anches but not other refs. Will such mangling be ok? Or could I prepare=
 the call of setup_revisions() in a way that only branches will be incl=
uded by --all? Anyway the semantics of --all will be different for git-=
branch and git-rev-list, but I believe more important is to keep it unc=
hanged for git-branch.

> =9ANote that "branch --list", "tag --list" and "for-each-ref" are bei=
ng
> =9Arevamped to share more internal code. If you want to pursue this,
> =9Ayou probably would want to build on top of that effort once it is
> =9Adone. That way, you may get "tag --grep=3DFIX123" for free.
>

This is interesting. So can I have a look on some repo/branch or just w=
ait until it'll be merged?

>> =9A=9AThat said, do you think the goal is worth such changes?
>
> =9AThat is a dangerous question. As Duy already said,
>
>> =9A=9AProbably because nobody is interested and steps up to do it. T=
he lack
>> =9A=9Aof response to you mail is a sign.
>
> =9Aapparently not many people thought it is worth; otherwise we would
> =9Aalready have such a feature.
>
> =9AIf you are asking me personally, I'm sorry but I have to say no.
>
> =9AThe reason why I personally do not think your "branch --grep=3DFIX=
123"
> =9Awould be very useful to me is because I would imagine that I would
> =9Abe interested in learning the exact commit that mentions FIX123 as
> =9Awell as which branches contain it, if I had a need for such a
> =9Afeature.
>
> =9AThat is, it would inherently be two step process for me anyway, i.=
e.
>
> =9A=9A(1) I'd run "log -p --grep" to find which commits are about FIX=
123
> =9A=9A=9A=9A=9A=9Aand check that what they did indeed make sense; and
>
> =9A=9A(2) I'd then run "branch --contains" to learn which ones are
> =9A=9A=9A=9A=9A=9Aalready up to date with respect to the fix.
>
> =9AYour "branch --grep=3DFIX123" that only tells me the names of bran=
ches
> =9Awould have no use in that workflow, as it would not even give me a=
n
> =9Aindication that the request --grep=3DFIX123 found the right commit=
 in
> =9Athe first place.

Yes, I see your point. But let me also explain my use case so it'll be =
probably more clear. Sorry if it's too long.

I work for HP as SCM and build manager for a product >15 years old. One=
 of this product's greatest strenghts always was support for many old r=
eleases and customizations for particular users. So right now we are pr=
oviding support for 10 subsequent releases (oldest one released back in=
 2006), and each release has 5 to 10 "customer" branches with their spe=
cific enhancements and fixes. (Though, as you would expect, all the fix=
es are generally merged to mainline, some customers are reluctant to ap=
ply fixes they don't need, so even here we must be flexible when prepar=
ing a patch.) So basically now I'm managing around 60 public branches i=
n the repository.

SCM was ClearCase at the beginning, then StarTeam (whoa, complete disas=
ter). At this point I joined the team and performed migration to Git la=
st year (took a whole year). So now our history is a mixture of ancient=
 baselines from ClearCase and artificial branches imported from StarTea=
m (thanks to my colleague who wrote a Git helper for StarTeam, https://=
github.com/AndreyPavlenko/git-st). So many changes which are 100% ident=
ical are represented by different commits, only identifiable with --che=
rry-pick option to git-log and friends. Even if I spent a great amount =
of time manually cutting and glueing history in Git to have the shortes=
t logs.

And obviously, our workflow is based on cherry-picks, because very very=
 often fixes and enhancements have to be merged *back* to many old cust=
omer branches. And you could immagine that when you port something to a=
 codebase which is 5 years old, it rarely applies cleanly, so even --ch=
erry-pick will not be able to identify it. And even if something is mer=
ged forward, it's only merged selectively when we are speaking about fe=
atures and customer branches.

Supporting all this is a mess, as you could immagine. But that's what c=
ustomers want, so I have no problem with that. After all, not every tea=
m has a dedicated SCM/build manager.

So quite often I or QA or support need to quickly find out, for example=
, which branches have specific enhancement or fix (ticket id) in their =
history. Commits which implement the actual feature or fix could be com=
pletely different, but the ticket id will be the same. True, it's not e=
nough per se: you will still need to go and look into the branch. But h=
aving some initial set of branches is necessary anyway. And usually I t=
rust our developers to mark their commits properly.

I had a look in the Internet before asking to this List, and I was a bi=
t surprised to see that very few people really needed that. So I assume=
d that either I'm doing something wrong or we are really really special=
 with our 10 years LTS, 60 public branches and cherry-picks. From your =
answers I tend to think that latter assumption is more correct.

Thanks a lot for your quick and detailed answers.

--=20
  Ivan

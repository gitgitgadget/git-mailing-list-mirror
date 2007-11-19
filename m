From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 2/2] push: Add '--current', which pushes only the current branch
Date: Mon, 19 Nov 2007 07:41:59 +0100
Message-ID: <EA5C3227-12E1-43C4-96E8-43BABF26792B@zib.de>
References: <Pine.LNX.4.64.0711121501500.4362@racer.site> <11954023881802-git-send-email-prohaska@zib.de> <119540238994-git-send-email-prohaska@zib.de> <7vwssfqb0w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/mixed; boundary=Apple-Mail-14-251471371
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 07:41:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu0Ji-0000ZM-VI
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 07:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751967AbXKSGkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 01:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbXKSGkv
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 01:40:51 -0500
Received: from mailer.zib.de ([130.73.108.11]:63936 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751770AbXKSGku (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 01:40:50 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lAJ6eiRw029566;
	Mon, 19 Nov 2007 07:40:45 +0100 (CET)
Received: from [192.168.178.21] (brln-4db83cdd.pool.einsundeins.de [77.184.60.221])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lAJ6eh9k029610
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 19 Nov 2007 07:40:44 +0100 (MET)
In-Reply-To: <7vwssfqb0w.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65405>


--Apple-Mail-14-251471371
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	delsp=yes;
	format=flowed


On Nov 19, 2007, at 2:28 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> Often you want to push only the current branch to the default
>> remote.  This was awkward to do in the past.
>
> While I think --current is a handy shorthand to have, I do not
> think the above description is correct.
>
> Wouldn't your earlier patch have allowed the configuration setting:
>
> 	[remote "$there"]
>         	push = HEAD
> 	[branch "$current"]
>         	remote = $there
>
> to work very well already?

No.  This was the case in the verst first version of the patch
series.  Someone, I don't remember who, proposed to put the
resolution of HEAD into builtin-push.c.  This simplified code
a lot.  Now, HEAD is resolved when parsing the command line.
At that time it is replaced with the full local refname.
The refspec parsing code never sees HEAD, and it won't
understand it.  Try the above setup, and you'll see that it
doesn't work.

Anyway it's not needed if we proceed as outlined below.


> I do not think it is "Often you want" that makes it awkward.
>
> Instead, the awkward case is if you do the "only the current"
> push NOT often enough.  If it is often enough, you set the
> configuration once and the awkwardness is behind you.
>
> If however it is not often enough, you cannot afford to have the
> configuration above, because that would force you to tell from
> the command line which branches, not just the current one, to
> push, and that is inconvenient because it is not rare enough.

Will try to rephrase the commit message.


> Together with your [PATCH 1/2], I like the general direction
> these patckes are taking us, but it feels a bit too hasty.  I
> personally am not convinced that switching to --current for
> everybody is a good move.
>
>> ...
>> Maybe in two years (that's twice an eternity in git time scales):
>>
>> 4) make "git push --current" the default.
>
> If these, both the uncertainly expressed by "Maybe" and "twice
> an eternity" are true, which they are, the new warning in the
> current patch are inappropriate.  Many people's settings depend
> on a working "push the matching refs" behaviour, and we need a
> very good excuse to annoy the existing happy users with such a
> warning.

I think 3) is the interesting case.  "git push" should do
nothing by default.  Either you can configure "git push" to do
something by setting a remote.$remote.push line or you need
to provide a command line switch.  But if you do not tell
explicitly what you want, "git push" will not do anything
for you.

I'm not sure if we ever switch to 4).  But already with 3) the
default changed.  So a warning seems to be appropriate.  But if
we go as outlined below, it's probably a different warning.

I attached a patch that illustrates what "do nothing by default"
means.  This patch should _not_ be applied.  It's only an
illustration what I'm working on.


> Remember, how much vocal the dissenters might have been on the
> list in the recent discussions, we need to consider the needs of
> the silent majority that has been content with the current
> behaviour for a long time.
>
> The "warning" to annoy them may be a way to get their attention
> and get them involved in a discussion to decide what the default
> should be.  But changing the default without giving the people
> who do not like the _new_ default a way to avoid inconvenience
> of always typing --matching or --current is not nice.  And
> honestly, I do not think there is one single default that is
> good for everybody.

Personally, I'd switch to the do-nothing default immediately.
But you are right.  More work is needed to have a smooth transition.


> We should be doing better.
>
> A smoother transition route would be:
>
>  - Keep "matching" the built-in default for now;
>
>  - Take your patches (but drop "warning" bits at this point) to
>    introduce 'matching' and 'current' behaviours, and a way to
>    override the built-in default from the command line;
>
>  - Introduce a configuration 'push.defaultRefs' ('matching' or
>    'current') to override that built-in default, so people who
>    prefer 'current' can override the built-in default, without
>    having to type --current every time.

Sounds like a plan.

If we have the configuration variable, maybe we could switch
off the default behaviour immediately.  Setting a single global
config variable once would be sufficient to get it back.  So,
we could change the default and print a recommendation to run
'git config --global push.defaultRefs matching' to get it back.

...

> After all that happens, we can start discussing what the
> built-in default should be.  When it is changed after the
> discussion concludes (which may never happen), people who want
> to keep 'matching' behaviour would have had the configuration
> mechanism to override that built-in default for some time during
> the discussion period.  So the beginning of that discussion
> period is when we should start talking about "We might change
> the default soon; set the configuration to your liking if you do
> not want to get affected" in the warning.

... And we'd not even start the discussion.  Because there's no
need to.  Every user should make a choice, once.  We do not
provide a default (which obviously will trigger another discussion ;)


> Then after that, we may or may not decide to change the default.
> Even if we end up not changing the default, 'current' people
> will then have a way (push.matching = false) to tailor their git
> for their liking, so everybody wins.
>
>>  DESCRIPTION
>> @@ -63,6 +63,12 @@ the remote repository.
>>  	Instead of naming each ref to push, specifies that all
>>  	refs under `$GIT_DIR/refs/heads/` be pushed.
>>
>> +\--matching::
>> +	Instead of naming each ref to push, specifies that matching
>> +	refs under `$GIT_DIR/refs/heads/` be pushed.  Matching means
>> +	the branch exists locally and at the remote under the same name.
>> +	Currently, this is the default.  But this will change in the  
>> future.
>
> For the above reason, "But this will..." is a bit premature.

I'll change the plan and will come back with a full
implementation.

Thanks for the helpful comments.

	Steffen



--Apple-Mail-14-251471371
Content-Transfer-Encoding: quoted-printable
Content-Type: application/octet-stream;
	x-unix-mode=0640;
	name=0001-push-do-nothing-by-default.patch
Content-Disposition: attachment;
	filename=0001-push-do-nothing-by-default.patch

=46rom=20a97c117794c631f556f87419a3dbaa702b858d95=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Steffen=20Prohaska=20<prohaska@zib.de>=0ADate:=20=
Sun,=2018=20Nov=202007=2019:22:30=20+0100=0ASubject:=20[PATCH]=20push:=20=
do=20nothing=20by=20default=0A=0AWe=20used=20to=20push=20all=20matching=20=
branches.=20=20This=20behaviour=0Awas=20suitable=20in=20many=20=
situations,=20but=20sometimes=20confusing.=0A=0AThis=20commit=20switches=20=
off=20the=20default.=20=20push=20now=20dies=20instead.=0A=0AWORK=20IN=20=
PROGRESS.=20=20NOT-SIGNED-OFF.=0A---=0A=20builtin-push.c=20=20=20=20=20=20=
=20=20|=20=20=20=209=20+++++++--=0A=20t/t5516-fetch-push.sh=20|=20=20=20=
13=20++++---------=0A=202=20files=20changed,=2011=20insertions(+),=2011=20=
deletions(-)=0A=0Adiff=20--git=20a/builtin-push.c=20b/builtin-push.c=0A=
index=20e5646d4..e637540=20100644=0A---=20a/builtin-push.c=0A+++=20=
b/builtin-push.c=0A@@=20-143,8=20+143,13=20@@=20int=20cmd_push(int=20=
argc,=20const=20char=20**argv,=20const=20char=20*prefix)=0A=20=09=09=
fprintf(stderr,=20"--all,=20--matching,=20and=20--current=20are=20mutual=20=
exclusive.\n");=0A=20=09=09usage_with_options(push_usage,=20options);=0A=20=
=09}=0A-=09if=20((all=20||=20matching=20||=20current)=20&&=20refspec)=0A=
-=09=09usage_with_options(push_usage,=20options);=0A+=09if=20(all=20||=20=
matching=20||=20current)=20{=0A+=09=09if=20(refspec)=0A+=09=09=09=
usage_with_options(push_usage,=20options);=0A+=09}=20else=20{=0A+=09=09=
if=20(!refspec)=0A+=09=09=09die("No=20default=20action=20found.");=0A+=09=
}=0A=20=09if=20(!all=20&&=20!matching=20&&=20!current=20&&=20!refspec)=0A=
=20=09=09fprintf(stderr,=20"Warning:=20assuming=20'--matching'."=0A=20=09=
=09=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20"=20This=20default=20=
will=20change=20in=20the=20future.\n");=0Adiff=20--git=20=
a/t/t5516-fetch-push.sh=20b/t/t5516-fetch-push.sh=0Aindex=20=
20e0796..48689b9=20100755=0A---=20a/t/t5516-fetch-push.sh=0A+++=20=
b/t/t5516-fetch-push.sh=0A@@=20-108,11=20+108,6=20@@=20test_expect_code=20=
129=20'push=20command=20line=20options=20(2)'=20'=0A=20=09git=20push=20=
--matching=20testrepo=20master=0A=20'=0A=20=0A-test_expect_success=20=
'push=20command=20line=20options=20(3)'=20'=0A-=09git=20push=20testrepo=20=
2>stderr.txt=20&&=0A-=09grep=20-q=20"Warning:=20assuming.*--matching"=20=
stderr.txt=0A-'=0A-=0A=20test_expect_code=20129=20'push=20command=20line=20=
options=20(4)'=20'=0A=20=09git=20push=20--all=20--current=20testrepo=0A=20=
'=0A@@=20-154,7=20+149,7=20@@=20test_expect_success=20'push=20with=20=
wildcard'=20'=0A=20test_expect_success=20'push=20with=20matching=20=
heads'=20'=0A=20=0A=20=09mk_test=20heads/master=20&&=0A-=09git=20push=20=
testrepo=20&&=0A+=09git=20push=20--matching=20testrepo=20&&=0A=20=09=
check_push_result=20$the_commit=20heads/master=0A=20=0A=20'=0A@@=20=
-319,7=20+314,7=20@@=20test_expect_success=20'push=20with=20dry-run'=20'=0A=
=20=09cd=20testrepo=20&&=0A=20=09old_commit=3D$(git=20show-ref=20-s=20=
--verify=20refs/heads/master)=20&&=0A=20=09cd=20..=20&&=0A-=09git=20push=20=
--dry-run=20testrepo=20&&=0A+=09git=20push=20--dry-run=20--matching=20=
testrepo=20&&=0A=20=09check_push_result=20$old_commit=20heads/master=0A=20=
'=0A=20=0A@@=20-331,7=20+326,7=20@@=20test_expect_success=20'push=20=
updates=20local=20refs'=20'=0A=20=09cd=20..=20&&=0A=20=09git=20clone=20=
parent=20child=20&&=20cd=20child=20&&=0A=20=09=09echo=20two=20>foo=20&&=20=
git=20commit=20-a=20-m=20two=20&&=0A-=09=09git=20push=20&&=0A+=09=09git=20=
push=20--matching=20&&=0A=20=09test=20$(git=20rev-parse=20master)=20=3D=20=
$(git=20rev-parse=20remotes/origin/master)=0A=20=0A=20'=0A@@=20-346,7=20=
+341,7=20@@=20test_expect_success=20'push=20does=20not=20update=20local=20=
refs=20on=20failure'=20'=0A=20=09cd=20..=20&&=0A=20=09git=20clone=20=
parent=20child=20&&=20cd=20child=20&&=0A=20=09=09echo=20two=20>foo=20&&=20=
git=20commit=20-a=20-m=20two=20||=20exit=201=0A-=09=09git=20push=20&&=20=
exit=201=0A+=09=09git=20push=20--matching=20&&=20exit=201=0A=20=09test=20=
$(git=20rev-parse=20master)=20!=3D=20$(git=20rev-parse=20=
remotes/origin/master)=0A=20=0A=20'=0A--=20=0A1.5.3.5.750.gc43b=0A=0A=

--Apple-Mail-14-251471371
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed



--Apple-Mail-14-251471371--

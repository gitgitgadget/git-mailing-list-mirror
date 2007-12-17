From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH] Have a flag to stop the option parsing at the first argument.
Date: Mon, 17 Dec 2007 13:06:30 +0100
Message-ID: <3CF3CEA5-72F1-47D1-ADB9-37F5C2E292A8@wincent.com>
References: <20071217095014.GF7453@artemis.madism.org> <30351C09-8BED-4D81-ABDD-2E079B4D54D2@wincent.com> <20071217114703.GH7453@artemis.madism.org> <Pine.LNX.4.64.0712171149540.9446@racer.site>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 17 13:08:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4ElZ-0007KI-1r
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 13:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbXLQMHt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 07:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757839AbXLQMHt
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 07:07:49 -0500
Received: from wincent.com ([72.3.236.74]:58075 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752520AbXLQMHs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 07:07:48 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lBHC6WMo020638;
	Mon, 17 Dec 2007 06:06:32 -0600
In-Reply-To: <Pine.LNX.4.64.0712171149540.9446@racer.site>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68550>

El 17/12/2007, a las 12:50, Johannes Schindelin escribi=F3:

> On Mon, 17 Dec 2007, Pierre Habouzit wrote:
>
>> On Mon, Dec 17, 2007 at 11:10:00AM +0000, Wincent Colaiuta wrote:
>>> El 17/12/2007, a las 10:50, Pierre Habouzit escribi=F3:
>>>
>>>> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
>>>> ---
>>>>>  // ...
>>>>>  /* when in `git --opt1 --opt2 foo -a -b -c` mode: */
>>>>>  int cmd_pos =3D git_find_builtin_command_name(argc, argv);
>>>>>  int count =3D parse_options(cmd_pos, argv, git_generic_options,
>>>>> 	"git [special-options] cmd [options]", 0);
>>>>>  if (count)
>>>>> 	die("unknown git command: `%s`", argv[0]);
>>>>>  argv +=3D cmd_pos;
>>>>>  argc -=3D cmd_pos;
>>>>>  /* here we simulate an argv of {"foo", "-a", "-b", "-c"} */
>>>>
>>>>  Or even simpler, with the following specifically tailored patch =20
>>>> you
>>>>  can directly write:
>>>>
>>>>  argc =3D parse_options(argc, argv, git_generic_options,
>>>> 	"git [generic-options] <command> [cmd-options]",
>>>> 	PARSE_OPT_STOP_AT_ARG);
>>>>
>>>>  and then {argc, argv} will exactly be the NULL-terminated array
>>>>  starting with the builtin command. Kind of nice :)
>>>
>>> Indeed, nice ideas. I think all this will lead to a nice UI =20
>>> improvement
>>> post-1.5.4.
>>>
>>> About the only thing that I think would merit action *prior* to =20
>>> 1.5.4 is
>>> marking the "-p" switch to git (synonym for --paginate) as =20
>>> deprecated,
>>> see as it clashes with other commands' uses of that switch ("git =20
>>> log -p"
>>> for example). Are there any other conflicting specials that a =20
>>> currently
>>> parsed in git.c?
>>
>>  You don't need to, and I'd see that as a regression. With my =20
>> proposal,
>> there isn't any kind of need that git commands do not clash with git
>> ones. The parse-option mechanism will properly hide options that are
>> masked this way, dscho wrote the patch for that.
>>
>>  git -p log -p ...
>>
>> just makes sense to me. CVS or SVN e.g. (don't hit me !) have the =20
>> same
>> kind of "issues", and I never found that weird.

Yes, we know what it does because we know that "git ... log ..." is =20
actually two commands and each one handles one of the -p switches, but =
=20
it is much easier to present git as a single tool to the newcomer (and =
=20
I guess I don't need to argue that case here seeing as the decision =20
has already been taken long ago to talk using dashless forms), and it =20
is much easier to explain to a newcomer something like:

git log --paginate -p

Than:

git -p log -p

(Incidentally, who actually uses "git -p log -p"? Doesn't everybody =20
have a pager set-up by default?)

>>  In fact I see this the other way around: git status -p that is in =20
>> fact
>> the same as git -p status, is the conveniency, git -p status is the
>> canonical form.
>
> I would even go further: "git status -p" looks utterly wrong to me.

This is exactly the kind of insider knowledge that will baffle =20
newcomers. The canonical form is canonical only because it relies on =20
an historical (and continuing) implementation detail, but we shouldn't =
=20
expect newcomers to have to learn such details in order to know where =20
to stick their command line arguments; they already have enough things =
=20
to learn about, I think.

But it doesn't really matter. The proposed changes allow old-timers to =
=20
continue putting their special options between the "git" and the =20
"command". If you don't want to deprecate the -p special because of =20
the confusion it might cause, I think we should at least not give it a =
=20
very prominent place in the documentation, nor use it any examples.

Cheers,
Wincent

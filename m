From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCHv2 2/3] parse-remote: support default reflist in 
	get_remote_merge_branch
Date: Sun, 7 Jun 2009 20:02:05 +0200
Message-ID: <adf1fd3d0906071102v9c15517v8e7b41a6638a52bb@mail.gmail.com>
References: <1244367862-6306-2-git-send-email-santi@agolina.net>
	 <7vljo49e08.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 20:02:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDMhI-0004u5-W0
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 20:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbZFGSCJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Jun 2009 14:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752695AbZFGSCG
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 14:02:06 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:51907 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752289AbZFGSCG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Jun 2009 14:02:06 -0400
Received: by bwz9 with SMTP id 9so2589339bwz.37
        for <git@vger.kernel.org>; Sun, 07 Jun 2009 11:02:06 -0700 (PDT)
Received: by 10.204.112.11 with SMTP id u11mr5701594bkp.134.1244397725871; 
	Sun, 07 Jun 2009 11:02:05 -0700 (PDT)
In-Reply-To: <7vljo49e08.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120989>

2009/6/7 Junio C Hamano <gitster@pobox.com>:
> Santi B=E9jar <santi@agolina.net> writes:
>
>> Expand get_remote_merge_branch to compute the tracking branch to mer=
ge
>> when called without arguments (or only the remote name). This allows
>> "git pull --rebase" without arguments (default upstream branch) to
>> work with a rebased upstream.
>
> The last sentence leaves readers wondering... =A0"Ok, with this patch=
, X
> without Y now works. =A0What about X _with_ Y? =A0Is it left unfixed?=
 =A0Was it
> already working before this patch? =A0What is going on???"

No changes in the "with Y" case, so working.

Maybe add the sentence "( with explicit arguments it already worked)".

>
>> Also add a test to check for this case and another one (failing) to
>> test rebasing two branches on top of a rebased upstream using just
>> 'git pull --rebase'.
>
> "test doing X using just Y" _sounds as if_ you are implying
>
> =A0 =A0 =A0 =A0Doing X using Z (that is more cumbersome to type than =
Y) works but
> =A0 =A0 =A0 =A0doing X using Y (that ought to be the equivalent to Z)=
 does not.
> =A0 =A0 =A0 =A0Let's expose this inconsistent breakage.
>
> without saying what Z is, and/or why Y is preferred. =A0So if that is=
 what
> is going on, please spell these out.

If you have two branches tracking an upstream that is rebased,
currently you have to do:

git checkout branch1
git pull --rebase remote branch
git checkout branch2
git pull --rebase remote branch

The second rebase works because the first "git pull --rebase" does not
store in the local tracking branch the new value, so the second rebase
detects that it is rebased.

I think one should be able to do the same without the explicit
arguments to "git pull --rebase", but without arguments it stores the
new state of the remote branch so the second "git pull --rebase" does
not work.

I just wanted to single out that it does not currently works.

I see two solutions for this: 1) declare that it is not going to work
and to do it you have to do the explicit invocation or 2) examine the
reflog of the remote tracking branch.

> If that is not the case please drop "just"; it is confusing.

I'll add some of this explanation to the commit message, and keep the
"just" (they should be equivalent, but are not).

>
>> +test_expect_success '--rebase with rebased default upstream' '
>> +
>> + =A0 =A0 git update-ref refs/remotes/me/copy copy-orig &&
>> + =A0 =A0 git checkout --track -b to-rebase2 me/copy &&
>> + =A0 =A0 git reset --hard to-rebase-orig &&
>> + =A0 =A0 git pull --rebase &&
>> + =A0 =A0 test "conflicting modification" =3D "$(cat file)" &&
>> + =A0 =A0 test file =3D $(cat file2)
>> +
>> +'
>> +
>> +test_expect_failure '--rebase with rebased upstream and two branche=
s' '
>> +
>> + =A0 =A0 git update-ref refs/remotes/me/copy copy-orig &&
>> + =A0 =A0 git reset --hard to-rebase-orig &&
>> + =A0 =A0 git checkout --track -b to-rebase3 me/copy &&
>> + =A0 =A0 git reset --hard to-rebase-orig &&
>> + =A0 =A0 git pull --rebase &&
>> + =A0 =A0 test "conflicting modification" =3D "$(cat file)" &&
>> + =A0 =A0 test file =3D $(cat file2) &&
>> + =A0 =A0 git checkout to-rebase2 &&
>> + =A0 =A0 git pull --rebase me copy
>> +
>> +'
>> +
>> =A0test_expect_success 'pull --rebase dies early with dirty working =
directory' '
>>
>> + =A0 =A0 git rebase --abort &&
>> + =A0 =A0 git checkout to-rebase &&
>
> Hmm, saying "--abort" when rebase is not in progress

The rebase is in progress (the last test failed)

> (i.e. after your next
> patch fixes the above "expect_failure" to pass) does not error out? =A0=
It is
> not very nice...

My next patch does not fix the expect_failure, I only wanted to make
this behavior explicit. But if at the end this is the prefered
behavior (fail rebasing two branches with a rebased upstream) I'll
drop this test.

Santi

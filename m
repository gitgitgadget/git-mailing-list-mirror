From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 7/7] sequencer: Remove sequencer state after final commit
Date: Sun, 14 Aug 2011 22:07:31 +0530
Message-ID: <CALkWK0m0KyZkOqVWJET=_Xy5GxwVfpPkB0OO1b2hJ8aN_x7hGA@mail.gmail.com>
References: <1313310789-10216-1-git-send-email-artagnon@gmail.com>
 <1313310789-10216-8-git-send-email-artagnon@gmail.com> <20110814160440.GK18466@elie.gateway.2wire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 14 18:37:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QsdhG-0001u0-7p
	for gcvg-git-2@lo.gmane.org; Sun, 14 Aug 2011 18:37:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912Ab1HNQhx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Aug 2011 12:37:53 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:64594 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669Ab1HNQhw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Aug 2011 12:37:52 -0400
Received: by wyg24 with SMTP id 24so3072114wyg.19
        for <git@vger.kernel.org>; Sun, 14 Aug 2011 09:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=nt3jC44MlZ/Ie1Au5J+FchrwuiMxeH70vd7aZyVyCBw=;
        b=IqXMwCLnXt1z0FD3BAQtuvbM/TM2FSeiD5sNSEQPht8Of2wjM5+MbQiofQkblt0hMx
         xqP+YncjV8fBSTDlnhYwX8eSyq1uGhsuYBPHsi0wt8ZkJK21HV9v1X18ymFbSg0fNi7U
         d0ZzC7hG/WORSwPDginar7As0jZOSkhAJX3vk=
Received: by 10.216.46.208 with SMTP id r58mr1299563web.78.1313339871076; Sun,
 14 Aug 2011 09:37:51 -0700 (PDT)
Received: by 10.216.172.132 with HTTP; Sun, 14 Aug 2011 09:37:31 -0700 (PDT)
In-Reply-To: <20110814160440.GK18466@elie.gateway.2wire.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179335>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> [...]
>
> The function name (..._notify_commit()) does not seem very intuitive.
> Based on the name, I expect it to use the sequencer to print a messag=
e
> to the user about the commit in progress.

=46or the record, I'm not too happy with the name either.  I was hoping
that someone would suggest a better name during the review :P

> .git/index
> =C2=A0- afterward, because when writing the index fails, I (the user)
> =C2=A0 might want to react by running "git cherry-pick --abort".

Very subtle point: will fix.  I'd originally put it along with the
other state-removing functions.

> Not about this patch: I keep on forgetting what the argument to
> remove_sequencer_state means. =C2=A0Would it be possible to make it
> a flag, which would both make the meaning more obvious and mean
> it is easy to support additional flags in the future?

I don't want to create a struct and populate it because I highly doubt
remove_sequencer_state will take any more arguments in the future.
Putting an "int aggressive =3D 1" and passing the variable instead of
the literal is a little inelegant.  Actually making any change at this
stage is inelegant because of the other remove_sequencer_state() calls
:|  My call: we can fix it if and when the function needs more
arguments.

>> --- a/t/t3032-merge-recursive-options.sh
>> +++ b/t/t3032-merge-recursive-options.sh
>> @@ -114,8 +114,10 @@ test_expect_success 'naive cherry-pick fails' '
>> =C2=A0 =C2=A0 =C2=A0 git read-tree --reset -u HEAD &&
>> =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick --no-commit remo=
te &&
>> =C2=A0 =C2=A0 =C2=A0 git read-tree --reset -u HEAD &&
>> + =C2=A0 =C2=A0 git cherry-pick --reset &&
>> =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick remote &&
>> =C2=A0 =C2=A0 =C2=A0 test_must_fail git update-index --refresh &&
>> + =C2=A0 =C2=A0 git cherry-pick --reset &&
>> =C2=A0 =C2=A0 =C2=A0 grep "<<<<<<" text.txt
>> =C2=A0'
>
> What is this about? =C2=A0Maybe it would be clearer to change the "gi=
t
> read-tree ..." to "git reset --hard", so the test assertion would not
> rely on new cherry-pick features (and to mention the change in the
> commit message!).

Okay, I can do this instead (don't check whitespace! I just typed out
the patch):

@@ -114,8 +114,10 @@ test_expect_success 'naive cherry-pick fails' '
=C2=A0 =C2=A0 =C2=A0 git read-tree --reset -u HEAD &&
=C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick --no-commit remote =
&&
- =C2=A0 =C2=A0 git read-tree --reset -u HEAD &&
+ =C2=A0 =C2=A0 git reset --hard &&
=C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick remote &&
=C2=A0 =C2=A0 =C2=A0 test_must_fail git update-index --refresh &&
+ =C2=A0 =C2=A0 git reset --hard &&
=C2=A0 =C2=A0 =C2=A0 grep "<<<<<<" text.txt
=C2=A0'

> Doesn't this point to a risk in the patch? =C2=A0Do you think there m=
ight
> be scripts out there relying on being able to use "git read-tree
> --reset -u HEAD" to clear away a failed cherry-pick before trying
> again, and if so, can we do something about it?

I'm not sure we can do anything about it -- we should probably put
some kind of warning in the commit message?

>> --- a/t/t3510-cherry-pick-sequence.sh
>> +++ b/t/t3510-cherry-pick-sequence.sh
>> @@ -82,13 +82,13 @@ test_expect_success '--reset cleans up sequencer=
 state' '
>> =C2=A0 =C2=A0 =C2=A0 test_path_is_missing .git/sequencer
>> =C2=A0'
>>
>> -test_expect_success 'cherry-pick cleans up sequencer state when one=
 commit is left' '
>> +test_expect_success 'final commit cleans up sequencer state' '
>> =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
>> =C2=A0 =C2=A0 =C2=A0 test_must_fail git cherry-pick base..picked &&
>> - =C2=A0 =C2=A0 test_path_is_missing .git/sequencer &&
>> =C2=A0 =C2=A0 =C2=A0 echo "resolved" >foo &&
>> =C2=A0 =C2=A0 =C2=A0 git add foo &&
>> =C2=A0 =C2=A0 =C2=A0 git commit &&
>> + =C2=A0 =C2=A0 test_path_is_missing .git/sequencer &&
>> =C2=A0 =C2=A0 =C2=A0 {
>
> It would also be nice to check "test_path_is_dir" before the final
> commit, so people working on this code in the future know both aspect=
s
> of the patch are intentional.

Good point.  Fixed.

Thanks.

-- Ram

From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: stash refuses to pop
Date: Wed, 11 Apr 2012 12:47:44 +1000
Message-ID: <CAH5451=0KvUPB77hKyjFVXRwPfEZ8+45b20SimBPmuF-gq_A3w@mail.gmail.com>
References: <4F847350.3000409@ubuntu.com> <7vpqbfpim2.fsf@alter.siamese.dyndns.org>
 <4F84827B.80104@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 04:48:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHnbm-00087y-RC
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 04:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757092Ab2DKCsH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 22:48:07 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64081 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111Ab2DKCsG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2012 22:48:06 -0400
Received: by wgbdr13 with SMTP id dr13so414602wgb.1
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 19:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=+R88t/HUH6q4tPH8Ar2b5FnW7VMqGTWFtOY5yX8inbg=;
        b=Sg4sRxaax+7OhHqtZvY4WY5ZBwSbyOJ6LKZKgX5UEFS5d+fB++HlGbIWBdATfWIjB2
         X//sgt0r8Q/uWaEdTbu2pBg4DSwPj1oqad/cpzMuvPUa6/0TO+R4lpKDdtrB+/hNe3Ue
         3ChXsOCFZ66+wZlFqbtFd1FGGqjpiFzRJ3JdgPiNhAHmna1ByrRbVYWntbaWOUWNdSWx
         +Sh/vn+UJ1Q1TWnm4NX/VRDnD79zZkqapRMIVf6d/cILPUdK1GDRSEDcj82cv2V8SLu6
         JLt0KplB1mCvMBhHzVVJwkp6TSTO6+DLXhKM//nJLxVjm1nCZNTNbOjVXy7YtOq464I2
         mdTA==
Received: by 10.216.132.169 with SMTP id o41mr7636598wei.121.1334112484337;
 Tue, 10 Apr 2012 19:48:04 -0700 (PDT)
Received: by 10.223.159.72 with HTTP; Tue, 10 Apr 2012 19:47:44 -0700 (PDT)
In-Reply-To: <4F84827B.80104@ubuntu.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195143>

On 11 April 2012 04:56, Phillip Susi <psusi@ubuntu.com> wrote:
> On 4/10/2012 2:05 PM, Junio C Hamano wrote:
>>
>> Phillip Susi<psusi@ubuntu.com> =C2=A0writes:
>>
>>> git stash refuses to apply a stash if it touches files that are
>>> modified. =C2=A0Using stash -p to selectively stash some hunks of a=
 file
>>> and then immediately trying to pop that stash causes this failure
>>> every time.
>>
>>
>> I think that is by design.
>
>
> Being able to push something that you can not pop seems to be broken
> design...
>
>
>> I do not use "stash -p" and personally, but I think its broken from =
the UI
>> point of view. =C2=A0The point of "stash" is to clear your workspace=
 to a
>> pristine state, do random things, and after you are done and cleared=
 your
>> workspace again, apply it to come back to the original state or a st=
ate as
>> if you started your WIP from the updated clean-slate.
>
>
> Or temporarily undo some changes and come back to those changes later=
?
>
>
>> So probably the right way to use "stash -p" (if there were such a th=
ing)
>> would be to stash away the remainder in a separate stash with anothe=
r
>> "stash" without "-p" (which will clear your workspace to a pristine =
state)
>> and then pop the one you created with "stash -p", I think.
>
>
> That would not get you back to the state you were in when you first s=
tashed,
> but instead to a state where you have the first set of changes, but n=
ot the
> second ( which you then also can not pop due to the first changes bei=
ng
> there ).

The first question, it would seem, is what should git do when there
are modified files present, and the user tries to pop a stash which
touches those files. The current behaviour is to reject the pop,
reasonable enough, though for what exact reason I am not sure
(potential merge issues, I assume).

The method you have described is just one way of coming on this
situation. The user could have
* stashed their work, modified some files and tried to pop
* partially stashed their work, and tried to pop
* partially stashed their work, modified some files and then tried to p=
op.

The options for dealing with this situation seem to be
1. Reject the pop outright
2. put the affected files into a merge conflict state
3. revert the file to the state they were at at the time of stash
4. reject those files that do not apply cleanly (but apply all others)
5. reject those hunks which do not apply cleanly (but apply all others)
6. provide an interactive pop session for choosing what to apply

I don't know if all of these are possible/feasible/reasonable.
1. possible by # git reset
2. default behaviour
3. is possible using # git stash branch <branchname> [<stash>]
4. 5. seems this might be possible, not sure of best method
6. this would be something like # git stash pop -p [<stash>], which I
think does not exist yet

I would like to see 6. implemented, but the behaviour seems very
reasonable at the moment.

Regards,

Andrew Ardill

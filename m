From: Pat Notz <patnotz@gmail.com>
Subject: Re: Refactoring git-rebase.sh and git-rebase--interactive.sh
Date: Thu, 4 Nov 2010 15:49:42 -0600
Message-ID: <AANLkTi=cK0M2icUzTa2c4HUkNfSAGEmeY1LNds_AcRPk@mail.gmail.com>
References: <AANLkTimeWDbJPor9PnKgW5sD7DLjqrm-vTzEtnARvP3M@mail.gmail.com>
 <201011030424.33093.chriscool@tuxfamily.org> <20101104211556.GB8911@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	christian.couder@gmail.com, trast@student.ethz.ch
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Thu Nov 04 22:50:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE7hC-0000BY-NV
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 22:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206Ab0KDVuG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Nov 2010 17:50:06 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43860 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124Ab0KDVuE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Nov 2010 17:50:04 -0400
Received: by bwz11 with SMTP id 11so2116199bwz.19
        for <git@vger.kernel.org>; Thu, 04 Nov 2010 14:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=S1FG32O/Nx+TRy8jC+aiT4Rs7T5zZWxLZyEXsm0JUZQ=;
        b=GQWEtWk3mDMHLkQzozPkimsC5o8/IokVscJgKIUfW/fuFg5pRwGSswkPyKQdapEXfa
         nFTPxS6HEha5qq/k+unricI7LTj0GUHHy2u/a7sZMVqc/RxeaBwwE54vBdi3hwY+fjqR
         MyWFHIUpFc5my25ZUoRDeJAPa6754tjUsabu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=hUsVQLzOw3dWJIaQ7amCis7+JdB/DZTHcR8TQAwm1f61c6vGywx4aMmNu7xhZhQH9V
         SCVbhrWko2qXs0bXCDCz+c6WW6uUJKY+omyxHB+9ROwypCCblOKQ9ImyAAd1kpRWAywG
         AZM1zUSKfhzOgHtdRrrAAbXHaA3iXVKWJe9oA=
Received: by 10.204.66.65 with SMTP id m1mr1132463bki.109.1288907402458; Thu,
 04 Nov 2010 14:50:02 -0700 (PDT)
Received: by 10.204.70.140 with HTTP; Thu, 4 Nov 2010 14:49:42 -0700 (PDT)
In-Reply-To: <20101104211556.GB8911@home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160777>

On Thu, Nov 4, 2010 at 3:15 PM, Yann Dirson <ydirson@free.fr> wrote:
> Hi Christian,
>
> On Wed, Nov 03, 2010 at 04:24:32AM +0100, Christian Couder wrote:
>> Now that GTAC (http://www.gtac.biz) is over, I plan to work on optio=
ns
>> --continue, --abort and --skip for git cherry-pick/revert. After tha=
t I hope
>> to be able to refactor the code so that in the end common code is us=
ed by
>> cherry-pick/revert and rebase.
>
> Sounds like "sequencer is coming back", great news :)
>
> I don't know if you would like the idea enough, but something I often
> think would be good to have (and which could be useful for cherry-pic=
k
> and other commands in need of a sequencer), would be more flexibility=
=2E
> The thing I find myself lacking most often, is the possibility to
> change my mind on an already-edited commit (ie, go back after
> --continue), the alternatives I can see today being:
>
> - keeping a note on what to do on next pass (but may be more work in =
case
> =A0of conflicts with further commits)
> - fast-forward --continue'ing to keep curent changes and add new ones=
 in
> =A0next pass (same restriction)
> - --abort'ing the rebase and starting it again, possibly fetching the
> =A0changes from previous run via HEAD's reflog (not very handy either=
)
> - checkout back to where you want to re-amend and cherry-pick those y=
ou
> =A0already passed, essentially redoing an interactive rebase by hand
>
> If we could go back to previous commit, while keeping changes done to
> the current one (say, --previous), or reverting to the original one
> (say, --revert). =A0In the same way, continuing until another
> previously-unforeseen commit without the need to edit the todo file
> would be nice to have (eg. --next).

I've long wanted something like --next.  That would save me a lot of
multi-pass rebases.

> While I'm at it, another somewhat loosely option I have thought of
> would be to seed the todo file with "edit" commands instead of "pick"=
,
> to make it possible to validate a series of patches one by one before
> sending. =A0That could be generalized for running a test script
> automatically, that is inserting "x whatever" between all pick's - an=
d
> my 1st idea would boil down to inserting arg-less "edit" or "x false"
> instead. =A0Maybe some --stepcmd=3D<command> flag ?

Yes, --stepcmd would be *really* useful for testing a patch sequence
or adding forgotten signed-off by's.

> --
> Yann
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

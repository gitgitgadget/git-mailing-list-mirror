From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: [PATCH] Make git log --follow support --find-copies-harder.
Date: Thu, 22 Apr 2010 10:27:55 +0800
Message-ID: <m2p41f08ee11004211927w88506198sfd740da672b5c6f7@mail.gmail.com>
References: <1271860641-29305-1-git-send-email-struggleyb.nku@gmail.com>
	 <7v8w8gbv75.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 04:28:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4m9M-0003s4-8T
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 04:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab0DVC16 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 22:27:58 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55527 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106Ab0DVC15 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 22:27:57 -0400
Received: by vws18 with SMTP id 18so505599vws.19
        for <git@vger.kernel.org>; Wed, 21 Apr 2010 19:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1O7zU+srjrnT23S6rigydh+xTLWOvy4wswd2vsIYxqk=;
        b=M0ikZNZP+DxUOhRNKx2OB5eyuOkInj3Peg8Zq8vESOfYRFX+KUAMGSmipFo6KCrHUt
         NrqjvZ41fDkkM5DXbzLZwqp3VAB3BFUvAtrX6KWQgg2rGcUY76m570XbJF4fLijFZwPd
         NyDVrQZypWCYNWAlnkDzPiU3HYcR7kJ9uN5PY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mR2jB1O06OY86YoGDrNcGAFQj4cQteuIkk8MJ6d4lFY2rqwOHPqjAvqrCWVB9vj1Z9
         3y+Fhb+PqxUr3Ehl4MpGbaTPprIUqRGeFBDv+Gw1rvtcRe+l0T0l4U+6nKWeUU6y4NAt
         IPbOF1IVKJXJEP52rAHB8wK2lObh8W/nUwFpE=
Received: by 10.229.98.196 with HTTP; Wed, 21 Apr 2010 19:27:55 -0700 (PDT)
In-Reply-To: <7v8w8gbv75.fsf@alter.siamese.dyndns.org>
Received: by 10.229.38.69 with SMTP id a5mr2856147qce.15.1271903275697; Wed, 
	21 Apr 2010 19:27:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145494>

On Thu, Apr 22, 2010 at 12:56 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> What does the command do when given a single -C instead of --f-c-h, w=
ith
> or without your patch? =A0What should it do?

I have found that two days ago, all '-M/-C/-C -C' with some <path>
specified will fail.
byang@byang-laptop:~/git/git$ git diff --name-status -M  maint master
builtin/add.c
A       builtin/add.c

byang@byang-laptop:~/git/git$ git log -M -C -C --name-status
--pretty=3Doneline t/t4013/diff.show_--first-parent_master
2bf6587349e31b582dae47954b1a334052230e28 show --first-parent/-m: do
not default to --cc
A       t/t4013/diff.show_--first-parent_master

without <path>
byang@byang-laptop:~/git/git$ git diff --name-status -M  maint master
| grep  'builtin/add.c'
R100	builtin-add.c	builtin/add.c

byang@byang-laptop:~/git/git$ git log -M -C -C --name-status
--pretty=3Doneline | grep -- 't/t4013/diff.show_--first-parent_master'
C050	t/t4013/diff.show_master	t/t4013/diff.show_--first-parent_master

Both of above files are copied/renamed.

This because in diff_tree,

              if (opt->nr_paths) {
                        skip_uninteresting(t1, base, baselen, opt);
                        skip_uninteresting(t2, base, baselen, opt);
                }

And this give no chance for later rename/copy detection. I have been
trying to figure out a patch for this, but the logic is complex and it
will take more time...

> Because try_to_follow_renames() is supposed to be a rare-event (it on=
ly
> happens when a path we have been following disappears), I am having t=
his
> feeling that it would make more sense to do this change unconditional=
ly.
>
> Two possible outcomes that this patch allows the users to have by giv=
ing
> them a choice to give (or not to give) --f-c-h are:
>
> =A0(1) the path is judged to be new in a commit and traversal finishe=
s
> =A0 =A0 there; or
>
> =A0(2) the path is found to be a copy from another path from one of t=
he
> =A0 =A0 parents and traversal continues.
>
> But I think using --follow is a sure sign of the user wanting the lat=
ter
> and never the former, no?

Hmm, that makes sense. So, --follow always means --f-c-h.

Regards!
Bo

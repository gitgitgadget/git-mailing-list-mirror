From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [RFC] rebase: use @{upstream} if no upstream specified
Date: Tue, 16 Nov 2010 21:29:46 -0500
Message-ID: <AANLkTin+3FuuX_pavZQMrbi4qxjTRvM7nHk1PXcFbeiZ@mail.gmail.com>
References: <1289595349-12589-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<20101113095140.GH8911@home.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
To: Yann Dirson <ydirson@free.fr>
X-From: git-owner@vger.kernel.org Wed Nov 17 03:29:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIXmW-0001sb-NS
	for gcvg-git-2@lo.gmane.org; Wed, 17 Nov 2010 03:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756851Ab0KQC3v convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Nov 2010 21:29:51 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:65041 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756670Ab0KQC3u convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Nov 2010 21:29:50 -0500
Received: by qyk4 with SMTP id 4so1536486qyk.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 18:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=37V6uGpGKp/ER5tomgMl4XIX4KqyatEmamGHy+VWRpA=;
        b=AnfLKRh2UxmF5umucQ2yiRoZp1WR4STEcvYBpqX/tXoxedqaeIL5l1Ku9/NnNLcAdT
         tCJFK8BCM964Jp/fjSV/8RccppYUkSAzZi2QkleJe5b59AENTuToGKq0droKaYWx4pO/
         qQOi7VGRLbitRNqhY5OAZsnXc2svUagCS2GsU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Q5WQzSOK1Bo34M/q3xzHCd0fUhTjwtx5x1V1l5xGSWSdiP5Q+TR+glhGo2UFcQseqH
         g47KnXGCHYxF+POzdvMOPmk2AtyHDhrZeSsX6ApDDqpHqBekKOwUA2+TaK2xhi8TIim/
         2WqJ4zEPtv/9M6YL98zSSZNZsQXVcpeThYUYM=
Received: by 10.224.60.136 with SMTP id p8mr5775723qah.175.1289960986913; Tue,
 16 Nov 2010 18:29:46 -0800 (PST)
Received: by 10.224.80.202 with HTTP; Tue, 16 Nov 2010 18:29:46 -0800 (PST)
In-Reply-To: <20101113095140.GH8911@home.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161595>

On Sat, Nov 13, 2010 at 4:51 AM, Yann Dirson <ydirson@free.fr> wrote:
> On Fri, Nov 12, 2010 at 09:55:49PM +0100, Martin von Zweigbergk wrote=
:
>
>> @@ -21,6 +21,10 @@ If <branch> is specified, 'git rebase' will perfo=
rm an automatic
>> =C2=A0`git checkout <branch>` before doing anything else. =C2=A0Othe=
rwise
>> =C2=A0it remains on the current branch.
>>
>> +If <upstream> is not specified, the upstream configured in
>> +branch.<name>.remote and branch.<name>.merge options will be used; =
see
>> +linkgit:git-config[1] for details.
>> +
>
> Maybe make explicit that it will abort when no upstream is configured=
=2E

Will do.

>
>> @@ -416,9 +409,31 @@ esac
>>
>> =C2=A0if test -z "$rebase_root"
>> =C2=A0then
>> - =C2=A0 =C2=A0 # The upstream head must be given. =C2=A0Make sure i=
t is valid.
>> - =C2=A0 =C2=A0 upstream_name=3D"$1"
>> - =C2=A0 =C2=A0 shift
>> + =C2=A0 =C2=A0 case "$#" in
>> + =C2=A0 =C2=A0 0) =C2=A0 =C2=A0 =C2=A0branch_name=3D$(git symbolic-=
ref -q HEAD) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 upstream_name=3D$(git fo=
r-each-ref \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 --format=3D'%(upstream)' ${branch_name})
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if test -z $branch_name
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die "You are not currently on a branch, so I cannot use any
>> +'branch.<branchname>.merge' in your configuration file.
>> +Please specify which upstream branch you want to use on the command
>> +line and try again (e.g. 'git rebase <upstream branch>').
>> +See git-rebase(1) for details."
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif test -z $upstream_n=
ame
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 then
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 die "You asked me to rebase without telling me which branch you
>> +want to rebase against, and 'branch.${branch_name#refs/heads/}.merg=
e' in
>> +your configuration file does not tell me, either. Please
>> +specify which branch you want to use on the command line and
>> +try again (e.g. 'git rebase <upstream branch>').
>> +See git-rebase(1) for details."
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fi
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;
>> + =C2=A0 =C2=A0 *) =C2=A0 =C2=A0 =C2=A0upstream_name=3D"$1"
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 shift
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;;
>> + =C2=A0 =C2=A0 esac
>> =C2=A0 =C2=A0 =C2=A0 upstream=3D`git rev-parse --verify "${upstream_=
name}^0"` ||
>> =C2=A0 =C2=A0 =C2=A0 die "invalid upstream $upstream_name"
>> =C2=A0 =C2=A0 =C2=A0 unset root_flag
>
> What about simply checking if "rev-parse @{u}" succeeds, in which cas=
e
> we can use upstream_name=3D@{u} ? =C2=A0If it fails, then we can do t=
he work
> of finding where the config flaw is (and delegate this to a func).
> That would help keep the nominal code path short.

Will make sure to find out the error only when needed as you suggest.

I thought I would need the ref name to be able to walk the reflog if my
other propasal would be accepted (see
http://thread.gmane.org/gmane.comp.version-control.git/161381), but it
seems to work with @{u} as well. I just adapted the call from 'git pull=
'
(git-parse-remote.sh), but I guess I could use 'git rev-parse @{upstrea=
m}'
instead. It does seem more natural to me.

Maybe one of the guys on the CC list can advise?

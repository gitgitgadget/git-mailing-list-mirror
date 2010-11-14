From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [RFC] rebase: be cleverer with rebased upstream branches
Date: Sat, 13 Nov 2010 21:46:03 -0500
Message-ID: <AANLkTikvpXpFH81q6f-xp5zKCNGFpYoVO7D9-Cy2M_J7@mail.gmail.com>
References: <1289592713-11786-1-git-send-email-martin.von.zweigbergk@gmail.com>
	<AANLkTincij4wR4=RhbA0oCwe66OhVry0AkS6GCALVWmz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, trast@student.ethz.ch, newren@gmail.com
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Sun Nov 14 03:46:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHSbi-0004Zk-2q
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 03:46:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab0KNCqK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Nov 2010 21:46:10 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46666 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224Ab0KNCqH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Nov 2010 21:46:07 -0500
Received: by qwh5 with SMTP id 5so696196qwh.19
        for <git@vger.kernel.org>; Sat, 13 Nov 2010 18:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=f1pMQYyipB2iGZXxy/PmgaShlAHPE/rN2/ZKjr5X6Hs=;
        b=yIXjiaE2NxHIkmIm+MNYunOYTpkS78Lo4uK4C9riVjOWG/OY42nTSI6lWay+Z9tzdr
         kRAwjWN6VOrhwoFv+pc9VrwOVD2NBf9k/9zze6F+93M9zKUtU+mGVMW8j4GAEXZ4yyZr
         wa3E810Bve8crbVBzEXalsv7XZRVXwJNPM/rc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aRp+NhV3ze0OLigtDHisHpEidHyTP2zO9HCZuktzfMEFhaFiKZWxz+x5gOI5/WTGtB
         p8GQRucvEPL5OG35GyArqZzI1YviYVoqp97jgV6zvpsg93Jm++ITKE79NCHJCYFAcu3I
         pwxc8ElH7YkERifDm3Nm3uY8PlpsJ+Ey5U5Mc=
Received: by 10.224.204.134 with SMTP id fm6mr3950444qab.325.1289702763249;
 Sat, 13 Nov 2010 18:46:03 -0800 (PST)
Received: by 10.224.138.5 with HTTP; Sat, 13 Nov 2010 18:46:03 -0800 (PST)
In-Reply-To: <AANLkTincij4wR4=RhbA0oCwe66OhVry0AkS6GCALVWmz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161404>

On Sat, Nov 13, 2010 at 6:30 PM, Santi B=C3=A9jar <santi@agolina.net> w=
rote:
> On Fri, Nov 12, 2010 at 9:11 PM, Martin von Zweigbergk
> <martin.von.zweigbergk@gmail.com> wrote:
>> Since c85c792 (pull --rebase: be cleverer with rebased upstream
>> branches, 2008-01-26), 'git pull --rebase' has used the reflog to tr=
y to
>> rebase from the old upstream onto the new upstream.
>>
>> However, if, instead of 'git pull --rebase', the user were to do 'gi=
t
>> fetch' followed by 'git rebase @{upstream}', the reflog would not be
>> walked. This patch teaches "git rebase" the same reflog-walking tric=
ks
>> that 'git pull --rebase' already knows.
>>
>> Apart from making 'git rebase' better aligned with 'git pull --rebas=
e',
>> this may also be useful on its own for rebasing one branch against
>> another local branch that has been rebased. Currently, you would hav=
e to
>> do that using 'git rebase --onto' or by configuring it on the branch=
=2E
>>
>> It might seem like most of the related code in git-pull.sh can be
>> removed once git-rebase.sh supports reflog walking. Unfortunately, n=
ot
>> much of it can be removed, though. The reason is that git-pull.sh do=
es
>> one step of 'reflog' walking even when the reflog is not used. There=
 are
>> at least two cases where the reflog is not used: a) when it is disab=
led,
>> b) when the remote branch was specified on the command line (let's s=
ay
>> 'git pull --rebase origin master'). In both of these cases, git-pull=
=2Esh
>> remembers the position of the reference before the fetch and uses th=
at
>> in place of '$ref@{1}'.
>
> In the code I don't see when b) is different to call it without
> command line branches. And if it is different I suppose it is a bug.

The difference is somewhere in the code for 'git fetch'. I'm trying to
refer to the same thing as I did in
http://thread.gmane.org/gmane.comp.version-control.git/160004/focus=3D1=
60939.

> The code must stay in git-pull.sh because there it has more
> information (commit before and after fetch) than in git-rebase,
> essentially when reflogs are disabled.

Yes, I think that's what I meant by reason 'a)', but maybe I could have
explained it in a better way.

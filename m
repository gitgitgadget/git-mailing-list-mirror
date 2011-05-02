From: Csaba Henk <csaba@lowlife.hu>
Subject: Re: git symbolic-ref vs. reflog (vs. rebase)
Date: Mon, 2 May 2011 14:16:02 +0530
Message-ID: <BANLkTinyKQJQUHa8tn43=cCJMsVbgaZXjA@mail.gmail.com>
References: <ipek0o$l0v$1@dough.gmane.org> <7vk4edyqqn.fsf@alter.siamese.dyndns.org>
 <BANLkTi=yDECQs=mVkEfrkrFfy0dgFf4U3Q@mail.gmail.com> <20110430041312.GA5287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 02 10:46:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGolx-0003gP-Ag
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 10:46:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756845Ab1EBIqY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 04:46:24 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:62997 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873Ab1EBIqX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 04:46:23 -0400
Received: by wwk4 with SMTP id 4so2124991wwk.1
        for <git@vger.kernel.org>; Mon, 02 May 2011 01:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=eAoSP6IJFs0g9fm1SSCJrOLWDOtq5oY2cvnvmVFHbb8=;
        b=GNHVtTB6mccr9Ln5hDbSTa993runuFr6sPsvKU5KUHUjJiJnlm4nh2aKzw7Kp6nC5c
         G3EpHwW15AklG3+Oieg8y2HFxiX0PeNsgeZOB7AAHKqeYStIwE/qp6mKp/1FcU0I/28q
         OhPamtKq/bCUatX08/7K7FcLAlJIq8cgshULk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=Tw5JkZQD2dIpwFQFCMAEcA3Gl4gqgmKomuafdAlWDe+tSziQErqimOD+UB5TxcmJvS
         G8g3XPe8XNDuSXRiNX/nLhQRcg6SrUAUysOZqWuaAe2hGM2hXdaPM/UKGNQ0yOy7eNYM
         WjF2oEKvYhk9YgzEIifQoyHEupc17+tPUpyyE=
Received: by 10.216.255.73 with SMTP id i51mr2205881wes.88.1304325982131; Mon,
 02 May 2011 01:46:22 -0700 (PDT)
Received: by 10.216.186.143 with HTTP; Mon, 2 May 2011 01:46:02 -0700 (PDT)
In-Reply-To: <20110430041312.GA5287@sigill.intra.peff.net>
X-Google-Sender-Auth: vTzD-lP-FJm8uU3pI3qacVgp2UQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172567>

On Sat, Apr 30, 2011 at 9:43 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 29, 2011 at 10:51:31PM +0530, Csaba Henk wrote:
>
>> > Yes, it is. =A0But you can choose to do:
>> >
>> > =A0 =A0 =A0 =A0$ git branch side
>> > =A0 =A0 =A0 =A0$ git symoblic-ref -m "move to side" HEAD refs/head=
s/side
>> > =A0 =A0 =A0 =A0$ git log --oneline -g HEAD@{0}
>> > =A0 =A0 =A0 =A005ddb9b HEAD@{0}: move to side
>> > =A0 =A0 =A0 =A0e69de29 HEAD@{1}: commit (initial): first commit
>> >
>> > if you wanted to.
>>
>> So do you think the following patch would be the correct fix for the
>> rebase issue:
>>
>> diff --git a/git-rebase.sh b/git-rebase.sh
>> index cbb0ea9..10c1727 100755
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>> @@ -284,7 +284,7 @@ do
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 head_name=3D"$(cat "$dotest"/head-na=
me)" &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case "$head_name" in
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 refs/*)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git symbolic-ref HEAD =
$head_name ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git symbolic-ref -m "r=
ebase: aborting" HEAD
>> $head_name ||
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die "Could not move =
back to $head_name"
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 esac
>
> I count 2 uses of symbolic-ref without reflogs in git-rebase, one mor=
e
> in git-rebase--interactive, and one in git-cvsexportcommit. Should al=
l
> be fixed to write a reflog entry?

Yeah, that's why I didn't set the above patch as PATCH -- I lack the in=
sight
to rebase / plumbing in general to be able to propose a change with the=
 right
impact.

Csaba

From: Elijah Newren <newren@gmail.com>
Subject: Re: [PATCHv4 2/2] pull --rebase: Avoid spurious conflicts and
 reapplying unnecessary patches
Date: Thu, 12 Aug 2010 14:19:55 -0600
Message-ID: <AANLkTimoB=__-FmuFYa_rKqMjoYwWQS9hzziuk9Jseyx@mail.gmail.com>
References: <1281592569-740-1-git-send-email-newren@gmail.com>
	<1281592569-740-3-git-send-email-newren@gmail.com>
	<AANLkTimHiYUPyNTtT4SwapqN8YZGB1wjxJPwTTaPZhEa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	martinvz <martin.von.zweigbergk@gmail.com>
To: =?UTF-8?B?U2FudGkgQsOpamFy?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Thu Aug 12 22:20:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjeFw-0006lN-Dr
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 22:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760556Ab0HLUT5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 16:19:57 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39579 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760525Ab0HLUT4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 16:19:56 -0400
Received: by fxm13 with SMTP id 13so982687fxm.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 13:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0FlvmoteOSZkMLIBFdTJCM44If7cH9pHMOyfUC5lthY=;
        b=ttj+awwiQGAoFcRJlEyB3CbV/YoWQ4ueKnMKOX92pIRTS+ZFiRRxNZe4meg6RkSiRz
         6csOwUZk60SdTV87LU1bp81Du21GE3f+2XwuGbW6Iusrdlaf2aREGAuFQlXBDSt65368
         GCCRmGNmhvoGf491H01yjI5GT/D+OPHOMMPRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XAQWvDBrTSgFy7PpoZSGB65HFTewMNLyCVl415B9Aeau/L+RyqndJMlKsJkl9MCMdp
         PgjpcnEGQd9XXIDouz54YerUSPErHHisjWIkRALK1VIuEh6ibJNRHSN5fHqesWAmV8T3
         gq0xLU8o1VCKOefF/lrCfNJGoXmdFbrYF5kzw=
Received: by 10.223.104.15 with SMTP id m15mr727904fao.103.1281644395413; Thu,
 12 Aug 2010 13:19:55 -0700 (PDT)
Received: by 10.223.149.82 with HTTP; Thu, 12 Aug 2010 13:19:55 -0700 (PDT)
In-Reply-To: <AANLkTimHiYUPyNTtT4SwapqN8YZGB1wjxJPwTTaPZhEa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153408>

Hi,

Thanks for the review and comments!

On Thu, Aug 12, 2010 at 7:34 AM, Santi B=C3=A9jar <santi@agolina.net> w=
rote:
<snip>
> All this makes sense.
>
> But can you explain when it happens? One possibility is when you don'=
t
> fork from the tracking branch as in:

That's one possibility.  Patch 1/2 in this thread contains testcases
for two others.  Another possibility is having your patches get
upstream by some alternative route (e.g. pulling your changes to a
third machine, pushing from there, and then going back to your
original machine and trying to pull --rebase).

> Subject: Difference between pull --rebase and fetch+rebase
> Message-ID: <27059158.post@talk.nabble.com>
> From: martinvz <martin.von.zweigbergk@gmail.com>
>
> and this patch should also fix martinvz's issue (I've CC martinvz, ca=
n
> you test this patch? Thanks).

Since you've cc'd martinvz, I'll note for his benefit that in the
thread you reference above, you stated,

"By the way, when Git tries to apply these two commits it should detect
that they are already applied so it should do nothing, isn't it?"

The answer is no, it won't detect they are already applied, as
explained in the commit message that started the current thread.  (If
git did detect the changes were already applied, this bug would have
been innocuous.)

> Can you refer to commits with something like this?
>
> c85c792 (pull --rebase: be cleverer with rebased upstream branches, 2=
008-01-26)

Sure, I'll start doing that.

> You've moved all the lines after the call to "git fetch". It changes
> the behavior when the reflog is not enabled, as the old value of
> remoteref is lost.

Doh.  That's what I get for trying to 'clean up' some code and put all
the references to setting oldremoteref together.  I should have stuck
with my original 7-line addition patch.  I'll resend the simplified
patch.

Elijah

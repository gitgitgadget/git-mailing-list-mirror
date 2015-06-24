From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP v3 07/31] am: extract patch, message and authorship with git-mailinfo
Date: Wed, 24 Jun 2015 08:59:39 -0700
Message-ID: <xmqqa8vpayhg.fsf@gitster.dls.corp.google.com>
References: <1434626743-8552-1-git-send-email-pyokagan@gmail.com>
	<1434626743-8552-8-git-send-email-pyokagan@gmail.com>
	<xmqqtwu4d8pg.fsf@gitster.dls.corp.google.com>
	<CACRoPnS9eyBF5NEM7sKvep+A8aKUNLJDaV-1c_oWDBwMcv26Bg@mail.gmail.com>
	<xmqq1th7brsj.fsf@gitster.dls.corp.google.com>
	<20150624075446.GA1964@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 17:59:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7n5X-0008A7-Mh
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 17:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752605AbbFXP7o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 11:59:44 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:37292 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbbFXP7m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 11:59:42 -0400
Received: by igblr2 with SMTP id lr2so36857290igb.0
        for <git@vger.kernel.org>; Wed, 24 Jun 2015 08:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=2tvhxyC7NWv7qP/VbeumxF/WloBb9DX08PJCPVfK+Rk=;
        b=EQCxpiDDj3UwmtfGmU3q29/0VTRTzfz9y32OG6zbv71dfUNjnB/mttc2UNJTMDiLup
         FlMZC0fdDjjhEaJeH3vaKVwdRQFtJc8agzzfN7UyEVOmoXK0gBZMp1YRYM/vKHpBdKlX
         DZ1zNmBRK1LrWZLD0Ymi9xUL2O8HpI+agAi4x9bHmPTD8oK3fxFY/dvxOEyDOm1UgTzy
         oepaFhebxdHsSZdKkI+a2S1M0ApdsJPWTSUuMko3pSuvEyUbp3CASrpVLgoBbEqk+y0F
         SB0WdbKoy4iiSyx5f1i2Ka4CRzbWTWvBbMDx9LL+Hyd3EfCN0yei6knfwubD2MT94S39
         b0kA==
X-Received: by 10.43.151.83 with SMTP id kr19mr38090036icc.3.1435161582118;
        Wed, 24 Jun 2015 08:59:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1c05:dbc5:2f2f:d033])
        by mx.google.com with ESMTPSA id e10sm1280462igy.11.2015.06.24.08.59.41
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 24 Jun 2015 08:59:41 -0700 (PDT)
In-Reply-To: <20150624075446.GA1964@yoshi.chippynet.com> (Paul Tan's message
	of "Wed, 24 Jun 2015 15:54:46 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272561>

Paul Tan <pyokagan@gmail.com> writes:

> 3. I'm over-thinking this and you just want the "struct strbufs" in the
>    struct am_state to be switched to "char*"s?

Yes, everybody interacts with am_state, and these fields are
supposed to be constant during the processing of each patch input
message; they should be simple strings, not strbufs, to make sure if
anybody _does_ muck with them in-place, that would be very visible.
The helpers to initialize them are free to use strbuf API to prepare
these simple string fields, of course.

> (On a somewhat related thought, currently we do write_file() all over
> the place, which is really ugly. I'm leaning heavily on introducing an
> am_save() function, for "I don't care how it is done but just update the
> contents of the am state directory so that it matches the contents of
> the struct am_state".

Sure; the scripted Porcelain may have done "echo here, echo there"
instead of "concatenate into a $var and then 'echo $var' at end" as
that is more natural way to program in that environment.  You are
doing this in C and "prepare the thing in-core and write it all at
the point to snapshot" may well be the more natural way to program.

As long as a process that stops in the middle does not leave on-disk
state inconsistent, batching would be fine.  For example, you may
apply and commit two (or more) patches without updating the on-disk
state as you do not see need to give control back to the user
(i.e. they applied cleanly) and then write out the on-disk state
with .next incremented by two (or more) before giving the control
back could be a valid optimization (take this example with a grain
of salt, though; I haven't thought too deeply about what should
happen if you Ctrl-C the process in the middle).

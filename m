From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Sat, 25 Jul 2015 10:18:45 -0700
Message-ID: <xmqqlhe4jgui.fsf@gitster.dls.corp.google.com>
References: <20150723012343.GA21000@peff.net>
	<CAGZ79kbY8hAom+voAOourkDy34nwaACQEM-n=f25Qbg0+ha_8g@mail.gmail.com>
	<20150724074028.GE2111@peff.net>
	<xmqq4mkto9lg.fsf@gitster.dls.corp.google.com>
	<20150725013634.GA7269@peff.net> <20150725014722.GA17830@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 25 19:18:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJ36A-0007UD-03
	for gcvg-git-2@plane.gmane.org; Sat, 25 Jul 2015 19:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbbGYRSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2015 13:18:51 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34146 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110AbbGYRSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2015 13:18:50 -0400
Received: by pacan13 with SMTP id an13so29947599pac.1
        for <git@vger.kernel.org>; Sat, 25 Jul 2015 10:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sqZ9t76V5oJlK7En8kJXlhve8tS3h2OCiCOoC2roJls=;
        b=w5NFURIPC6yuQAci0CftKzN9kwzJJK641Hja6jHodtyE+PCwaOszzwygVBWFYRbrvY
         Xf/zoM+H3ET8JeVWR7kLtbcDucB2VAT7ogbuUTw7/kE62l6v6XuJH9ib1ZpSbOj9KUKV
         Bp2BmLHw9sq+x1u3vfDnKrWA9cI++N5MDINDatYLfCrUUOH2e0h1wapGXMR5fNdILLXv
         d3dss8AC2I8EXwKsJU4PYegsSwQtKU00IlT+Dri3b29bb2dH36y5U5Go7D+kiHb2lV+n
         bjuNRZLVQ/B/S32llOVO2PatWuez2zAaYDxufFCQTfTYzCj/so79/RBi9XphYDsPCFxx
         PO0g==
X-Received: by 10.66.63.8 with SMTP id c8mr47080064pas.122.1437844729673;
        Sat, 25 Jul 2015 10:18:49 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f068:7766:ecc2:8f58])
        by smtp.gmail.com with ESMTPSA id qn7sm20981859pab.14.2015.07.25.10.18.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 25 Jul 2015 10:18:47 -0700 (PDT)
In-Reply-To: <20150725014722.GA17830@peff.net> (Jeff King's message of "Fri,
	24 Jul 2015 18:47:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274613>

Jeff King <peff@peff.net> writes:

> This works for "format-patch -s". But I guess that leaves open the
> question of "commit --signoff". It should not matter when making a
> commit new (after all, you have not yet had a chance to put the "---"
> in). But something like "git commit --amend --signoff" might want to
> handle it. Of course we have no idea if any "---" we find there is meant
> to be an email notes-separator by the user, or if they happened to use
> "---" for something else[1] (which is a bad idea if you have an emailed
> patches workflow, but many people do not). So it's a bit riskier.
>
> -Peff
>
> [1] While reading the old "git commit --notes" thread recently, Johan
>     Herland gave a plausible confusing example:
>
>     ...
>       Why
>       ---
>
>       To show that "---" can be part of a commit message. :)

That is all true, but such a commit already is problematic when used
as an input to "am", regardless of where the sign-off goes.  With or
without our change, the intended explanation of "why" part will be
missing from the resulting commit at the receiving end.  The only
difference your change makes is that the resulting truncated log
message at least will have a sign-off, albeit at a place that the
user did not intend to put it.

We could invent a new and more prominent delimiter, teach
"format-patch" to add that between the log and patch if and only if
the log has a three-dashes line in it (with an option to override
that "if and only if" default), and teach "mailsplit" to pay
attention to it.  People who are relying on the fact that a
three-dashes line in the local log message will be stripped off at
the receiving end have to pass that "The commit has three-dash in it
as a cut-mark on purpose; don't add that prominent delimiter" option
when formatting their patches out for submission.

But I somehow think it is not worth the effort.  It is fairly well
established that three-dash lines are cut marks and Johan's example
log message above deliberately violates only to spite itself.  My
knee-jerk advice is that people can just rephrase s/Why/Reason/ and
be done with it.

I dunno.

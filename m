From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: it is OK for a tag and a commit to lack the body
Date: Sun, 28 Jun 2015 22:42:45 -0700
Message-ID: <xmqqsi9bcboq.fsf@gitster.dls.corp.google.com>
References: <20150625155128.C3E9738005C@gemini.denx.de>
	<xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
	<20150625201309.5026A384E81@gemini.denx.de>
	<xmqqegkzy1ri.fsf@gitster.dls.corp.google.com>
	<2b124e09d9c89ff3892f246ea91aa3c4@www.dscho.org>
	<xmqqoak3wkkq.fsf@gitster.dls.corp.google.com>
	<xmqqbng3wheu.fsf@gitster.dls.corp.google.com>
	<d455a77d76b3558fb79d550d6ed4468d@www.dscho.org>
	<20150626155248.GB30273@peff.net>
	<xmqqlhf3elxk.fsf_-_@gitster.dls.corp.google.com>
	<32aa1979e75ba9bc6dc8a58fe32e9e55@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Wolfgang Denk <wd@denx.de>,
	git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 29 07:46:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9Rtk-0004pt-6u
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 07:46:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbbF2Fmu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 01:42:50 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:34548 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750742AbbF2Fmt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 01:42:49 -0400
Received: by iebmu5 with SMTP id mu5so107972024ieb.1
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 22:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=uMhHyD8b2VS1b53Hr4q1MUURZkLnUo1XsBGuYZo1WyU=;
        b=eOT283TRNJVxcXQ/Pf+C3dbePe4poywKKlPHVco6nrLYAnf995BkMX2u/MI/3vDAZv
         r5/XPw+D/5Y/Jq4ot27GpurAZFKL6CAMK9/ZOElZIldJ6/4pFY70/bkpA6pzH8guHDbs
         dchR8gE1n7VW2ZqaCFvJ0NyWLHuEeEMmMW0v1eJJ8BaDECtgwbH/mU14GWQfvPKrdW+N
         OoCAH5yx/3zkZokTRhjB2ZSecLnBToRcCFgYgIu5Y79wa/8XdwFrBm+Cu23YkYZQC8aW
         nBN0ad0ibQCEhRPzaZUb9I5ff9FL2QQAXlfZTwjIBbHlROg7VomJilbUD3N9r8GjZL1H
         UIHA==
X-Received: by 10.43.10.194 with SMTP id pb2mr17150125icb.31.1435556568247;
        Sun, 28 Jun 2015 22:42:48 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a109:3c27:ff77:e0c7])
        by mx.google.com with ESMTPSA id l128sm27009387iol.1.2015.06.28.22.42.46
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 28 Jun 2015 22:42:46 -0700 (PDT)
In-Reply-To: <32aa1979e75ba9bc6dc8a58fe32e9e55@www.dscho.org> (Johannes
	Schindelin's message of "Mon, 29 Jun 2015 07:12:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272940>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>> +	/*
>> +	 * We did not find double-LF that separates the header
>> +	 * and the body.  Not having a body is not a crime but
>> +	 * we do want to see the terminating LF for the last header
>> +	 * line.
>> +	 */
>> +	if (size && buffer[size - 1] == '\n')
>> +		return 0;
>> +
>>  	return error_func(obj, FSCK_ERROR, "unterminated header");
>>  }
>
> Hmm. Maybe we should still warn when there is no empty line finishing
> the header explicitly, or at least make it FSCK_IGNORE by default so
> that maintainers who like a stricter check can upgrade the condition
> to an error?

Wolfgang, do you know how these old tags without messages were
created?  I think in the old days we didn't advertise "git tag" as
the sole way to create a tag object and more people drove "git
mktag" from their script, and "mktag" until e0aaf781 (mktag.c:
improve verification of tagger field and tests, 2008-03-27) did not
complain if the header were not terminated with double-LF even when
the tag did not have a body (hence there is no need for double-LF).

Dscho, I do not think it is reasonable to force all repository
owners of projects that started using Git before early 2008 to set
configuration variable to ignore warnings for something that was
perfectly kosher back when their project started.  More importantly,
even though Git core itself adds unnecessary double-LF after the
header in a tag or a commit that does not have any body, I am not
sure if we punish people who use current versions of third-party
reimplementations of Git that do not write that unnecessary
double-LF at the end an object without a body (I am not saying that
there is any known third-party reimplementation to do so---I am
saying that I do not think it is their bug if such implementations
existed today).

Do we have check marked as FSCK_IGNORE by default?  I think a more
interesting "stricter check" may be to flag a tag object or a commit
object that does not have any body, with or without the double-LF at
the end.

And such a check can certainly be added in the future, but what I
sent was a fix to a regression that caused us to start whining on a
syntactically valid object in the v2.2 timeframe, and is not about
adding a new feature.

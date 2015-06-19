From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 08/19] fsck: Make fsck_commit() warn-friendly
Date: Fri, 19 Jun 2015 14:01:16 -0700
Message-ID: <xmqqk2uz5s6b.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<1ce6b2b32cb94d9697056d1181bb1fe396c64a5b.1434720655.git.johannes.schindelin@gmx.de>
	<xmqqmvzv78z9.fsf@gitster.dls.corp.google.com>
	<ba0cb32edf26639a8a00ad9d17b49e32@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 23:03:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z63S0-0007aG-HN
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 23:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933165AbbFSVDf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 17:03:35 -0400
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34170 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932233AbbFSVBS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 17:01:18 -0400
Received: by iebmu5 with SMTP id mu5so82429019ieb.1
        for <git@vger.kernel.org>; Fri, 19 Jun 2015 14:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=L6vvpl78kCeA+hn0p8IBSKsSCVHJcoT92eiP9FbD1yU=;
        b=uzFJoJJXtE26SfLz5Mfa8NINMLKFa0U5oLYSqn+QwvdAUYxdDNzfHl4JGKyyjTZaO7
         5QxoFyS/8T5co/eHX4GLPouy8LneMoGMei8cTdBOBvWsB4odrhAVr6glRfwnTf32aSUX
         8A+K6212vjaD6q6AmZtNcyi3bq1NPm0lRwxXoiEm/6HCWyaVU+Qzu2Axcmd8rbziPv6G
         dLo7D6Jm4OI0GUGJMP8BdvKQy2ARKr2dhHPs/H2Tnhg6c8Zcs5B6P7SB8ocw3l5ce10X
         oXIOY/gUdEZ/+95o31sOgzSMzBesM+XLuc/Z8xX9sLoBfqvGpyRoiU5KAkWM+4AObKTq
         uVhg==
X-Received: by 10.107.8.210 with SMTP id h79mr3973295ioi.27.1434747677759;
        Fri, 19 Jun 2015 14:01:17 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:80a8:63af:ca7c:ab61])
        by mx.google.com with ESMTPSA id qh9sm2429081igb.20.2015.06.19.14.01.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 19 Jun 2015 14:01:17 -0700 (PDT)
In-Reply-To: <ba0cb32edf26639a8a00ad9d17b49e32@www.dscho.org> (Johannes
	Schindelin's message of "Fri, 19 Jun 2015 22:52:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272207>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>> I do not think this "if (err) return err;" that uses the return
>> value of report(), makes sense.
>> 
>> As all the errors that use this pattern are isolated ones that does
>> not break parsing of the remainder (e.g. author ident had an extra >
>> in it may break "author " but that does not prevent us from checking
>> "committer ").
>> 
>> Your report() switches its return value based on the user setting;
>> specifically, it returns 0 if the user tells us to ignore/skip or
>> warn.  Which means that the user will see all warnings, but we stop
>> at the first error.
>> 
>> Shouldn't we continue regardless of the end-user setting in order to
>> show errors on other fields, too?
>
> I can make that happen, but please note that this is a change of
> behavior: we always stopped upon the first error.

Yeah, and we always died when we saw error, without giving users an
option to turn it down.  So?

> It was my intention not to change behavior in that way without a
> proper reason, and I saw none.

What would be the end-user experience if you stopped at the first
error?  You see an error, add an "fsck.<msg-id> = ignore" and rerun,
only to find another error and rinse and repeat?  Wouldn't you
rather see all of them and add the "ignore" to cover them in one go?

> I actually see a really good reason to *keep* the current behavior:
> one of the most prominent users of this code path is `git receive-pack
> --strict`. It is used heavily by GitHub to ensure at least a certain
> level of validity of pushed objects. Now, for this use case it is easy
> to see that you want to stop *as soon as an error was
> encountered*. And as GitHub sponsors my work on this patch series, my
> main aim is to support their use case.

While I understand that use case, I do not think stopping after
showing three more errors in a single commit would make much
difference in the bigger picture.

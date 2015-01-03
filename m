From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCHv9 1/9] receive-pack.c: shorten the execute_commands loop
 over all commands
Date: Sat, 3 Jan 2015 16:53:18 +0700
Message-ID: <CACsJy8DGS2KN5Vd=UY2nUBH1Nc9rMiTt84HNB9K=8z2H0m4zVg@mail.gmail.com>
References: <1419982898-23108-1-git-send-email-sbeller@google.com>
 <1419982898-23108-2-git-send-email-sbeller@google.com> <20150103022004.GI29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	ronniesahlberg@gmail.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 03 10:53:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7LP8-00053v-QN
	for gcvg-git-2@plane.gmane.org; Sat, 03 Jan 2015 10:53:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbbACJxu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2015 04:53:50 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:42423 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbbACJxt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2015 04:53:49 -0500
Received: by mail-ig0-f169.google.com with SMTP id z20so1279957igj.4
        for <git@vger.kernel.org>; Sat, 03 Jan 2015 01:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xoqsJo1IZdkXL+0+OlJI7PVeDVVlrEcpP1YhM/PYtQ4=;
        b=r7FpdVLeZs9SXhJ8Zxf77SG8EeIFXaOMvBzkx3SPzS2mSWYELOJRBehMYp3UbNbwWK
         rog2ybYWWiQ2Yb3f5ENdOTwfxobFRAUgLe1GcitDeGnAELaYIvOa0W2Bi3kuU2Lh0e4V
         waiIEmnB6kd/u9dKJN7RXqG3t6jZi4YpigvLociXkNjsYrDPTSospqdsMbqMVQ79eEXU
         LiVbsVp5yluApKGR560v6zRTC6LGMdQXYUl4eIgfTQU4qk8jdzztws1ZUmyXQHJCND5z
         Q/QKg2frYe1P3SyvsVzNfWUxNqzsEA+KK8eIbKMbr8pX/UVM6+OBwfQR8F+ESHn1HH+e
         FbMQ==
X-Received: by 10.43.64.146 with SMTP id xi18mr60865128icb.65.1420278828349;
 Sat, 03 Jan 2015 01:53:48 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Sat, 3 Jan 2015 01:53:18 -0800 (PST)
In-Reply-To: <20150103022004.GI29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261994>

On Sat, Jan 3, 2015 at 9:20 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>> -     if (shallow_update && !checked_connectivity)
>> -             error("BUG: run 'git fsck' for safety.\n"
>> -                   "If there are errors, try to remove "
>> -                   "the reported refs above");
>> +     if (shallow_update)
>> +             check_shallow_bugs(commands, si);
>
> In the same spirit of saving the reader from having to look at the
> body of check_shallow_bugs, would it make sense for the part that reacts
> to an error to be kept in the caller?  E.g.:
>
>         if (shallow_update && warn_if_skipped_connectivity_check(commands, si))
>                 error("BUG: run 'git fsck for safety.\n"
>                       "If there are errors, try removing the refs reported above");
>
> Is this error possible, by the way?

That code is to prevent bugs in future. The whole operation is spread
out in many functions/steps and people may overlook.

> update() does not return success
> unless it has reached the bottom block in the function.  In the
> !is_null_sha1(new_sha1) case that means it calls update_shallow_ref(),
> which performs the connectivity check.  In the is_null_sha1(new_sha1)
> case, update_shallow_info() does not set cmd->index and
> si->shallow_ref[cmd->index] cannot be set.
>
> Perhaps this error message could be written in a way that makes it
> clearer that we really expect it not to happen, like
>
>                 die("BUG: connectivity check skipped in shallow push???");
>
> (die() instead of error() to prevent refs from updating and pointing
> to a disconnected history).

If connectivity test is not done, we don't know if history is really
disconnected. But yeah die() may be better (err on the safe side).
-- 
Duy

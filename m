From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v6 12/42] replace.c: use the ref transaction functions for updates
Date: Thu, 15 May 2014 09:50:25 -0700
Message-ID: <CAL=YDWkOz2Xa_ZA4TJ2sh9oG9m18yDkEd=-252h+u7w3nG1ZVQ@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-13-git-send-email-sahlberg@google.com>
	<20140515003031.GI9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 18:50:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkyrX-0000Fi-0F
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 18:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753686AbaEOQu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 12:50:27 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:37464 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752525AbaEOQu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 12:50:26 -0400
Received: by mail-vc0-f177.google.com with SMTP id if17so4674338vcb.36
        for <git@vger.kernel.org>; Thu, 15 May 2014 09:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LqWJHsR2SALeET/Uik/tCoMl9fivx4p3dhFXouU1gWs=;
        b=h44V+qdwlyMdHHCxVZdtr7DHVLRWcaRuMiXySHhKxVVWWPOJNLcmyfO5Tqhz/xhhSe
         ASA9WGb7ZWYU5zzH7CbAkxSpeQaQtbjdzB6uHCa2uRyBas5iczxmrvyPhlwpl7/DcOlK
         lItLZrq5jFaxp0h44qQvjN2NiVeM5Bhhv78LOAALEwwC04GS1FmA2o7VC0Om9Iatmk8D
         oyT0hKJ+0dMYjPeo+LpIpGUNP/B23HPW6dmBML6Htpzosrtp+H+IliTajRC2FiD50Oan
         yQlZftqY5iI0mGSmTUT/cpf5HfhVThBtjHE1Nr+p1gmZ/VpTzmJ9guCvrqEZDh2fc9pT
         WMmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LqWJHsR2SALeET/Uik/tCoMl9fivx4p3dhFXouU1gWs=;
        b=Tq4BksM3pJM7ep40+Y/F4DYuXve17xmRxXz0B6TMOGeYgu/NK8RYdZQqj4YStYC3Zj
         igGnpYeJtz8eQklIbKO74T9NEoExFMBUddHvmT5D9sWKzCs/00s2zqBiOCuVAJ8JlPGM
         4X0bQtraJo34AgDjWHSl7csHK84uNyYTNOfVbhaU50pV5o+0VJEuaDQoMyS9D4X7c8Rb
         8Cy/emwvKnZBr0esD2FzR1cSFXd3zkF5SEt54zVq0ER6p8gwucpotAJ620JSdsw1Obd1
         rU9X1w28pMkptF8VNTKT0/6OA1wgii4e93RNZ5OxHCbcvQfJbRSjZ0K9eCEPjs8U8hcJ
         pAew==
X-Gm-Message-State: ALoCoQkxI59iIPN4ZYEECYi3sRJLm4LBtFBtNywWZ/QY9mPW26i+hI7+F4bDP0G3utW2KAdV6bBQ
X-Received: by 10.221.58.144 with SMTP id wk16mr9472435vcb.23.1400172625836;
 Thu, 15 May 2014 09:50:25 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 09:50:25 -0700 (PDT)
In-Reply-To: <20140515003031.GI9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249114>

On Wed, May 14, 2014 at 5:30 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
> [...]
>> +++ b/builtin/replace.c
> [...]
>> @@ -157,11 +158,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>>       else if (!force)
>>               die("replace ref '%s' already exists", ref);
>>
>> -     lock = lock_any_ref_for_update(ref, prev, 0, NULL);
>> -     if (!lock)
>> -             die("%s: cannot lock the ref", ref);
>> -     if (write_ref_sha1(lock, repl, NULL) < 0)
>> -             die("%s: cannot update the ref", ref);
>> +     transaction = ref_transaction_begin();
>> +     if (!transaction ||
>> +         ref_transaction_update(transaction, ref, repl, prev,
>> +                                0, !is_null_sha1(prev)) ||
>> +         ref_transaction_commit(transaction, NULL, &err))
>> +             die(_("%s: failed to replace ref: %s"), ref, err.buf);
>
> Same question about the !transaction case.
>
> This makes the message translated, which is a nice change but not
> mentioned in the commit message.  (Generally speaking, I don't mind
> either way about adding or not adding _() to new messages in files
> that have not already undergone a pass of marking everything for
> translation.)

Removed the _.  This series is long enough as is so lets not start
worrying about translations too.

Same opinion about the ref_transaction_begin() case as before. I think
it will be better to just add err to it
since it is likely this will be useful for future non-file based ref backends.

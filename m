From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH v3 17/19] pathspec.c: extract new validate_path() for reuse
Date: Fri, 28 Dec 2012 21:08:57 +0000
Message-ID: <CAOkDyE_XBcYxisnkneY2jV0Fiv4r=e_P45hYdSo9ru0Qq7TFCA@mail.gmail.com>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
	<1356575558-2674-18-git-send-email-git@adamspiers.org>
	<7v38ypj490.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 22:09:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TohBD-0006sW-S4
	for gcvg-git-2@plane.gmane.org; Fri, 28 Dec 2012 22:09:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084Ab2L1VI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2012 16:08:59 -0500
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33809 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab2L1VI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2012 16:08:58 -0500
Received: by mail-wi0-f178.google.com with SMTP id hn3so6115667wib.5
        for <git@vger.kernel.org>; Fri, 28 Dec 2012 13:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=WXgRStg8roi169NqinjGUVpGFAX058lR+DJjBWgCylE=;
        b=yf9U6j8hVrSQlEWLZ4Jr88q0iVLl16i/k/yLAIdBS2ik1NbgrWXpKvm/F2z71cULT6
         6O6/a0wXIsZ61YeZDnf3N1A3JbMyd2N5uXUcW17it1MR7Dy6AaSCcnSKqXFK9u0RaxIf
         opV+tMXxuwJhSWophfelr52A3JPG8uBB2uNZztn1aqm0FBAMg9D5pSBzZLK4gBqS3nJE
         cMhOKPDtzmFJ/nzgGb3becz6tLNcLToYeEa/v0mBtmAafmfxB6I8wfQkp2fVSYB3lHNC
         16c9Jn88aTv0VKRHKH0aY5JK3cQV9NADRATvPKDvAmDEzHyvom+YVFXggFLxNvt6gGAv
         z0sw==
Received: by 10.194.85.234 with SMTP id k10mr55351172wjz.53.1356728937541;
 Fri, 28 Dec 2012 13:08:57 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Fri, 28 Dec 2012 13:08:57 -0800 (PST)
In-Reply-To: <7v38ypj490.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: CS0NfAEea1ARys9jLuOPPmTlxYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212264>

On Fri, Dec 28, 2012 at 8:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Adam Spiers <git@adamspiers.org> writes:
>
>> This will be reused by a new git check-ignore command.
>>
>> Signed-off-by: Adam Spiers <git@adamspiers.org>
>> ---
>>  pathspec.c | 20 ++++++++++++++------
>>  pathspec.h |  1 +
>>  2 files changed, 15 insertions(+), 6 deletions(-)
>>
>> diff --git a/pathspec.c b/pathspec.c
>> index 8aea0d2..6724121 100644
>> --- a/pathspec.c
>> +++ b/pathspec.c
>> @@ -77,9 +77,20 @@ void treat_gitlinks(const char **pathspec)
>>  }
>>
>>  /*
>> + * Dies if the given path refers to a file inside a symlinked
>> + * directory.
>> + */
>> +void validate_path(const char *path, const char *prefix)
>
> The name needs to be a lot more specific.
>
> There may be 47 different kinds of "validations" various callers may
> want to do on a path, but this function only caters to one kind of
> callers that want to make sure that the path refers to something
> that we would directly add to our index.
>
>> +{
>> +     if (has_symlink_leading_path(path, strlen(path))) {
>> +             int len = prefix ? strlen(prefix) : 0;
>> +             die(_("'%s' is beyond a symbolic link"), path + len);
>> +     }
>> +}

Good point.  Which do you prefer of these suggested names?

- die_if_path_beyond_symlink()
- validate_path_not_beyond_symlink()
- die_if_symlink_leading_path()
- validate_no_symlink_leading_path()
- validate_path_addable_to_index()

Or something else?

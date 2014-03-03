From: Guanglin Xu <mzguanglin@gmail.com>
Subject: Re: [PATCH v3] branch.c: change install_branch_config() to use skip_prefix()
Date: Mon, 3 Mar 2014 14:20:48 +0800
Message-ID: <CAATe9ugFxfcPukBoboGsb6A_cVkEchk4SpG-VHVE+uCrRqj2wg@mail.gmail.com>
References: <1393813495-9079-1-git-send-email-mzguanglin@gmail.com>
	<CAJr59C1hoc6FPrgHLLy8_xBPNEvCkDHurGSETqPM5j51w7zrHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: He Sun <sunheehnus@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 07:20:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKMFB-0006Yb-C0
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 07:20:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbaCCGUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 01:20:49 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:36866 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbaCCGUt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 01:20:49 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so3873746iec.29
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 22:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=em6bvVzecQJfQ9ZRGv6FYrgP4L5YY7DiqrOmKsiheLs=;
        b=LhOsRLHjXju0Wkv1uQ3JspYZ8unyG5KsiXJaai7ey10kHdWP/TTkP2u7SKghsWi781
         mCd5Jul1w6DVl4QMby/ZV42iNoSAXRye4lai/CHhXXirI71Kj+/4Oi8TSfE9wRH8IQkz
         bezt1Kd7DlNowWOcZpaJfcRzZlKxWxN3Z31MMt8PqHiRUcoWIw29LtLc5Ty2RtpQxJU4
         7hU2/954xaQILdNFHjcRyWe3sEZMUUnV1htVoh8578LbLHlFrDVOstiIDzTZJF/H+tfZ
         H1cavcSblpcdCUXDHWBhw/qkEJ8ds7Udd0J+/LTdaUWX00G9aYbdEB69NPLarPIXj6Vg
         G7bw==
X-Received: by 10.50.154.66 with SMTP id vm2mr595996igb.4.1393827648494; Sun,
 02 Mar 2014 22:20:48 -0800 (PST)
Received: by 10.64.14.135 with HTTP; Sun, 2 Mar 2014 22:20:48 -0800 (PST)
In-Reply-To: <CAJr59C1hoc6FPrgHLLy8_xBPNEvCkDHurGSETqPM5j51w7zrHg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243177>

2014-03-03 13:39 GMT+08:00 He Sun <sunheehnus@gmail.com>:
> 2014-03-03 10:24 GMT+08:00 Guanglin Xu <mzguanglin@gmail.com>:
>> to avoid a magic code of 11.
>>
>> Helped-by: Eric Sunshine <sunsh...@sunshineco.com>
>> Helped-by: Jacopo Notarstefano <jaco...@gmail.com>
>> Signed-off-by: Guanglin Xu <mzguanglin@gmail.com>
>> ---
>>
>> This is an implementation of the idea#2 of GSoC 2014 microproject.
>>
>>  branch.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 723a36b..3e2551e 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -49,7 +49,7 @@ static int should_setup_rebase(const char *origin)
>>
>>  void install_branch_config(int flag, const char *local, const char *origin, const char *remote)
>>  {
>> -       const char *shortname = remote + 11;
>> +       const char *shortname = skip_prefix(remote ,"refs/heads/");
>>         int remote_is_branch = starts_with(remote, "refs/heads/");
>
> Or it may be better to keep remote_is_branch, and replace starts_with
> with something
> you have just fixed.

Hi He,

Thanks for your comments.

This PATCH v3 scans the "remote" twice. It's unnecessary at all. So I
decide to post PATCH v4 like this:

- const char *shortname = remote + 11;
- int remote_is_branch = starts_with(remote, "refs/heads/");
+ const char *shortname = skip_prefix(remote ,"refs/heads/");
+ int remote_is_branch;
+ if (NULL == shortname)
+ remote_is_branch = 0;
+ else
+ remote_is_branch = 1;

Guanglin


>
>>         struct strbuf key = STRBUF_INIT;
>>         int rebasing = should_setup_rebase(origin);
>> --
>> 1.9.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

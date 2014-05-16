From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 23/44] fetch.c: change s_update_ref to use a ref transaction
Date: Fri, 16 May 2014 15:22:15 -0700
Message-ID: <CAL=YDW=0DA_pxrD75n-MN1N5QyEJV36w5HkvoBUC04gZyaxNUw@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-24-git-send-email-sahlberg@google.com>
	<20140516191231.GE12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 17 00:22:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlQWD-0003P4-Qz
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 00:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312AbaEPWWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 18:22:17 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:43382 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756277AbaEPWWQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 18:22:16 -0400
Received: by mail-vc0-f180.google.com with SMTP id hy4so6939430vcb.39
        for <git@vger.kernel.org>; Fri, 16 May 2014 15:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ySinGrUi1qDiCFsEBqmu/gZuz/idaaSr8G494El1AZU=;
        b=WyYNKHdmFZpJK1ViUbNxEiKxSTY1CymyCpBZK7E0Q0FjshRK76P6Dz4bt3ihegmi1Y
         gHh/g/tUg5NoVczwJBtsSKB+ASKqL+gHucrC86iwySAY5xsFxBh776Ulyyee/+GpU+E6
         3kbn3PpSAXYIYRqWCDfzsWtHNGkBjLnI4TcQOwi6NQ8Q32RZj4cbWQnLlbDAInQzxazV
         LmLgyE6mD1qbdm7bn4ZYDTlw8HdBbPCG/Lys3mxOig3ZgGDf6BYLfDalL2Y2V9hfe9pm
         rdXA/geXFwmR6fpARk2kvTBA4m5ZpLrLRUVg+Mwg09uisMWKc3FtIi3P4lSvA8nOaDQ5
         vNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ySinGrUi1qDiCFsEBqmu/gZuz/idaaSr8G494El1AZU=;
        b=BwueW0YGTqmiv8iBatToqf9LxVm2GR+RKZl2mq3H3QLKBwH8+tJhNui9f15eMKO9to
         tc3d4t+nCZiZbHo9mPRIvDuQqqHY1Bow+u4xMWqNc+GM29WSXqxwu4Xiy52kqgvHUOez
         26LmUOCgM78ChQ5lNtZcJnHWzgZuqNQ1x7OnhuKWYAv/ZTST6D66Lp5/sVbwGMpWMuaU
         i5db2NPWiZsTwvnc9fjz7fHw5SkVHgAmRFciKQZ1Iz9ZQZ/Gfg0V77hVO0GZgaBwVbVR
         0xrLDdbbQi/iJQ0EY+qAhHSzqSmhAc7alcI/sqHaMVkObxYzVHw89IuG5H474B6ILjWR
         toMg==
X-Gm-Message-State: ALoCoQnemYzOrZCnART5H7rtuI2cZb8bCQxAYlT1GN6fwPstGA5EkQ373b0kZck90QLLIlsle21C
X-Received: by 10.58.23.6 with SMTP id i6mr16218676vef.12.1400278935223; Fri,
 16 May 2014 15:22:15 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Fri, 16 May 2014 15:22:15 -0700 (PDT)
In-Reply-To: <20140516191231.GE12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249423>

On Fri, May 16, 2014 at 12:12 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> (+cc: peff for STORE_REF_ERROR_DF_CONFLICT expertise)
> Ronnie Sahlberg wrote:
>
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -375,7 +375,7 @@ static int s_update_ref(const char *action,
> [...]
>> +     transaction = ref_transaction_begin();
>> +     if (!transaction ||
>> +         ref_transaction_update(transaction, ref->name, ref->new_sha1,
>> +                                ref->old_sha1, 0, check_old) ||
>> +         ref_transaction_commit(transaction, msg, NULL)) {
>> +             ref_transaction_rollback(transaction);
>>               return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
>>                                         STORE_REF_ERROR_OTHER;
>> +     }
>
> I'd rather not rely on errno here (see the previous patch for why).
> Is there some other way to distinguish the case where a ref couldn't
> be created because there was a prefix of that ref in the way?
>
> For example, maybe ref_transaction_commit could return a different
> negative integer in this case.

I have changed it to make transaction_commit will return a special
error if there is a name conflict
and fetch.c now uses that instead of looking at errno to decide if to
print the "try pruning" message.


>
> Thanks,
> Jonathan

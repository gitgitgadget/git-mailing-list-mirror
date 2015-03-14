From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v3 1/4] git-credential-store: support multiple credential files
Date: Sat, 14 Mar 2015 16:15:53 +0800
Message-ID: <CACRoPnR9pTc2LC87Vf0bMAgTj-FnbsRBpjn+3RCxCP6yrzsCkw@mail.gmail.com>
References: <1426056553-9364-1-git-send-email-pyokagan@gmail.com>
	<1426056553-9364-2-git-send-email-pyokagan@gmail.com>
	<20150313061530.GA24588@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 14 09:16:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWhEz-0008By-N4
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 09:16:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbbCNIQC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 04:16:02 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:34695 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbbCNIPz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 04:15:55 -0400
Received: by lagg8 with SMTP id g8so6015092lag.1
        for <git@vger.kernel.org>; Sat, 14 Mar 2015 01:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TIkZ2Hm6NZQ0b6kiarMVBGAxqEW+PNhCbCopyLdp40c=;
        b=WP5vHC/2zoAZQy4hlAGAPk9FKrOKy6yUycBsKNYKKxkAUGc/PnxutaPCJEILLaZLzF
         Dj1pUmFUbPzvbOB2I+kKnall1CObDtx3lHUV+bvPH9/keo/IyT+FN0LCAV2hUTKOIilT
         1Q/szVcPzqfarzmpWp2QznnImeylsgKolNW5uJUV6XPfiJ0LcsB5tV/QUEHhpNwd8Oiv
         cWMZN8BXCi+BoZfF9vX7Xsr5rqua2tqtUk/wqomIUyqD0jLEkTMm1aUtf5bpt6bWnLv2
         LV2PXgyVxT5rpC7pJOBx0M7ZIumeAxxwSS+yJe9sK3wmX+BFT6RhE8pSQ49ccENs9Mbw
         p5dQ==
X-Received: by 10.112.46.201 with SMTP id x9mr46869626lbm.65.1426320953258;
 Sat, 14 Mar 2015 01:15:53 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Sat, 14 Mar 2015 01:15:53 -0700 (PDT)
In-Reply-To: <20150313061530.GA24588@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265441>

On Fri, Mar 13, 2015 at 2:15 PM, Jeff King <peff@peff.net> wrote:
>> +static void store_credential(const struct string_list *fns, struct credential *c,
>> +                          const char *default_fn)
>
> I think you could even get away without passing default_fn here, and
> just use the rule "the first file in the list is the default". Unless
> you are anticipating ever passing something else, but I couldn't think
> of a case where that would be useful.

Even though in this case the store_credential() function is not used
anywhere else, from my personal API design experience I think that
cementing the rule of "the first file in the list is the default" in
the behavior of the function is not a good thing. For example, in the
future, we may wish to keep the precedence ordering the same, but if
none of the credential files exist, we create the XDG file by default
instead. It's a balance of flexibility, but in this case I think
putting the default filename in a separate argument is a good thing.

>> +     struct string_list fns = STRING_LIST_INIT_NODUP;
>
> This is declared NODUP...
>
>> -     if (!file)
>> +     if (file)
>> +             string_list_append_nodup(&fns, file);
>
> So you can just call the regular string_list_append here (the idea of
> declaring the list as DUP or NODUP is that the callers do not have to
> care; string_list_append does the right thing).

Actually, thinking about it again from a memory management
perspective, STRING_LIST_INIT_DUP should be used instead as the
string_list `fns` should own the memory of the strings inside it.
Thus, in this case since `file` is pulled from the argv array,
string_list_append() should be used to duplicate the memory, and for
expand_user_path(), string_list_append_nodup() should be used because
the returned path is newly-allocated memory. Finally,
string_list_clear() should be called at the end to release memory.

Thanks for taking the time to review the patches, I will work on v4
now. (Really keen on getting this to pu)

Regards,
Paul

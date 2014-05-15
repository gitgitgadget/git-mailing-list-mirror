From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 13/44] tag.c: use ref transactions when doing updates
Date: Thu, 15 May 2014 15:27:08 -0700
Message-ID: <CAL=YDWn5hNte5dAyddyHaGoYV3+8gW=qj2KqDkWxn+djQgOcbA@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-14-git-send-email-sahlberg@google.com>
	<20140515211156.GK26471@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 00:27:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl47O-0007lG-8V
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 00:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932AbaEOW1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 18:27:10 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:64036 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751582AbaEOW1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 18:27:09 -0400
Received: by mail-vc0-f175.google.com with SMTP id hu19so5179985vcb.6
        for <git@vger.kernel.org>; Thu, 15 May 2014 15:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dyM+g0Xp8t7eO2PRT9Yh2pfHlNYzCTv2ta9PXzSdHCw=;
        b=BOhQ5edowq1GAegv4XwfN0ITSQK9DqkqU/R0UVNi/U2nnV49ngaFOf9C5RIHUnfcPd
         KIcA70cAqTfzvkmSNkINyeiGutRgJAIJHHPNYUyd8agymnLtF19qGndZE++sJk3m35cp
         hubZ0u5sAYHr6hy3ZEgdjYLz9mAabm92TrLNGfNN1YY+0gsBhFwNsrOFfW85NmZQHCu9
         YkNCjw193poJd30EjasjTCVzX1T5Dz9fwMupEuZWSNifI2mTHuKxfrgh2D2/Whz8R8Ex
         JoJBwPPP7/FqrdyyaV6NOFy7fJ9eOIVirSOFj4n5S0w0C6AZkthwRPgQsEB9hxjTpZzY
         1cNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=dyM+g0Xp8t7eO2PRT9Yh2pfHlNYzCTv2ta9PXzSdHCw=;
        b=CSl9KBsm3yrTsEtCGXd/vcJ7PzxiJAMNMQtq8t9AMUU1zJvAW24FIgmg9OKZdMUStZ
         DHPei9TZKwH3dznfUDHKniThObpF3WYNxLe1a6/PmdAwyEj92OnMewTXk6ICmcXT9Kzg
         dEyVtXg2DpiEfZmqTA0XyT1bxGmwqBGP54COEoaojW+C+3uJ56HiH42pVwdqhygBpuU5
         KE6W7QRNZ+c36dvIQhUDCg3xyZRgRo3Sz/51xM+H/p5a8dFN4ZgvJi8FZYuFqR2eCfpx
         H13dQ4DbzckMpPUH3fZ8bESRR+vTtHCtiqvuPSHIHXtymJITF5r443Jf3nGhtG1UW+5V
         UhjA==
X-Gm-Message-State: ALoCoQko00jiDcE1EW6eC+Iv5nlfe3a5nYer3+QRubgSBlPtJE7UqiVZO2yEBlEGMjiMAZMyqhhv
X-Received: by 10.58.209.233 with SMTP id mp9mr3816289vec.30.1400192828794;
 Thu, 15 May 2014 15:27:08 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 15:27:08 -0700 (PDT)
In-Reply-To: <20140515211156.GK26471@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249212>

On Thu, May 15, 2014 at 2:11 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -701,11 +702,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>       if (annotate)
>>               create_tag(object, tag, &buf, &opt, prev, object);
>>
>> -     lock = lock_any_ref_for_update(ref.buf, prev, 0, NULL);
>> -     if (!lock)
>> -             die(_("%s: cannot lock the ref"), ref.buf);
>> -     if (write_ref_sha1(lock, object, NULL) < 0)
>> -             die(_("%s: cannot update the ref"), ref.buf);
>> +     transaction = ref_transaction_begin();
>> +     if (!transaction ||
>> +         ref_transaction_update(transaction, ref.buf, object, prev,
>> +                                0, !is_null_sha1(prev)) ||
>> +         ref_transaction_commit(transaction, NULL, &err))
>> +             die(_("%s: cannot update the ref: %s"), ref.buf, err.buf);
>
> The error string says what ref it was trying to update, so
>
>                 die("%s", err.buf);
>
> should be enough.  (E.g.,
>
>         fatal: refs/tags/v1.0: cannot lock the ref
>
> would become
>
>         fatal: Cannot lock the ref 'refs/tags/v1.0'.
>
> instead of
>
>         fatal: refs/tags/v1.0: cannot update the ref: Cannot lock the ref 'refs/tags/v1.0'.
>
> .)
>

Done.

Thanks!

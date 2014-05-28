From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 23/41] refs.c: change update_ref to use a transaction
Date: Wed, 28 May 2014 14:14:35 -0700
Message-ID: <CAL=YDWkCN1ZW48YM3pwVoRLu4-TPwa4cr1m420H+LLx=DBvM=g@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-24-git-send-email-sahlberg@google.com>
	<20140528193139.GW12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 23:14:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WplBI-00014N-IV
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 23:14:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771AbaE1VOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 17:14:37 -0400
Received: from mail-vc0-f180.google.com ([209.85.220.180]:47099 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbaE1VOg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 17:14:36 -0400
Received: by mail-vc0-f180.google.com with SMTP id hy4so13145757vcb.11
        for <git@vger.kernel.org>; Wed, 28 May 2014 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qFjyNamCKWeK2rCIzlgmfinlULkGwjs7fGQFVsvqaZA=;
        b=ho3iOgYOyzBde87fp2hvLL98jm4i3g6TFTn/FuufExrcSqK7iVDYLKzbNwQD6BDx6g
         PGFxb4KnIczk0SQB6FF0Dw85i17eFiYBwvk2gmzM4qbzdGXNXyT+AMYDj5VnKOkKNAcD
         1DzCccur498IH4I/SYJOfN2SLTF5+qYUqUVW9CCs9t6EfSLBxlrqclGTmuECoQWv2NYJ
         Rz7Q3pBTs2Zx0Ogo9mMovS1zMA+gNvUEMUnvgNbz4TkPteIENQyM6UTqEefSD3L7S+mc
         qH3yX+7iqfNtNhd/2ioC4doORMYfzRFhVDE9oD7UYgPGH+F4LQnrXJxCVvQ7EzC8rDN3
         mkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=qFjyNamCKWeK2rCIzlgmfinlULkGwjs7fGQFVsvqaZA=;
        b=cZq3NPtnfVvTs2s0/glndLIoP9epX8u52eot0T3FEr3RAxeduFJ/rUfIUXj/0H1E4U
         G4csMFB5m5atQv3TD0/dTPf2qvPxXb/JT2sLUWU9zlG/6orS1GZAGHv6d9Wp1V8VeOY/
         n0si64vvw8l8Pd0l45wpOLRArloxYxbfk0aG1LHAOw4pON7aNxPI8MPbqPOBuheAu13C
         sSeSgbjWaJsZuCEay8LSFVKJoFRZzTyWc7UbI4/QpoW/uakd2BU9VAuDRhzldt7F0q1s
         +aSE5PgJ3XFPXVuPyPSGnlDaElQG3wkrRFk6dcFUu3iMdc7YeF+AQrl1os8xDfmYbT1J
         L33A==
X-Gm-Message-State: ALoCoQk9jDzmxVkSDOElnW/2md4d6R5c05RSiqJuCpuEeTGTCULxHyBlRpuY9PMqoKVq/nElDI4l
X-Received: by 10.220.18.134 with SMTP id w6mr2549650vca.5.1401311675687; Wed,
 28 May 2014 14:14:35 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 28 May 2014 14:14:35 -0700 (PDT)
In-Reply-To: <20140528193139.GW12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250330>

Done.
Thanks.

On Wed, May 28, 2014 at 12:31 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3474,11 +3474,28 @@ int update_ref(const char *action, const char *refname,
>>              const unsigned char *sha1, const unsigned char *oldval,
>>              int flags, enum action_on_err onerr)
>>  {
>> -     struct ref_lock *lock;
>> -     lock = update_ref_lock(refname, oldval, flags, NULL, onerr);
>> -     if (!lock)
>> +     struct ref_transaction *t;
>> +     struct strbuf err = STRBUF_INIT;
>> +
>> +     t = ref_transaction_begin(&err);
>> +     if ((!t ||
>> +         ref_transaction_update(t, refname, sha1, oldval, flags,
>> +                                !!oldval, &err)) ||
>
> (style) Extra parens.
>
>> +         (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
>
> No need for this assignment-in-if.
>
> With the following squashed in,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> diff --git i/refs.c w/refs.c
> index 568b358..fb462a3 100644
> --- i/refs.c
> +++ w/refs.c
> @@ -3474,10 +3474,10 @@ int update_ref(const char *action, const char *refname,
>         struct strbuf err = STRBUF_INIT;
>
>         t = ref_transaction_begin(&err);
> -       if ((!t ||
> +       if (!t ||
>             ref_transaction_update(t, refname, sha1, oldval, flags,
> -                                  !!oldval, &err)) ||
> -           (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
> +                                  !!oldval, &err) ||
> +           ref_transaction_commit(t, action, &err)) {
>                 const char *str = "update_ref failed for ref '%s': %s";
>
>                 ref_transaction_free(t);

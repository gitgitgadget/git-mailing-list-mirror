From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 14/44] replace.c: use the ref transaction functions for updates
Date: Thu, 15 May 2014 15:30:39 -0700
Message-ID: <CAL=YDWk0S4StNcZhz6JDBEe2dpvVsCTqROZ+100Cv012t9FNrg@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-15-git-send-email-sahlberg@google.com>
	<20140515211835.GL26471@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 16 00:30:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl4Am-00007X-0b
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 00:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbaEOWak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 18:30:40 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:35771 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbaEOWaj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 18:30:39 -0400
Received: by mail-ve0-f169.google.com with SMTP id jx11so2142560veb.14
        for <git@vger.kernel.org>; Thu, 15 May 2014 15:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vyKJOUNxYtEGs+Yu5eYHMsQLLWDs36/82v/xMrGOEEA=;
        b=b8Etq1JYmlPERzvVTG9Zvw3XqPORWJUhWHV0muXHfnOj4k9VaBGscAVRc0cwDhxW2I
         JmQMW9F6eztfhjTSQEgTdJePh8JxOC4aPDYrEFbAEqbLmx63ew7Grpxgqy/5yBcLTeOR
         SYOJy/KEJkh/TTnMU+xNd2Az2RiTLZaFN044CPGTlOZPLV0Qwuaii6hvonFYYY7U+JW9
         ORVBCUMbFUdiYlyJyN6BmwLRT+Ws8nAAjhcRiwD7NnYrgzuWTnLnb7TNoB+Lbv9iBI+D
         2bkOsma06izsrXuhDVvtO4GpIGjDuI/CM5oiJCM8DOJwgG8MSKTUJHPTJLqOFtaFUPCR
         SDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vyKJOUNxYtEGs+Yu5eYHMsQLLWDs36/82v/xMrGOEEA=;
        b=hUn2n0/VxdwTUFX1mNnhMRw68NXn0fffIKYZlyMXWgHTCFz0V/MLvL6ujs03vTMkw1
         9Uq31Kok8EoCI8TRpXe2q5X3P6VGWsSRLMciJOQPnVfy+teufMB3ui5qnrXwh1zdfDpT
         jicauIzv/xUEb59frG8JJlzQYedNCATUA30/a4QZbr/axXEUFywhkYGQ8wr0Lv1dVfbi
         YsBzj6c5quZ6i6PO7y+SF83W+arzwCzqMUlLHCYlS26x7jxDVMHf+s7p3MyZZWjp4WuJ
         Jo/UpM2d+g4PZZ0Sw+5X8fJFjCFxZexH0dM2mqP/wPJM/uPMmkjKasz6ZnG8VmTTlL+A
         fRNQ==
X-Gm-Message-State: ALoCoQnUKBeAJTgnSg7HC050UwgFUmypduYwIpufblHadHa2ZTN2AW4g1a9MDFa/CCJV+FlrBEOj
X-Received: by 10.58.13.104 with SMTP id g8mr10634551vec.16.1400193039145;
 Thu, 15 May 2014 15:30:39 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 15:30:39 -0700 (PDT)
In-Reply-To: <20140515211835.GL26471@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249213>

On Thu, May 15, 2014 at 2:18 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/builtin/replace.c
>> +++ b/builtin/replace.c
> [...]
>> @@ -156,11 +157,12 @@ static int replace_object_sha1(const char *object_ref,
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
>> +             die("%s: failed to replace ref: %s", ref, err.buf);
>
> This would write
>
>         fatal: refs/replace/09c779943364d893c190066c385e6112af421db3: failed to replace ref: Cannot lock the ref 'refs/replace/09c779943364d893c190066c385e6112af421db3'.
>
> Perhaps something like
>
>         $ git replace foo bar
>         fatal: replace foo: Cannot lock the ref 'refs/replace/09c779943364d893c190066c385e6112af421db3'.
>
> would make sense (die("replace %s: %s", object_ref, err.buf)).  Plain
>
>         $ git replace foo bar
>         fatal: Cannot lock the ref 'refs/replace/09c779943364d893c190066c385e6112af421db3'.
>
> also seems fine (die("%s", err.buf)).

Done.

I used : die("%s", err.buf)
since this is consistent with most of the other if-transaction-failed-die()

>
> Thanks,
> Jonathan

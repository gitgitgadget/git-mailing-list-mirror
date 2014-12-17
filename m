From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 4/6] receive-pack.c: use a single ref_transaction for
 atomic pushes
Date: Wed, 17 Dec 2014 15:58:24 -0800
Message-ID: <CAGZ79kZCTb5Uj34Kj-qnQEWmD+4=3U8LyeHxQWmLg-ozJr7Azg@mail.gmail.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418841177-12152-1-git-send-email-sbeller@google.com>
	<1418841177-12152-5-git-send-email-sbeller@google.com>
	<xmqqa92l97u1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 18 00:58:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1OU9-0004r1-SV
	for gcvg-git-2@plane.gmane.org; Thu, 18 Dec 2014 00:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbaLQX60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2014 18:58:26 -0500
Received: from mail-ie0-f170.google.com ([209.85.223.170]:44341 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaLQX6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2014 18:58:25 -0500
Received: by mail-ie0-f170.google.com with SMTP id rd18so119393iec.29
        for <git@vger.kernel.org>; Wed, 17 Dec 2014 15:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9uo214yFCjKSnOxYMlgjffJrV5DvGe9xdRZ7I/zCl1M=;
        b=kTE+XXJ/7Tg/RsAExKU4qsaxa1h2iAqEgcfkqUFJu0zdLqFHA83oChE9zv08jBfjE9
         ReYIQrvuB2fcCZrH1XeOdLMD3EPetYiKftsySF5GdIgjXgxWxGn8TLD+Waw+ihoXeaB8
         zs3ZodbjKkmnEfvk175yXlhA4vulX9p5MVJbrSAURZuVEBoMNQ264/2ECE9gXZxVLvLv
         /Qx23A5V3E6JfIQGBjTwOZXq+QjIqQ8uROZEEve3oSwmXLPA1S9PDE5dogZW+XpwmuYa
         almIKVI0yqSKjwZO9sjuZSuRfPCiUElf+mL77hSF1WvJJoaTgC9xQ20Y9hC32y8bImbD
         HXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=9uo214yFCjKSnOxYMlgjffJrV5DvGe9xdRZ7I/zCl1M=;
        b=MRG6D6Nv3R1vVruHxWVT152uVYOUuue+WlMsV7JZgDE3QAkgNc7aZDVyDkQKxCZPVY
         Ji/VJ7NnLX8piWU4X7F8aGxxzKXuIpOBf9Ocl0/0oJ9Syn6+HhcMZTKeMVcaQPRqHXeG
         LQgWY0mpo5UwztiRNFepE3RLHao/xJVkhqKGGeSmtRl8UWbxb5VFYzIrgGQL5gpoBgY6
         2JgsRmMOtB4jAxQo6TFMmYiwY0fQRCh4SRN145uuA8xknqHEUDAztqhoyYEmTJIoAY7l
         HYFbxm946KULR3Uwy5abJ+1rF+PkLqscm5v6N3FhDj6K6aZaehsMgvHRvyrlOL+9ISvj
         wPAw==
X-Gm-Message-State: ALoCoQlDJHjp5IsR3DyPomzYEeReQoiZfCGllPKhqXIsLDTIcsPw4FNAN1617JD+65a4DAoFLEzw
X-Received: by 10.50.134.195 with SMTP id pm3mr593805igb.0.1418860704703; Wed,
 17 Dec 2014 15:58:24 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Wed, 17 Dec 2014 15:58:24 -0800 (PST)
In-Reply-To: <xmqqa92l97u1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261509>

On Wed, Dec 17, 2014 at 3:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> @@ -1086,8 +1100,25 @@ static void execute_commands(struct command *commands,
>>
>>               if (cmd->skip_update)
>>                       continue;
>> -
>> +             if (!use_atomic) {
>> +                     transaction = ref_transaction_begin(&err);
>> +                     if (!transaction) {
>> +                             rp_error("%s", err.buf);
>> +                             strbuf_release(&err);
>> +                             cmd->error_string = "failed to start transaction";
>> +                             return;
>> +                     }
>> +             }
>>               cmd->error_string = update(cmd, si);
>> +             if (!use_atomic)
>> +                     if (ref_transaction_commit(transaction, &err)) {
>> +                             ref_transaction_free(transaction);
>> +                             rp_error("%s", err.buf);
>> +                             strbuf_release(&err);
>> +                             cmd->error_string = "failed to update ref";
>> +                             return;
>> +                     }
>
> Hmm, should the code even attempt to commit if update() returned a
> non NULL, signaling a failure?
>
> Or would we want to do this instead?

This would change the current behavior. In the case of !atomic we want
to consider all commands and not stop early.

So maybe more
if (!cmd->error_string) {
        if (!use_atomic
            && ref_transaction_commit(...)) {
            ...
        }
} else {
        if (use_atomic)
             goto check_atomic_commit;
}

and the  check_atomic_commit label is replacing the loop to check:
-        for (cmd = commands; cmd; cmd = cmd->next)
-                if (cmd->error_string)
-                        break;
+ check_atomic_commit:

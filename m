From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv2 4/6] receive-pack.c: use a single ref_transaction for
 atomic pushes
Date: Tue, 16 Dec 2014 15:30:38 -0500
Message-ID: <CAPig+cQu48Woi-TbbSe1=hsnh1EgGzV781gV_tZQwjVFoHy2Bg@mail.gmail.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-4-git-send-email-sbeller@google.com>
	<CAPig+cRkPZ8-MQyDs_S-3UXy2JUP6nLzjCE-pmpOa4Z4gyQKEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>, ronniesahlberg@gmail.com,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 21:30:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0ylX-0007l1-E3
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 21:30:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbaLPUaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 15:30:39 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:63682 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbaLPUai (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 15:30:38 -0500
Received: by mail-yk0-f171.google.com with SMTP id 142so6240400ykq.16
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 12:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7JkHV2gD5l5qVYZYx5BaoTWhfdEEIWnLgr4IyrYnzU4=;
        b=BNSR2/hwC4aXO7P/QKFt5K/qGb2EYzU50Ujo2rW4KkMNO1xRrpafsiJrwqHKX3Fdn4
         +P621+q3g/MAkE0tgnwQxzQY7uMjp8BCjF/rXjUg0Z9B800zAhZsPtCFjADKv7h7pd+Q
         Zv3jREPKXGpGup+hsSi7mRDOj3/9mUogx/V+rqehVBTbvM4reZMt4l0oQqOr9KOhItS/
         EMeSZseS6QgyPcW75e0gpRhRjOcF99DJaj47DE8ZRhZER9OfXJ7W+MXITilAc5rPsY5W
         o2lSuOUvZKNmWaGx+pthXyeyh8/GdxnisZQ+1epryvfiIPZVrz5PnGAjAi7wypITKPVi
         73ug==
X-Received: by 10.170.133.5 with SMTP id z5mr32208775ykb.2.1418761838057; Tue,
 16 Dec 2014 12:30:38 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Tue, 16 Dec 2014 12:30:38 -0800 (PST)
In-Reply-To: <CAPig+cRkPZ8-MQyDs_S-3UXy2JUP6nLzjCE-pmpOa4Z4gyQKEg@mail.gmail.com>
X-Google-Sender-Auth: Wvs_8M8TW-Kc5k4ZuDTgzqphcig
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261466>

On Tue, Dec 16, 2014 at 2:29 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Dec 16, 2014 at 1:49 PM, Stefan Beller <sbeller@google.com> wrote:
>> ---
>> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
>> index e76e5d5..0803fd2 100644
>> --- a/builtin/receive-pack.c
>> +++ b/builtin/receive-pack.c
>> @@ -1059,6 +1059,16 @@ static void execute_commands(struct command *commands,
>>                 return;
>>         }
>>
>> +       if (use_atomic) {
>> +               transaction = ref_transaction_begin(&err);
>> +               if (!transaction) {
>> +                       error("%s", err.buf);
>> +                       strbuf_release(&err);
>> +                       for (cmd = commands; cmd; cmd = cmd->next)
>> +                               cmd->error_string = "transaction error";
>> +                       return;
>> +               }
>> +       }
>
> Not seen in this diff, but just below this point, the pre-receive hook
> is invoked. If it "declines", then execute_commands() returns without
> releasing the transaction which was begun here. Is that correct
> behavior?
>
> For robustness, it might also be sane to release the 'err' strbuf at
> this early return (though the current code does not strictly leak it).

To clarify: By "this early return", I mean the early return taken when
pre-receive hook declines.

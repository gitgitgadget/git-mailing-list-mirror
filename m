From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2] run-command: detect finished children by closed pipe
 rather than waitpid
Date: Mon, 23 Nov 2015 11:01:12 -0800
Message-ID: <CAGZ79kYte2-1ddbFOnWL5NFAuK6auLDD2n47Dz+6FcZCpC1vTA@mail.gmail.com>
References: <1448053719-28340-1-git-send-email-sbeller@google.com>
	<5650161E.9060305@web.de>
	<CAGZ79kYs9+UTx__yccy6qZY+Xn4onWx3zpH51pzHPn8Hz_FMww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 23 20:01:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0wMj-0000JS-Dm
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 20:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbbKWTBP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2015 14:01:15 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:36806 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100AbbKWTBN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2015 14:01:13 -0500
Received: by ykdr82 with SMTP id r82so247383315ykd.3
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 11:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=W6QjGZAYgxe1exnJHt5Y0dORyc8qB6nrAGNQiVPGJQc=;
        b=Z6wXGcVAZ25W+Hkc/JN+MoSDbmU0iA5WNgiZvp8nCESE2W5mZ/OhOafO/GC0zT4USA
         wGLA0DKvVKUpq8OVulxqDqmAnJ8//6UuhMX06jtMBN283zkbkx12KuO+K6SIEBePq5yZ
         wwZ8We4wOISuzbMA8/xJVFZTN+fLF7kkXLtzfS63FMY+4NSIUEVmZkUaJAf2oTACc4FI
         Rna/aSgjsjtb5O8FAZvNGk2NJsme2T2r4zESehBY9bxH0wHnQLUIsdSzEnqDWLDR3l5d
         qSXDjkeRcs5/qjqr7TEWRqLXrurYlfa1yzPT8P3vbWQJ+QduETJZzqvq0ulhNBg0dF8w
         6YpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=W6QjGZAYgxe1exnJHt5Y0dORyc8qB6nrAGNQiVPGJQc=;
        b=Dmm9hNuzSOhWWAIy61GijVlCG3xy7Vdb65OsABO7O0JC9XnsmKESjFHX7k5wsB2cfB
         lEzSLmESjFqM+uvyRKs+SRCSMGYRZL//Uuge57NKx8+OM0IuYhC5iQZzWxQOBSoem/Vt
         +3TdnT8DTcz/TPYNr30uZSk3OmuX+4y9xYPHYcfkLJo4r6cOLFRAipnQxq0VPg+WRT2f
         0ReUWZ76wwRLFmN57du5b+8ul4mLb3fbQAtIH9xhoZOSzWLADxaGNEIiDmu4RUwR2bKg
         YKbA3QR9j5vgS1SppwPAPkR5r+HUsm2eg+v2gqIhNv9yMcC+Rk2NvpBzzergX+1CaGNO
         ogJw==
X-Gm-Message-State: ALoCoQmEG8fdsM7D/ZqHDgL/6QGWMoEcYqUZI7lkefe6/K1CSsQSl5AZdTT4untFwVKk6dBA7Rbf
X-Received: by 10.13.221.15 with SMTP id g15mr5532971ywe.320.1448305272734;
 Mon, 23 Nov 2015 11:01:12 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Mon, 23 Nov 2015 11:01:12 -0800 (PST)
In-Reply-To: <CAGZ79kYs9+UTx__yccy6qZY+Xn4onWx3zpH51pzHPn8Hz_FMww@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281595>

On Mon, Nov 23, 2015 at 10:44 AM, Stefan Beller <sbeller@google.com> wr=
ote:
> On Fri, Nov 20, 2015 at 10:58 PM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>> On 2015-11-20 22.08, Stefan Beller wrote:
>> The patch looks good at first glance, one minor remark below:
>>>
>>> diff --git a/run-command.c b/run-command.c
>>
>>> @@ -1071,70 +1089,31 @@ static void pp_output(struct parallel_proce=
sses *pp)
>>>
>>>  static int pp_collect_finished(struct parallel_processes *pp)
>>>  {
>>> -     int i =3D 0;
>>> -     pid_t pid;
>>> -     int wait_status, code;
>>> +     int i, code;
>>
>> code is probably "return code"?
>> woud "ret_value", "res" or "rc" make that more clear ?
>>
>

Although looking through the code, we have lots of functions
having a local `code` variable, so we may want to preserve consistency
across the different functions to have a `code`which contains the retur=
n
value of the process or function invoked.

We had the `code` already in pp_collect_finished, so I'd like to not
rename a variable (which was used for the same purpose) in this patch.

In pp_start_one we introduce a new variable `code` which contains
the return from the user callback function, so I would understand if
we were arguing there.

That said, I plan to resend with a reworded commit message later today.

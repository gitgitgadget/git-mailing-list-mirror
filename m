From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] submodule--helper: initial clone learns retry logic
Date: Thu, 9 Jun 2016 16:38:27 -0700
Message-ID: <CAGZ79ka1=nH5iYB_jbNm8gsVYcMiZHVnKg49kEUuEMiL9PaqXQ@mail.gmail.com>
References: <20160609190637.21177-1-sbeller@google.com> <20160609190637.21177-2-sbeller@google.com>
 <xmqqy46egofw.fsf@gitster.mtv.corp.google.com> <CAGZ79kbpurbwAB4H5_JPMsaGHmbeZA=EWjMOfQGB6apLhEXVeA@mail.gmail.com>
 <xmqqtwh2gmlv.fsf@gitster.mtv.corp.google.com> <xmqqlh2egko4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 01:38:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bB9X2-0002wi-1c
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jun 2016 01:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbcFIXia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2016 19:38:30 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33842 "EHLO
	mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbcFIXi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2016 19:38:29 -0400
Received: by mail-qt0-f177.google.com with SMTP id q45so14639348qtq.1
        for <git@vger.kernel.org>; Thu, 09 Jun 2016 16:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2qgUwdxw1P/mo6anC2gjYPL9A8cgxZf2PU7PniP10Ks=;
        b=EPd/BV7/npEE82XNScoPwN4NYdqe9V+6hO5wqeNNvezeHbuRy1X4JTNvB1CQ8TvHBK
         DACKFCik8p18Q/f9Q38xMhuOs6bYomNm8mC5QCteezpL8WxeoPTxqL73TDZPYpIWPaLg
         GaVav2AnQgSZE+8Bc5QDMIAc8dsO6jTQBhwg80vCrPAFdhUk65vo1Z3eHJcuLxV3xSAy
         aEJJeUdFy5qb8Puyzz9zlc9ZW39Acia6T+A+gyS9XOHiNj05kUegCWw+CbuuaFP5Gd79
         zJN1sKYmeOvBMbcbMa24khvtUvzdL8LlqUOV5fUIsLqOcPFoV+VMzMufbsLtAaGapnTU
         pulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2qgUwdxw1P/mo6anC2gjYPL9A8cgxZf2PU7PniP10Ks=;
        b=L0aYFsPu4JfQw43Sg8fRMH7ERRJGUIm8HNLcNvlYqNPUiB6OnL0CqzYzy2RYl3tF5j
         v3cjDhb5XM8wCiNyeb8EzMWSHTT6BOCj3jJ07WKqVNaiuyyC0thIzOBDdrm82kmfXgj7
         6ibv+8ebcAnaQtKcdSURmarifz6w7T3KnQ33WFq0NMs+xqkabNRZzjI05FFT1Gz8IaYJ
         VATQWtJpumahWj6r/Dk7R8h9vsMZRabxuIF76eys+FfsjSJKfYCCYPmDh4RfeobT/EeK
         ERRjvt/7knCuoGPUyxPIx7ysGaHPId+JulMRHurbD7Hp79nF5jjSVzz2xKqqnFgyE4hw
         3SyA==
X-Gm-Message-State: ALyK8tK/C4NXhIuM6q6SJT6ZXGc7NmYy2fdVdxvmpq7YfDtr7WJWSUNbZAk0EG1qMnZ4UYNvLBbz1O71J9Zz3XUq
X-Received: by 10.200.39.142 with SMTP id w14mr12575191qtw.59.1465515507830;
 Thu, 09 Jun 2016 16:38:27 -0700 (PDT)
Received: by 10.237.42.226 with HTTP; Thu, 9 Jun 2016 16:38:27 -0700 (PDT)
In-Reply-To: <xmqqlh2egko4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296940>

On Thu, Jun 9, 2016 at 1:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> instead. But that is still unspecified, so we rather go with
>>>
>>> static int compare_ce(const void *one, const void *two, void *cb_data)
>>> {
>>>     const struct cache_entry *ce_one = one, *ce_two = two;
>>>     return strcmp(ce_one->name, ce_two->name);
>>> }
>>
>> As I said below, I do not think it is worth addressing by making the
>> code's behaviour on real systems worse.  As long as what you have as
>> the key into priority queue is a pointer to cache_entry, you cannot
>> make it better from that point of view.
>
> ... because having to strcmp() their names would be much more
> expensive than the pointer comparison.
>
> However, I think you could use a pointer into a single array as
> an element of prio_queue.  I notice here:
>
>         for (; suc->current < suc->list.nr; suc->current++) {
> -               const struct cache_entry *ce = suc->list.entries[suc->current];
> +               ce = suc->list.entries[suc->current];
>                 if (prepare_to_clone_next_submodule(ce, child, suc, err)) {
> +                       *ce_task_cb = (struct cache_entry *) ce;
>                         suc->current++;
>                         return 1;
>                 }
>         }
>
> that list.entries[] can serve as such an array.  If you pass around
> the pointer to its element instead, i.e.
>
> -               ce = suc->list.entries[suc->current];
> +               ceP = &suc->list.entries[suc->current];
> -               if (prepare_to_clone_next_submodule(ce, child, suc, err)) {
> +               if (prepare_to_clone_next_submodule(*ceP, child, suc, err)) {
> +                       *ce_task_cb = (struct cache_entry *) ce;
> -                       *ce_task_cb = ceP;
>                 ...
>         }
>         /*
>          * The loop above tried cloning each submodule once,
>          * now try the stragglers again.
>          */
> -       ce = (struct cache_entry *) prio_queue_get(&suc->failed_queue);
> +       ceP = (struct cache_entry **) prio_queue_get(&suc->failed_queue);
>
> then the elements you are pushing into prio-queue would not be ce
> (pointer to a cache entry), but would be a pointer of an array that
> holds many pointers to cache entries, so it becomes kosher to
> compare them for ordering.
>
> That would probably not add too much overhead at runtime; it may
> have to involve a bit of code restructuring, so I do not know if it
> is worth it, though.
>

I realized the patch above was bogus for another reason:
In update_clone_task_finished we never distinguish between first-failing
submodules and repeated fails, such that we may end up in an infinite loop.

So I think the easiest way forward would be if we would pass around the index
and then we can properly determine if we tried that already. (Though casting
pointer to int is not possible, so we'll pass around a pointer to an int)

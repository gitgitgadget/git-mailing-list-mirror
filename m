From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 8/8] revert/cherry-pick: add --skip option
Date: Wed, 29 May 2013 08:27:28 -0500
Message-ID: <CAMP44s1i9H9cp_RoOo-rDWL6b76=zxbwC19=DnUayK_Ti2CXFA@mail.gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-9-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0m02XCVnrnFQ+mF8FFZEMD36_J3Tyjh-E4SuZ++xdcXHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 15:27:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhgPf-0004C9-5c
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 15:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759542Ab3E2N1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 09:27:31 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:56811 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087Ab3E2N1a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 09:27:30 -0400
Received: by mail-lb0-f177.google.com with SMTP id o10so8887515lbi.22
        for <git@vger.kernel.org>; Wed, 29 May 2013 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=G9Au7NnsgLlR9G4EL0ZVeBAAIqvV8jHfLI3nC+QYPKk=;
        b=YhFVUW/9JxW5CJ2mcc/HB1yrA3oD7rXB+9isDFoFLVmtm6Z/t+AZBUhnaELz/wciuq
         POHxMoopES5xUUBZaZAocjmrsw8NKjJZjVDDFLPlIqckOc6UfmHj7QS5NJTrcHBSRIJh
         XXbJpuIllx7al/W9PrD8fqPDbiLkGUdi0SxW9V2dWiGG+L6zEb/lNZBEX+aG1AELyxJs
         IrPl5zsbkVarwO9cedqw5mMP69Mc6V45m3V8VjOdVPv1IyAN0eBfuJxd1j0EPwQfnfBd
         guAk3H6l6BP21FeoLAIK0RGUvRR8I5yujNp3MEdaDS6+qnF5Exc2Nze7Vh8uNxzN2Hpl
         LsNw==
X-Received: by 10.112.88.166 with SMTP id bh6mr1630108lbb.47.1369834048941;
 Wed, 29 May 2013 06:27:28 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Wed, 29 May 2013 06:27:28 -0700 (PDT)
In-Reply-To: <CALkWK0m02XCVnrnFQ+mF8FFZEMD36_J3Tyjh-E4SuZ++xdcXHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225815>

On Wed, May 29, 2013 at 7:27 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> Akin to 'am --skip' and 'rebase --skip'.
>
> This ranged-cherry-pick can be useful for small ranges.  As pointed
> out by others on the list, it hemorrhages memory quite horribly (and
> this problem is non-trivial to fix).  Perhaps we should document this
> in limitations or bugs if we intend to make it more useful?

Is there a test-case that triggers this?

I don't see why we shouldn't try to fix this.

>> diff --git a/builtin/revert.c b/builtin/revert.c
>> index d63b4a6..6afd990 100644
>> --- a/builtin/revert.c
>> +++ b/builtin/revert.c
>> @@ -99,11 +99,13 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
>>         int remove_state = 0;
>>         int contin = 0;
>>         int rollback = 0;
>> +       int skip = 0;
>
> Ugh, one more integer.  Can't we use an OPT_BIT and store the action
> in one variable? No hurry ofcourse: just asking.

I thought of switching to bit fields, but then I opened
builtin/checkout.c to see how many options were implemented, and I saw
more ints, so I left it like that.

>> @@ -1201,7 +1203,7 @@ static int sequencer_continue(struct replay_opts *opts)
>>         }
>>         if (index_differs_from("HEAD", 0))
>>                 return error_dirty_index(opts);
>> -       {
>> +       if (!skip) {
>>                 unsigned char to[20];
>>                 if (!read_ref("HEAD", to))
>>                         add_rewritten(todo_list->item->object.sha1, to);
>
> Couldn't you just say if (skip) todo_list = todo_list -> next?

We are already doing that. And after that we need to continue with the
rest of the commits.

>> +       if (setup_rerere(&merge_rr, 0) >= 0) {
>> +               rerere_clear(&merge_rr);
>> +               string_list_clear(&merge_rr, 1);
>> +       }
>
> Why exactly?  Why doesn't rebase --skip 'rerere clear'?

It does, and so does 'git am', so why shouldn't 'git cherry-pick'.

Also, I think the same should happen in --abort.

-- 
Felipe Contreras

From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/2] run-command: Remove set_nonblocking
Date: Fri, 6 Nov 2015 06:51:27 +0100
Message-ID: <563C3FDF.9050304@kdbg.org>
References: <1446747439-30349-1-git-send-email-sbeller@google.com>
 <1446747439-30349-2-git-send-email-sbeller@google.com>
 <563BBBBC.7070807@kdbg.org>
 <CAGZ79kZs8HQegNy=L5nGMUGJ98s-xgce1Ncrxpxe_ReaJXMjKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 06:51:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuZvz-0004W4-Tn
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 06:51:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbbKFFvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 00:51:31 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:53074 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbbKFFvb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 00:51:31 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3nsW742pBRz5tlH;
	Fri,  6 Nov 2015 06:51:28 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id B95B75393;
	Fri,  6 Nov 2015 06:51:27 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kZs8HQegNy=L5nGMUGJ98s-xgce1Ncrxpxe_ReaJXMjKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280960>

Am 05.11.2015 um 23:20 schrieb Stefan Beller:
> On Thu, Nov 5, 2015 at 12:27 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>
>> diff --git a/run-command.c b/run-command.c
>> index 51d078c..3e42299 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -977,7 +977,7 @@ static struct parallel_processes *pp_init(int n,
>>          for (i = 0; i < n; i++) {
>>                  strbuf_init(&pp->children[i].err, 0);
>>                  child_process_init(&pp->children[i].process);
>> -               pp->pfd[i].events = POLLIN;
>> +               pp->pfd[i].events = POLLIN|POLLHUP;
>>                  pp->pfd[i].fd = -1;
>>          }
>>          sigchain_push_common(handle_children_on_signal);
>> @@ -1061,11 +1061,17 @@ static void pp_buffer_stderr(struct parallel_processes *pp, int output_timeout)
>>          /* Buffer output from all pipes. */
>>          for (i = 0; i < pp->max_processes; i++) {
>>                  if (pp->children[i].in_use &&
>> -                   pp->pfd[i].revents & POLLIN)
>> -                       if (strbuf_read_once(&pp->children[i].err,
>> -                                            pp->children[i].process.err, 0) < 0)
>> +                   pp->pfd[i].revents & (POLLIN|POLLHUP)) {
>> +                       int n = strbuf_read_once(&pp->children[i].err,
>> +                                            pp->children[i].process.err, 0);
>> +                       if (n == 0) {
>> +                               close(pp->children[i].process.err);
>> +                               pp->children[i].process.err = -1;
>
> So you set .err to -1 to signal the process has ended here...
>
>> -
>>                  for (i = 0; i < pp->max_processes; i++)
>>                          if (pp->children[i].in_use &&
>> -                           pid == pp->children[i].process.pid)
>> +                           pp->children[i].process.err == -1)
>>                                  break;
>
> to make a decision here if we want to finish_command on it.

Correct.

>> +               code = finish_command(&pp->children[i].process);
>
>> -               child_process_clear(&pp->children[i].process);
>
> but .err stays stays -1 here for the next iteration?
> We would need to reset it to 0 again.

No. In the next round, we need -1 to request a pipe. get_next_task 
callback sets it to -1 as well (and I think it is wrong that the 
callback does it; pp_start_one should do that).

> So .err is
>    0 when the slot is not in use
>   -1 when the child has finished awaiting termination
>   >0 when the child is living a happy life.

But, as I said, .err is not the right place to mark dying processes (it 
was just the simplest way to demonstrate the concept in this patch). 
Better extend .in_use to a tri-state indicator.

-- Hannes

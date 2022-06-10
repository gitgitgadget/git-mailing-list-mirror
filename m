Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA33C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 15:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbiFJPbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 11:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbiFJPbh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 11:31:37 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CBFE98749
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 08:31:34 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 93FE63F4806;
        Fri, 10 Jun 2022 11:31:33 -0400 (EDT)
Received: from jeffhost-mbp.local (unknown [IPv6:2600:1004:b152:1102:e4:36c9:c5c5:172f])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 326A93F481F;
        Fri, 10 Jun 2022 11:31:33 -0400 (EDT)
Subject: Re: [PATCH v2] run-command: don't spam trace2_child_exit()
To:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Cc:     gitster@pobox.com
References: <4616d09ffa632bd2c9e308a713c4bdf2a1328c3c.1651179450.git.steadmon@google.com>
 <50d872a057a558fa5519856b95abd048ddb514dc.1654625626.git.steadmon@google.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <e1a078cc-b1b0-5ee0-9539-77fd97dd5a78@jeffhostetler.com>
Date:   Fri, 10 Jun 2022 11:31:30 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <50d872a057a558fa5519856b95abd048ddb514dc.1654625626.git.steadmon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/7/22 2:21 PM, Josh Steadmon wrote:
> In rare cases[1], wait_or_whine() cannot determine a child process's
> status (and will return -1 in this case). This can cause Git to issue
> trace2 child_exit events despite the fact that the child may still be
> running. In pathological cases, we've seen > 80 million exit events in
> our trace logs for a single child process.
> 
> Fix this by only issuing trace2 events in finish_command_in_signal() if
> we get a value other than -1 from wait_or_whine(). This can lead to
> missing child_exit events in such a case, but that is preferable to
> duplicating events on a scale that threatens to fill the user's
> filesystem with invalid trace logs.
> 
> [1]: This can happen when:
> 
> * waitpid() returns -1 and errno != EINTR
> * waitpid() returns an invalid PID
> * the status set by waitpid() has neither the WIFEXITED() nor
>    WIFSIGNALED() flags
> 
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
> Updated the commit message with more details about when wait_or_whine()
> can fail.
> 
>   run-command.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/run-command.c b/run-command.c
> index a8501e38ce..e0fe2418a2 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -983,7 +983,8 @@ int finish_command(struct child_process *cmd)
>   int finish_command_in_signal(struct child_process *cmd)
>   {
>   	int ret = wait_or_whine(cmd->pid, cmd->args.v[0], 1);
> -	trace2_child_exit(cmd, ret);
> +	if (ret != -1)
> +		trace2_child_exit(cmd, ret);
>   	return ret;
>   }
>   
> 
> base-commit: faa21c10d44184f616d391c158dcbb13b9c72ef3
> 


I think there are larger bugs lurking here.

finish_command_in_signal() is only called from
wait_for_pager_signal(), which is loaded up by
sigchain_push_common() when the pager is started.

There are no loops or other callers here.

We sigchain-pop our handler upon first use, so even if we
were getting millions of PIPE signals from other chilld
processes, we shouldn't be getting more than 1 message
here.  (Assuming that our pop is working and our call to
raise() doesn't cause us to be called again.)

The code is behaving as if the "s->n--" at the bottom of
sigchain_pop() isn't being performed and our raise() is
calling us again.

I originally thought it might be due to unbalanced push/pops -- which
could happen if the process were in a "push; do something; pop"
sequence and the PIPE happened in the middle of that.  But I don't
think that matters.

So I have to wonder if the sigchain code has a bug.

The Linux man-page states that signal(2) is not thread-safe
and even if it were, the sigchain code here does not have any
locking on those global data structures.

But that might not be the problem here and it's hard to say without
any of the original trace data.

Having said all of that I think it would be better to fix the
original problem something like this (not tested):

  static void wait_for_pager_signal(int signo)
  {
+	static int handled = 0;
+
+	if (handled)
+		return;
+	handled = 1;
+
	close_pager_fds();
	finish_command_in_signal(&pager_process);
	sigchain_pop(signo);
	raise(signo);
  }

Jeff


Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9725F211B5
	for <e@80x24.org>; Fri, 25 Jan 2019 21:14:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfAYVOD (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 16:14:03 -0500
Received: from siwi.pair.com ([209.68.5.199]:13678 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbfAYVOC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 16:14:02 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 9BB213F4015;
        Fri, 25 Jan 2019 16:13:59 -0500 (EST)
Received: from [IPv6:2001:4898:6808:13e:584a:7851:5944:ebfe] (unknown [IPv6:2001:4898:8010:0:4180:7851:5944:ebfe])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 585B43F400D;
        Fri, 25 Jan 2019 16:13:59 -0500 (EST)
Subject: Re: [PATCH 01/14] trace2: Documentation/technical/api-trace2.txt
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jeffhost@microsoft.com
References: <pull.108.git.gitgitgadget@gmail.com>
 <1a90de9dab0dd836e54fee9e08ab9e2284e1027a.1548192131.git.gitgitgadget@gmail.com>
 <xmqqbm47ayhv.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0ed19c21-4844-79b3-3428-54b2ecb56b0f@jeffhostetler.com>
Date:   Fri, 25 Jan 2019 16:13:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <xmqqbm47ayhv.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/23/2019 3:51 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +These high-level events are written to one or more Trace2 Targets
>> +in a target-specific format.  Each Trace2 Target defines a different
>> +purpose-specific view onto the event data stream.  In this mannor,
> 
> "In this manner"
> 
>> +a single set of Trace2 API event calls in the Git source can drive
>> +different types of analysis.
>> +
>> ...
>> +$ cat ~/log.perf
>> +12:28:42.620675 common-main.c:38                  | d0 | main                     | version      |     |           |           |            | 2.20.1.155.g426c96fcdb
>> +12:28:42.621001 common-main.c:39                  | d0 | main                     | start        |     |           |           |            | git version
>> +12:28:42.621111 git.c:432                         | d0 | main                     | cmd_verb     |     |           |           |            | version (version)
>> +12:28:42.621225 git.c:662                         | d0 | main                     | exit         |     |  0.001227 |           |            | code:0
>> +12:28:42.621259 trace2/tr2_tgt_perf.c:211         | d0 | main                     | atexit       |     |  0.001265 |           |            | code:0
>> +------------
>> ...
>> +
>> +trace2_def_param(...)
> 
> Not limited to this single one, but please either
> 
>   - omit "..." in parens, unless all of these functions take varargs
>     of unspecified type (which I do not think is the case), or
> 
>   - write a proper prototype for these functions, explain what the
>     function itself and what the parameters are for.
> 
> I'll complain about lack of info around here later X-<.

I documented the prototypes in trace2.h and was hoping to avoid
duplicating all that text here in this document.  The list of
functions here in this document was more of an overview of the
groups of concepts covered.  I'll revisit this.


> 
>> +trace2_def_repo(...)
> 
>> +----------------
>> +
>> +Git Child Process Events::
>> +
>> +	These are concerned with the various spawned child processes,
>> +	including sub-git processes and hooks,
>> ++
>> +----------------
>> +trace2_child_start(...)
>> +trace2_child_exit(...)
>> +
>> +trace2_exec(...)
>> +trace2_exec_result(...)
>> +----------------
>> +
>> +Git Thread Events::
>> +
>> +	These are concerned with Git thread usage.
>> ++
>> +----------------
>> +trace2_thread_start(...)
>> +trace2_thread_exit(...)
>> +----------------
> 
> Lack of _wait()/_join() feels a bit curious, but _exit() from what
> is being waited would suffice as a substitute.

The 2 trace2_thread_ functions have to be run by the thread-proc itself
rather than by the code calling the pthread functions.  So to me it made
more sense inside the thread-proc for them to be named _start and _exit.
This gives us an event with the elapsed time of the thread in isolation
using TLS data within each thread.

If I understand your question about _wait/_join, adding trace2 calls
near the pthread_create and pthread_join, would be a bit of a mess
because of the usual create loop and then later the join loop.  And
the exit times would be less accurate, since we typically _join them
in array order rather in the order they finish.

And having the trace2_thread_ calls in the pthread caller doesn't let
me access the thread's private TLS data.

Wrapping a region (like I show later in the preload_index() example)
around both of the pthread loops gives us the overall time for the
threading and insight into the thread overhead.  (One could even
have a region around the pthread_create loop and another around the
pthread_join loop, but that might not be worth the trouble.

> 
>> +Initialization::
>> +
>> +	Initialization happens in `main()`.  The initialization code
>> +	determines which, if any, Trace2 Targets should be enabled and
>> +	emits the `version`, `start`, and `exit` events.  It causes an
>> +	`atexit` function and `signal` handler to be registered that
>> +	will emit `atexit` and `signal` events.
>> ++
>> +----------------
>> +int main(int argc, const char **argv)
>> +{
>> +	int exit_code;
>> +
>> +	trace2_initialize();
>> +	trace2_cmd_start(argv);
> 
> Nobody other than trace2 integration would make a call to this
> helper, so it may not matter, but sending av alone without ac, even
> though ac is almost always redundant, feels somewhat unexpected.

Agreed.  There were other places that took an argv that didn't have
an argc on hand in the calling code.  So rather than fake up one for
them, I just omitted it from all the calls in my API.


> 
>> +Command Details::
>> +
>> +	After the basics are established, additional process
>> +	information can be sent to Trace2 as it is discovered, such as
>> +	the command verb, alias expansion, interesting config
>> +	settings, the repository worktree, error messages, and etc.
>> ++
>> +----------------
>> +int cmd_checkout(int argc, const char **argv)
>> +{
>> +	// emit a single "def_param" event
>> +	trace2_def_param("core.editor", "emacs");
> 
> Without knowing what "def_param event" is, this example is hard to
> fathom.  At this point in the doc, the reader does not even know
> what "def" stands for.  Is this call to define a param called
> core.editor?  Is it reporting that the default value for core.editor
> is emacs?
> 
>> +	// emit def_params for any config setting matching a pattern
>> +	// in GIT_TR2_CONFIG_PARAMS.
>> +	trace2_cmd_list_config();
> 
> As the reader does not know what def_param is, this is also hard to
> follow.

I'll rewrite that section.  The idea is to define a parameter that
a perf-tester might consider important.  For example, "core.abbrev"
used to cause massive perf problems on our mega repo where it might
take minutes to compute 7 or 8 digit abbreviations for a log or
branch command (completely dominating the time to actually compute
the log or branch list).


> 
>> +	trace2_cmd_verb("checkout");
>> +	trace2_cmd_subverb("branch");
> 
> These are guessable.  It probably reports what the codepath is
> doing.

These are to help post-processing.  The git command line is parsed
in 2 or 3 different phases and it takes quite a bit of work to get
to cmd_*() function (such as skipping over the -c, -C, --exec-path,
and other such args, and handling the commands where there isn't
a cmd_*() function (such as "git --exec-path")).  Then within the
cmd_*() function, a lot of work to see which variant of the command
is (such as is this checkout checking out a branch or a single
file).  And there are short and long forms of many arguments. And then 
there is the alias expansion which wants to rewrite the command line
(possibly recursively).  And then there is the code to try to run the
non-builtin dashed form.

For post-processing, you want to be able to do something like this:

	select elapsed_time where verb='checkout' and subverb='branch'
	select elapsed_time where verb='checkout' and subverb='path'

and report averages over those 2 sets independently without having
to recreate all that argv parsing inside the database query (or perl
script on the trace log).

> 
>> +	trace2_def_repo(the_repository);
> 
> Again, this is not easy to guess.  Is it reporting what the default
> repository is?

I'll reword this.


> 
>> +	if (do_something(...))
>> +	    trace2_cmd_error("Path '%s': cannot do something", path);
> 
> This is guessable, which is good.
> 
>> +void run_child(...)
>> +{
>> +	int child_exit_code;
>> +	struct child_process cmd = CHILD_PROCESS_INIT;
>> +	...
>> +
>> +	trace2_child_start(&cmd);
>> +	child_exit_code = ...();
>> +	trace2_child_exit(&cmd, child_exit_code);
> 
> Even though child_exit() has not been explained just like
> def_param(), this is far more guessable.  I wonder why it is.  The
> name of the variable passed to it in the example certainly helps, as
> it is totally unclear where the string constant "emacs" in the
> earlier example came from (e.g. is it hardcoded in the program?  is
> it merely illustrating "here is how you report the value you have
> decided to use for 'core.editor' variable"?).

yes, some of these are synthetic uses of the API to illustrate
the trace2 concepts.  I just picked 'core.editor' at random.  I'll
revisit the examples.


> 
>> ...
>> +$ cat ~/log.perf
>> +d0 | main                     | version      |     |           |           |            | 2.20.1.160.g5676107ecd.dirty
>> +d0 | main                     | start        |     |           |           |            | git status
>> +d0 | main                     | def_repo     | r1  |           |           |            | worktree:/Users/jeffhost/work/gfw
>> +d0 | main                     | cmd_verb     |     |           |           |            | status (status)
>> +...
>> +d0 | main                     | region_enter | r1  |  0.010988 |           | status     | label:worktrees
> 
> It is hard to guess what "d0" and "r1" stand for here.
> 
> In an earlier example we also saw an unexplained "d0" there, which I
> think was OK because the illustration was merely to give the "feel"
> of the format up there.  But now we are giving a bit more detailed
> explanation, we probably would want to at least briefly mention what
> each column means.

yes, the example at the top was just to preview the formats.
I'll add more info here.

> I'd stop here for now, as I am more interested in reading the code
> ;-)
> 

Thanks
Jeff

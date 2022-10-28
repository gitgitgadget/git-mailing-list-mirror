Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DCAFA3740
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 19:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiJ1TOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 15:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJ1TOE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 15:14:04 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C6F22C453
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 12:14:02 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 911B5CA1272;
        Fri, 28 Oct 2022 15:14:01 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3DA67CC833D;
        Fri, 28 Oct 2022 15:14:01 -0400 (EDT)
Subject: Re: [PATCH v2 6/6] t5556-http-auth: add test for HTTP auth hdr logic
To:     Derrick Stolee <derrickstolee@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
 <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
 <f3f13ed8c8238f396163dd0e6a3d6c948c2b879b.1666372083.git.gitgitgadget@gmail.com>
 <8593dd49-4d95-ed4f-b414-8170efc138d4@github.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <d61d8881-ce58-de02-2c3b-e3cc812e316a@jeffhostetler.com>
Date:   Fri, 28 Oct 2022 15:14:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.0; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <8593dd49-4d95-ed4f-b414-8170efc138d4@github.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/28/22 11:08 AM, Derrick Stolee wrote:
> }
> 
>> diff --git a/t/helper/test-http-server.c b/t/helper/test-http-server.c
> 
>> @@ -0,0 +1,1134 @@
>> +#include "config.h"
>> +#include "run-command.h"
>> +#include "strbuf.h"
>> +#include "string-list.h"
>> +#include "trace2.h"
>> +#include "version.h"
>> +#include "dir.h"
>> +#include "date.h"
>> +
>> +#define TR2_CAT "test-http-server"
>> +
>> +static const char *pid_file;
>> +static int verbose;
>> +static int reuseaddr;
>> +
>> +static const char test_http_auth_usage[] =
>> +"http-server [--verbose]\n"
>> +"           [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]\n"
>> +"           [--reuseaddr] [--pid-file=<file>]\n"
>> +"           [--listen=<host_or_ipaddr>]* [--port=<n>]\n"
>> +"           [--anonymous-allowed]\n"
>> +"           [--auth=<scheme>[:<params>] [--auth-token=<scheme>:<token>]]*\n"
>> +;
> 
> These are a lot of options to implement all at once. They are probably
> simple enough, but depending on the implementation and tests, it might
> be helpful to split this patch into smaller ones that introduce these
> options along with the tests that exercise each. That will help
> verify that they are being tested properly instead of needing to track
> back and forth across the patch for each one.

how many of these options were inherited from test-gvfs-protocol or
from upstream git-daemon?  If most came from git-daemon, it's probably
easier to see that this was a cut-n-paste from it if it comes over in
one commit, since all of the OPT_ processing, usage(), and static global
state vars will come over together I would think -- rather than to build
up the arg parsing bit by bit.  More on this in a minute...


>> +
>> +/* Timeout, and initial timeout */
>> +static unsigned int timeout;
>> +static unsigned int init_timeout;
>> +
>> +static void logreport(const char *label, const char *err, va_list params)
>> +{
>> +	struct strbuf msg = STRBUF_INIT;
>> +
>> +	strbuf_addf(&msg, "[%"PRIuMAX"] %s: ", (uintmax_t)getpid(), label);
>> +	strbuf_vaddf(&msg, err, params);
>> +	strbuf_addch(&msg, '\n');
>> +
>> +	fwrite(msg.buf, sizeof(char), msg.len, stderr);
>> +	fflush(stderr);
>> +
>> +	strbuf_release(&msg);
>> +}
>> +
>> +__attribute__((format (printf, 1, 2)))
>> +static void logerror(const char *err, ...)
>> +{
>> +	va_list params;
>> +	va_start(params, err);
>> +	logreport("error", err, params);
>> +	va_end(params);
>> +}
>> +
>> +__attribute__((format (printf, 1, 2)))
>> +static void loginfo(const char *err, ...)
>> +{
>> +	va_list params;
>> +	if (!verbose)
>> +		return;
>> +	va_start(params, err);
>> +	logreport("info", err, params);
>> +	va_end(params);
>> +}

...Maybe it would be easier to see/diff this large new test server
if we copied `daemon.c` into this source file in 1 commit and then
converted it to what you have now in 1 commit -- so that only new
code shows up here.  For example, all of the above logreport, logerror,
and loginfo routines would show up as new in the copy commit, but not
in the edit commit.  However, that may lead to too much noise when
you actually get into the meat of the auth changes, maybe.


> I wonder how much of this we need or is just a nice thing. I would
> err on the side of making things as simple as possible, but being
> able to debug this test server may be important based on your
> experience.

i'd vote to keep it.

[...]
>> +static void kill_some_child(void)
> 
>> +static void check_dead_children(void)
> 
> These technically sound methods have unfortunate names.
> Using something like "connection" over "child" might
> alleviate some of the horror. (I initially wanted to
> suggest "subprocess" but you compare live_children to
> max_connections in the next method, so connection seemed
> appropriate.)

These names were inherited from `daemon.c` IIRC. I wouldn't change
them since it'll just introduce noise when diffing.  Especially,
if we do the copy commit first.


[...]
>> +static struct strvec cld_argv = STRVEC_INIT;
>> +static void handle(int incoming, struct sockaddr *addr, socklen_t addrlen)
>> +{
>> +	struct child_process cld = CHILD_PROCESS_INIT;
>> +
>> +	if (max_connections && live_children >= max_connections) {
>> +		kill_some_child();
>> +		sleep(1);  /* give it some time to die */
>> +		check_dead_children();
>> +		if (live_children >= max_connections) {
>> +			close(incoming);
>> +			logerror("Too many children, dropping connection");
>> +			return;
>> +		}
>> +	}
> 
> Do we anticipate exercising concurrent requests in our
> tests? Perhaps it's not worth putting a cap on the
> connection count so we can keep the test helpers simple.

again, this code was inherited from `daemon.c`, so we could leave it.

[...]
>> +			mod = xmalloc(sizeof(struct auth_module));
>> +			mod->scheme = xstrdup(p[0]->buf);
>> +			mod->challenge_params = p[1] ? xstrdup(p[1]->buf) : NULL;
> 
> Here, you xstrdup() into a 'const char *', but you are really
> passing ownership so it shouldn't be conts.

There is a strbuf_detach() that will let you steal the buffer from the
strbuf if that would help.


[...]
> This was a lot to read, and the interesting bits are all mixed in
> with the http server code, which is less interesting to what we
> are trying to accomplish. It would be beneficial to split this
> into one or two patches before we actually introduce the tests.

agreed. it is big, but it does make sense.  perhaps doing the
copy daemon.c commit and then see how this commit diffs from it
would make it more manageable. (not sure, but worth a try.)

[...]
>  From what I read, I don't think there is much to change in
> the end result of the code, but it definitely was hard to read
> the important things when surrounded by many lines of
> boilerplate.

agreed. i think the end result is good.

Thanks
Jeff



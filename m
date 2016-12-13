Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21802042F
	for <e@80x24.org>; Tue, 13 Dec 2016 19:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbcLMTD6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 14:03:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52314 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932964AbcLMTD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 14:03:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8CEF3572A4;
        Tue, 13 Dec 2016 14:03:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kFleV8J5RsTs6U3r5DPaqdhOOOg=; b=qyi90p
        Pr04OxBGpcy/XnyxHVssZZsXZ2yJdK43oZQtcOY1p5oY15Y3BX9OD7ZJiDExV6+Q
        ZaL3u4JNlFDE9ZuN3GdRxohLwSroqlx8lNb/nfF+Vr6yi3D4FY+nlr52+IX/2PNf
        /z4GjK8i0iK35e7kUwxgIQytSf1bEGVr+s95A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h6y0tH//SIT7MwsykS6aEfAw31RBWJRc
        qrRYtbaQ56r6MKVrASHyF/ooi1N5Im84WmVKhMroS+QUUH5Ou6/VTW9VmDJT5UHF
        vR/PI1vRQDfGwRAlj7gDhrj+3a+b3K6CdYRRObnUV7py4MMGA2ZUy709B0uE/HPm
        nSCSen0nLO8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 855BB572A3;
        Tue, 13 Dec 2016 14:03:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 02C6C572A2;
        Tue, 13 Dec 2016 14:03:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/commit.c: convert trivial snprintf calls to xsnprintf
References: <20161213132717.42965-1-gitter.spiros@gmail.com>
        <20161213135514.z7eituxgxsvybwgz@sigill.intra.peff.net>
Date:   Tue, 13 Dec 2016 11:03:53 -0800
In-Reply-To: <20161213135514.z7eituxgxsvybwgz@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 13 Dec 2016 08:55:14 -0500")
Message-ID: <xmqqy3zj3b3a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4C4AB0E-C166-11E6-A91F-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +		argv_array_pushf(&env, "GIT_INDEX_FILE=%s", index_file);
>> +		if (launch_editor(git_path_commit_editmsg(), NULL, env.argv)) {
>>  			fprintf(stderr,
>>  			_("Please supply the message using either -m or -F option.\n"));
>> +			argv_array_clear(&env);
>>  			exit(1);
>>  		}
>> +		argv_array_clear(&env);
>
> I'd generally skip the clear() right before exiting, though I saw
> somebody disagree with me recently on that.  I wonder if we should
> decide as a project on whether it is worth doing or not.

I'd say it is a responsibility of the person who turns exit(1) to
return -1 to ensure the code does not leak.

>> @@ -1525,12 +1526,10 @@ static int git_commit_config(const char *k, const char *v, void *cb)
>>  static int run_rewrite_hook(const unsigned char *oldsha1,
>>  			    const unsigned char *newsha1)
>>  {
>> -	/* oldsha1 SP newsha1 LF NUL */
>> -	static char buf[2*40 + 3];
>> +	char *buf;
>>  	struct child_process proc = CHILD_PROCESS_INIT;
>>  	const char *argv[3];
>>  	int code;
>> -	size_t n;
>>  
>>  	argv[0] = find_hook("post-rewrite");
>>  	if (!argv[0])
>> @@ -1546,34 +1545,33 @@ static int run_rewrite_hook(const unsigned char *oldsha1,
>>  	code = start_command(&proc);
>>  	if (code)
>>  		return code;
>> -	n = snprintf(buf, sizeof(buf), "%s %s\n",
>> -		     sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
>> +	buf = xstrfmt("%s %s\n", sha1_to_hex(oldsha1), sha1_to_hex(newsha1));
>>  	sigchain_push(SIGPIPE, SIG_IGN);
>> -	write_in_full(proc.in, buf, n);
>> +	write_in_full(proc.in, buf, strlen(buf));
>>  	close(proc.in);
>> +	free(buf);
>
> Any time you care about the length of the result, I'd generally use an
> actual strbuf instead of xstrfmt. The extra strlen isn't a big deal
> here, but it somehow seems simpler to me. It probably doesn't matter
> much either way, though.

Your justification for this extra allocation was that it is a
heavy-weight operation.  While I agree that the runtime cost of
allocation and deallocation does not matter, I would be a bit
worried about extra cognitive burden to programmers.  They did not
have to worry about leaking because they are writing a fixed length
string.  Now they do, whether they use xstrfmt() or struct strbuf.
When they need to update what they write, they do have to remember
to adjust the size of the "fixed string", and the original is not
free from the "programmers' cognitive cost" point of view, of
course.  Probably use of strbuf/xstrfmt is an overall win.

And of course, I think strbuf is more appropriate if you have to do
strlen().

Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9F76AD6
	for <git@vger.kernel.org>; Thu, 21 Dec 2023 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TfPXBff/"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 358361C56DC;
	Thu, 21 Dec 2023 12:02:17 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Xu7BPpkntOopT96c/cxIwJKxMHr7U55NxLXVU0
	i3IrM=; b=TfPXBff/IoJNw5MC+huM4S30ZVdSlE5iIsZ2Mvk/p5AXQ4Z623wA7b
	eN6XCZdTQxqRuxk05jvCuBqdaoDc2tlAsI0xgMkF963FsZyQhVMv1wtGynwqGprt
	bSmlFeVlOsJ/j7JRqNEqYu4rvJPcGrz8yF3qI1QDHs0jZ2rnS1i/I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E13A1C56DA;
	Thu, 21 Dec 2023 12:02:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 960551C56D9;
	Thu, 21 Dec 2023 12:02:16 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org
Subject: Re: [PATCH/RFC] sparse-checkout: take care of "--end-of-options" in
 set/add
In-Reply-To: <20231221084011.GB545870@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 21 Dec 2023 03:40:11 -0500")
References: <xmqqbkakqx6s.fsf@gitster.g> <ZYN-5H-2NNoRRpf-@google.com>
	<xmqqplz0p90k.fsf@gitster.g>
	<20231221084011.GB545870@coredump.intra.peff.net>
Date: Thu, 21 Dec 2023 09:02:15 -0800
Message-ID: <xmqqsf3vmqug.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B1BC8446-A022-11EE-8A7C-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> On Wed, Dec 20, 2023 at 06:46:51PM -0800, Junio C Hamano wrote:
>
>> Josh Steadmon <steadmon@google.com> writes:
>> 
>> > I can confirm that this fixes an issue noticed by sparse-checkout users
>> > at $DAYJOB. Looks good to me. Thanks!
>> 
>> Heh, there is another one that is not converted in the same file for
>> "check-rules" subcommand, so the posted patch is way incomplete, I
>> think.
>
> Yeah. I think it is in the same boat as the other two, in that I believe
> that the KEEP_UNKNOWN_OPT flag is counter-productive and should just be
> dropped.

If we dropped KEEP_UNKNOWN_OPT, however, the pattern that is
currently accepted will stop working, e.g.,

 $ git sparse-checkout [add/set] --[no-]cone --foo bar

as we would barf with "--foo: unknown option", and the users who are
used to this sloppy command line parsing we had for the past few
years must now write "--end-of-options" before "--foo".  After all,
the reason why the original authors of this code used KEEP_UNKNOWN
is likely to deal with path patterns that begin with dashes.

The patch in the message that started this thread may not be
correct, either, I am afraid.  For either of these:

 $ git sparse-checkout [add/set] --[no-]cone foo --end-of-options bar
 $ git sparse-checkout [add/set] --[no-]cone --foo --end-of-options bar

we would see that "foo" (or "--foo") is not "--end-of-options", and
we end up using three patterns "foo" (or "--foo"),
"--end-of-options", and "bar", I suspect.  I wonder if we should
notice the "foo" or "--foo" that were not understood and error out,
instead.

But after all, it is not absolutely necessary to notice and barf.
The ONLY practical use of the "--end-of-options" mechanism is to
allow us to write (this applies to any git subcommand):

 #!/bin/sh
 git cmd --hard --coded --options --end-of-options "$@"

in scripts to protect the intended operation from mistaking the
end-user input as options.  And with a script written carefully to
do so, all the args that appear before "--end-of-options" would be
recognizable by the command line parser.  On the other hand, such a
"notice and barf" would not help a script that is written without
"--end-of-options", when it is fed "$@" that happens to begin with
"--end-of-options".  We would silently swallow "--end-of-options"
without any chance to notice the lack of "--end-of-options" in the
script.  So I dunno.

Here is an additional test on top of [1/3]
<20231221065925.3234048-2-gitster@pobox.com>

that demonstrates and summarizes the idea.

 t/t1090-sparse-checkout-scope.sh | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git c/t/t1090-sparse-checkout-scope.sh w/t/t1090-sparse-checkout-scope.sh
index 5b96716235..da9534d222 100755
--- c/t/t1090-sparse-checkout-scope.sh
+++ w/t/t1090-sparse-checkout-scope.sh
@@ -54,6 +54,40 @@ test_expect_success 'return to full checkout of main' '
 	test "$(cat b)" = "modified"
 '
 
+test_expect_success 'sparse-checkout set command line parsing' '
+	# baseline
+	git sparse-checkout disable &&
+	git sparse-checkout set --no-cone "a*" &&
+	echo "a*" >expect &&
+	test_cmp .git/info/sparse-checkout expect &&
+
+	# unknown string that looks like a dashed option is
+	# taken as a mere pattern
+	git sparse-checkout disable &&
+	git sparse-checkout set --no-cone --foo "a*" &&
+	test_write_lines "--foo" "a*" >expect &&
+	test_cmp .git/info/sparse-checkout expect &&
+
+	# --end-of-options can be used to protect parameters that
+	# potentially begin with dashes
+	set x --cone "a*" && shift &&
+	git sparse-checkout disable &&
+	git sparse-checkout set --no-cone --end-of-options "$@" &&
+	test_write_lines "$@" >expect &&
+	test_cmp .git/info/sparse-checkout expect &&
+
+	# but writing --end-of-options after what the command does not
+	# recognize is too late; it becomes one of the patterns, so
+	# that the end-user input that happens to be "--end-of-options"
+	# can be passed through.  To be absoutely sure, you should write
+	# --end-of-options yourself before taking "$@" in.
+	set x --foo --end-of-options "a*" && shift &&
+	git sparse-checkout disable &&
+	git sparse-checkout set --no-cone "$@" &&
+	test_write_lines "$@" >expect &&
+	test_cmp .git/info/sparse-checkout expect
+'
+
 test_expect_success 'skip-worktree on files outside sparse patterns' '
 	git sparse-checkout disable &&
 	git sparse-checkout set --no-cone "a*" &&

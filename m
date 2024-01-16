Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2711C698
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 16:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HO86J/K+"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A326E3FE8D;
	Tue, 16 Jan 2024 11:36:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=x82OwkyD5meO3NvBqOh9xN+EcPcRcTR/3gFZ62
	9huMY=; b=HO86J/K+/Lg9pyKn8r9ayRd3fv+VenJz6vAGsMM4NZUL+CcREEin/k
	QRe+lVleEZrczD7mmBiYg4ajkKiqyQkcuHEkQ6J/b6wDdugezL3wZwHhGg97E3+n
	GhPM/xWzddjoNdwDbsmmwtt9P4pj0T+XsIsAGgvesRN66Roz4WSvM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C2713FE8C;
	Tue, 16 Jan 2024 11:36:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 28D113FE88;
	Tue, 16 Jan 2024 11:36:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Pratap <chandrapratap376@gmail.com>,
  Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v2] tests: move t0009-prio-queue.sh to the new unit
 testing framework
In-Reply-To: <pull.1642.v2.git.1705220304781.gitgitgadget@gmail.com> (Chandra
	Pratap via GitGitGadget's message of "Sun, 14 Jan 2024 08:18:24
	+0000")
References: <pull.1642.git.1705219829965.gitgitgadget@gmail.com>
	<pull.1642.v2.git.1705220304781.gitgitgadget@gmail.com>
Date: Tue, 16 Jan 2024 08:36:44 -0800
Message-ID: <xmqqzfx51bhf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7042610A-B48D-11EE-9701-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/t/unit-tests/t-prio-queue.c b/t/unit-tests/t-prio-queue.c
> new file mode 100644
> index 00000000000..07b112f5894
> --- /dev/null
> +++ b/t/unit-tests/t-prio-queue.c
> @@ -0,0 +1,99 @@
> +#include "test-lib.h"
> +#include "prio-queue.h"
> +
> +static int intcmp(const void *va, const void *vb, void *data UNUSED)
> +{
> +	const int *a = va, *b = vb;
> +	return *a - *b;
> +}

This came from the original and looks obviously OK.

> +static int show(int *v)
> +{
> +	int ret = -1;
> +	if (v)
> +		ret = *v;
> +	free(v);
> +	return ret;
> +}

The original allowed us to differentiate "prio queue did not yield
anything" case and "the integer obtained from the queue happened to
be negative" cases, but with this, -1 is taken.

It is not a huge loss, as the tests can limit themselves to a subset
of "int" (say, positive integers only).  But this realization can
lead to further simplfication.

> +static int test_prio_queue(const char **input, int *result)

This takes an array of strings, but it does not have to.  Make it
take an array of "int" and then with something like

	#define MISSING	-1
        #define GET	-2
        #define DUMP	-3
	#define STACK	-4

you can get rid of strcmp(), atoi(), and xmalloc(), like so:

	while (*input) {
		int val = *input++;

		switch (val) {
		case GET:
			void *peek = prio_queue_peek(&pq);
			...
			result[i++] = peek ? (*(int*)peek) : MISSING;
			break;
		... other "commands" here ...
		default:
			prio_queue_put(&pq, val);
			break;			
		}
	}

I inlined the show() in the above illustration, but you can keep it
as a separate small helper function.  The point is that it makes it
far easier to follow by using the MISSING symbolic constant either
way.

> +{
> +	struct prio_queue pq = { intcmp };
> +	int i = 0;
> +
> +	while (*input) {
> +		if (!strcmp(*input, "get")) {
> +			void *peek = prio_queue_peek(&pq);
> +			void *get = prio_queue_get(&pq);
> +			if (peek != get)
> +				BUG("peek and get results do not match");
> +			result[i++] = show(get);
> +		} else if (!strcmp(*input, "dump")) {
> +			void *peek;
> +			void *get;
> +			while ((peek = prio_queue_peek(&pq))) {
> +				get = prio_queue_get(&pq);
> +				if (peek != get)
> +					BUG("peek and get results do not match");
> +				result[i++] = show(get);
> +			}
> +		} else if (!strcmp(*input, "stack")) {
> +			pq.compare = NULL;
> +		} else if (!strcmp(*input, "reverse")) {
> +			prio_queue_reverse(&pq);
> +		} else {
> +			int *v = xmalloc(sizeof(*v));
> +			*v = atoi(*input);
> +			prio_queue_put(&pq, v);
> +		}
> +		input++;
> +	}
> +
> +	clear_prio_queue(&pq);
> +
> +	return 0;
> +}
> +
> +#define INPUT_SIZE 6

You do not need this (see below)

> +#define BASIC_INPUT "1", "2", "3", "4", "5", "5", "dump"
> +#define BASIC_EXPECTED 1, 2, 3, 4, 5, 5
> +
> +#define MIXED_PUT_GET_INPUT "6", "2", "4", "get", "5", "3", "get", "get", "1", "dump"
> +#define MIXED_PUT_GET_EXPECTED 2, 3, 4, 1, 5, 6
> +
> +#define EMPTY_QUEUE_INPUT "1", "2", "get", "get", "get", "1", "2", "get", "get", "get"
> +#define EMPTY_QUEUE_EXPECTED 1, 2, -1, 1, 2, -1

And these input and expectation can become all integers, i.e.

	#define EMPTY_QUEUE_INPUT 1, 2, GET, GET, GET, 1, 2, GET, GET, GET
	#define EMPTY_QUEUE_EXPECTED 1, 2, MISSING, 1, 2, MISSING

> +
> +#define STACK_INPUT "stack", "1", "5", "4", "6", "2", "3", "dump"
> +#define STACK_EXPECTED 3, 2, 6, 4, 5, 1
> +
> +#define REVERSE_STACK_INPUT "stack", "1", "2", "3", "4", "5", "6", "reverse", "dump"
> +#define REVERSE_STACK_EXPECTED 1, 2, 3, 4, 5, 6
> +
> +#define TEST_INPUT(INPUT, EXPECTED, name)			\
> +  static void test_##name(void)					\
> +{								\
> +	const char *input[] = {INPUT};				\
> +	int expected[] = {EXPECTED};				\
> +	int result[INPUT_SIZE];					\

This can be written more like

	int result[ARRAY_SIZE(expected)]

so that you can freely extend each test without having to worry
about increasing the hardcoded limit.

> +	test_prio_queue(input, result);				\
> +	check(!memcmp(expected, result, sizeof(expected)));	\
> +}
> +
> +TEST_INPUT(BASIC_INPUT, BASIC_EXPECTED, basic)
> +TEST_INPUT(MIXED_PUT_GET_INPUT, MIXED_PUT_GET_EXPECTED, mixed)
> +TEST_INPUT(EMPTY_QUEUE_INPUT, EMPTY_QUEUE_EXPECTED, empty)
> +TEST_INPUT(STACK_INPUT, STACK_EXPECTED, stack)
> +TEST_INPUT(REVERSE_STACK_INPUT, REVERSE_STACK_EXPECTED, reverse)
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	TEST(test_basic(), "prio-queue works for basic input");
> +	TEST(test_mixed(), "prio-queue works for mixed put & get commands");
> +	TEST(test_empty(), "prio-queue works when queue is empty");
> +	TEST(test_stack(), "prio-queue works when used as a LIFO stack");
> +	TEST(test_reverse(), "prio-queue works when LIFO stack is reversed");
> +
> +	return test_done();
> +}
>
> base-commit: 1a87c842ece327d03d08096395969aca5e0a6996

Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6CF280033
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.254.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457055; cv=none; b=cxJYJpHe4Yrp8j8F9j41ipS2uX1D4c7b+7W0LNZRHnXvwcps2mGR+14AXkr129pYz1zze4AXEY7GA99Tax/RT/1DF04DXjOA7dtYhJdi6eSKFChBwLqnu97lAXGmH1Ljk7BhaEBZJFCGPemJsvxms2cJx3DcwoTra+BnSqx3FtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457055; c=relaxed/simple;
	bh=zkgwS2WcPuyqtsn7kPtZauiAmnywO7rOCzglqGyD5BQ=;
	h=To:From:Subject:Date:Message-ID:References:Mime-Version:
	 Content-Type; b=QD0gzAVqb4O0F2+Rs472NNmzm7uKcFCNAC/UFOwyxI4uAX7kF2hjrl24HXBj3a35fCIyAZbTnNnN4t+PO5+njBg7gaf6yxssSyjYI7YzwjU/wxKAGshGCv/A6gmzQHhmelqsP5iqkazbTN2GN/ARsye0RrR8yqDJUjz5XSgdE4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=m.gmane-mx.org; arc=none smtp.client-ip=116.202.254.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.gmane-mx.org
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gcvg-git-3@m.gmane-mx.org>)
	id 1vkSbs-0004vQ-5J
	for git@vger.kernel.org; Mon, 26 Jan 2026 20:50:52 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] u-string-list: add unit tests for string-list methods
Date: Mon, 26 Jan 2026 11:50:45 -0800
Message-ID: <xmqqa4y0i25m.fsf@gitster.g>
References: <20260122171523.94234-1-amishhhaaaa@gmail.com>
	<20260126185604.90089-1-amishhhaaaa@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
User-Agent: Gnus/5.13 (Gnus v5.13)
Cancel-Lock: sha1:aujAUOoPSfpuM7HuMrkAH+3GjPI=

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> +void test_string_list__remove(void)
> +{
> +	struct string_list expected_strings = STRING_LIST_INIT_DUP;
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +
> +	t_create_string_list_dup(&expected_strings, 0, NULL);
> +	t_create_string_list_dup(&list, 0, NULL);
> +	t_string_list_remove(&expected_strings, &list, "");
> +
> +	t_create_string_list_dup(&expected_strings, 0, "a", NULL);
> +	t_create_string_list_dup(&list, 0, "a", "a", NULL);
> +	t_string_list_remove(&expected_strings, &list, "a");

Not a complaint, not a suggestion to change anything, but just an
observation.  While "remove" requires the string-list to be sorted,
its implementation does not seem to care if you by mistake fed an
unsorted string list.

After seeing this particular test that feeds a list with two "a"
and expects in the resulting list a single "a", I naturally wondered
which one of these two "a" survives and which one is dropped.

"remove" removes only one matching element that is picked at random
among the duplicates, but because the input is expected to be
sorted, these duplicate elements sit next to each other forming a
single strand of identical pearls.  The end result of picking one of
these pearls out would not be different no matter which one of them
you pick.  So the answer to my "which one of these 'a'?" question
turns out to be "you cannot tell, but it does not matter" ;-)

> +static void t_string_list_remove_empty_items(struct string_list *expected_strings, struct string_list *list)
> +{
> +	string_list_remove_empty_items(list, 0);
> +	t_string_list_equal(list, expected_strings);
> +}
> +
> +void test_string_list__remove_empty_items(void)
> +{
> +	struct string_list expected_strings = STRING_LIST_INIT_DUP;
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +
> +	t_create_string_list_dup(&expected_strings, 0, NULL);
> +	t_create_string_list_dup(&list, 0, "", "", "", NULL);
> +	t_string_list_remove_empty_items(&expected_strings, &list);

Again, not a complaint, not a suggestion to change anything, but
just an observation.  As we saw earlier, "remove" is "remove just
one of many", but "remove_empty" is "remove all empties".  Simply
makes me wonder if the API looked more sane if we had "remove_all"
whose signature is the same as string_list_remove().

> +static void t_string_list_unsorted_string_list_delete_item(struct string_list *expected_list, struct string_list *list, int i)

This is a way overlong line.

> +{
> +	unsorted_string_list_delete_item(list, i, 0);
> +
> +	t_string_list_equal(list, expected_list);
> +}
> +
> +void test_string_list__unsorted_string_list_delete_item(void)
> +{
> +	struct string_list expected_strings = STRING_LIST_INIT_DUP;
> +	struct string_list list = STRING_LIST_INIT_DUP;
> +
> +	t_create_string_list_dup(&expected_strings, 0, "a", "c", "b", NULL);
> +	t_create_string_list_dup(&list, 0, "a", "d", "b", "c", NULL);
> +	t_string_list_unsorted_string_list_delete_item(&expected_strings, &list, 1);

This demonstrates one peculiar aspect of this "delete item from
unsorted list" API function very well.  If one is expected to name
an element to delete by specifying its position in the list, it is
natural to expect that the elements in the list to be ordered in
some way that is meaningful to the application [*], and the API is
not expected to shuffle the resulting list in such a way that makes
further use of the list cumbersome.  Yet, the function does exactly
that by moving the element at the end of the list to the place the
location of the deleted element.

	Side note: [*] The "unsorted" in the name of the function is
	a reference to the fact that the elements are not sorted by
	the natural order string-list API uses to allow it to binary
	search; it does not mean the elements are entirely randomly
	thrown in and it shouldn't mean that the application cannot
	rely on

The only caller of this function is git.c::list_cmds() that is asked
to remove the helper binaries (i.e., those whose name contains
"--"), so even though git.c::commands[] list is in sorted order, and
the list_builtins() function slurps them into a working list with
string_list_append(), processing "nohelpers" will splinkle command
names from near the tail of the list into random places in the
middle of the list.

> +	t_string_list_clear(&expected_strings, 0);
> +	t_string_list_clear(&list, 0);
> +}
> \ No newline at end of file

Don't.  Always end a text file with a complete line, please.


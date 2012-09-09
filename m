From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Add a new function, string_list_split_in_place()
Date: Sun, 09 Sep 2012 02:35:38 -0700
Message-ID: <7voblfsfmd.fsf@alter.siamese.dyndns.org>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu>
 <1347169990-9279-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 09 11:35:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAdvj-0003OW-FI
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 11:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752164Ab2IIJfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 05:35:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33198 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751865Ab2IIJfm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 05:35:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 574BF763E;
	Sun,  9 Sep 2012 05:35:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ciZWYNRFFjDRNXcg+CvAmvhb3Vg=; b=OlPi9m
	AFYC+9K6+wcqYeze2QGpJn6k3Kgwx2EWDTt0dA2tansuTh1atfNjHxd/r6Pky7dL
	U5r+yOA32nVKvhkj4NuZreOsbYz6OjDOR83monnohw3PVI6WZgfHH6JRt79Dyosm
	SUw6Kx2NzwBIud2rXKDvL+euwHZvlFOUrPgKE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a4R6r/iOqxPmGE1ahqkiN8CrmenQePku
	DkDvRmIZ0K+nnrnmfDD9UWb7oDJXY1+BXi7Fs20UCq6HmAaQxcfNvf72DVSy81U9
	S69IflgA8nB4nj8VGc5fush8hA2H7mg5CzFp87gU6peLoyqaHXqQF8uE6Etbltr7
	lOUastGiKy0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45838763D;
	Sun,  9 Sep 2012 05:35:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3C511763C; Sun,  9 Sep 2012
 05:35:40 -0400 (EDT)
In-Reply-To: <1347169990-9279-2-git-send-email-mhagger@alum.mit.edu> (Michael
 Haggerty's message of "Sun, 9 Sep 2012 07:53:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7EFCB52-FA61-11E1-8EFD-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205070>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Split a string into a string_list on a separator character.
>
> This is similar to the strbuf_split_*() functions except that it works
> with the more powerful string_list interface.  If strdup_strings is
> false, it reuses the memory from the input string (thereby needing no
> string memory allocations, though of course allocations are still
> needed for the string_list_items array).
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>
> In the tests, I use here documents to specify the expected output.  Is
> this OK?  (It is certainly convenient.)

I offhand do not have an objection to that style, but it looked
funny to see the helper test function "string_list_split_in_place"
named without "test_" prefix.  Maybe it's just me.

> diff --git a/.gitignore b/.gitignore
> index bb5c91e..0ca7df8 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -193,6 +193,7 @@
>  /test-run-command
>  /test-sha1
>  /test-sigchain
> +/test-string-list
>  /test-subprocess
>  /test-svn-fe
>  /common-cmds.h
> diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
> index 5a0c14f..3b959a2 100644
> --- a/Documentation/technical/api-string-list.txt
> +++ b/Documentation/technical/api-string-list.txt
> @@ -124,6 +124,18 @@ counterpart for sorted lists, which performs a binary search.
>  	is set. The third parameter controls if the `util` pointer of the
>  	items should be freed or not.
>  
> +`string_list_split_in_place`::
> +
> +	Split string into substrings on character delim and append the
> +	substrings to a string_list.  The delimiter characters in
> +	string are overwritten with NULs in the process.  If maxsplit
> +	is a positive integer, then split at most maxsplit times.  If

So passing 0 is the natural way to say "pay attention to all the
delimiters", which matches my intuition.

> +	list.strdup_strings is not set, then the new string_list_items
> +	point into string, which therefore must not be modified or
> +	freed while the string_list is in use.  Return the number of
> +	substrings appended to the list.

I am not sure about this strdup_strings business; it smells somewhat
fishy from the API design point of view.

If you are not mucking with the input string and not splitting in
place, it would not be possible to do this without strdup_strings,
but if you are doing the in-place splitting, is there any reason for
the caller to ask for strdup_strings?

In such a case, the reason the caller cannot promise that the input
string will not go away to the string_list (hence it has to ask to
make a copy) is because it does not own the string in the first
place, and in such a case, I would imagine it cannot allow the
delimiters in the string to be overwritten with NULs.

I would sort-of-kind-of understand a function "string_list_split"
that bases its decision to do an in-place splitting or not on the
strdup_strings flag in the string list that was passed in.  But it
would make the use of the function a bit limited (e.g. you cannot
sanely mix and match tokens from different kind of strings).

> diff --git a/string-list.c b/string-list.c
> index d9810ab..110449c 100644
> --- a/string-list.c
> +++ b/string-list.c
> @@ -194,3 +194,26 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
>  	list->items[i] = list->items[list->nr-1];
>  	list->nr--;
>  }
> +
> +int string_list_split_in_place(struct string_list *list, char *string,
> +			       int delim, int maxsplit)
> +{
> +	int count = 0;
> +	char *p = string, *end;

Blank line here.

> +	for (;;) {
> +		count++;
> +		if (maxsplit > 0 && count > maxsplit) {
> +			string_list_append(list, p);
> +			return count;
> +		}
> +		end = strchr(p, delim);
> +		if (end) {
> +			*end = '\0';
> +			string_list_append(list, p);
> +			p = end + 1;
> +		} else {
> +			string_list_append(list, p);
> +			return count;
> +		}
> +	}
> +}
> diff --git a/string-list.h b/string-list.h
> index 0684cb7..7e51d03 100644
> --- a/string-list.h
> +++ b/string-list.h
> @@ -45,4 +45,23 @@ int unsorted_string_list_has_string(struct string_list *list, const char *string
>  struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
>  						     const char *string);
>  void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
> +
> +/*
> + * Split string into substrings on character delim and append the
> + * substrings to list.  The delimiter characters in string are
> + * overwritten with NULs in the process.  If maxsplit is a positive
> + * integer, then split at most maxsplit times.  If list.strdup_strings
> + * is not set, then the new string_list_items point into string, which
> + * therefore must not be modified or freed while the string_list
> + * is in use.  Return the number of substrings appended to list.
> + *
> + * Examples:
> + *   string_list_split_in_place(l, "foo:bar:baz", ':', -1) -> ["foo", "bar", "baz"]
> + *   string_list_split_in_place(l, "foo:bar:baz", ':', 1) -> ["foo", "bar:baz"]
> + *   string_list_split_in_place(l, "foo:bar:", ':', -1) -> ["foo", "bar", ""]

I would find it more natural to see a sentinel value against
"positive" to be 0, not -1.  "-1" gives an impression as if "-2"
might do something different from "-1", but Zero is a lot more
special.

> diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
> new file mode 100755
> index 0000000..0eede83
> --- /dev/null
> +++ b/t/t0063-string-list.sh
> @@ -0,0 +1,63 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2012 Michael Haggerty
> +#
> +
> +test_description='Test string list functionality'
> +
> +. ./test-lib.sh
> +
> +string_list_split_in_place() {

SP before ()?

> +	cat >split-expected &&
> +	test_expect_success "split $1 $2 $3" "

"split '$1' at '$2', max $3", or something?

> +		test-string-list split_in_place '$1' '$2' '$3' >split-actual &&
> +		test_cmp split-expected split-actual
> +	"
> +}

What is it buying us to use "split-" before expected and actual to
make things "unusual" from many other tests?

> +string_list_split_in_place "foo:bar:baz" ":" "-1" <<EOF

Likewise about "-1" (I think your test helper does not even require
"-1" to be spelled out here).

> +3
> +[0]: "foo"
> +[1]: "bar"
> +[2]: "baz"
> +EOF
> +
> +string_list_split_in_place "foo:bar:baz" ":" "0" <<EOF
> +3
> +[0]: "foo"
> +[1]: "bar"
> +[2]: "baz"
> +EOF
> +
> +string_list_split_in_place "foo:bar:baz" ":" "1" <<EOF
> +2
> +[0]: "foo"
> +[1]: "bar:baz"
> +EOF
> +
> +string_list_split_in_place "foo:bar:baz" ":" "2" <<EOF
> +3
> +[0]: "foo"
> +[1]: "bar"
> +[2]: "baz"
> +EOF
> +
> +string_list_split_in_place "foo:bar:" ":" "-1" <<EOF
> +3
> +[0]: "foo"
> +[1]: "bar"
> +[2]: ""
> +EOF
> +
> +string_list_split_in_place "" ":" "-1" <<EOF
> +1
> +[0]: ""
> +EOF
> +
> +string_list_split_in_place ":" ":" "-1" <<EOF
> +2
> +[0]: ""
> +[1]: ""
> +EOF
> +
> +test_done
> diff --git a/test-string-list.c b/test-string-list.c
> new file mode 100644
> index 0000000..f08d3cc
> --- /dev/null
> +++ b/test-string-list.c
> @@ -0,0 +1,25 @@
> +#include "cache.h"
> +#include "string-list.h"
> +
> +int main(int argc, char **argv)
> +{
> +	if ((argc == 4 || argc == 5) && !strcmp(argv[1], "split_in_place")) {
> +		struct string_list list = STRING_LIST_INIT_NODUP;
> +		int i;
> +		char *s = xstrdup(argv[2]);
> +		int delim = *argv[3];
> +		int maxsplit = (argc == 5) ? atoi(argv[4]) : -1;

Likewise on "-1".

> +		i = string_list_split_in_place(&list, s, delim, maxsplit);
> +		printf("%d\n", i);
> +		for (i = 0; i < list.nr; i++)
> +			printf("[%d]: \"%s\"\n", i, list.items[i].string);
> +		string_list_clear(&list, 0);
> +		free(s);
> +		return 0;
> +	}
> +
> +	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
> +		argv[1] ? argv[1] : "(there was none)");
> +	return 1;
> +}

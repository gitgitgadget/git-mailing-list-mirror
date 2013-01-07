From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/10] list_lookup: create case and length search
Date: Mon, 07 Jan 2013 14:37:39 -0800
Message-ID: <7vpq1ghb64.fsf@alter.siamese.dyndns.org>
References: <1357421206-5014-1-git-send-email-apelisse@gmail.com>
 <1357421206-5014-2-git-send-email-apelisse@gmail.com>
 <7vmwwnp84p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 23:38:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsLKW-0000BE-6I
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 23:38:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755884Ab3AGWho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 17:37:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40449 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456Ab3AGWhn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 17:37:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B63CFB963;
	Mon,  7 Jan 2013 17:37:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5G/Wq483S8Xn8xZGGn0sBpW6TAg=; b=rbcAEJ
	QjJuc/HQMOwtHZ7gwHQpVEWE8BaFVtrCKsY8VOQncPHbxYWlDppFvZVe+8Wzrtee
	B/aG4LleyE95pd3n46Y5f4XRKt2B3nRnzFk2mtjntdzzo61NBahENNTJRW6aSgfL
	ZUPI//xi6amp4BQtD56YbnvlfPbC7WXZL6z5M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OlbOsYkgOEnXjLCge9xvSkToO4YtFFRk
	SnkI4JSk1d//3TbNSt4bnxPlTbwvJwYcROYV/4Reo0oPjMuJuncbZ04LxKaRzGfz
	dnnDgBFTET40h4I0jYFZfSHgxnYC7BYfaBaavZlY7PtAUYrkGOB+QQVPZDx/0o+J
	nLA03cQM54A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A766FB961;
	Mon,  7 Jan 2013 17:37:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AD232B960; Mon,  7 Jan 2013
 17:37:41 -0500 (EST)
In-Reply-To: <7vmwwnp84p.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 05 Jan 2013 14:39:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D8E0C1AA-591A-11E2-89B0-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212920>

Junio C Hamano <gitster@pobox.com> writes:

> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> Create a new function to look-up a string in a string_list, but:
>>  - add a new parameter to ignore case differences
>>  - add a length parameter to search for a substring
>>
>> The idea is to avoid several copies (lowering a string before searching
>> it when we just want to ignore case), or copying a substring of a bigger
>> string to search it in the string_list
>>
>> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
>> ---
>
> I did not read beyond the log message and the function signature of
> the updated get_entry_index(), but it strikes me insane to build a
> sorted list using case sensitive full string comarison and then to
> look for an element in that list using a different comparison
> criteria (e.g. case insensitive comparison) and to expect the
> bisection search to still work.  Shouldn't the codepath that builds
> the string-list be sorting the list in case insensitive way from the
> beginning if this were to work correctly?
>
> It seems to suggest to me that this "are the keys case sensitive?"
> bit belongs to the entire struct string_list structure as its
> property (similar to the way "do the keys need to be strdup'ed?"
> bit), not something you would flip per invocation basis of the
> lookup function.
>
> Also isn't size_t an unsigned type?  What does it even mean to pass
> "-1" to it, and propagate it down to strncmp()?
>
> If you have a list sorted by a key, and if you want to query it with
> a partial prefix of a possibly valid key, I think you shouldn't have
> to add the "length search" at all. The existing look up function
> would return the location in the list that short key would have been
> inserted, which would come before the first entry that your short
> key is a prefix of, so the caller can iterate the list from there to
> find all entries.  In other words, if existing list has "aaa",
> "bba", and "bbc", and you want to grab entries that begin with "bb",
> you can ask for "bb" to the loop up function, which would say "the
> key does not exist in the list, but it would be inserted before this
> 'bba' entry".  Then you can discover that "bba" and "bbc" both
> matches the shortened key you have, no?

In the above, I mixed up which string is a prefix of which, but the
overall comment still stands, I think.

Your mailmap string list has "Ee@eee" (email part only) stored, while
the record from author/committer line has "NNNN <EE@EEE> TTTTTT sZZZZ",
to hold name, timestamp and zone.  You have a pointer email pointing
at the first "E" in that record, with maillen set to 6, and see if
the mailmap contains a string that match "EE@EEE".  So I mixed up
the prefix-ness of these strings.

Let's address the case sensitivety first.  The string_list_lookup()
and your string_list_lookup_extended() functions both work on a
string list that is built by add_mapping() function that asks
string_list_find_insert_index() to find an insertion point in the
sorted string list.  If this is not done using the same case
insensitive manner for a string list that is meant to be queried
case insensitively, the resulting list is still sorted case
sensitively, and look-up functions that work by binary search won't
find what you are looking for when they try to find the string using
case-insensitive comparison.  The change to implement it would
probably look like the attached patch.

Assuming that we can leave the case sensitivity behind us that way,
we still would need a new helper function

    string_list_lookup_prefix(struct string_list *, const char*, size_t)

so that you can find an existing "Ee@eee" entry in the string list
by email that points at "EE@EEE> TTTTTT sZZZZ" with maillen of 6.

I am wondering if we can do that without adding the length-limited
sort in the low-level get_entry_index() to do so, though.

You could first ask string_list_find_insert_index() to locate the
insertion point for "EE@EEE> TTTTTT sZZZZ".  That has to come after
"Ee@eee" if it exists (or it could be "De@eee" in which case you
know there is no match).

 1. Ask string_list_find_insert_index() to locate "EE@EEE> TTTTTT..."

    a. If it says there is an exact match, then that did not match
       "EE@EEE" list (you found "EE@EEE> TTTTTT sZZZZ").  You might
       still find "EE@EEE" before that record, though.  Also your
       key may have been "EE@EEE" exactly, in which case you already
       found what you were looking for.

    b. If it says there is not an exact match, the returned value is
       pointing at a record that comes after "EE@EEE> TTTTTT sZZZZ" if
       you were to insert it, which definitely is after "EE@EEE".

    So in either case, you know what you are looking for must come
    before string_list_find_insert_index() gave you.  Let's call
    that position "i".

    You still need to be careful that there could be an existing
    entry whose key is "EE@EEE" followed by a byte that sorts before
    ">" or " " (we do not want to limit this new generic string-list
    function to operate only on e-mail addresses), though.  So the
    above "must come before" is not "must come immediately before".

 2. Then compare map->items[i].string and email using strncasecmp()
    for maillen bytes, and make sure map->items[].string is exactly
    maillen bytes long.  If it matches, you found what you were
    looking for.  Otherwise, decrement "i" (e.g. the overlong key
    string you had was "EE@EEE> TTTTTT..." and the record at one
    before the insertion point was "EE@EEE\t" which sorts before it,
    but the string-list may have "EE@EEE" before that entry), see if
    the first maillen bytes still match, and continue.  Once you
    decrement i enough, the first maillen bytes won't match
    (e.g. you hit "De@EEE"), or "i" goes negative, and you can stop.

or something like that.  I'll cook up a patch and see how ugly it
ends up with.

-- >8 --
Subject: [PATCH] string-list: allow case-insensitive string list

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * At the very beginning of mailmap.c::read_mailmap(), you would say
   something like:

	int read_mailmap(struct string_list *map, char **repo_ident)
        {
        	map->strdup_strings = 1;
       +        map->cmp = strcasecmp;
                /* each failure returns 1, so >1 means both calls ...

   to make the mailmap string list a case insensitive one.

 string-list.c | 17 +++++++++++++----
 string-list.h |  4 ++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/string-list.c b/string-list.c
index 397e6cf..6f3d8cf 100644
--- a/string-list.c
+++ b/string-list.c
@@ -7,10 +7,11 @@ static int get_entry_index(const struct string_list *list, const char *string,
 		int *exact_match)
 {
 	int left = -1, right = list->nr;
+	compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
 
 	while (left + 1 < right) {
 		int middle = (left + right) / 2;
-		int compare = strcmp(string, list->items[middle].string);
+		int compare = cmp(string, list->items[middle].string);
 		if (compare < 0)
 			right = middle;
 		else if (compare > 0)
@@ -96,8 +97,9 @@ void string_list_remove_duplicates(struct string_list *list, int free_util)
 {
 	if (list->nr > 1) {
 		int src, dst;
+		compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
 		for (src = dst = 1; src < list->nr; src++) {
-			if (!strcmp(list->items[dst - 1].string, list->items[src].string)) {
+			if (!cmp(list->items[dst - 1].string, list->items[src].string)) {
 				if (list->strdup_strings)
 					free(list->items[src].string);
 				if (free_util)
@@ -230,15 +232,20 @@ struct string_list_item *string_list_append(struct string_list *list,
 			list->strdup_strings ? xstrdup(string) : (char *)string);
 }
 
+/* Yuck */
+static compare_strings_fn compare_for_qsort;
+
+/* Only call this from inside sort_string_list! */
 static int cmp_items(const void *a, const void *b)
 {
 	const struct string_list_item *one = a;
 	const struct string_list_item *two = b;
-	return strcmp(one->string, two->string);
+	return compare_for_qsort(one->string, two->string);
 }
 
 void sort_string_list(struct string_list *list)
 {
+	compare_for_qsort = list->cmp ? list->cmp : strcmp;
 	qsort(list->items, list->nr, sizeof(*list->items), cmp_items);
 }
 
@@ -246,8 +253,10 @@ struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string)
 {
 	int i;
+	compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
+
 	for (i = 0; i < list->nr; i++)
-		if (!strcmp(string, list->items[i].string))
+		if (!cmp(string, list->items[i].string))
 			return list->items + i;
 	return NULL;
 }
diff --git a/string-list.h b/string-list.h
index c50b0d0..446e79e 100644
--- a/string-list.h
+++ b/string-list.h
@@ -5,10 +5,14 @@ struct string_list_item {
 	char *string;
 	void *util;
 };
+
+typedef int (*compare_strings_fn)(const char *, const char *);
+
 struct string_list {
 	struct string_list_item *items;
 	unsigned int nr, alloc;
 	unsigned int strdup_strings:1;
+	compare_strings_fn cmp; /* NULL uses strcmp() */
 };
 
 #define STRING_LIST_INIT_NODUP { NULL, 0, 0, 0 }
-- 
1.8.1.304.gf036638

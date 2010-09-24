From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add --exclude-dir option to git grep
Date: Fri, 24 Sep 2010 13:33:33 -0700
Message-ID: <7v1v8iq3tu.fsf@alter.siamese.dyndns.org>
References: <20100924042614.GA25944@nulllenny.dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Ripton <dripton@ripton.net>
X-From: git-owner@vger.kernel.org Fri Sep 24 22:33:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzExo-0000eu-RD
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 22:33:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758001Ab0IXUdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 16:33:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46231 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754810Ab0IXUdn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 16:33:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9FEFD8A08;
	Fri, 24 Sep 2010 16:33:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E92Noyo5dtjop54qLDmC8WFdj84=; b=edytCm
	lmseNmjbonidGWEJpzH+RsLNCkTTMk9rAc1sKNIaUMAPla0xSIH76nuR3NM9mw6j
	NF7KTIouboMBAwF3CIfbflrtJ5U+KgBTot+lt8dO4C7U5OQMgF3onFBGPA7FsRQv
	vDI+/SRJVuGrAzVRU0th1MSafjvCVlla6OYeg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rDvccEgdD97EK5RxhTiIWP/6Jg5A8veb
	cPJYUgZkfUNgu5KbVU9+yA1mkiCW/DOR0Ai4mqDj5Jd9MhAcIPOddWzQxkY3F4BH
	3ivNevAf0vLwybzGIzvbPLexEEwk/RQo6jvWHRvRI5cDtD6KqfdbtxvmFzQlsvw7
	u7OU7F3ffDw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AF8F8D8A07;
	Fri, 24 Sep 2010 16:33:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB0B1D8A06; Fri, 24 Sep
 2010 16:33:35 -0400 (EDT)
In-Reply-To: <20100924042614.GA25944@nulllenny.dreamhost.com> (David Ripton's
 message of "Thu\, 23 Sep 2010 21\:26\:14 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 032652EC-C81B-11DF-A73F-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157052>

David Ripton <dripton@ripton.net> writes:

> It works much like the same option in recent versions of GNU grep.
> Any directory name which matches the option will not be searched.
>
> For example, "git grep --exclude-dir Documentation malloc"
>
> Signed-off-by: David Ripton <dripton@ripton.net>

Thanks.

> +/* Return a sorted string_list of all possible directories within path.
> + *
> + * e.g. if path is "foo/bar/baz", then return a string_list with:
> + *                 "bar"
> + *                 "bar/baz"
> + *                 "baz"
> + *                 "foo"
> + *                 "foo/bar"
> + *                 "foo/bar/baz"
> + */
> +static struct string_list subdirs(const char *path)
> +{
> +...
> +}
> +
>  /*
>   * Return non-zero if max_depth is negative or path has no more then max_depth
>   * slashes.
>   */
> -static int accept_subdir(const char *path, int max_depth)
> +static int accept_subdir(const char *path, int max_depth,
> +				struct string_list exclude_dir_list)
>  {
> +	struct string_list subdir_list = subdirs(path);

Do you need to run this every time we visit a new directory, expanding
directory components over and over?

It is not like we are jumping around directory hierarchies, visiting
"foo/bar" and then "xyzzy" and then "foo/baz", but rather we visit
directories in a nicer order (i.e. after leaving "foo/bar" but before
jumping to "xyzzy", we would visit "foo/baz"), don't we?

For example, if we are about to visit "foo/bar/baz", that would mean we
were in "foo/bar" and already checked that our exclude list is Ok with
either "foo", "foo/bar" or "bar"; shouldn't we be skipping the test for
these three expansions at least?  IOW, when checking against the exclude
list, shouldn't we be testing with "baz", "bar/baz" and "foo/bar/baz" and
nothing else?

> +	int i;
> +	for (i = 0; i < subdir_list.nr; i++) {
> +		if (string_list_has_string(&exclude_dir_list, subdir_list.items[i].string)) {
> +			string_list_clear(&subdir_list, 0);
> +			return 0;
> +		}
> +	}
> +	string_list_clear(&subdir_list, 0);
> +
>  	if (max_depth < 0)
>  		return 1;

Isn't this original check much cheaper than the new test based on many
comparisons and should be at the beginning of the function?

> @@ -826,6 +886,25 @@ static int help_callback(const struct option *opt, const char *arg, int unset)
>  	return -1;
>  }
>
> +static int exclude_dir_callback(const struct option *opt, const char *arg,
> +				int unset)
> +{
> +	struct string_list *exclude_dir_list = opt->value;
> +	char *s1 = (char *)arg;

What is this cast for?

> +	/* We do not want leading or trailing slashes. */
> +	while (*s1 == '/') {
> +		s1++;
> +	}

Can the result of this loop become an empty string, and what happens to
the rest of the logic when it happens?

> +	char *s2 = strdup(s1);

decl-after-statement.  Use xstrdup().

> +	while (*s2 && s2[strlen(s2)-1] == '/') {
> +		s2[strlen(s2)-1] = '\0';
> +	}

Don't scan s2 repeatedly to find its end by calling strlen(s2) on it.
Find its length once, and scan backwards from there yourself.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] pathspec: record labels
Date: Thu, 12 May 2016 22:26:10 -0700
Message-ID: <xmqqy47ea5ql.fsf@gitster.mtv.corp.google.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<20160513001936.7623-5-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
	Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri May 13 07:26:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b15cB-0008Cd-SP
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 07:26:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665AbcEMF0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 01:26:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61838 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752640AbcEMF0O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 01:26:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 4A8D41B6AE;
	Fri, 13 May 2016 01:26:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=17bAqPe3rMrBJ+2JdvBMEEyG+VQ=; b=gzAgOq
	GyyyxWCTCeTofGEDhyGuUz8R/X/VUTZ9ISuh0lkgQpqvS3AGoEUJXB5klULhMuL0
	VGpVHxt7tqrTW5W0UMPVfd4hK8NL3fc9EivzYB9H0En99TbmSqCwi31q3ZJ27veM
	xp2Vl2NnGE1spvtwJylGIV0bkz2ZHe1BqMwNg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MN/dEofE4y4i95oMNHMGyKjPQ1fLRvXQ
	Y1R80p6upZFTkMrt8a+Qys0uINZ/IgklHiH8CLWM+6ykerOpHAtQWytAMUS31Yik
	xKGDJDrNyQbazmWi5s+sn6ukzjl42PaOxovTB9QMtLTtO6r6AKbT8uh4DhkN8FXL
	Q2SKYI6UqT8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 424241B6AD;
	Fri, 13 May 2016 01:26:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B11CB1B6AC;
	Fri, 13 May 2016 01:26:12 -0400 (EDT)
In-Reply-To: <20160513001936.7623-5-sbeller@google.com> (Stefan Beller's
	message of "Thu, 12 May 2016 17:19:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 34F6EC62-18CB-11E6-B05E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294503>

Stefan Beller <sbeller@google.com> writes:

> +
> +label:<white space separated list>;;
> +	Labels can be assigned to pathspecs in the .gitattributes file.
> +	By specifying a list of labels the pattern will match only
> +	files which have all of the listed labels.
>  +

Attributes are given to paths, not pathspecs.  You specify which paths
the entry applies to by matching the pattern (which is at the beginning
of the line) against each path, and take the matching entries.

In any case, what the first sentence tries to explain applies to
each and every attribute .gitattributes file can define, and
explaining it should be better left for the first sentence in the
DESCRIPTION section.

As to the second sentence, I would say "When specifying the paths to
work on to various Git commands, the :(label=<label>,...)  magic
pathspec can be used to select paths that have all the labels given
by the 'label' attribute.", or something like that, to clarify where
that "specifying" and "match" happens (they do not happen here, but
happen when using magic pathspec).

> +void load_labels(const char *name, int namelen, struct string_list *list)

This must be file scope static, no?

> +{
> +	static struct git_attr *attr;
> +	struct git_attr_check check;
> +	char *path = xmemdupz(name, namelen);
> +
> +	if (!attr)
> +		attr = git_attr("label");
> +	check.attr = attr;
> +
> +	if (git_check_attr(path, 1, &check))
> +		die("git_check_attr died");
> +
> +	if (ATTR_CUSTOM(check.value)) {
> +		string_list_split(list, check.value, ',', -1);
> +		string_list_sort(list);
> +	}
> +
> +	free(path);
> +}

I am wondering where we should sanity check (and die, pointing out
an error in .gitattributes file).  Is this function a good place to
reject TRUE and FALSE?

By the way, ATTR_CUSTOM() is probably a bad name.  gitattributes.txt
calls them Set, Unset, Set to a value and Unspecified, and this is
trying to single out "Set to a value" case.  ATTR_STRING() may be
more appropriate.

> @@ -263,6 +285,15 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
>  	    strncmp(item->match, name - prefix, item->prefix))
>  		return 0;
>  
> +	if (item->group) {
> +		struct string_list has_labels = STRING_LIST_INIT_DUP;
> +		struct string_list_item *si;
> +		load_labels(name, namelen, &has_labels);
> +		for_each_string_list_item(si, item->group)
> +			if (!string_list_has_string(&has_labels, si->string))
> +				return 0;
> +	}
> +

Is this the right place, before we even check if the prefix already
covered everything?

We are looking at one element in the pathspec here.  If that element
is known to be a "group", and the path has all the required labels,
is it correct to fall through?

    Ahh, you are making ":(label=...)makefile" to say "paths must
    match the string 'makefile' in some way, and further the paths
    must have all these labels?  Then falling through is correct.
    The placement before the "prefix covered" looks still a bit
    strange, but understandable.

Is this code leaking has_labels every time it is called?

By the way, we should pick one between label and group and stick to
it, no?  Perhaps call the new field "item->label"?

>  	/* If the match was just the prefix, we matched */
>  	if (!*match)
>  		return MATCHED_RECURSIVELY;
> diff --git a/pathspec.c b/pathspec.c
> index 4dff252..c227c25 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -94,6 +94,7 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
>  {
>  	int i;
>  	const char *copyfrom = *copyfrom_;
> +	const char *out;

It probably is meant as "output", but it looks more like the "body" or
the "contents" of the named magic to me.

>  	/* longhand */
>  	const char *nextat;
>  	for (copyfrom = elt + 2;
> @@ -117,6 +118,20 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
>  			continue;
>  		}
>  
> +		if (skip_prefix(copyfrom, "label:", &out)) {

This is good, but can you fix the "prefix:" one we see a few lines
above, too, using this to lose "copyfrom + 7" there?

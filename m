From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC-PATCHv6 4/4] pathspec: allow querying for attributes
Date: Mon, 16 May 2016 22:03:11 -0700
Message-ID: <xmqqvb2dxomo.fsf@gitster.mtv.corp.google.com>
References: <20160517031353.23707-1-sbeller@google.com>
	<20160517031353.23707-5-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: pclouds@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 07:03:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2XAW-0000FA-Qd
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 07:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695AbcEQFDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 01:03:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54208 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754664AbcEQFDP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 01:03:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA2571625F;
	Tue, 17 May 2016 01:03:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PbkEQPB1WmSCNYXRg017yQOKBRw=; b=s5Dcai
	IpeIzwPIi00An6Ta3TcF4Fzu8q1nAqZ50cdCEQNNyPUcOh8iTztuQyRHAebR7e6Z
	ZREROaKjY7wocX3HL8FvCZ6vyx8agqWzN6Um+l6XWPNqTfZtucj3cBGC8zph46rx
	tcm2+XlFxnT1umFILcuUkqBzQubj65CABx1lk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qi+R6OimAytF3QOqvWm6xhb7TiTv9Cza
	fUlGw9mkkZylLXJNoyO6dwkh6ltlyzOoe2zs4iwaf0w6CUyTuddANdmxnUFx5VY2
	8SjUAhcWZI1LOdHCojA+mzyC4BCO37YCise96z6QkgFXq2GcXfxnWoYK1XsLBch+
	en0Qb+rMzc0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E25E01625E;
	Tue, 17 May 2016 01:03:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CFBC1625D;
	Tue, 17 May 2016 01:03:13 -0400 (EDT)
In-Reply-To: <20160517031353.23707-5-sbeller@google.com> (Stefan Beller's
	message of "Mon, 16 May 2016 20:13:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A86C67AC-1BEC-11E6-8112-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294855>

Stefan Beller <sbeller@google.com> writes:

> +static struct git_attr_check *check;
> +static int match_attrs(const char *name, int namelen,
> +		       const struct pathspec_item *item)
> +{
> +	char *path;
> +	int i;
> +
> +	if (!check) {
> +		check = git_attr_check_alloc();
> +		for (i = 0; i < item->attr_nr; i++)
> +			git_attr_check_append(check, item->attrs[i].attr);

This is simply wrong; you may have two pathspec elements with
attribute match magic, the first one may ask for one attribute while
the second one may ask for seven.  The first time around you
allocate and append one attribute.  The second time around you don't
do anything useful, and send a git_attr_check with one element to
deal with 7 attributes.

> +	}
> +	path = xmemdupz(name, namelen);
> +	git_all_attrs(path, check);

However, the above "This is simply wrong" bogosity is covered
because git_all_attrs() is used here, ignoring what is in check.

The loop we see above is an expensive no-op, as the first thing
all_attrs() does is to empty check() and instead stuff it with every
attribute under the sun, not necessarily limited to attributes in
item->attrs[].

By the way, do not call an array as plural.  item->attr[i] is a good
name to call a single ith element in an array.  item->attrs[i] isn't.

> +	for (i = 0; i < item->attr_nr; i++) {
> +		int matched;
> +		const char *value = check->check[i].value;

check[i] has no relevance to item->attrs[i] here.  I do not think
the code after this point is computing anything sensible.

> diff --git a/pathspec.h b/pathspec.h
> index 0c11262..89d73db 100644
> --- a/pathspec.h
> +++ b/pathspec.h
> @@ -32,6 +32,21 @@ struct pathspec {
>  		int len, prefix;
>  		int nowildcard_len;
>  		int flags;
> +		int attr_nr;
> +		int attr_alloc;
> +		struct attr_item {
> +			char *attr;
> +			char *value;
> +			enum attr_match_mode {
> +				NOT_INIT,
> +				MATCH_SET,
> +				MATCH_UNSET,
> +				MATCH_VALUE,
> +				MATCH_UNSPECIFIED,
> +				MATCH_NOT_UNSPECIFIED,
> +				INVALID_ATTR
> +			} mode;
> +		} *attrs;

I'd think the above addition that is in line with the updated API
would look more like this [*1*]:

	int attr_match_nr;
        int attr_match_alloc;
        struct attr_match {
        	struct git_attr *attr;
                char *value;
                enum attr_match_mode {
                	...
		} match_mode;
	} *attr_match;
	struct git_attr_check *attr_check;

Then while parsing ":(attr:VAR1=VAL1 -VAR2 VAR3...)path/to/dir/",
you would first do:

	p->attr_check = git_attr_check_alloc();

once, and then send each of VAR1=VAL2, -VAR2, VAR3... to your
parse_one_item() helper function which would:

 * parse the match-mode like your code does;

 * parse out the attribute name (i.e. VAR1, VAR2 and VAR3), and
   instead of keeping it as a "(const) char *", call git_attr()
   to intern it (and keep it in local variable "attr"), and save
   it in p->attr_match[p->attr_nr].attr;

 * call git_attr_check_append(p->attr_check, git_attr_name(attr))

After the above finishes, you would end up with something like:

        .attr_match = {
            { .attr = git_attr("VAR1"), .value = "VAL2",
              .match_mode = MATCH_VALUE },
            { .attr = git_attr("VAR2"), .value = <does not matter>,
              .match_mode = MATCH_UNSET },
            ...
	},
        .attr_check = {
	    .check = {
            	{ .attr = git_attr("VAR1"), .value = <does not matter> },
            	{ .attr = git_attr("VAR2"), .value = <does not matter> },
            	{ .attr = git_attr("VAR3"), .value = <does not matter> },
            }
	    
When matching (i.e. the match_attrs() function), you would instead
do

	path = xmemdupz(name, namelen);
	git_check_attr(path, item->attr_check);

to grab values for only attributes that matter to you, instead of
calling git_all_attrs() [*2*].

After git_check_attr() returns, item->attr_check.check[0].attr would
be git_attr("VAR1") and item->attr_check.check[0].value would be
whatever setting the path has for the VAR1 attribute.  You can use
your match_mode logic to compare it with the values .attr_match
expects.

You do not necessarily have to have the same number of elements in
.attr_match and .attr_check.check by the way.  .attr_match might say

	VAR1=VAL2 !VAR1 -VAR1

which may be always false if these are ANDed together, but in order
to evaluate it, you need only one git_attr_check_elem for VAR1.


[Footnote]

*1* With the old API, things would not be that much different.
    Instead of single structure .attr_check, you would make an
    array of git_attr_check structure, exactly like the array
    at .attr_check.check[] in the new API by hand.  The new API
    makes this preparation simpler by managing the array on the API
    implementation side.

*2* Please do not use that silly function especially in performance
    sensitive codepath.

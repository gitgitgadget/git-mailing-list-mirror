From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] for-each-ref: re-structure code for moving to 'ref-filter'
Date: Mon, 25 May 2015 10:15:39 -0700
Message-ID: <xmqqegm4bmtg.fsf@gitster.dls.corp.google.com>
References: <556317F8.2070609@gmail.com>
	<1432557943-25337-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	matthieu.moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 25 19:15:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ywvyd-0000rA-7b
	for gcvg-git-2@plane.gmane.org; Mon, 25 May 2015 19:15:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbbEYRPn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 May 2015 13:15:43 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35911 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbbEYRPm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 May 2015 13:15:42 -0400
Received: by igbpi8 with SMTP id pi8so40363281igb.1
        for <git@vger.kernel.org>; Mon, 25 May 2015 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=w9jC4cc9C7vQvQ+xfRZl3RsrGJ1kL2idGm0UjM7ZlKo=;
        b=K83DGRX1CH/JVewyrE0TNcYIlDarcsM81Y3FaKZGTd8aMc6tUmfYCcX53ogpV9svsa
         efSmvI1+2H0rXnZFKH/i/1ayZtQ3wD0jxHG4nhO75ny9fOAqoDSfOzS6Y5ke+D2bKgyI
         Q+znP+GDu4UT91fARi50FL6irk7jUIYMgI5QvpakRlMczPCli4J6m8PBY00hRfEgseVE
         APs6mlcF42XVZBYlFP6WWYxy7qhBlI4UOdOXyLHHTkw/4Udf0N5uCZcJGgtpOoHF5UtJ
         st84ZPukbDuLC0WuA22ScV1b7QdtEqeiufJd57vufY++rp3K+IYPFKLWCWbmzLLpJ2jS
         KvsQ==
X-Received: by 10.107.29.148 with SMTP id d142mr30836982iod.9.1432574141521;
        Mon, 25 May 2015 10:15:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:21e0:c856:141b:7701])
        by mx.google.com with ESMTPSA id y124sm9114858iod.13.2015.05.25.10.15.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 May 2015 10:15:40 -0700 (PDT)
In-Reply-To: <1432557943-25337-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Mon, 25 May 2015 18:15:42 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269846>

Karthik Nayak <karthik.188@gmail.com> writes:

> -struct refinfo {
> -	char *refname;
> -	unsigned char objectname[20];
> -	int flag;
> +struct ref_filter_item {
> +	unsigned char sha1[20];
> +	int flags;
>  	const char *symref;
>  	struct atom_value *value;
> +	char *name;
> +};

I do not see much point in renaming between these two.  The latter
makes it sound as if this is only for "filtering" and from that
angle of view is probably a worse name.  If you do not think of a
better one, and if you are going to name the array that contains
this thing "ref_list", calling "ref_list_item" would be following
suit to what string-list did.

I somehow had an impression that we are trying to move away from
calling the name of objects as "sha1[]" as a longer term goal?  I do
not think it is particularly a good idea to start using "struct
object_id" in this series (it can be done after everything is done
and you still have time left in GSoC), but I do not see how much
value this interim renaming (because eventually we would change not
just name but type, and the final name will _not_ be sha1[] but more
closer to "object name") adds value.

You didn't explain why you reordered the fields, either.  Were you
planning to make the name[] field to flex-array to reduce need for
one level of redirection or something?

> +
> +struct ref_list {
> +	int nr, alloc;
> +	struct ref_filter_item **items;
> +};
> +
> +struct ref_filter {
> +	const char **name_patterns;
> +};
> +
> +struct ref_filter_data {
> +	struct ref_list list;
> +	struct ref_filter filter;
>  };

I agree that "grab" part of "grab_ref_cbdata" sounds unprofessional,
and using "ref_filter_" to signal that this callback data is about
ref-filter API might be a good idea (I do not think the original is
too bad, either, though).  I do not think you would use this struct
anywhere other than as the callback data; you would want to end its
name with "_cbdata", not just "_data", to make it clear why these
two unrelated things are in a single struct (the only time these two
concepts, operation and operatee, meet is when they need to be
passed to an "apply operation to operatee" function; there is no
such "this set of operatee always are for this operation"
association between them---which is what I mean by 'two unrelated
things').

> @@ -98,7 +112,7 @@ static int need_color_reset_at_eol;
>  /*
>   * Used to parse format string and sort specifiers
>   */
> -static int parse_atom(const char *atom, const char *ep)
> +int parse_atom(const char *atom, const char *ep)

It was perfectly good name as a file-scope static; within the
context of 'for-each-ref' implementation, when every somebody says
"atom", you would know it is those %(atomic-data-item) things, and
parse_atom() would be a helper function to do so.

But it is *WAY* too generic a name to make public, where you are
naming things in the whole context of Git implementation.  If you
used the word "atom" while discussing formatting done with "git
for-each-ref" with somebody else, it would be unambiguously clear
what you mean; you wouldn't say "I am writing a function to parse
'atoms' in Git"---that's too broad and you will get "'atom', in what
sense?" in response.

> @@ -175,7 +189,7 @@ static const char *find_next(const char *cp)
>   * Make sure the format string is well formed, and parse out
>   * the used atoms.
>   */
> -static int verify_format(const char *format)
> +int verify_format(const char *format)

Ditto.

> @@ -622,7 +636,7 @@ static inline char *copy_advance(char *dst, const char *src)
>  /*
>   * Parse the object referred by ref, and grab needed value.
>   */
> -static void populate_value(struct refinfo *ref)
> +static void populate_value(struct ref_filter_item *ref)
>  {

As long as this will stay private within the new ref-filter.c after
the move, this name is OK.

> @@ -655,14 +669,14 @@ static void populate_value(struct refinfo *ref)
>  		}
>  
>  		if (starts_with(name, "refname"))
> -			refname = ref->refname;
> +			refname = ref->name;
>  		else if (starts_with(name, "symref"))
>  			refname = ref->symref ? ref->symref : "";
>  		else if (starts_with(name, "upstream")) {
>  			/* only local branches may have an upstream */
> -			if (!starts_with(ref->refname, "refs/heads/"))
> +			if (!starts_with(ref->name, "refs/heads/"))
>  				continue;
> -			branch = branch_get(ref->refname + 11);
> +			branch = branch_get(ref->name + 11);
>  
>  			if (!branch || !branch->merge || !branch->merge[0] ||
>  			    !branch->merge[0]->dst)
> @@ -677,9 +691,9 @@ static void populate_value(struct refinfo *ref)
>  			continue;
>  		} else if (!strcmp(name, "flag")) {
>  			char buf[256], *cp = buf;
> -			if (ref->flag & REF_ISSYMREF)
> +			if (ref->flags & REF_ISSYMREF)
>  				cp = copy_advance(cp, ",symref");
> -			if (ref->flag & REF_ISPACKED)
> +			if (ref->flags & REF_ISPACKED)
>  				cp = copy_advance(cp, ",packed");
>  			if (cp == buf)
>  				v->s = "";

I see fallouts from the two renamed fields in the above hunks.  Was
the rename necessary?

refinfo keeps two names (ref and object) and calling one "refname"
made perfect sense (and calling other "objectname" did, too).  Has
anything around its use changed to invalidate that rationale after
the structure was renamed?

When we say 'flag', it is obvious that it is a "flag word", i.e. a
word that holds collection of flags.  Otherwise, we would have named
each "unsigned foo_flag : 1" with meaningful names.  Was it
necessary to make the field name longer?

> @@ -688,7 +702,7 @@ static void populate_value(struct refinfo *ref)
>  				v->s = xstrdup(buf + 1);
>  			}
>  			continue;
> -		} else if (!deref && grab_objectname(name, ref->objectname, v)) {
> +		} else if (!deref && grab_objectname(name, ref->sha1, v)) {
>  			continue;

Mental note: grab_objectname() still remains, so I'd guess that it
will not be moved from this file or it will stay private after it is
moved.

Another mental note: it was a consistent naming for the function to
grab objectname to store the result into objectname[] field.  Now it
stores into sha1[] field.

> +/*
> + * Given a refname, return 1 if the refname matches with one of the patterns
> + * while the pattern is a pathname like 'refs/tags' or 'refs/heads/master'
> + * and so on, else return 0. Supports use of wild characters.
> + */
> +static int match_name_as_path(const char **pattern, const char *refname)
> +{
> +	int namelen = strlen(refname);
> +	for (; *pattern; pattern++) {
> +		const char *p = *pattern;
> +		int plen = strlen(p);
> +
> +		if ((plen <= namelen) &&
> +		    !strncmp(refname, p, plen) &&
> +		    (refname[plen] == '\0' ||
> +		     refname[plen] == '/' ||
> +		     p[plen-1] == '/'))
> +			return 1;
> +		if (!wildmatch(p, refname, WM_PATHNAME, NULL))
> +			return 1;
> +	}
> +	return 0;
> +}

Yuck; I can see what you are doing but can you imitate what the more
experienced people (e.g. peff, mhagger) do when restructuring
existing code and do things in smaller increments?  For example, I
think it should be a separate preparatory patch, even before these
renames of structures, fields and functions, to extract this helper
function out of grab_single_ref() function.

> +
> +/* Allocate space for a new ref_filter_item and copy the sha1 and flags to it */
> +static struct ref_filter_item *new_ref_filter_item(const char *refname,
> +						   const unsigned char *sha1,
> +						   int flag)
> +{
> +	struct ref_filter_item *ref = xcalloc(1, sizeof(struct ref_filter_item));
> +	ref->name = xstrdup(refname);
> +	hashcpy(ref->sha1, sha1);
> +	ref->flags = flag;
> +
> +	return ref;
> +}

And extracting this could be another separate preparatory step
before renames (but I didn't look too closely).

I won't be commenting on the remainder of the patch in this message,
as I need to step out.  I see quite a many instances of the same
"overly generic public names" in your "s/static //".

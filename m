Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NrJysc1r"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A30192
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 17:26:20 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5AFFC32DC6;
	Wed, 15 Nov 2023 20:26:20 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jkZxVB/MoLrV9xZzH+oUzn9GmgdIXRhpoYscCo
	iwDGc=; b=NrJysc1rJ5AVvSOXKs8Gk+x70NZFOXkWrwbw7Vhq8AWDEtwJ+Iy1k1
	SQOaPJ6bscFkNf8PbZ3WmIItOJa53GM8vYHuk+fAYbdMkrZyWDXYuVtwf0b6MNJX
	5Ko6c7B9dsOSCBG80aQpdn5VtMUQcgxzh9Iin19JzHbhX06iff5OY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5338832DC5;
	Wed, 15 Nov 2023 20:26:20 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E48B632DC0;
	Wed, 15 Nov 2023 20:26:16 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Joanna Wang <jojwang@google.com>
Cc: git@vger.kernel.org,  tboegi@web.de
Subject: Re: [PATCH 1/1] attr: add builtin objectmode values support
In-Reply-To: <20231114214934.3484892-1-jojwang@google.com> (Joanna Wang's
	message of "Tue, 14 Nov 2023 21:49:34 +0000")
References: <xmqqbkbx11x2.fsf@gitster.g>
	<20231114214934.3484892-1-jojwang@google.com>
Date: Thu, 16 Nov 2023 10:26:15 +0900
Message-ID: <xmqqy1eytrns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 238015EA-841F-11EE-B4AE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Joanna Wang <jojwang@google.com> writes:

>>                static struct git_attr mode_attr;
>>
>>                if (!mode_attr)
>>                        mode_attr = git_attr("mode");
> Is there an idiomatic way to check if this git_attr (struct or pointer)
> has been initialized?

Sorry (I think the above is a typo from the "to illustrate the idea"
code snippet in my message), the static one should be a pointer to a
struct, as git_attr() is meant to "intern" the given name and return
a singleton instance.

The idiom is to see if it is still NULL and then call git_attr().
Of course, you could repeatedly call git_attr() with the same name
and get the same singleton instance, so without the "have we
initialized?" check, your code will still be correct, but it would
incur a locked hashmap lookup (to ensure that we do not create the
second instance of the same name), so...

> +RESERVED BUILTIN_* ATTRIBUTES
> +-----------------------------
> +
> +builtin_* is a reserved namespace for builtin attribute values. Any
> +user defined attributes under this namespace will result in a warning.

warning and then?  I think we would want to do "warn and ignore",
not "warn and disable all the builtin_ computation", i.e.,

	... will be ignored and a warning message is given.

> +/*
> + * Atribute name cannot begin with "builtin_" which
> + * is a reserved namespace for built in attributes values.
> + */
> +static int attr_name_reserved(const char *name)
> +{
> +	return !strncmp(name, "builtin_", strlen("builtin_"));
> +}
> +

You'd want to use starts_with() probably.

> @@ -1240,6 +1250,57 @@ static struct object_id *default_attr_source(void)
>  	return &attr_source;
>  }
>  
> +static const char *builtin_object_mode_attr(struct index_state *istate, const char *path)
> +{
> +	unsigned int mode;
> +	struct strbuf sb = STRBUF_INIT;
> +	
> +	if (direction == GIT_ATTR_CHECKIN) {
> +		struct object_id oid;
> +		struct stat st;
> +		if (lstat(path, &st))
> +			die_errno(_("unable to stat '%s'"), path);
> +		mode = canon_mode(st.st_mode);
> +		if (S_ISDIR(mode)) {
> +			/* `path` is either a directory or it is a submodule,
> +			 * in which case it is already indexed as submodule
> +			 * or it does not exist in the index yet and we need to
> +			 * check if we can resolve to a ref.
> +			*/

	/*
	 * Our multi-line comment begins and ends with
	 * slash-asterisk and asterisk-slash on their
	 * own lines without anything else.
	 */

> +			int pos = index_name_pos(istate, path, strlen(path));
> +			if (pos >= 0) {
> +				 if (S_ISGITLINK(istate->cache[pos]->ce_mode))
> +					 mode = istate->cache[pos]->ce_mode;
> +			} else if (resolve_gitlink_ref(path, "HEAD", &oid) == 0)
> +				mode = S_IFGITLINK;
> +		}

Give {braces} around the else if block as the other side has it
(Documentation/CodingGuidelines):

	- When there are multiple arms to a conditional and some of them
	  require braces, enclose even a single line block in braces for
	  consistency.

> +	} else {
> +		/*
> +		 * For GIT_ATTR_CHECKOUT and GIT_ATTR_INDEX we only check
> +		 * for mode in the index.
> +		 */
> +		int pos = index_name_pos(istate, path, strlen(path));
> +		if (pos >= 0)
> +			mode = istate->cache[pos]->ce_mode;
> +		else 
> +			return ATTR__UNSET;
> +	}
> +	strbuf_addf(&sb, "%06o", mode);
> +	return sb.buf;
> +	

The struct itself will be reclaimed as it is on stack, and sb.buf is
given back to the caller, so there technically is no leak, but I think
a more kosher way to do this involves the use of strbuf_detach().

Let's lose the blank line at the end of the function that is not
serving much useful purpose.

>  void git_check_attr(struct index_state *istate,
>  		    const char *path,
>  		    struct attr_check *check)
> @@ -1253,7 +1314,7 @@ void git_check_attr(struct index_state *istate,
>  		unsigned int n = check->items[i].attr->attr_nr;
>  		const char *value = check->all_attrs[n].value;
>  		if (value == ATTR__UNKNOWN)
> -			value = ATTR__UNSET;
> +			value = compute_builtin_attr(istate, path, check->all_attrs[n].attr);
>  		check->items[i].value = value;
>  	}
>  }

Nicely done.

> diff --git a/t/t0003-attributes.sh b/t/t0003-attributes.sh
> index aee2298f01..25aa3fbd05 100755
> --- a/t/t0003-attributes.sh
> +++ b/t/t0003-attributes.sh
> @@ -19,6 +19,16 @@ attr_check () {
>  	test_must_be_empty err
>  }
>  
> +attr_check_object_mode () {
> +	path="$1" &&
> +	expect="$2" &&
> +	check_opts="$3" &&
> +	git check-attr $check_opts builtin_objectmode -- "$path" >actual 2>err &&
> +	echo "$path: builtin_objectmode: $expect" >expect &&
> +	test_cmp expect actual
> +	test_must_be_empty err
> +}
> +
>  attr_check_quote () {
>  	path="$1" quoted_path="$2" expect="$3" &&
>  
> @@ -558,4 +568,38 @@ test_expect_success EXPENSIVE 'large attributes file ignored in index' '
>  	test_cmp expect err
>  '
>  
> +test_expect_success 'native object mode attributes work' '

> +	>exec && chmod +x exec && attr_check_object_mode exec 100755 &&
> +	>normal && attr_check_object_mode normal 100644 &&
> +	mkdir dir && attr_check_object_mode dir 040000 &&

Just a style thing, but we tend to write one statement on each line.

> +	>to_sym ln -s to_sym sym && attr_check_object_mode sym 120000
> +'

You do not need to_sym file, do you?  Symbolic links can be left
dangling.

In any case, the above test would not work on a filesystem without
native executable bit support.  Also, you cannot do "ln -s" on
certain filesystems.  It is a good idea to split the above into
three tests, one that is run unconditionally (for "normal" and
"dir"), another that is run under the POSIXPERM prerequisite, and
the third that is run under the SYNLINKS prerequisite.

> +test_expect_success 'native object mode attributes work with --cached' '
> +	>normal && attr_check_object_mode normal unspecified --cached &&
> +	git add normal && attr_check_object_mode normal 100644 --cached
> +'

For "--cached test", on the other hand, we should be able to set the
executable bit or record a symbolic link regardless of the
filesystem using "update-index", e.g.,

	>normal && git add normal &&
	empty_blob=$(git rev-parse :normal)
	cat <<-EOF | git update-index --index-info
	100755 $empty_blob 0	exec
	120000 $empty_blob 0	symlink
	EOF
	attr_check_object_mode normal 100644 --cached &&
	attr_check_object_mode exec 100755 --cached &&
	attr_check_object_mode symlink 120000 --cached

or something.

> +test_expect_success 'check object mode attributes work for submodules' '
> +	mkdir sub &&
> +	(
> +		cd sub &&
> +		git init &&
> +		mv .git .real &&
> +		echo "gitdir: .real" >.git &&
> +		test_commit first
> +	) &&
> +	attr_check_object_mode sub 160000 &&
> +	attr_check_object_mode sub unspecified --cached &&
> +	git add sub &&
> +	attr_check_object_mode sub 160000 --cached
> +'

Sounds good.

> +test_expect_success 'we do not allow user defined builtin_* attributes' '
> +	echo "foo* builtin_foo" >.gitattributes &&
> +	git add .gitattributes 2>actual &&
> +	echo "builtin_foo is not a valid attribute name: .gitattributes:1" >expect &&
> +	test_cmp expect actual
> +'

Another thing that is worth checking is what happens when there is an
conflicting entry:

	echo "foo builtin_objectmode=200" >.gitattributes &&
	>foo &&
	attr_check_object_mode foo 100644

>  test_done
> diff --git a/t/t6135-pathspec-with-attrs.sh b/t/t6135-pathspec-with-attrs.sh
> index a9c1e4e0ec..b08a32ea68 100755
> --- a/t/t6135-pathspec-with-attrs.sh
> +++ b/t/t6135-pathspec-with-attrs.sh
> @@ -295,4 +295,29 @@ test_expect_success 'reading from .gitattributes in a subdirectory (3)' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'pathspec with builtin_objectmode attr can be used' '
> +	>mode_exec_file_1 &&
> +
> +	git status -s ":(attr:builtin_objectmode=100644)mode_exec_*" >actual &&
> +	echo ?? mode_exec_file_1 >expect &&
> +	test_cmp expect actual &&
> +
> +	git add mode_exec_file_1 && chmod +x mode_exec_file_1 &&
> +	git status -s ":(attr:builtin_objectmode=100755)mode_exec_*" >actual &&
> +	echo AM mode_exec_file_1 >expect &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'builtin_objectmode attr can be excluded' '
> +	>mode_1_regular &&
> +	>mode_1_exec  && chmod +x mode_1_exec &&
> +	git status -s ":(exclude,attr:builtin_objectmode=100644)" "mode_1_*" >actual &&
> +	echo ?? mode_1_exec >expect &&
> +	test_cmp expect actual &&
> +
> +	git status -s ":(exclude,attr:builtin_objectmode=100755)" "mode_1_*" >actual &&
> +	echo ?? mode_1_regular >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_done

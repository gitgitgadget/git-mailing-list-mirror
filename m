From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v4 1/1] receive-pack: optionally deny case clone refs
Date: Fri, 13 Jun 2014 06:03:14 +0200
Message-ID: <539A7802.9090007@web.de>
References: <1402525838-31975-1-git-send-email-dturner@twitter.com> <1402525838-31975-2-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 13 06:03:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvIi7-0000Ro-Gt
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 06:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbaFMEDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 00:03:23 -0400
Received: from mout.web.de ([212.227.17.12]:55104 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbaFMEDW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 00:03:22 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LiUG8-1WL8Xr2CYm-00clb9; Fri, 13 Jun 2014 06:03:19
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1402525838-31975-2-git-send-email-dturner@twitter.com>
X-Provags-ID: V03:K0:IVciUOkw+EV3dYVX03rP2ChpzwQInuTH0fWAGbjqxUF2Ii3TgNG
 YWMkONuHT8oeFZBkMYdnDsxdL7z9+YqzE23u5rNZjmL7CWEnA1GD0dLTtKACzIF1az3pgU5
 SWzmL5OLU+iBQcTiJ7L4y8dhZPyZiSiqXQ8NrXauQvhc7FNTku0IpPO26UIE9E7YxjUJhKV
 jharrFRChx9apJy4xtcCQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251512>

On 12.06.14 00:30, David Turner wrote:
[]
Just a general question:

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index c323081..6431758 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -27,6 +27,7 @@ enum deny_action {
>  
>  static int deny_deletes;
>  static int deny_non_fast_forwards;
> +static int deny_case_clone_refs = DENY_UNCONFIGURED;
>  static enum deny_action deny_current_branch = DENY_UNCONFIGURED;
>  static enum deny_action deny_delete_current = DENY_UNCONFIGURED;
>  static int receive_fsck_objects = -1;
> @@ -69,6 +70,11 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>  	if (status)
>  		return status;
>  
> +	if (strcmp(var, "receive.denycaseclonerefs") == 0) {
> +		deny_case_clone_refs = parse_deny_action(var, value);
                                       _action() : Which action ?
May be this is a better name:
parse_deny_case_clone_refs()
> +		return 0;
> +	}
> +
>  	if (strcmp(var, "receive.denydeletes") == 0) {
>  		deny_deletes = git_config_bool(var, value);
>  		return 0;
> @@ -468,6 +474,138 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
>  	return 0;
>  }
>  
> +/*
> + * This contains not just refs, but ref prefixes -- i.e. not just
> + * refs/heads/foo/bar, but refs, refs/heads, and refs/heads/foo
> + */
> +struct ref_cache_entry {
> +	struct hashmap_entry ent;
> +	unsigned int count; /* count of refs having this as a component */
> +	char ref[FLEX_ARRAY];
> +};
> +
> +static struct hashmap *ref_case_clone_cache;
> +
> +static int ref_cache_entry_cmp(const struct ref_cache_entry *e1,
> +			       const struct ref_cache_entry *e2, const char *ref)
> +{
> +	return strcasecmp(e1->ref, ref ? ref : e2->ref);
> +}
> +
> +/*
> + * Insert a ref into the ref cache, as well as all of its ancestor
> + * directory names -- so if we insert refs/heads/something/other,
> + * refs, refs/heads, refs/heads/something/other will be included.
> + */
> +static int ref_cache_insert(const char *refname, struct hashmap *map)
> +{
> +	int total_len = 0, comp_len;
> +
> +	while ((comp_len = check_refname_component(refname + total_len, 0)) >= 0) {
> +		struct ref_cache_entry *old;
> +		struct ref_cache_entry *entry = xmalloc(sizeof(*entry) + total_len + comp_len + 1);
> +		total_len += comp_len;
Could the total length can be calculated first and already used in xmalloc() ?
That will give 3 lines of code, but the reader is sure we are allocating the right length.
> +		struct ref_cache_entry;
> +		total_len += comp_len;
> +		entry = xmalloc(sizeof(*entry) + total_len  + 1);



> +		memcpy(entry->ref, refname, total_len);
> +		entry->ref[total_len] = 0;
> +		entry->count = 1;
> +		hashmap_entry_init(entry, memihash(entry->ref, total_len));
> +		old = hashmap_get(map, entry, entry->ref);
> +		if (old) {
> +			old->count ++;
> +			free(entry);
I'm not sure if I read it right:
If there is an old entry "old", we anyway create a new one and delete it immediately ?
> +		} else
> +			hashmap_add(map, entry);
> +		total_len ++;
> +	}
> +}
> +
> +/*
> + * Remove a ref from the ref cache, as well as any of its ancestor
> + * directory names that no longer contain any refs.
> + */
> +static int ref_cache_delete(const char *refname, struct hashmap *map)
> +{
> +	int total_len = 0, comp_len;
> +
> +	struct ref_cache_entry *entry = xmalloc(sizeof(*entry) + strlen(refname));
> +
> +	while ((comp_len = check_refname_component(refname + total_len, 0)) >= 0) {
> +		struct ref_cache_entry *old;
> +		total_len += comp_len;
> +		memcpy(entry->ref, refname, total_len);
> +		entry->ref[total_len] = 0;
> +		hashmap_entry_init(entry, memihash(entry->ref, total_len));
> +		old = hashmap_get(map, entry, entry->ref);
> +		if (old) {
> +			old->count --;
> +			if (old->count == 0) {
> +				hashmap_remove(map, old, old->ref);
> +				free(old);
> +			}
> +		} else {
> +			warn("Ref cache coherency failure: %s from %s", entry->ref, refname);
> +			break;
> +		}
> +		total_len ++;
> +	}
> +	free(entry);
> +}
> +
> +
> +static int ref_cache_insert_cb(const char *refname, const unsigned char *sha1,
> +			       int flags, void *cb_data)
> +{
> +	ref_cache_insert(refname, cb_data);
> +}
> +
> +static void ensure_ref_case_clone_cache(void)
> +{
> +	if (ref_case_clone_cache)
> +		return;
> +	ref_case_clone_cache = xmalloc(sizeof(*ref_case_clone_cache));
> +	hashmap_init(ref_case_clone_cache,
> +		     (hashmap_cmp_fn)ref_cache_entry_cmp, 1000);
> +
> +	for_each_ref(ref_cache_insert_cb, (void *)ref_case_clone_cache);
> +}
> +
> +/*
> + * Search the ref cache for a ref that is a case clone of this
> + * incoming ref; this includes prefix case clones so that
> + * refs/heads/case/clone will conflict with refs/heads/CASE/other
> + */
> +static int ref_is_case_clone(const char *name) {
> +	struct ref_cache_entry key;
> +	struct ref_cache_entry *existing;
> +	int total_len = 0, comp_len;
> +	char *name_so_far = strdup(name);
> +
> +	while ((comp_len = check_refname_component(name + total_len, 0)) >= 0) {
> +		total_len += comp_len;
> +		name_so_far[total_len] = 0;
> +		hashmap_entry_init(&key, memihash(name_so_far, total_len));
> +		existing = hashmap_get(ref_case_clone_cache, &key, name_so_far);
> +		if (!existing)
> +			return 0;
> +		if (memcmp(existing->ref, name_so_far, total_len))
> +			return 1;
> +		name_so_far[total_len] = '/';
> +		total_len ++;
> +	}
> +
> +	free(name_so_far);
> +	return 0;
> +}
> +
> +static int ref_is_denied_case_clone(const char *name)
> +{
> +	if (!deny_case_clone_refs)
> +		return 0;
> +	ensure_ref_case_clone_cache();
> +
> +	return ref_is_case_clone(name);
> +}
> +
>  static const char *update(struct command *cmd, struct shallow_info *si)
>  {
>  	const char *name = cmd->ref_name;
> @@ -478,7 +616,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  	struct ref_lock *lock;
>  
>  	/* only refs/... are allowed */
> -	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0)) {
> +	if (!starts_with(name, "refs/") || check_refname_format(name + 5, 0) ||
> +	    ref_is_denied_case_clone(name)) {
>  		rp_error("refusing to create funny ref '%s' remotely", name);
>  		return "funny refname";
Not related to this patch: the word "funny" may be not so funny.

But related to the patch:
If the update is denied because of ref_is_denied_case_clone() says so,
the user wants to know this.  So that she/he is able to understand it better.

Here we may want something like
		rp_error("refusing to create ref '%s' remotely because of a case insensitive duplicate", name);
>  
>  	}
> @@ -573,6 +712,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  			rp_error("failed to delete %s", name);
>  			return "failed to delete";
>  		}
> +		if (deny_case_clone_refs)
> +			ref_cache_delete(name, ref_case_clone_cache);
>  		return NULL; /* good */
>  	}
>  	else {
> @@ -589,6 +730,8 @@ static const char *update(struct command *cmd, struct shallow_info *si)
>  		if (write_ref_sha1(lock, new_sha1, "push")) {
>  			return "failed to write"; /* error() already called */
>  		}
> +		if (deny_case_clone_refs)
> +			ref_cache_insert(name, ref_case_clone_cache);
>  		return NULL; /* good */
>  	}
>  }
> @@ -1171,6 +1314,8 @@ int cmd_receive_pack(int argc, const char **argv, const char *prefix)
>  		die("'%s' does not appear to be a git repository", dir);
>  
>  	git_config(receive_pack_config, NULL);
> +	if (deny_case_clone_refs == DENY_UNCONFIGURED)
> +		deny_case_clone_refs = ignore_case;
>  
>  	if (0 <= transfer_unpack_limit)
>  		unpack_limit = transfer_unpack_limit;
> diff --git a/refs.c b/refs.c
> index 28d5eca..7d534cc 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -29,12 +29,7 @@ static inline int bad_ref_char(int ch)
>  	return 0;
>  }
>  
> -/*
> - * Try to read one refname component from the front of refname.  Return
> - * the length of the component found, or -1 if the component is not
> - * legal.
> - */
> -static int check_refname_component(const char *refname, int flags)
> +int check_refname_component(const char *refname, int flags)
>  {
>  	const char *cp;
>  	char last = '\0';
> diff --git a/refs.h b/refs.h
> index 87a1a79..38f3272 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -200,6 +200,12 @@ extern int for_each_reflog(each_ref_fn, void *);
>   * "." or "..").
>   */
>  extern int check_refname_format(const char *refname, int flags);
> +/*
> + * Try to read one refname component from the front of refname.  Return
> + * the length of the component found, or -1 if the component is not
> + * legal.
> + */
> +extern int check_refname_component(const char *refname, int flags);
>  
>  extern const char *prettify_refname(const char *refname);
>  extern char *shorten_unambiguous_ref(const char *refname, int strict);
> diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
> index 0736bcb..de0a88d 100755
> --- a/t/t5400-send-pack.sh
> +++ b/t/t5400-send-pack.sh
> @@ -129,6 +129,96 @@ test_expect_success 'denyNonFastforwards trumps --force' '
>  	test "$victim_orig" = "$victim_head"
>  '
>  
> +test_expect_success 'denyCaseCloneRefs works' '
> +	(
> +	    cd victim &&
> +	    git config receive.denyCaseCloneRefs true &&
> +	    git config receive.denyDeletes false
> +	) &&
> +	git send-pack ./victim HEAD:refs/heads/case/clone &&
> +	orig_ver=$(git rev-parse HEAD) &&
> +	test_must_fail git send-pack ./victim HEAD^:refs/heads/Case/Clone &&
> +	# confirm that this had no effect upstream
> +	(
> +	    cd victim &&
> +	    ref=$(git for-each-ref --format="%(refname)" refs/heads/Case/Clone) &&
> +	    echo "$ref" | test_must_fail grep -q Case/Clone &&
> +	    remote_ver=$(git rev-parse case/clone) &&
> +	    test "$orig_ver" = "$remote_ver"
> +	) &&
> +	git send-pack ./victim HEAD^:refs/heads/notacase/clone &&
> +	test_must_fail git send-pack ./victim :Case/Clone &&
> +	# confirm that this had no effect upstream
> +	(
> +	    cd victim &&
> +	    ref=$(git for-each-ref --format="%(refname)" refs/heads/Case/Clone) &&
> +	    echo "$ref" | test_must_fail grep -q Case/Clone &&
I'm not sure if this is the ideal combination:
Collect information in a shell variable, echo that to stdout and use grep -q
to find out that something is NOT there-
especially as I have in the back of my mind the warning "grep -q" is not portable...
But grep -q is in POSIX, so it may be that versions of grep being part of busybox
have this restriction.
I don't have a better suggestion either, just a loose idea:

	cd victim &&
	cat "this_or_that" >expected &&	
	git for-each-ref --format="%(refname)" refs/heads/Case/Clone | sort >actual &&
	test_cmp expect actual

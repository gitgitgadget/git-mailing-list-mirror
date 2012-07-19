From: Alexey Muranov <alexey.muranov@gmail.com>
Subject: Re: [PATCH 1/3] retain reflogs for deleted refs
Date: Fri, 20 Jul 2012 00:23:12 +0200
Message-ID: <7515FF5F-2B4F-4CD0-B4A3-D2B1328AE313@gmail.com>
References: <20120719213225.GA20311@sigill.intra.peff.net> <20120719213311.GA20385@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 20 00:23:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Srz7z-0004bC-8K
	for gcvg-git-2@plane.gmane.org; Fri, 20 Jul 2012 00:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab2GSWXR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jul 2012 18:23:17 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:61960 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751036Ab2GSWXP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2012 18:23:15 -0400
Received: by weyx8 with SMTP id x8so2128765wey.19
        for <git@vger.kernel.org>; Thu, 19 Jul 2012 15:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=tLvbVRtQ80+AR92ZRmYceN4wlR8f1BfFTE2OASUjhFM=;
        b=TKdCAyVWqScpgneuqo9uwgrpQ1edEJFqEAuNZl7/PtGPfFk7GhXW+XUfL22nvhdHRk
         gagYR8rIfMkLKlLykDxNBwe9goK1M/uPk7kN3+Mn9Px43YhZqyOWnbebBpKTWgEUnK4Q
         OhHPhd9eC0bmkRrJtWmkkadqAXlmYm4lz1xOWwCX7u1lnseOgjzFXSlOPlayuW13TFkn
         jNmGa4L09u+nd46FlqD1tuXq/2nmw8su2u9ZlEWUX0f6e2xyhOUMJWP/6Lr990Wsl8y5
         gqXP0J3FMm46DAEp9X29B0ri5HifWPhJ/BHxVnQ4lOWsdCPYOXparM3doFRgZ4zYT4zV
         f58g==
Received: by 10.180.86.226 with SMTP id s2mr8285104wiz.9.1342736594079;
        Thu, 19 Jul 2012 15:23:14 -0700 (PDT)
Received: from [192.168.6.127] (bi1.roaming.dfn.de. [195.37.234.61])
        by mx.google.com with ESMTPS id w7sm40886848wiz.0.2012.07.19.15.23.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jul 2012 15:23:13 -0700 (PDT)
In-Reply-To: <20120719213311.GA20385@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201757>

Jeff,

i have no idea about Git source and little idea of how it is working internally, but reading through your message i wonder: wouldn't it be a good idea to timestamp the dead reflogs ?

Alexey.

On 19 Jul 2012, at 23:33, Jeff King wrote:

> When a ref is deleted, we completely delete its reflog on
> the spot, leaving very little help for the user to reverse
> the action. One can sometimes reconstruct the missing
> entries based on the HEAD reflog, but not always; the
> deleted entries may not have ever been on HEAD (for example,
> in the case of a refs/remotes branch that was pruned). That
> leaves "git fsck --lost-found", which can be quite tedious.
> 
> Instead, let's keep the reflogs for deleted refs around
> until their entries naturally expire according to the
> regular reflog expiration rules.
> 
> This cannot be done by simply leaving the reflog files in
> place. The ref namespace does not allow D/F conflicts, so a
> ref "foo" would block the creation of another ref "foo/bar",
> and vice versa. This limitation is acceptable for two refs
> to exist simultaneously, but should not have an impact if
> one of the refs is deleted.
> 
> This patch moves reflog entries into a special "graveyard"
> namespace, and appends a tilde (~) character, which is
> not allowed in a valid ref name. This means that the deleted
> reflogs of these refs:
> 
>   refs/heads/a
>   refs/heads/a/b
>   refs/heads/a/b/c
> 
> will be stored in:
> 
>   logs/graveyard/refs/heads/a~
>   logs/graveyard/refs/heads/a/b~
>   logs/graveyard/refs/heads/a/b/c~
> 
> Putting them in the graveyard namespace ensures they will
> not conflict with live refs, and the tilde prevents D/F
> conflicts within the graveyard namespace.
> 
> The implementation is fairly straightforward, but it's worth
> noting a few things:
> 
>  1. Updates to "logs/graveyard/refs/heads/foo~" happen
>     under the ref-lock for "refs/heads/foo". So deletion
>     still takes a single lock, and anyone touching the
>     reflog directly needs to reverse the transformation to
>     find the correct lockfile.
> 
>  2. We append entries to the graveyard reflog rather than
>     simply renaming the file into place. This means that
>     if you create and delete a branch repeatedly, the
>     graveyard will contain the concatenation of all
>     iterations.
> 
>  3. We do not resurrect dead entries when a new ref is
>     created with the same name. However, it would be
>     possible to build an "undelete" feature on top of this
>     if one was so inclined.
> 
>  4. The for_each_reflog code has been loosened to allow
>     reflogs that do not have a matching ref. In this case,
>     the callback is passed the null_sha1, and callers must
>     be prepared to handle this case (the only caller that
>     cares is the reflog expiration code, which is updated
>     here).
> 
> Only one test needed to be updated; t7701 tries to create
> unreachable objects by deleting branches. Of course that no
> longer works, which is the intent of this patch. The test
> now works around it by removing the graveyard logs.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> builtin/reflog.c                     |  9 +++--
> refs.c                               | 69 +++++++++++++++++++++++++++++++++---
> refs.h                               |  3 ++
> t/t7701-repack-unpack-unreachable.sh |  5 ++-
> 4 files changed, 79 insertions(+), 7 deletions(-)
> 
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index b3c9e27..e79a2ca 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -359,6 +359,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
> 	struct commit *tip_commit;
> 	struct commit_list *tips;
> 	int status = 0;
> +	int updateref = cmd->updateref && !is_null_sha1(sha1);
> 
> 	memset(&cb, 0, sizeof(cb));
> 
> @@ -367,6 +368,10 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
> 	 * getting updated.
> 	 */
> 	lock = lock_any_ref_for_update(ref, sha1, 0);
> +	if (!lock && is_null_sha1(sha1))
> +		lock = lock_any_ref_for_update(
> +				graveyard_reflog_to_refname(ref),
> +				sha1, 0);
> 	if (!lock)
> 		return error("cannot lock ref '%s'", ref);
> 	log_file = git_pathdup("logs/%s", ref);
> @@ -426,7 +431,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
> 			status |= error("%s: %s", strerror(errno),
> 					newlog_path);
> 			unlink(newlog_path);
> -		} else if (cmd->updateref &&
> +		} else if (updateref &&
> 			(write_in_full(lock->lock_fd,
> 				sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
> 			 write_str_in_full(lock->lock_fd, "\n") != 1 ||
> @@ -438,7 +443,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
> 			status |= error("cannot rename %s to %s",
> 					newlog_path, log_file);
> 			unlink(newlog_path);
> -		} else if (cmd->updateref && commit_ref(lock)) {
> +		} else if (updateref && commit_ref(lock)) {
> 			status |= error("Couldn't set %s", lock->ref_name);
> 		} else {
> 			adjust_shared_perm(log_file);
> diff --git a/refs.c b/refs.c
> index da74a2b..553de77 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -4,6 +4,8 @@
> #include "tag.h"
> #include "dir.h"
> 
> +static void mark_reflog_deleted(struct ref_lock *lock);
> +
> /*
>  * Make sure "ref" is something reasonable to have under ".git/refs/";
>  * We do not like it if:
> @@ -1780,7 +1782,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
> 	 */
> 	ret |= repack_without_ref(refname);
> 
> -	unlink_or_warn(git_path("logs/%s", lock->ref_name));
> +	mark_reflog_deleted(lock);
> 	invalidate_ref_cache(NULL);
> 	unlock_ref(lock);
> 	return ret;
> @@ -2385,9 +2387,8 @@ static int do_for_each_reflog(struct strbuf *name, each_ref_fn fn, void *cb_data
> 			} else {
> 				unsigned char sha1[20];
> 				if (read_ref_full(name->buf, sha1, 0, NULL))
> -					retval = error("bad ref for %s", name->buf);
> -				else
> -					retval = fn(name->buf, sha1, 0, cb_data);
> +					hashcpy(sha1, null_sha1);
> +				retval = fn(name->buf, sha1, 0, cb_data);
> 			}
> 			if (retval)
> 				break;
> @@ -2552,3 +2553,63 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
> 	free(short_name);
> 	return xstrdup(refname);
> }
> +
> +char *refname_to_graveyard_reflog(const char *ref)
> +{
> +	return git_path("logs/graveyard/%s~", ref);
> +}
> +
> +char *graveyard_reflog_to_refname(const char *log)
> +{
> +	static struct strbuf buf = STRBUF_INIT;
> +
> +	if (!prefixcmp(log, "graveyard/"))
> +		log += 10;
> +
> +	strbuf_reset(&buf);
> +	strbuf_addstr(&buf, log);
> +	if (buf.len > 0 && buf.buf[buf.len-1] == '~')
> +		strbuf_setlen(&buf, buf.len - 1);
> +
> +	return buf.buf;
> +}
> +
> +static int copy_reflog_entries(const char *dst, const char *src)
> +{
> +	int fdi, fdo, status;
> +
> +	fdi = open(src, O_RDONLY);
> +	if (fdi < 0)
> +		return errno == ENOENT ? 0 : -1;
> +
> +	fdo = open(dst, O_WRONLY | O_APPEND | O_CREAT, 0666);
> +	if (fdo < 0) {
> +		close(fdi);
> +		return -1;
> +	}
> +
> +	status = copy_fd(fdi, fdo);
> +	if (close(fdo) < 0)
> +		return -1;
> +	if (status < 0 || adjust_shared_perm(dst) < 0)
> +		return -1;
> +	return 0;
> +}
> +
> +static void mark_reflog_deleted(struct ref_lock *lock)
> +{
> +	static const char msg[] = "ref deleted";
> +	const char *log = git_path("logs/%s", lock->ref_name);
> +	char *grave = refname_to_graveyard_reflog(lock->ref_name);
> +
> +	if (log_ref_write(lock->ref_name, lock->old_sha1, null_sha1, msg) < 0)
> +		warning("unable to update reflog for %s: %s",
> +			lock->ref_name, strerror(errno));
> +
> +	if (safe_create_leading_directories(grave) < 0 ||
> +	    copy_reflog_entries(grave, log) < 0)
> +		warning("unable to copy reflog entries to graveyard: %s",
> +			strerror(errno));
> +
> +	unlink_or_warn(log);
> +}
> diff --git a/refs.h b/refs.h
> index d6c2fe2..9d14558 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -111,6 +111,9 @@ int for_each_recent_reflog_ent(const char *refname, each_reflog_ent_fn fn, long,
>  */
> extern int for_each_reflog(each_ref_fn, void *);
> 
> +char *refname_to_graveyard_reflog(const char *ref);
> +char *graveyard_reflog_to_refname(const char *log);
> +
> #define REFNAME_ALLOW_ONELEVEL 1
> #define REFNAME_REFSPEC_PATTERN 2
> #define REFNAME_DOT_COMPONENT 4
> diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
> index b8d4cde..c06b715 100755
> --- a/t/t7701-repack-unpack-unreachable.sh
> +++ b/t/t7701-repack-unpack-unreachable.sh
> @@ -38,7 +38,9 @@ test_expect_success '-A with -d option leaves unreachable objects unpacked' '
> 	git show $csha1 &&
> 	git show $tsha1 &&
> 	# now expire the reflog, while keeping reachable ones but expiring
> -	# unreachables immediately
> +	# unreachables immediately; also remove any graveyard reflogs
> +	# from deleted branches that would keep things reachable
> +	rm -rf .git/logs/graveyard &&
> 	test_tick &&
> 	sometimeago=$(( $test_tick - 10000 )) &&
> 	git reflog expire --expire=$sometimeago --expire-unreachable=$test_tick --all &&
> @@ -76,6 +78,7 @@ test_expect_success '-A without -d option leaves unreachable objects packed' '
> 	test 1 = $(ls -1 .git/objects/pack/pack-*.pack | wc -l) &&
> 	packfile=$(ls .git/objects/pack/pack-*.pack) &&
> 	git branch -D transient_branch &&
> +	rm -rf .git/logs/graveyard &&
> 	test_tick &&
> 	git repack -A -l &&
> 	test ! -f "$fsha1path" &&
> -- 
> 1.7.10.5.40.g059818d
> 

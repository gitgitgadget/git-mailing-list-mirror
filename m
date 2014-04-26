From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 19/19] refs.c: pass **transaction to commit and have
 it clear the pointer
Date: Sat, 26 Apr 2014 03:31:27 +0200
Message-ID: <535B0C6F.509@alum.mit.edu>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com> <1398442494-23438-20-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 26 03:31:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdrSq-0002O3-Tk
	for gcvg-git-2@plane.gmane.org; Sat, 26 Apr 2014 03:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbaDZBbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2014 21:31:32 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:61756 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751125AbaDZBbb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Apr 2014 21:31:31 -0400
X-AuditID: 1207440c-f79656d000003eba-2a-535b0c72b037
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 11.D2.16058.27C0B535; Fri, 25 Apr 2014 21:31:30 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB3D11.dip0.t-ipconnect.de [93.219.61.17])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3Q1VS5Z016682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 25 Apr 2014 21:31:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1398442494-23438-20-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1C3iiQ42OLyG26LrSjeTxb8JNQ5M
	Hgs2lXp83iQXwBTFbZOUWFIWnJmep2+XwJ1xY/MG9oIu14odv+ewNTA+Mu1i5OSQEDCRON//
	ggXCFpO4cG89WxcjF4eQwGVGiUe9vVDOOSaJeftPM4JU8QqoS3y4/JsZxGYRUJX4vncOG4jN
	JqArsainmamLkYNDVCBI4s9ZRYhyQYmTM5+ALRARsJNYf2shM0iJsECSxPHjSSCmkECNxNad
	2iAVnAKuEv+vvQMbIiEgLtHTGAQSZhbQkXjX94AZwpaX2P52DvMERoFZSObPQlI2C0nZAkbm
	VYxyiTmlubq5iZk5xanJusXJiXl5qUW6hnq5mSV6qSmlmxgh4cmzg/HbOplDjAIcjEo8vDtz
	ooKFWBPLiitzDzFKcjApifKa/wQK8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuE9+gAox5uSWFmV
	WpQPk5LmYFES51Vdou4nJJCeWJKanZpakFoEk5Xh4FCS4OXhjg4WEixKTU+tSMvMKUFIM3Fw
	ggznkhIpTs1LSS1KLC3JiAfFaHwxMEpBUjxAe01A2nmLCxJzgaIQracYdTkuNKxoYRJiycvP
	S5US5+3iAioSACnKKM2DWwFLRq8YxYE+FuY1AxnFA0xkcJNeAS1hAlpSMCEcZElJIkJKqoGx
	m22B5ewj82oc3ZcJTGc5vVZTd6+4zSG18mRZ9QM9/b7yW2L2nHzTeL3rY5RDeBDDO4v5Ar9D
	VGZt79SfqPP2x9z16XqXJIvfJX88xKEt270g+lDBtoWP++dF8AWeEkj53fY549Sc 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247138>

On 04/25/2014 06:14 PM, Ronnie Sahlberg wrote:
> Change ref_transaction_commit to take a pointer to a pointer for the
> transaction. This allows us to clear the transaction pointer from within
> ref_transaction_commit so that it becomes NULL in the caller.
> 
> This makes transaction handling in the callers much nicer since instead of
> having to write horrible code like :
> 	t = ref_transaction_begin();
> 	if ((!t ||
> 	    ref_transaction_update(t, refname, sha1, oldval, flags,
> 				   !!oldval)) ||
> 	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
> 		ref_transaction_rollback(t);
> 
> we can now just do the much nicer
> 	t = ref_transaction_begin();
> 	if (!t ||
> 	    ref_transaction_update(t, refname, sha1, oldval, flags,
> 				   !!oldval) ||
> 	    ref_transaction_commit(&t, action, &err)) {
> 		ref_transaction_rollback(t);

I understand the motivation for this change, but passing
pointer-to-pointer is unconventional in a case like this.  Unfortunately
I ran out of steam for the night before I could think about alternatives.

Regarding patches 01-18, I agree with Jonathan's comments and made a few
of my own.  I definitely don't think that code like "!(t = NULL)" should
stay in our code base as more than a transitional state.  But I'd have
to play with the alternatives before I can form an opinion on your
suggestion in this patch.

Thanks for working on this!

Michael

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  branch.c             |  4 ++--
>  builtin/commit.c     |  2 +-
>  builtin/replace.c    |  2 +-
>  builtin/tag.c        |  2 +-
>  builtin/update-ref.c |  2 +-
>  fast-import.c        |  7 +++----
>  refs.c               | 18 ++++++++++--------
>  refs.h               |  3 ++-
>  sequencer.c          |  7 +++----
>  9 files changed, 24 insertions(+), 23 deletions(-)
> 
> diff --git a/branch.c b/branch.c
> index 23cde1e..5d68467 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -303,14 +303,14 @@ void create_branch(const char *head,
>  			if (!transaction ||
>  			    ref_transaction_update(transaction, ref.buf, sha1,
>  						   NULL, 0, 0) ||
> -			    ref_transaction_commit(transaction, msg, &err))
> +			    ref_transaction_commit(&transaction, msg, &err))
>  			  die_errno(_("%s: failed to write ref: %s"),
>  				    ref.buf, err);
>  		} else {
>  			if (!transaction ||
>  			    ref_transaction_create(transaction, ref.buf, sha1,
>  						   0) ||
> -			    ref_transaction_commit(transaction, msg, &err))
> +			    ref_transaction_commit(&transaction, msg, &err))
>  			  die_errno(_("%s: failed to write ref: %s"),
>  				    ref.buf, err);
>  		}
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 7e4c306..3142827 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1682,7 +1682,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>  				   current_head ? 
>  				   current_head->object.sha1 : NULL,
>  				   0, !!current_head) ||
> -	    ref_transaction_commit(transaction, sb.buf, &err)) {
> +	    ref_transaction_commit(&transaction, sb.buf, &err)) {
>  		rollback_index_files();
>  		die(_("HEAD: cannot update ref: %s"), err);
>  	}
> diff --git a/builtin/replace.c b/builtin/replace.c
> index cf0f56d..51e9ddf 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -162,7 +162,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>  	if (!transaction ||
>  	    ref_transaction_update(transaction, ref, repl, prev,
>  				   0, !is_null_sha1(prev)) ||
> -	    ref_transaction_commit(transaction, NULL, &err))
> +	    ref_transaction_commit(&transaction, NULL, &err))
>  	  die(_("%s: failed to replace ref: %s"), ref, err);
>  
>  	return 0;
> diff --git a/builtin/tag.c b/builtin/tag.c
> index dd53fb4..60b57a1 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -646,7 +646,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	if (!transaction ||
>  	    ref_transaction_update(transaction, ref.buf, object, prev,
>  				   0, !is_null_sha1(prev)) ||
> -	    ref_transaction_commit(transaction, NULL, &err))
> +	    ref_transaction_commit(&transaction, NULL, &err))
>  	  die(_("%s: cannot update the ref: %s"), ref.buf, err);
>  	if (force && !is_null_sha1(prev) && hashcmp(prev, object))
>  		printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index a600ab3..4a0901d 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -373,7 +373,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
>  		if (end_null)
>  			line_termination = '\0';
>  		update_refs_stdin();
> -		if (ref_transaction_commit(transaction, msg, &err))
> +		if (ref_transaction_commit(&transaction, msg, &err))
>  			die("update_ref failed: %s", err);
>  		return 0;
>  	}
> diff --git a/fast-import.c b/fast-import.c
> index a2b05fa..3ce2f47 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1703,11 +1703,10 @@ static int update_branch(struct branch *b)
>  		}
>  	}
>  	transaction = ref_transaction_begin();
> -	if ((!transaction ||
> +	if (!transaction ||
>  	    ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
> -				   0, 1)) ||
> -	    (ref_transaction_commit(transaction, msg, &err) &&
> -	     !(transaction = NULL))) {
> +				   0, 1) ||
> +	    ref_transaction_commit(&transaction, msg, &err)) {
>  		ref_transaction_rollback(transaction);
>  		return error("Unable to update branch %s: %s", b->name, err);
>  	}
> diff --git a/refs.c b/refs.c
> index ffa9c83..0b60250 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3401,10 +3401,10 @@ int update_ref(const char *action, const char *refname,
>  	char *err = NULL;
>  
>  	t = ref_transaction_begin();
> -	if ((!t ||
> +	if (!t ||
>  	    ref_transaction_update(t, refname, sha1, oldval, flags,
> -				   !!oldval)) ||
> -	    (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
> +				   !!oldval) ||
> +	    ref_transaction_commit(&t, action, &err)) {
>  	     const char *str = "update_ref failed for ref '%s': %s";
>  
>  		ref_transaction_rollback(t);
> @@ -3444,16 +3444,17 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
>  	return 0;
>  }
>  
> -int ref_transaction_commit(struct ref_transaction *transaction,
> +int ref_transaction_commit(struct ref_transaction **transaction,
>  			   const char *msg, char **err)
>  {
>  	int ret = 0, delnum = 0, i;
>  	const char **delnames;
> -	int n = transaction->nr;
> -	struct ref_update **updates = transaction->updates;
> +	int n = (*transaction)->nr;
> +	struct ref_update **updates = (*transaction)->updates;
>  
>  	if (!n) {
> -		ref_transaction_free(transaction);
> +		ref_transaction_free(*transaction);
> +		*transaction = NULL;
>  		return 0;
>  	}
>  
> @@ -3527,7 +3528,8 @@ cleanup:
>  		if (updates[i]->lock)
>  			unlock_ref(updates[i]->lock);
>  	free(delnames);
> -	ref_transaction_free(transaction);
> +	ref_transaction_free(*transaction);
> +	*transaction = NULL;
>  	return ret;
>  }
>  
> diff --git a/refs.h b/refs.h
> index 8135131..85127f2 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -270,8 +270,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
>   * problem.  The ref_transaction is freed by this function.
>   * If error is non-NULL it will return an error string that describes
>   * why a commit failed. This string must be free()ed by the caller.
> + * *transaction is reset to NULL in this call.
>   */
> -int ref_transaction_commit(struct ref_transaction *transaction,
> +int ref_transaction_commit(struct ref_transaction **transaction,
>  			   const char *msg, char **err);
>  
>  /** Lock a ref and then write its file */
> diff --git a/sequencer.c b/sequencer.c
> index 7d59f58..3f6eced 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -283,11 +283,10 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
>  	strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
>  
>  	transaction = ref_transaction_begin();
> -	if ((!transaction ||
> +	if (!transaction ||
>  	    ref_transaction_update(transaction, "HEAD", to, from,
> -				   0, !unborn)) ||
> -	    (ref_transaction_commit(transaction, sb.buf, &err) &&
> -	     !(transaction = NULL))) {
> +				   0, !unborn) ||
> +	    ref_transaction_commit(&transaction, sb.buf, &err)) {
>  		ref_transaction_rollback(transaction);
>  		strbuf_release(&sb);
>  		return error(_("HEAD: Could not fast-forward: %s\n"), err);
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] rebase: use update_ref
Date: Tue, 28 Jul 2015 11:18:17 -0700
Message-ID: <xmqq4mkof8nq.fsf@gitster.dls.corp.google.com>
References: <1438027720-23074-1-git-send-email-dturner@twopensource.com>
	<1438027720-23074-5-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, sunshine@sunshineco.com,
	philipoakley@iee.org
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 20:18:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK9SV-0000QJ-Go
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 20:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753453AbbG1SSV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 14:18:21 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33247 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbbG1SST (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 14:18:19 -0400
Received: by padck2 with SMTP id ck2so73619481pad.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 11:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Ik4Ycn2UmPt/uZCIQVv3b5llagC2IWXSo6bCYSX/T4w=;
        b=VSHwJSfGrXqJf+XLxs/ZjamlIxwfxP9sMQ5g7d2nSpKE5OL/Qo7j8Oty8oO7kbJnTH
         5VlKQYbpsbqhiKLTRM/ic54TLQGsQuzyo8/x0eWOAuNFt1VVW9RfJW6cpxUunDyDNgqv
         Xi2iCZ1nfuQts5YfePg8gy9kq2P/kI6ALi0BMyxHm4qQzVk7RyrBxwAGprIqgGqvoEeF
         BsK24CHs7CC3rVdlqH1SJdyGde7/b7RbISzc1uJRCAgE6DHapIr6H8xE5UBLCyBUTNsr
         IK6dA2juwu3fzEHiyCQIWKSIF142Pa76i73k5+N68Hv1NbohtKLsLRPjW5u0WwsBiJuR
         IntQ==
X-Received: by 10.66.185.199 with SMTP id fe7mr84809817pac.48.1438107499106;
        Tue, 28 Jul 2015 11:18:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id to5sm36619020pac.33.2015.07.28.11.18.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 11:18:18 -0700 (PDT)
In-Reply-To: <1438027720-23074-5-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Mon, 27 Jul 2015 16:08:39 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274810>

David Turner <dturner@twopensource.com> writes:

> Instead of manually writing a pseudoref (in one case) and shelling out
> to git update-ref (in another), use the update_ref function.  This
> is much simpler.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  bisect.c | 37 ++++++++-----------------------------
>  1 file changed, 8 insertions(+), 29 deletions(-)

Mistitled?  I can do s/rebase/bisect/ at my end if that is all
needed.

>
> diff --git a/bisect.c b/bisect.c
> index 857cf59..33ac88d 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -19,7 +19,6 @@ static struct object_id *current_bad_oid;
>  
>  static const char *argv_checkout[] = {"checkout", "-q", NULL, "--", NULL};
>  static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
> -static const char *argv_update_ref[] = {"update-ref", "--no-deref", "BISECT_HEAD", NULL, NULL};
>  
>  static const char *term_bad;
>  static const char *term_good;
> @@ -675,34 +674,16 @@ static int is_expected_rev(const struct object_id *oid)
>  	return res;
>  }
>  
> -static void mark_expected_rev(char *bisect_rev_hex)
> -{
> -	int len = strlen(bisect_rev_hex);
> -	const char *filename = git_path("BISECT_EXPECTED_REV");
> -	int fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
> -
> -	if (fd < 0)
> -		die_errno("could not create file '%s'", filename);
> -
> -	bisect_rev_hex[len] = '\n';
> -	write_or_die(fd, bisect_rev_hex, len + 1);
> -	bisect_rev_hex[len] = '\0';
> -
> -	if (close(fd) < 0)
> -		die("closing file %s: %s", filename, strerror(errno));
> -}
> -
> -static int bisect_checkout(char *bisect_rev_hex, int no_checkout)
> +static int bisect_checkout(const unsigned char *bisect_rev, int no_checkout)
>  {
> +	char bisect_rev_hex[GIT_SHA1_HEXSZ + 1];
>  
> -	mark_expected_rev(bisect_rev_hex);
> +	memcpy(bisect_rev_hex, sha1_to_hex(bisect_rev), GIT_SHA1_HEXSZ + 1);
> +	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
>  
>  	argv_checkout[2] = bisect_rev_hex;
>  	if (no_checkout) {
> -		argv_update_ref[3] = bisect_rev_hex;
> -		if (run_command_v_opt(argv_update_ref, RUN_GIT_CMD))
> -			die("update-ref --no-deref HEAD failed on %s",
> -			    bisect_rev_hex);
> +		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0, UPDATE_REFS_DIE_ON_ERR);
>  	} else {
>  		int res;
>  		res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
> @@ -804,7 +785,7 @@ static void check_merge_bases(int no_checkout)
>  			handle_skipped_merge_base(mb);
>  		} else {
>  			printf("Bisecting: a merge base must be tested\n");
> -			exit(bisect_checkout(sha1_to_hex(mb), no_checkout));
> +			exit(bisect_checkout(mb, no_checkout));
>  		}
>  	}
>  
> @@ -948,7 +929,6 @@ int bisect_next_all(const char *prefix, int no_checkout)
>  	struct commit_list *tried;
>  	int reaches = 0, all = 0, nr, steps;
>  	const unsigned char *bisect_rev;
> -	char bisect_rev_hex[GIT_SHA1_HEXSZ + 1];
>  
>  	read_bisect_terms(&term_bad, &term_good);
>  	if (read_bisect_refs())
> @@ -986,11 +966,10 @@ int bisect_next_all(const char *prefix, int no_checkout)
>  	}
>  
>  	bisect_rev = revs.commits->item->object.sha1;
> -	memcpy(bisect_rev_hex, sha1_to_hex(bisect_rev), GIT_SHA1_HEXSZ + 1);
>  
>  	if (!hashcmp(bisect_rev, current_bad_oid->hash)) {
>  		exit_if_skipped_commits(tried, current_bad_oid);
> -		printf("%s is the first %s commit\n", bisect_rev_hex,
> +		printf("%s is the first %s commit\n", sha1_to_hex(bisect_rev),
>  			term_bad);
>  		show_diff_tree(prefix, revs.commits->item);
>  		/* This means the bisection process succeeded. */
> @@ -1003,7 +982,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
>  	       "(roughly %d step%s)\n", nr, (nr == 1 ? "" : "s"),
>  	       steps, (steps == 1 ? "" : "s"));
>  
> -	return bisect_checkout(bisect_rev_hex, no_checkout);
> +	return bisect_checkout(bisect_rev, no_checkout);
>  }
>  
>  static inline int log2i(int n)

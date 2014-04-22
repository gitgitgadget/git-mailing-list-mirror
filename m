From: Ilya Bobyr <ilya.bobyr@gmail.com>
Subject: Re: [RTC/PATCH] Add 'update-branch' hook
Date: Mon, 21 Apr 2014 23:35:18 -0700
Message-ID: <53560DA6.5040202@gmail.com>
References: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 08:35:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcUJA-00017z-BX
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 08:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863AbaDVGfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2014 02:35:48 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:59999 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbaDVGf1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2014 02:35:27 -0400
Received: by mail-pb0-f41.google.com with SMTP id jt11so4575856pbb.14
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 23:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=TWpT/InpysLqBVYY9BhPxw/khh14feuXHKWfyH0PVZU=;
        b=Zjzl1LwR4Brm1rL3b2PEwnfg4be7wPWObpQ7PGAvBqGSmC7HC2d9qBWUQ82dviI5Qn
         tzlP85YcbdIva2YQCv35oKImQ85yr6puy1QQ6e+N4TNuw49DlmZ5UKODQ3y5z7+fzznB
         ysXe4r4o1vNv/HmhADA84sTZpu3A9gE4sSn7sVTxuRSYt6f0xTmC74U0YEaMWjTTWTuP
         gowyV2lifA/LoynTBW3wOiSJTy+36GJ2fdijXiMGhO/g2ejLyxACQiApZ39fnHflo/pR
         mQfgm3qZ4Be2tMmsg3r0FQXZGdt7iwPbwtwbwbPODvsy1JsEFpudmjDUaiursydlHVKC
         MfHg==
X-Received: by 10.68.170.66 with SMTP id ak2mr42568502pbc.5.1398148526185;
        Mon, 21 Apr 2014 23:35:26 -0700 (PDT)
Received: from [192.168.1.2] (c-50-136-172-14.hsd1.ca.comcast.net. [50.136.172.14])
        by mx.google.com with ESMTPSA id hy3sm82446553pbc.31.2014.04.21.23.35.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 23:35:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:28.0) Gecko/20100101 Thunderbird/28.0
In-Reply-To: <1398047016-21643-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246700>

On 4/20/2014 7:23 PM, Felipe Contreras wrote:
> [...]
>
> diff --git a/branch.c b/branch.c
> index 660097b..c2058d1 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -4,6 +4,7 @@
>  #include "refs.h"
>  #include "remote.h"
>  #include "commit.h"
> +#include "run-command.h"
>  
>  struct tracking {
>  	struct refspec spec;
> @@ -304,6 +305,11 @@ void create_branch(const char *head,
>  	if (real_ref && track)
>  		setup_tracking(ref.buf + 11, real_ref, track, quiet);
>  
> +	if (run_hook_le(NULL, "update-branch", ref.buf + 11, sha1_to_hex(sha1), NULL)) {
> +		unlock_ref(lock);

lock is NULL if dont_change_ref is true.  unlock_ref() would crash in
that case.
You may want to add a test for that.

> +		die("hook 'update-branch' returned error");
> +	}
> +
>  	if (!dont_change_ref)
>  		if (write_ref_sha1(lock, sha1, msg) < 0)
>  			die_errno(_("Failed to write ref"));
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 9b3c04d..6ec96e5 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -581,9 +581,10 @@ static void update_remote_refs(const struct ref *refs,
>  	}
>  }
>  
> -static void update_head(const struct ref *our, const struct ref *remote,
> +static int update_head(const struct ref *our, const struct ref *remote,
>  			const char *msg)
>  {
> +	int err = 0;
>  	if (our && starts_with(our->name, "refs/heads/")) {
>  		/* Local default branch link */
>  		create_symref("HEAD", our->name, NULL);
> @@ -591,6 +592,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
>  			const char *head = skip_prefix(our->name, "refs/heads/");
>  			update_ref(msg, "HEAD", our->old_sha1, NULL, 0, DIE_ON_ERR);
>  			install_branch_config(0, head, option_origin, our->name);
> +			err = run_hook_le(NULL, "update-branch", head, sha1_to_hex(our->old_sha1), NULL);

This is happening after the branch is updated and a config section for
it is created.

>  		}
>  	} else if (our) {
>  		struct commit *c = lookup_commit_reference(our->old_sha1);
> @@ -606,6 +608,7 @@ static void update_head(const struct ref *our, const struct ref *remote,
>  		update_ref(msg, "HEAD", remote->old_sha1,
>  			   NULL, REF_NODEREF, DIE_ON_ERR);
>  	}
> +	return err;
>  }
>  
>  static int checkout(void)
> @@ -987,7 +990,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	update_remote_refs(refs, mapped_refs, remote_head_points_at,
>  			   branch_top.buf, reflog_msg.buf, transport, !is_local);
>  
> -	update_head(our_head_points_at, remote_head, reflog_msg.buf);
> +	err = update_head(our_head_points_at, remote_head, reflog_msg.buf);
>  
>  	transport_unlock_pack(transport);
>  	transport_disconnect(transport);
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 1c41cbd..084dc36 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -631,7 +631,11 @@ do_next () {
>  		git update-ref -m "$message" $head_name $newhead $orig_head &&
>  		git symbolic-ref \
>  		  -m "$GIT_REFLOG_ACTION: returning to $head_name" \
> -		  HEAD $head_name
> +		  HEAD $head_name &&
> +		if test -x "$GIT_DIR"/hooks/update-branch; then
> +			"$GIT_DIR"/hooks/update-branch $branch_name \
> +				$newhead $onto
> +		fi

It looks like this is also after the branch was already updated.

>  		;;
>  	esac && {
>  		test ! -f "$state_dir"/verbose ||
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 2c75e9f..ededa32 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -149,7 +149,11 @@ move_to_original_branch () {
>  			$head_name $(git rev-parse HEAD) $orig_head &&
>  		git symbolic-ref \
>  			-m "rebase finished: returning to $head_name" \
> -			HEAD $head_name ||
> +			HEAD $head_name &&
> +		if test -x "$GIT_DIR"/hooks/update-branch; then
> +			"$GIT_DIR"/hooks/update-branch $branch_name \
> +				$(git rev-parse HEAD) $onto
> +		fi ||

Same here.

>  		die "$(gettext "Could not move back to $head_name")"
>  		;;
>  	esac
> diff --git a/t/t5408-update-branch-hook.sh b/t/t5408-update-branch-hook.sh
> new file mode 100755
> index 0000000..d921c0e
> --- /dev/null
> +++ b/t/t5408-update-branch-hook.sh
> @@ -0,0 +1,39 @@
> +#!/bin/sh
> +
> +test_description='Test the update-branch hook'
> +
> +. ./test-lib.sh
> +
> +setup () {
> +	mkdir -p .git/hooks &&
> +	cat > .git/hooks/update-branch <<-'EOF' &&
> +	#!/bin/sh
> +	echo $@ > .git/update-branch.args
> +	EOF
> +	chmod +x .git/hooks/update-branch &&
> +	echo one > content &&
> +	git add content &&
> +	git commit -a -m one
> +}
> +
> +setup
> +
> +test_expect_success 'creating a branch' '
> +	git checkout -b test master &&
> +	echo two > new &&
> +	git add new &&
> +	git commit -a -m two
> +	echo "test $(git rev-parse master)" > expected &&
> +	test_cmp expected .git/update-branch.args
> +'
> +
> +test_expect_success 'doing a rebase' '
> +	git checkout -b next master &&
> +	echo three > content &&
> +	git commit -a -m three &&
> +	git rebase --onto next master test &&
> +	echo "test $(git rev-parse HEAD) $(git rev-parse next)" > expected &&
> +	test_cmp expected .git/update-branch.args
> +'
> +
> +test_done

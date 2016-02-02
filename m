From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 02/15] branch: die on error in setting up tracking branch
Date: Tue, 02 Feb 2016 12:49:26 -0800
Message-ID: <xmqq60y6suqx.fsf@gitster.mtv.corp.google.com>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
	<1454413916-31984-3-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Tue Feb 02 21:49:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQhtG-0003jS-0x
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 21:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934252AbcBBUta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 15:49:30 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60335 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932934AbcBBUt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 15:49:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 513304071E;
	Tue,  2 Feb 2016 15:49:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UJVIW0/5xO7kTlCOrIDu2syGV4A=; b=ie9e01
	ssch6XgL/WjDamw0y1dHRJj63ok/LN04lpkYBKf+OBr2bsVqJi7rI+TDpiyeJ4aj
	baSszekE+ohQrRKW1YS9yEmiofZWSwn2zOIMFFIINXNUw6ojHIIuzrt4Zk03CZ+d
	gWtx7+I9qgXsm0IBDuEqUakL/da6rf9lxgJZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NjZEKYjiV+NEcw4OgGls1UfgQgWph/3I
	kCn8bNet5XsBUhx8YwGXKhRyR2Se86m5lWv6Z62XO9rVvfza6V4zxqfRR5YcRSfg
	L7ZzRI6KVaeLK6c3sYJV9B4880dDymjflxerefcJPczoKaq/+SnyWNSAvGfazQks
	WNWazV753i4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 484A94071D;
	Tue,  2 Feb 2016 15:49:28 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8D00F4071A;
	Tue,  2 Feb 2016 15:49:27 -0500 (EST)
In-Reply-To: <1454413916-31984-3-git-send-email-ps@pks.im> (Patrick
	Steinhardt's message of "Tue, 2 Feb 2016 12:51:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7325AB62-C9EE-11E5-A9EE-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285306>

Patrick Steinhardt <ps@pks.im> writes:

> The setup_tracking function calls install_branch_config, which
> may fail writing the configuration due to a locked configuration
> file or other error conditions. setup_tracking can also fail when
> trying to track ambiguous information for a reference. While this
> condition is checked for and an error code is returned, this
> error is not checked by the caller.
>
> Fix both issues by dying early when error occur.

Hmph.  I think create_branch() is written in such a way that all
die() come before the actual ref transaction attempts to create the
branch, but this change means that we have already created the
branch and then die without undoing the damage that is already done.

"The error is not checked by the caller" is very true, but can the
caller do something better than just die?  I personally do not think
it is such a big deal if we just died here, but I may have overlooked
something.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  branch.c          | 19 +++++++++----------
>  branch.h          |  1 +
>  t/t3200-branch.sh |  9 ++++++++-
>  3 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 7ff3f20..7106369 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -64,16 +64,16 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>  	}
>  
>  	strbuf_addf(&key, "branch.%s.remote", local);
> -	git_config_set(key.buf, origin ? origin : ".");
> +	git_config_set_or_die(key.buf, origin ? origin : ".");
>  
>  	strbuf_reset(&key);
>  	strbuf_addf(&key, "branch.%s.merge", local);
> -	git_config_set(key.buf, remote);
> +	git_config_set_or_die(key.buf, remote);
>  
>  	if (rebasing) {
>  		strbuf_reset(&key);
>  		strbuf_addf(&key, "branch.%s.rebase", local);
> -		git_config_set(key.buf, "true");
> +		git_config_set_or_die(key.buf, "true");
>  	}
>  	strbuf_release(&key);
>  
> @@ -109,8 +109,8 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>   * to infer the settings for branch.<new_ref>.{remote,merge} from the
>   * config.
>   */
> -static int setup_tracking(const char *new_ref, const char *orig_ref,
> -			  enum branch_track track, int quiet)
> +static void setup_tracking(const char *new_ref, const char *orig_ref,
> +			   enum branch_track track, int quiet)
>  {
>  	struct tracking tracking;
>  	int config_flags = quiet ? 0 : BRANCH_CONFIG_VERBOSE;
> @@ -118,7 +118,7 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
>  	memset(&tracking, 0, sizeof(tracking));
>  	tracking.spec.dst = (char *)orig_ref;
>  	if (for_each_remote(find_tracked_branch, &tracking))
> -		return 1;
> +		return;
>  
>  	if (!tracking.matches)
>  		switch (track) {
> @@ -127,18 +127,17 @@ static int setup_tracking(const char *new_ref, const char *orig_ref,
>  		case BRANCH_TRACK_OVERRIDE:
>  			break;
>  		default:
> -			return 1;
> +			return;
>  		}
>  
>  	if (tracking.matches > 1)
> -		return error(_("Not tracking: ambiguous information for ref %s"),
> -				orig_ref);
> +		die(_("Not tracking: ambiguous information for ref %s"),
> +		    orig_ref);
>  
>  	install_branch_config(config_flags, new_ref, tracking.remote,
>  			      tracking.src ? tracking.src : orig_ref);
>  
>  	free(tracking.src);
> -	return 0;
>  }
>  
>  int read_branch_desc(struct strbuf *buf, const char *branch_name)
> diff --git a/branch.h b/branch.h
> index 58aa45f..8ce22f8 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -43,6 +43,7 @@ void remove_branch_state(void);
>  /*
>   * Configure local branch "local" as downstream to branch "remote"
>   * from remote "origin".  Used by git branch --set-upstream.
> + * Dies if unable to install branch config.
>   */
>  #define BRANCH_CONFIG_VERBOSE 01
>  extern void install_branch_config(int flag, const char *local, const char *origin, const char *remote);
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index cdaf6f6..dd776b3 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -446,6 +446,13 @@ test_expect_success '--set-upstream-to fails on a non-ref' '
>  	test_must_fail git branch --set-upstream-to HEAD^{}
>  '
>  
> +test_expect_success '--set-upstream-to fails on locked config' '
> +	test_when_finished "rm -f .git/config.lock" &&
> +	>.git/config.lock &&
> +	git branch locked &&
> +	test_must_fail git branch --set-upstream-to locked
> +'
> +
>  test_expect_success 'use --set-upstream-to modify HEAD' '
>  	test_config branch.master.remote foo &&
>  	test_config branch.master.merge foo &&
> @@ -579,7 +586,7 @@ test_expect_success 'avoid ambiguous track' '
>  	git config remote.ambi1.fetch refs/heads/lalala:refs/heads/master &&
>  	git config remote.ambi2.url lilili &&
>  	git config remote.ambi2.fetch refs/heads/lilili:refs/heads/master &&
> -	git branch all1 master &&
> +	test_must_fail git branch all1 master &&
>  	test -z "$(git config branch.all1.merge)"
>  '

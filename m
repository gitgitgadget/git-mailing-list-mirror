Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852CB22F1E
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142381; cv=none; b=P6fwouISrdQGQ7DqMuMwBHR9LK6WnwU2Ip4wDCVu8B6LW1/PK5AjJ2AVTHFBrl9+/5UXP9ZHWQhv95kIRg9Nhog0oVhv1Vh0pM/j1jyQAdJsm4CdLCxEiMMQhpGWVG9MQqzV1lCp9J0IxrXxV1pA05ncGtqzSlDYlXLnm7Xn1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142381; c=relaxed/simple;
	bh=MgBR7evZQ5m2pjd3lnCTCFwybeGOpP78lQSXuSMkhRA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c+Zi5JZ9hObRF+seS+2VznSF4Smm4dxNj60fB/xpAPNqp/tDe7GtSh53bilZQXlDqltwlZjz9gsBwzMAOMzBJaNZAoYpiWteD0I1y9drYekixjKoO3x/j5xeTQ6rWBpscqyRCaJB39t9kqemyP88/lLt4iARB9CK6DOcyusofMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=RUjiNIJD; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RUjiNIJD"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E5E152C8ED;
	Wed, 28 Feb 2024 12:46:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MgBR7evZQ5m2pjd3lnCTCFwybeGOpP78lQSXuS
	MkhRA=; b=RUjiNIJDQJBeehH4pqGfPpXYVwpV9Y+M1zjMJJKXQJiqsyZW/5e8/v
	VtOvR38JvHGUbBW45eajT/uyKGYcrVA2Z54qjwuOpThZPdIP5Iz+jPEci4GTB/FG
	lJ715arp6Y5qI+LmUnurD471KzjmW6zcfpF4SykTRURZHYOroe15s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DE2142C8EC;
	Wed, 28 Feb 2024 12:46:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7C0262C8EB;
	Wed, 28 Feb 2024 12:46:09 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Cai
 <johncai86@gmail.com>,  Linus Arver <linusa@google.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] revision: fix --missing=[print|allow*] for annotated tags
In-Reply-To: <20240228091011.3652532-1-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 28 Feb 2024 10:10:11 +0100")
References: <20240214142513.4002639-1-christian.couder@gmail.com>
	<20240228091011.3652532-1-christian.couder@gmail.com>
Date: Wed, 28 Feb 2024 09:46:07 -0800
Message-ID: <xmqq5xy8lbxc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 41911A40-D661-11EE-ACCB-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> diff --git a/revision.c b/revision.c
> index 0c7266b1eb..8f0d638af1 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -419,15 +419,21 @@ static struct commit *handle_commit(struct rev_info *revs,
>  	 */
>  	while (object->type == OBJ_TAG) {
>  		struct tag *tag = (struct tag *) object;
> +		struct object_id *oid;
>  		if (revs->tag_objects && !(flags & UNINTERESTING))
>  			add_pending_object(revs, object, tag->tag);
> -		object = parse_object(revs->repo, get_tagged_oid(tag));
> +		oid = get_tagged_oid(tag);
> +		object = parse_object(revs->repo, oid);

This is locally a no-op but we need it because we will use oid
later, OK.

>  		if (!object) {
>  			if (revs->ignore_missing_links || (flags & UNINTERESTING))
>  				return NULL;
>  			if (revs->exclude_promisor_objects &&
>  			    is_promisor_object(&tag->tagged->oid))
>  				return NULL;
> +			if (revs->do_not_die_on_missing_objects && oid) {
> +				oidset_insert(&revs->missing_commits, oid);
> +				return NULL;
> +			}

And we recover from the "oh, that is not an object" by doing the
usual "add to missing-objects list".  OK.

At this point we do not know the type of the tagged object (the tag
itself may hint what the tagged object is, though).  We might want
to rename .missing_commits to .missing_objects later after the dust
settles.  revision.c:get_reference() already adds anything that is
pointed at by a ref to this oidset already, so it is not a new
problem with this patch, though.

> diff --git a/t/t6022-rev-list-missing.sh b/t/t6022-rev-list-missing.sh
> index 78387eebb3..127180e1c9 100755
> --- a/t/t6022-rev-list-missing.sh
> +++ b/t/t6022-rev-list-missing.sh
> @@ -10,7 +10,10 @@ TEST_PASSES_SANITIZE_LEAK=true
>  test_expect_success 'create repository and alternate directory' '
>  	test_commit 1 &&
>  	test_commit 2 &&
> -	test_commit 3
> +	test_commit 3 &&
> +	git tag -m "tag message" annot_tag HEAD~1 &&
> +	git tag regul_tag HEAD~1 &&
> +	git branch a_branch HEAD~1
>  '
>  
>  # We manually corrupt the repository, which means that the commit-graph may
> @@ -78,7 +81,7 @@ do
>  	done
>  done
>  
> -for missing_tip in "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
> +for missing_tip in "annot_tag" "regul_tag" "a_branch" "HEAD~1" "HEAD~1^{tree}" "HEAD:1.t"
>  do
>  	# We want to check that things work when both
>  	#   - all the tips passed are missing (case existing_tip = ""), and
> @@ -88,9 +91,6 @@ do
>  		for action in "allow-any" "print"
>  		do
>  			test_expect_success "--missing=$action with tip '$missing_tip' missing and tip '$existing_tip'" '
> -				oid="$(git rev-parse $missing_tip)" &&
> -				path=".git/objects/$(test_oid_to_path $oid)" &&
> -
>  				# Before the object is made missing, we use rev-list to
>  				# get the expected oids.
>  				if test "$existing_tip" = "HEAD"
> @@ -109,11 +109,23 @@ do
>  					echo $(git rev-parse HEAD:2.t) >>expect.raw
>  				fi &&
>  
> +				missing_oid="$(git rev-parse $missing_tip)" &&
> +
> +				if test "$missing_tip" = "annot_tag"
> +				then
> +					oid="$(git rev-parse $missing_tip^{commit})" &&
> +					echo "$missing_oid" >>expect.raw
> +				else
> +					oid="$missing_oid"
> +				fi &&
> +
> +				path=".git/objects/$(test_oid_to_path $oid)" &&
> +
>  				mv "$path" "$path.hidden" &&
>  				test_when_finished "mv $path.hidden $path" &&

Hmph, this might be OK for now, but recently I saw Dscho used a nice
trick to prepare a packfile that excludes certain objects in a
separate directory and use that directory as GIT_OBJECT_DIRECTORY to
simulate a situation where some objects are missing without touching
this level of implementation details.  We may want to clean things
up.

Perhaps somebody will write a shell helper function that creates
such an object directory that contains all objects in the current
repository, except for ones that are specified.  And then we add it
to t/test-lib-functions.sh, so that it can be used to update various
tests (#leftoverbits).

>  				git rev-list --missing=$action --objects --no-object-names \
> -				     $oid $existing_tip >actual.raw &&
> +				     $missing_oid $existing_tip >actual.raw &&
>  
>  				# When the action is to print, we should also add the missing
>  				# oid to the expect list.

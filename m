From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] refs.c: enable large transactions
Date: Tue, 21 Apr 2015 10:16:26 -0700
Message-ID: <xmqqegndieqd.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kY842JXB37++nwYjkX1WK9ja5m-G1aDj=QgLN-qKLo9Lg@mail.gmail.com>
	<1429576506-10790-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mhagger@alum.mit.edu, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 19:16:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ykbmk-0001vF-IN
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 19:16:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932774AbbDURQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 13:16:29 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63279 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932743AbbDURQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 13:16:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 47EE24A2DC;
	Tue, 21 Apr 2015 13:16:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k1RAuA7F4zenHselDeV1p7FtXmw=; b=bqFaCQ
	lx+gYfeLrAusu5c9izevIDSpD3yjwvjrddyVE6YXyWKNRQOyEAjJGccF2eZc8gdl
	sRymaXOE44rSNKX0bnBdbsj3StYk+PtwQdRafrllnddiEOmdlFakCVzHmKeYoTgd
	WRNKpHAtep9iCLUsftdkkrNh+bqisbMSbojRI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HWh02e956/jjKmowDrQdi1FzSCDcNP9o
	4EIVu5R1RdRbXol/j1YG8tJJUiPUo2LEiCxGhvbiblj9zVXmjp6Eq2mpvwG/viQw
	c1G9qTgo4ZonbRA31fcLSL8fIzVOsHUh7/ES5CoX6o1Yh69BGPSC7PM/ImJFb/HY
	uqULXwGZQJ4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 383274A2DB;
	Tue, 21 Apr 2015 13:16:28 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BDAA54A2DA;
	Tue, 21 Apr 2015 13:16:27 -0400 (EDT)
In-Reply-To: <1429576506-10790-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 20 Apr 2015 17:35:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 253C99BE-E84A-11E4-A890-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267535>

Stefan Beller <sbeller@google.com> writes:

> +	/*
> +	 * We may want to open many files in a large transaction, so come up with
> +	 * a reasonable maximum, keep some spares for stdin/out and other open
> +	 * files.
> +	 */
> +	int remaining_fds = get_max_fd_limit() - 32;

Can this go negative?  If it does so, does it matter?  I think the
code doesn't barf, but starting from a negative "remaining" feels
cryptic, compared to starting from a zero "remaining".

>  	struct ref_update **updates = transaction->updates;
>  	struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
>  	struct string_list_item *ref_to_delete;
> @@ -3762,6 +3770,11 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>  				    update->refname);
>  			goto cleanup;
>  		}
> +		if (remaining_fds > 0) {
> +			remaining_fds--;
> +		} else {
> +			close_lock_file(update->lock->lk);
> +		}

Any plan to add more code to these blocks in future updates?

Thanks.

> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index 7a69f1a..636d3a1 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> @@ -1071,7 +1071,7 @@ run_with_limited_open_files () {
>  
>  test_lazy_prereq ULIMIT_FILE_DESCRIPTORS 'run_with_limited_open_files true'
>  
> -test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
> +test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches does not burst open file limit' '
>  (
>  	for i in $(test_seq 33)
>  	do
> @@ -1082,7 +1082,7 @@ test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction creating branches
>  )
>  '
>  
> -test_expect_failure ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
> +test_expect_success ULIMIT_FILE_DESCRIPTORS 'large transaction deleting branches does not burst open file limit' '
>  (
>  	for i in $(test_seq 33)
>  	do

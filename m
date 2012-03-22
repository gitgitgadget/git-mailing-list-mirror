From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Strange effect merging empty file
Date: Thu, 22 Mar 2012 11:52:54 -0700
Message-ID: <7v62dwxybd.fsf@alter.siamese.dyndns.org>
References: <4F69AD3C.4070203@ericsson.com> <4F69B375.5050205@in.waw.pl>
 <86iphwomnq.fsf@red.stonehenge.com> <4F6B1F48.3040007@in.waw.pl>
 <20120322140140.GA8803@sigill.intra.peff.net>
 <7vty1gy3eh.fsf@alter.siamese.dyndns.org>
 <20120322175952.GA13069@sigill.intra.peff.net>
 <20120322182533.GA20360@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejew?= =?utf-8?Q?ski-Szmek?= 
	<zbyszek@in.waw.pl>, "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 22 19:53:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAn8B-0007mK-9C
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 19:53:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759121Ab2CVSw6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 14:52:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39998 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759075Ab2CVSw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 14:52:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B2EEF6388;
	Thu, 22 Mar 2012 14:52:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z3X6SEBSJGT1ifPiGLqFfVC/534=; b=cTg66T
	fQ10BkHhXPBnEuMP/EvE+9Vcd1697J7VjW0jAN/WJ84FAa0kXdnxv084At3LaDpp
	Q/tzkzh33ETouHvncGlk6HjtpZNqRaEwMUyEpQnqAsxEPkyxJQp19WtrZ7rWvXcP
	Jy9Zxws4t/W42NlALsFyyNt26wP/+tl1H8GoE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A00qBx2NL68UF3DVT5QFKow3DqjOL7f7
	Gg7293xI5V/aRolzquycv0sRtApxrQXfWuRmsV9IIoNCvhvi50MOfP++1AVE0Spe
	Cqp3558K1Uk5a+jLXej2acDjS2lwSJWh3FyEwxOSG1ADzjXSc9znixrqUbLJijJz
	sYGvlFfskN8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AAA486387;
	Thu, 22 Mar 2012 14:52:56 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 199026386; Thu, 22 Mar 2012
 14:52:56 -0400 (EDT)
In-Reply-To: <20120322182533.GA20360@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 22 Mar 2012 14:25:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3CA02F4C-7450-11E1-AD83-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193683>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 22, 2012 at 01:59:53PM -0400, Jeff King wrote:
>
>> > Yeah, thanks for digging up the old thread. I was looking at the patch to
>> > merge-recursive from Dscho on that thread and I think it identified the
>> > place that needs patching correctly. I was on a tablet, without the access
>> > to the surrounding code outside the patch context, so I do not know if the
>> > logic to detect the pure-rename of an empty file in the patch was correct,
>> > or the patch still applies to the current codebase, though.
>> 
>> It's easy to apply the patch manually, and I have written a test.
>> However, it seems to cause lots of other parts of t6022 to fail. I'll
>> try to dig up the cause.
>
> Found it. The diff code is very smart about doing as little work as
> possible. For a raw diff (i.e., not patch), we can often get away with
> not loading the blob at all, and therefore have no idea what the size
> is. The inexact rename code may load it, of course, but any file which
> is an exact rename will have a "0" size, also.

Thanks.

The "I do not know if the logic is correct" reservation pays off ;-)

I still wonder why checking only the preimage side is sufficient, though.
Shouldn't we check both sides?

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 6479a60..ed4ff16 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -502,7 +502,7 @@ static struct string_list *get_renames(struct merge_options *o,
>  		struct string_list_item *item;
>  		struct rename *re;
>  		struct diff_filepair *pair = diff_queued_diff.queue[i];
> -		if (pair->status != 'R') {
> +		if (pair->status != 'R' || is_empty_blob_sha1(pair->one->sha1)) {
>  			diff_free_filepair(pair);
>  			continue;
>  		}
> diff --git a/read-cache.c b/read-cache.c
> index 274e54b..dfabad0 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -157,7 +157,7 @@ static int ce_modified_check_fs(struct cache_entry *ce, struct stat *st)
>  	return 0;
>  }
>  
> -static int is_empty_blob_sha1(const unsigned char *sha1)
> +int is_empty_blob_sha1(const unsigned char *sha1)
>  {
>  	static const unsigned char empty_blob_sha1[20] = {
>  		0xe6,0x9d,0xe2,0x9b,0xb2,0xd1,0xd6,0x43,0x4b,0x8b,
> diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
> index 9d8584e..1104249 100755
> --- a/t/t6022-merge-rename.sh
> +++ b/t/t6022-merge-rename.sh
> @@ -884,4 +884,20 @@ test_expect_success 'no spurious "refusing to lose untracked" message' '
>  	! grep "refusing to lose untracked file" errors.txt
>  '
>  
> +test_expect_success 'do not follow renames for empty files' '
> +	git checkout -f -b empty-base &&
> +	>empty1 &&
> +	git add empty1 &&
> +	git commit -m base &&
> +	echo content >empty1 &&
> +	git add empty1 &&
> +	git commit -m fill &&
> +	git checkout -b empty-topic HEAD^ &&
> +	git mv empty1 empty2 &&
> +	git commit -m rename &&
> +	test_must_fail git merge empty-base &&
> +	>expect &&
> +	test_cmp expect empty2
> +'
> +
>  test_done

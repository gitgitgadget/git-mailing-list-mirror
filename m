From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] cherry-pick: don't forget -s on failure
Date: Thu, 13 Sep 2012 10:04:42 -0700
Message-ID: <7vd31pam6t.fsf@alter.siamese.dyndns.org>
References: <20120912195732.GB4722@suse.cz>
 <7vd31qc1p3.fsf@alter.siamese.dyndns.org>
 <7v8vcec13d.fsf@alter.siamese.dyndns.org> <20120913073324.GA14383@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robin Stocker <robin@nibor.org>
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Thu Sep 13 19:05:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCCqV-0004cR-1X
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 19:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758627Ab2IMREq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 13:04:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34996 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755167Ab2IMREp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 13:04:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF37D74EF;
	Thu, 13 Sep 2012 13:04:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b1fLYfDuGK6xHqJItKNZvOp0yEg=; b=yBtV6f
	wJDr6WzhF13JC3zSXotSYQ4tljsupkch6OE9xTBltIVZgE7XW/hZ7rXLwzWtTU6z
	nAekQx4nLCSoOlUsdzHJDrqfzuxsU0Wfh8HPy4/FeIMwwzEQIegIYLxHaAmJmf6C
	/gJpiXXgvFPP0frMf38SBVmwGw5J9wV5mta6c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jveaeKZPxAScLeljgrHGYnNJU7rgT43b
	0A9mfTLSkldnCf06NPZklLns/mXv97jpYqYS9WcoY9dlkAxVJO0JEogIYpk2eIHL
	snzPROw3GoGSfIdyJa/zL3e8vgIfBjayZGdvTKXwp9MmEjsenrdtqOwnVJb/MSPB
	JMwS0KLUrMY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADB1974EE;
	Thu, 13 Sep 2012 13:04:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 113D974ED; Thu, 13 Sep 2012
 13:04:43 -0400 (EDT)
In-Reply-To: <20120913073324.GA14383@suse.cz> (Miklos Vajna's message of
 "Thu, 13 Sep 2012 09:33:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1D5C0D8C-FDC5-11E1-A1AF-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205393>

Miklos Vajna <vmiklos@suse.cz> writes:

> In case 'git cherry-pick -s <commit>' failed, the user had to use 'git
> commit -s' (i.e. state the -s option again), which is easy to forget
> about.  Instead, write the signed-off-by line early, so plain 'git
> commit' will have the same result.
>
> Also update 'git commit -s', so that in case there is already a relevant
> Signed-off-by line before the Conflicts: line, it won't add one more at
> the end of the message.
>
> Signed-off-by: Miklos Vajna <vmiklos@suse.cz>
> ---
>
> On Wed, Sep 12, 2012 at 03:45:10PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
>>  - The additional S-o-b should come immediately after the existing
>>    block of footers.
>
> This was trivial to fix.

Indeed.  Just inserting before starting to add "Oh, there were
conflicts, and add the info on them" before doing it at the end is
all it takes.  Simple and straightforward---I like it.

> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -149,6 +149,12 @@ test_commit () {
>  		notick=yes
>  		shift
>  	fi &&
> +	signoff= &&
> +	if test "z$1" = "z--signoff"
> +	then
> +		signoff="$1"
> +		shift
> +	fi &&
>  	file=${2:-"$1.t"} &&
>  	echo "${3-$1}" > "$file" &&
>  	git add "$file" &&

This is somewhat iffy.  Shouldn't "test_commit --signoff --notick" work?

> @@ -156,7 +162,7 @@ test_commit () {
>  	then
>  		test_tick
>  	fi &&
> -	git commit -m "$1" &&
> +	git commit $signoff -m "$1" &&
>  	git tag "$1"
>  }

Thanks.

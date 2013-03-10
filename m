From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] mergetools/p4merge: create a base if none
 available
Date: Sat, 09 Mar 2013 20:55:55 -0800
Message-ID: <7v7glfetus.fsf@alter.siamese.dyndns.org>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
 <1362856860-15205-1-git-send-email-kevin@bracey.fi>
 <1362856860-15205-3-git-send-email-kevin@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sun Mar 10 05:56:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEYJ8-0001Bu-0I
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 05:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab3CJEz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Mar 2013 23:55:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49201 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751124Ab3CJEz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 23:55:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F812C20E;
	Sat,  9 Mar 2013 23:55:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WfsKLz3OF04Mu8iPeKIs741q3oU=; b=h2uTv4
	xQDkq0tHwk08iyyZBQSwAiDzm6RwvGJ5dpX4RHsrhxR3RXaP2lZkRiPYPjd+tiBr
	oISLRlKnmxQDVwTuPx0M7PtuHrj7NqfgQDneKYJQtlg8d1o+nQNsuxUD1biEfEk/
	Mmx/U2V8N7bCYgpZM0V6NNZCgXElZYPne5KZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pq8GwQnmeCoGw/FgtMT1hmKSfZAjI031
	r2Hjhz4rMePQqcX6XCJQaj2rmpd4HOMa5oyv6nxuw56brA+w+uV/2i77osZD4GiD
	HExbpeLYRO+A1AJ9Gg+S8XZtLvqwtU683eCXdy7BP/t79CqtOcx8jeoq9x6gzBo2
	K20xxmogofU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0381DC20D;
	Sat,  9 Mar 2013 23:55:58 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 535B1C20C; Sat,  9 Mar 2013
 23:55:57 -0500 (EST)
In-Reply-To: <1362856860-15205-3-git-send-email-kevin@bracey.fi> (Kevin
 Bracey's message of "Sat, 9 Mar 2013 21:20:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBBA7120-893E-11E2-8AC5-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217777>

Kevin Bracey <kevin@bracey.fi> writes:

> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index 795edd2..aa9a732 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -249,6 +249,19 @@ clear_local_git_env() {
>  	unset $(git rev-parse --local-env-vars)
>  }
>  
> +# Generate a virtual base file for a two-file merge. On entry the
> +# base file $1 should be a copy of $2. Uses git apply to remove
> +# lines from $1 that are not in $3, leaving only common lines.
> +create_virtual_base() {
> +	sz0=$(wc -c <"$1")
> +	@@DIFF@@ -u -La/"$1" -Lb/"$1" "$2" "$3" | git apply --no-add
> +	sz1=$(wc -c <"$1")
> +
> +	# If we do not have enough common material, it is not
> +	# worth trying two-file merge using common subsections.
> +	expr $sz0 \< $sz1 \* 2 >/dev/null || : >"$1"
> +}
> +

This rewrite is wrong.  It should be

> +	sz0=$(wc -c <"$1")
> +	@@DIFF@@ -u -La/"$1" -Lb/"$1" "$1" "$3" | git apply --no-add
> +	sz1=$(wc -c <"$1")

for it to make sense.  "diff $1 $3" is a change to go from $1 to $3;
with "-La/$1 -Lb/$1", we declare that the change is to be applied to
$1, and use --no-add to only use the removal from the diff when we
edit $1 using this mechanism.

The end effect is to in-place edit "$1" to remove what is not common
with "$3", and sz0/sz1 computation is done on "$1" for this reason.
Does it (i.e. "$1") shrink sufficiently when we remove the material
that is not common in it (i.e. "$1") and "$3"?

This part is a two-file operation between $1 and $3; there is
nothing you would want to pass $2 to influence what the above three
lines do.

It may happen that the caller has two copies of the same thing,
$orig and $src1, and uses one for $1 and the other for $2, so you
won't observe the damage from the incorrect rewriting of the above
logic, but it invites the next caller to incorrectly feed something
totally unrelated to $1 and $2.

Please fix it to a function that takes two temporary paths, not
three.

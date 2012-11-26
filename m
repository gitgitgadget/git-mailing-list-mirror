From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] push: require force for refs under refs/tags/
Date: Mon, 26 Nov 2012 10:57:06 -0800
Message-ID: <7vfw3wry4d.fsf@alter.siamese.dyndns.org>
References: <1353644515-17349-1-git-send-email-chris@rorvick.com>
 <1353644515-17349-6-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Angelo Borsotti <angelo.borsotti@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 19:57:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td3ry-0004Qx-5w
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 19:57:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab2KZS5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 13:57:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36406 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754103Ab2KZS5I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 13:57:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 693C0A72E;
	Mon, 26 Nov 2012 13:57:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ym5k230zrhsOCAZtVQJSPGB81jk=; b=Ftgj8m
	5+YdC/XcoPC8mstvdAn2UINYrJ7wLzkhI/NWqvxSvnXVlpG00fupd/CIngUtHaVi
	zDZx1+lYVaSxha1+USCbaRECy0lCjPJ8FHvxHAa2I2zf4nzN9QNCncGBpo6VxteX
	1mBWMPyuMteCItT4c6bY/v6gEEuDkJRZY60mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cgaHdThQ+HJQ4uuGLJnKEsA4axNS8lBh
	zPwb+NHUksHON8ryqUZAoBeOlOIcXxyIgNM7/eM8rwJwUE2ZM6xGFdmIB2JG9sHa
	IW8K4XRfBEH0KXHJXGJASXfZVDnZuSLxh2I4YD0C7Pxsu7Qh1+snn899fApTXwFp
	bga1Kmn5Av0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5537EA72D;
	Mon, 26 Nov 2012 13:57:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F698A72A; Mon, 26 Nov 2012
 13:57:07 -0500 (EST)
In-Reply-To: <1353644515-17349-6-git-send-email-chris@rorvick.com> (Chris
 Rorvick's message of "Thu, 22 Nov 2012 22:21:53 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 136F7758-37FB-11E2-835C-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210469>

Chris Rorvick <chris@rorvick.com> writes:

> diff --git a/remote.c b/remote.c
> index 4a6f822..012b52f 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1315,14 +1315,18 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>  		 *
>  		 * (1) if the old thing does not exist, it is OK.
>  		 *
> -		 * (2) if you do not have the old thing, you are not allowed
> +		 * (2) if the destination is under refs/tags/ you are
> +		 *     not allowed to overwrite it; tags are expected
> +		 *     to be static once created
> +		 *
> +		 * (3) if you do not have the old thing, you are not allowed
>  		 *     to overwrite it; you would not know what you are losing
>  		 *     otherwise.
>  		 *
> -		 * (3) if both new and old are commit-ish, and new is a
> +		 * (4) if both new and old are commit-ish, and new is a
>  		 *     descendant of old, it is OK.
>  		 *
> -		 * (4) regardless of all of the above, removing :B is
> +		 * (5) regardless of all of the above, removing :B is
>  		 *     always allowed.
>  		 */

We may want to reword (0) to make it clear that --force
(and +A:B) can be used to defeat all the other rules.

The updated logic in the patch looks sensible.  Thanks.

> ...
> +test_expect_success 'push requires --force to update lightweight tag' '
> +	mk_test heads/master &&
> +	mk_child child1 &&
> +	mk_child child2 &&
> +	(
> +		cd child1 &&
> +		git tag Tag &&
> +		git push ../child2 Tag &&
> +		git push ../child2 Tag &&
> +		>file1 &&
> +		git add file1 &&
> +		git commit -m "file1" &&
> +		git tag -f Tag &&
> +		test_must_fail git push ../child2 Tag &&
> +		git push --force ../child2 Tag &&
> +		git tag -f Tag &&
> +		test_must_fail git push ../child2 Tag HEAD~ &&
> +		git push --force ../child2 Tag
> +	)
> +'
> +

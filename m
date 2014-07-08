From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/4] cache-tree: subdirectory tests
Date: Tue, 08 Jul 2014 10:38:07 -0700
Message-ID: <xmqqsimbagzk.fsf@gitster.dls.corp.google.com>
References: <1404779625-16972-1-git-send-email-dturner@twitter.com>
	<1404779625-16972-3-git-send-email-dturner@twitter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 19:38:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4ZLQ-0002RS-9a
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 19:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbaGHRiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 13:38:16 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56504 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405AbaGHRiP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 13:38:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 850C825CC9;
	Tue,  8 Jul 2014 13:38:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UoBedXTDEu9ikYQ37pkDuXn+tpk=; b=vVxGxm
	/M20nzVi366kk71zL4f+4KP1+GMq3UI228sBgn8aUTJojA7Lj04GjFbCqJobJT9N
	Rds83m4wJO9uMU8i5Th+cr3yU3tbx/RLh2G5bPro6wGg+M/REDPfr6LeLJU9vOkl
	Z92B4cEEjzJv/m3ie39VtQDjzvdQkPIGNQ3jY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hjx4S2CoV00SQQr5hNZrlZkl3ZKdO6L6
	+Ns3h1dYHEk2JaWqqCmWgxyTZNq183rP/RzA4q+gC3ZiblBnfbp8tWb4FEQqMEpV
	8RYiK7/efZevTtlwlcqlLMeiv9utBRU4JeXTXbEo4KNzDtWQhhkk/+bK09shBQwx
	iAlvQeQ1i+0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 765A125CC8;
	Tue,  8 Jul 2014 13:38:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EDEC325CC2;
	Tue,  8 Jul 2014 13:37:55 -0400 (EDT)
In-Reply-To: <1404779625-16972-3-git-send-email-dturner@twitter.com> (David
	Turner's message of "Mon, 7 Jul 2014 17:33:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 98815D44-06C6-11E4-8190-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253035>

David Turner <dturner@twopensource.com> writes:

> +	printf "invalid                                  %s ()\n" "" "$@" >expect &&
> +	test-dump-cache-tree | \
> +	sed -n -e "s/$_x40/SHA/" -e "s/[0-9]* subtrees//g" -e '/#(ref)/d' -e '/^invalid /p' >actual &&

You only show lines that begin with "invalid ".  Does the first
"redact any object name to S H A" matter?  Also do more than one "N
subtrees" appear on an output line?

> +	test_cmp expect actual
>  }
>  
>  test_no_cache_tree () {
> @@ -49,6 +50,25 @@ test_expect_success 'git-add invalidates cache-tree' '
>  	test_invalid_cache_tree
>  '
>  
> +test_expect_success 'git-add in subdir invalidates cache-tree' '
> +	test_when_finished "git reset --hard; git read-tree HEAD" &&
> +	mkdir dirx &&
> +	echo "I changed this file" >dirx/foo &&
> +	git add dirx/foo &&
> +	test_invalid_cache_tree
> +'
> +
> +test_expect_success 'git-add in subdir does not invalidate sibling cache-tree' '
> +	git tag no-children &&
> +	test_when_finished "git reset --hard no-children; git read-tree HEAD" &&
> +	mkdir dir1 dir2 &&
> +	test_commit dir1/a &&
> +	test_commit dir2/b &&
> +	echo "I changed this file" >dir1/a &&
> +	git add dir1/a &&
> +	test_invalid_cache_tree dir1/
> +'
> +
>  test_expect_success 'update-index invalidates cache-tree' '
>  	test_when_finished "git reset --hard; git read-tree HEAD" &&
>  	echo "I changed this file" >foo &&

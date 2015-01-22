From: Junio C Hamano <gitster@pobox.com>
Subject: RFC "grep '...\{m,n\}"?
Date: Thu, 22 Jan 2015 12:19:19 -0800
Message-ID: <xmqqvbjysh4o.fsf_-_@gitster.dls.corp.google.com>
References: <CAPig+cQcYXzRwHMRcKQJf-mWq7d9Kgp7KndnEhFs4_mwgLpiiA@mail.gmail.com>
	<1421927415-114643-1-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 22 21:22:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEOH7-0001rd-Rz
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 21:22:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752954AbbAVUWm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 15:22:42 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52380 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752842AbbAVUWk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 15:22:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B82D231F86;
	Thu, 22 Jan 2015 15:22:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wFZwbOs+pcVRcjHswF81FjvL48o=; b=I/vvd/
	Oh44QTGsyBjIvWBKkNQ6SqXlvohOsvkiHg3JOt/cRuBbHCSt16VDzj6Fzkc5sIU2
	e8mY1WgMDW/oqcP368IzM3YHZvYUEVVPDTMk2Z+D0JwXyg37Oa/8a+PJTaCCvaSa
	/RLt01UIEU5rrEZi0Uay9zbt0Fy6bDySJcD64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DHn5LuHsjWiXso/yJtH6g6mYFzMXAwCK
	WSTKJdG/8ss9JwsmbF3TvTn6hacd+bsFEVlxvCWXTjZr/XcP2Hv6G7M2OYc2KiZJ
	GSnRBXGs+2xfvw8ctAkEfs/hwYpkbXNP08OnV0fJLI56PRQS6HNIPtUqbKXsgbtk
	zFkVYEK+fbY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ADF6D31F85;
	Thu, 22 Jan 2015 15:22:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7599831EB5;
	Thu, 22 Jan 2015 15:19:20 -0500 (EST)
In-Reply-To: <1421927415-114643-1-git-send-email-kirill.shutemov@linux.intel.com>
	(Kirill A. Shutemov's message of "Thu, 22 Jan 2015 13:50:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F2B638C2-A273-11E4-BED5-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262868>

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:

> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 8197ed29a9ec..a31f7e0430e1 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -1039,4 +1039,11 @@ test_expect_success 'short SHA-1 collide' '
>  	)
>  '
>  
> +test_expect_success 'respect core.abbrev' '
> +	git config core.abbrev 12 &&
> +	set_cat_todo_editor &&
> +	test_must_fail git rebase -i HEAD~4 >todo-list &&
> +	test 4 = $(grep -c "pick [0-9a-f]\{12,\}" todo-list)
> +'

Documentation/CodingGuidelines says

 - As to use of grep, stick to a subset of BRE (namely, no \{m,n\},
   [::], [==], or [..]) for portability.

   - We do not use \{m,n\};

   - We do not use -E;

   - We do not use ? or + (which are \{0,1\} and \{1,\}
     respectively in BRE) but that goes without saying as these
     are ERE elements not BRE (note that \? and \+ are not even part
     of BRE -- making them accessible from BRE is a GNU extension).

but I see we have multiple hits from "git grep 'grep .*\\{'" (all in
the t/ directory).  I wonder

 - if everybody's system is now OK with \{m,n\} these days, or

 - there are people who are grateful that we stayed away from using
   \{m,n\} but they are not running the tests because their system
   is too exotic to pass other parts of the test suite.

If the former, we may want to drop the \{m,n\} from the forbidden
list.

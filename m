From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] rebase -i: respect core.abbrev for real
Date: Thu, 22 Jan 2015 12:10:04 -0800
Message-ID: <xmqq3872tw4j.fsf@gitster.dls.corp.google.com>
References: <CAPig+cQcYXzRwHMRcKQJf-mWq7d9Kgp7KndnEhFs4_mwgLpiiA@mail.gmail.com>
	<1421927415-114643-1-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 21:10:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEO5O-0000du-9E
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 21:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbbAVUKf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 15:10:35 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61125 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751777AbbAVUKd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 15:10:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD3F031BCC;
	Thu, 22 Jan 2015 15:10:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jG139jn2bILhXKpg5QDw28vLdbo=; b=qtaEoO
	jRdvvW4AeMYjTTHm5EtdOAzkrVxxeGjCKw93ZSbFuAa28VYes6V96v/mm5kkOoOt
	lGFo7SiDmY3jcmbUGN3+0JVHKl8FNXcBN8uiv/e0GZmt7QRF+lEaNbvv0FkqfbLa
	2N0L2YMvFsyXMUxgjw0sj5epWZdQ8LO9onR+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V0mKg+17urFvpW+yiddtLKgVz3jdss9A
	Z1AtHt+O64zEkrfaIzvh3a095WDXPwTxx7gNutkNaNjpmuyyFsRs2U5opS5dfVOp
	IYETznYHUPSDdFScMXBhVIC8FOtVFpoOLv8qx3G8/0903HwyJJLMSNRuRTuEY9Pq
	TTKjifOYG58=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C3FAB31BCB;
	Thu, 22 Jan 2015 15:10:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE82331B9E;
	Thu, 22 Jan 2015 15:10:05 -0500 (EST)
In-Reply-To: <1421927415-114643-1-git-send-email-kirill.shutemov@linux.intel.com>
	(Kirill A. Shutemov's message of "Thu, 22 Jan 2015 13:50:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A81F3012-A272-11E4-AF99-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262864>

"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> writes:

> I have tried to fix this before: see 568950388be2, but it doesn't
> really work.
>
> I don't know how it happend, but that commit makes interactive rebase to
> respect core.abbrev only during --edit-todo, but not the initial todo
> list edit.
>
> For this time I've included a test-case to avoid this frustration again.
>
> The patch change code to use full 40-hex revision ids for todo actions
> everywhere and collapse them only to show to user.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  v3:
>     - use full 40-hex revision ids for todo actions everywhere and collapse them
>       only to show to user;

> @@ -1054,6 +1052,7 @@ has_action "$todo" ||
>  	return 2
>  
>  cp "$todo" "$todo".backup
> +collapse_todo_ids
>  git_sequence_editor "$todo" ||
>  	die_abort "Could not execute editor"
>  

OK, the matching expand_todo_ids is just beyond the horizon of this
patch context.

I was hoping that with this change we internally operate with the
full object names throughout the program, only to show shortened
ones in the editor, but I still see a handful of "rev-parse --short"
outside collapse_todo_ids.  Upon closer inspection, it turns out
that they are only about formatting "# Rebase a..b onto c", which is
never rewritten in transform/collapse/expand_todo_ids, so I think
all is well.

Thanks.

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
> +
>  test_done

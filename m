From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] diff_filespec: reorder dirty_submodule macro definitions
Date: Fri, 17 Jan 2014 10:46:59 -0800
Message-ID: <xmqqha92xx7g.fsf@gitster.dls.corp.google.com>
References: <20140117011844.GA6870@sigill.intra.peff.net>
	<20140117011945.GA7249@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 17 19:47:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4ERi-0005Ov-8r
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 19:47:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbaAQSrF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 13:47:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59128 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689AbaAQSrD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 13:47:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EDC6B61FC6;
	Fri, 17 Jan 2014 13:47:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VmPIAZos5QzGwIZ9HoaXC4q0HJU=; b=WLEfzh
	XrB1ske54q/X98WJ+b9IwwcJ58Md9IhWgrdeBOX0RFDgV4lU23RKuLqY39zDiRdS
	B+ScxAA/IUKX2ecrfxTs1Aj7YQwYL+lVV08axfntA6+tB5WaY1rwwvl1coa24SPJ
	dM/c+UGNE/CKOZO4LJAFjTuXvHiOOgrJGXVYI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ErrdTXJYBHrDWny8zEFGqEc9EzhXnerN
	h/8mGhSfXnQGWOAh1dDx/Ioly+B4ch+fJjF9Ec8XzWjvFizp/WxasJ2DzVD1qvW1
	nUk1X2Cp3kGLI1wvY+uKcGg6668Tho8drX9BZQUKDbYE1RJODIf1ZUkdyMAE0en1
	8ELnVc/gdjw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D52CB61FC5;
	Fri, 17 Jan 2014 13:47:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3BFF61FBD;
	Fri, 17 Jan 2014 13:47:01 -0500 (EST)
In-Reply-To: <20140117011945.GA7249@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 16 Jan 2014 20:19:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C07B0382-7FA7-11E3-B573-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240606>

Jeff King <peff@peff.net> writes:

> diff_filespec has a 2-bit "dirty_submodule" field and
> defines two flags as macros. Originally these were right
> next to each other, but a new field was accidentally added
> in between in commit 4682d85.

Interesting.

 - 4682d852 (diff-index.c: "git diff" has no need to read blob from
   the standard input, 2012-06-27) wants to use this rule: all the
   bitfield definitions first, and then whatever macro constants
   next.

 - 25e5e2bf (combine-diff: support format_callback, 2011-08-19),
   wants to use a different rule: a run of (one bitfield definition
   and zero-or-more macro constants to be used in that bitfield).

When they were merged together at d7afe648 (Merge branch
'jc/refactor-diff-stdin', 2012-07-13), these two conflicting
philosophies crashed.

That is the commit to be blamed for this mess ;-)

I am of course fine with the end result this patch gives us.

Thanks.

> This patch puts the field and
> its flags back together.
>
> Using an enum like:
>
>   enum {
> 	  DIRTY_SUBMODULE_UNTRACKED = 1,
> 	  DIRTY_SUBMODULE_MODIFIED = 2
>   } dirty_submodule;
>
> would be more obvious, but it bloats the structure. Limiting
> the enum size like:
>
>   } dirty_submodule : 2;
>
> might work, but it is not portable.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  diffcore.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diffcore.h b/diffcore.h
> index 1c16c85..f822f9e 100644
> --- a/diffcore.h
> +++ b/diffcore.h
> @@ -43,9 +43,9 @@ struct diff_filespec {
>  	unsigned should_free : 1; /* data should be free()'ed */
>  	unsigned should_munmap : 1; /* data should be munmap()'ed */
>  	unsigned dirty_submodule : 2;  /* For submodules: its work tree is dirty */
> -	unsigned is_stdin : 1;
>  #define DIRTY_SUBMODULE_UNTRACKED 1
>  #define DIRTY_SUBMODULE_MODIFIED  2
> +	unsigned is_stdin : 1;
>  	unsigned has_more_entries : 1; /* only appear in combined diff */
>  	struct userdiff_driver *driver;
>  	/* data should be considered "binary"; -1 means "don't know yet" */

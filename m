From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] Squelch warning about an integer overflow
Date: Mon, 26 Oct 2015 13:23:22 -0700
Message-ID: <xmqqpp01fkg5.fsf@gitster.mtv.corp.google.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<b0e4b6736cc2ec88e5f7cf587629d6a4d7e502d8.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 26 21:23:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqoIn-0006AL-Is
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 21:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbbJZUX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Oct 2015 16:23:28 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62372 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752564AbbJZUXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Oct 2015 16:23:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0304026FCE;
	Mon, 26 Oct 2015 16:23:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bkrjAVa3WQCGOT76XRlRAr2c5cg=; b=k3QWJe
	Vv39fpLrrcgw0FP7C+kPkiYcFGw6oR6NSMOcmfKA6yrR2bywrpm9+TOegZW1xIFD
	ph+CkwDOh78A7rl0X10HG/3bEjcvpo12AOoXiRSFLg8zh03j7EVNBSzzhDibcXxy
	jMeWz/YPiotv2Lbxylsw6sO53moZHMXdHLqUo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wzucXDt7XNlzB/JN7XK2zpQv7qaU4MWB
	W0fn/7MGbUtdIBe7EjJSkr6FvNbBHYVI5qVnDKAIZlQ37Y6OX9+rR2lF226TslNR
	hz4uoSwthzs7tjDYWOxOn29g6Xa2YTYzYJh8cxiQ5K9UX4fquo+wFFhSWft31Hlc
	m5wOiFY82rk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EEDE726FCD;
	Mon, 26 Oct 2015 16:23:23 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 79F9126FCA;
	Mon, 26 Oct 2015 16:23:23 -0400 (EDT)
In-Reply-To: <b0e4b6736cc2ec88e5f7cf587629d6a4d7e502d8.1445865176.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 26 Oct 2015 14:15:21 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 67FCD584-7C1F-11E5-BE8E-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280221>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We cannot rely on long integers to have more than 32 bits...
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

Interesting.  8192 * 1024 * 1024 does not fit within 32-bit long, of
course.  Perhaps we can lose L after 1024 if we are explicitly
saying that the result ought to be size_t (which may be larger than
long)?

>  git-compat-util.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 805d0e2..610e8a5 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -568,7 +568,7 @@ extern int git_lstat(const char *, struct stat *);
>  #endif
>  
>  #define DEFAULT_PACKED_GIT_LIMIT \
> -	((1024L * 1024L) * (sizeof(void*) >= 8 ? 8192 : 256))
> +	((1024L * 1024L) * (size_t)(sizeof(void*) >= 8 ? 8192 : 256))
>  
>  #ifdef NO_PREAD
>  #define pread git_pread

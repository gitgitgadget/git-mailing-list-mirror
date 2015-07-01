From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list: disable --use-bitmap-index when pruning commits
Date: Wed, 01 Jul 2015 12:00:13 -0700
Message-ID: <xmqq3817aeki.fsf@gitster.dls.corp.google.com>
References: <1435742651-15053-1-git-send-email-lawrencesiebert@gmail.com>
	<xmqqd20bc3cj.fsf@gitster.dls.corp.google.com>
	<20150701184217.GA8079@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Lawrence Siebert <lawrencesiebert@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jul 01 21:00:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZANFA-0003qf-66
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 21:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752876AbbGATAU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 15:00:20 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:33841 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865AbbGATAS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 15:00:18 -0400
Received: by igcsj18 with SMTP id sj18so142700866igc.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2015 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mULxKFIqnJ4UH/vhfYCRvSNaTXvnq/BQyMw36qMD5UE=;
        b=Ji7UJ8a6n9In4LF9kXBgg9B/6LAHr9XOdjNlCethoJz8TiHnaNm9UCGLWrnDfslmu9
         aajpsUgk9bX/Tw98qbW345BjgLvQCLaBqtp9X0F1kXpMuLlmOnT6h4IAQcnJxVkVYW2N
         mXEMgeG5Stk6KUo/m3K9ctWWcFDXsv0/4ZzfKjsIlFjS6qRkpbG75cYKu/rlTiu5XKXL
         KQKkAhCuB77mDXQHhbGgOvA/KEGuihdiVkNX52+TeYpIu9cmJPwCmAeqVM7h8Dcc4udx
         zSNj+6VTNg9sgp24UaE6hyi2sWfWcF7xaX3Rkk+KUVKfp2axt3QYJIudpQLvLumEMHH4
         IsLg==
X-Received: by 10.50.66.167 with SMTP id g7mr7880733igt.22.1435777216566;
        Wed, 01 Jul 2015 12:00:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:64b9:4225:baa1:c97c])
        by mx.google.com with ESMTPSA id p4sm2303268igg.20.2015.07.01.12.00.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Jul 2015 12:00:16 -0700 (PDT)
In-Reply-To: <20150701184217.GA8079@peff.net> (Jeff King's message of "Wed, 1
	Jul 2015 14:42:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273183>

Jeff King <peff@peff.net> writes:

> On Wed, Jul 01, 2015 at 08:19:40AM -0700, Junio C Hamano wrote:
>
>> Sounds good.  While at it, perhaps add a mention (perhaps by
>> creating a BUGS section at the end of the file) that --count
>> with --use-bitmap-index ignores pathspec silently?
>
> I think we can just fix it rather than documenting the problem. :)

;-)  Good.

Will queue; thanks.

>
> -- >8 --
> Subject: rev-list: disable --use-bitmap-index when pruning commits
>
> The reachability bitmaps do not have enough information to
> tell us which commits might have changed path "foo", so the
> current code produces wrong answers for:
>
>   git rev-list --use-bitmap-index --count HEAD -- foo
>
> (it silently ignores the "foo" limiter). Instead, we should
> fall back to doing a normal traversal (it is OK to fall
> back rather than complain, because --use-bitmap-index is a
> pure optimization, and might not kick in for other reasons,
> such as there being no bitmaps in the repository).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/rev-list.c      | 2 +-
>  t/t5310-pack-bitmaps.sh | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index ff84a82..88eddbd 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -355,7 +355,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  	if (bisect_list)
>  		revs.limited = 1;
>  
> -	if (use_bitmap_index) {
> +	if (use_bitmap_index && !revs.prune) {
>  		if (revs.count && !revs.left_right && !revs.cherry_mark) {
>  			uint32_t commit_count;
>  			if (!prepare_bitmap_walk(&revs)) {
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 6003490..d446706 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -53,6 +53,12 @@ rev_list_tests() {
>  		test_cmp expect actual
>  	'
>  
> +	test_expect_success "counting commits with limiting ($state)" '
> +		git rev-list --count HEAD -- 1.t >expect &&
> +		git rev-list --use-bitmap-index --count HEAD -- 1.t >actual &&
> +		test_cmp expect actual
> +	'
> +
>  	test_expect_success "enumerate --objects ($state)" '
>  		git rev-list --objects --use-bitmap-index HEAD >tmp &&
>  		cut -d" " -f1 <tmp >tmp2 &&

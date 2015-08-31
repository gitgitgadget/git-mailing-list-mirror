From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] trailer: support multiline title
Date: Mon, 31 Aug 2015 11:13:16 -0700
Message-ID: <xmqq8u8rwclf.fsf@gitster.mtv.corp.google.com>
References: <1440962080-24804-1-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 20:13:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWTa7-0004BU-Be
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 20:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbbHaSNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 14:13:19 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33955 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbbHaSNS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 14:13:18 -0400
Received: by pabzx8 with SMTP id zx8so146930047pab.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vsNdN8DTonlMWiDowR1gwS6E1B8r3LjRjICwul2cC4Y=;
        b=pzh4/iwTF95JR4X2z8ePLntGwM8z0MNq6NxeWGZvE/b6irPa0qA2HgJQGWv8HPRiwl
         LBMinN92B5+8UVfgEIBu+Bv76IBb0xQF7DAX9+HIQv+kTTdLUGqALjW6PTsmztaIBUh2
         ak2OS5y896zucwN3aK/lmajvz2+Guh/Op5+VHzcTm0MnqYZuszNMCbV8mPHyuSlDV5Np
         2+L1qUz5FFq4Wsnsab6vcpeRKTD23BM4yTKyJmcQcB3lHSplh/KZ3+kbv13d0r0x4Hpx
         aYM3QX3QQ0+ikhiELLpdWyBWTVLv1F1w09VB/0SfPuIYbgxWAMaffGG9yUPhpXYLx+py
         l+vg==
X-Received: by 10.68.111.98 with SMTP id ih2mr39487141pbb.165.1441044798467;
        Mon, 31 Aug 2015 11:13:18 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id zn9sm15415599pac.11.2015.08.31.11.13.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 11:13:17 -0700 (PDT)
In-Reply-To: <1440962080-24804-1-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Sun, 30 Aug 2015 21:14:40 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276901>

Christian Couder <christian.couder@gmail.com> writes:

> We currently ignore the first line passed to `git interpret-trailers`,
> when looking for the beginning of the trailers.
>
> Unfortunately this does not work well when a commit is created with a
> line break in the title, using for example the following command:
>
> git commit -m 'place of
> code: change we made'
>
> That's why instead of ignoring only the first line, it is better to
> ignore the first paragraph.
> ---
>  t/t7513-interpret-trailers.sh | 14 ++++++++++++++
>  trailer.c                     | 15 +++++++++++----
>  2 files changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> index 9577b4e..56efe88 100755
> --- a/t/t7513-interpret-trailers.sh
> +++ b/t/t7513-interpret-trailers.sh
> @@ -112,6 +112,20 @@ test_expect_success 'with only a title in the message' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'with multiline title in the message' '
> +	cat >expected <<-\EOF &&
> +		place of
> +		code: change
> +
> +		Reviewed-by: Peff
> +		Acked-by: Johan
> +	EOF
> +	printf "%s\n%s\n" "place of" "code: change" |

Just FYI, I think "%s\n" is sufficient to produce multi-line output,
e.g.

	printf "%s xyzzy\n" a b c d: e:

> +	git interpret-trailers --trailer "Reviewed-by: Peff" \
> +		--trailer "Acked-by: Johan" >actual &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'with config setup' '
>  	git config trailer.ack.key "Acked-by: " &&
>  	cat >expected <<-\EOF &&
> diff --git a/trailer.c b/trailer.c
> index b808868..6f3416f 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -735,15 +735,22 @@ static int find_patch_start(struct strbuf **lines, int count)
>   */
>  static int find_trailer_start(struct strbuf **lines, int count)
>  {
> -	int start, only_spaces = 1;
> +	int start, end_of_title, only_spaces = 1;
> +
> +	/* The first paragraph is the title and cannot be trailers */
> +	for (start = 0; start < count; start++) {
> +		if (lines[start]->buf[0] == comment_line_char)
> +			continue;
> +		if (contains_only_spaces(lines[start]->buf))
> +			break;
> +	}
> +	end_of_title = start;
>  
>  	/*
>  	 * Get the start of the trailers by looking starting from the end
>  	 * for a line with only spaces before lines with one separator.
> -	 * The first line must not be analyzed as the others as it
> -	 * should be either the message title or a blank line.
>  	 */
> -	for (start = count - 1; start >= 1; start--) {
> +	for (start = count - 1; start >= end_of_title; start--) {
>  		if (lines[start]->buf[0] == comment_line_char)
>  			continue;
>  		if (contains_only_spaces(lines[start]->buf)) {

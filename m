From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] diff: Let "git diff -O" read orderfile from any file, failing when appropriate
Date: Mon, 16 Dec 2013 10:43:15 -0800
Message-ID: <xmqqk3f4prgc.fsf@gitster.dls.corp.google.com>
References: <1387059521-23616-1-git-send-email-naesten@gmail.com>
	<1387059521-23616-3-git-send-email-naesten@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Anders Waldenborg <anders@0x63.nu>
To: Samuel Bronson <naesten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 16 19:43:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vsd8W-0004if-RX
	for gcvg-git-2@plane.gmane.org; Mon, 16 Dec 2013 19:43:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333Ab3LPSnU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Dec 2013 13:43:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59256 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754993Ab3LPSnT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Dec 2013 13:43:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC2475BD5D;
	Mon, 16 Dec 2013 13:43:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hcYbdxNhCkLkZSwTh3TeS6jEesw=; b=O9BAwo
	Lz0ONhs0HONmI5Um3HBjiM9W3JQMwSSz8bf2z6caQwGUdthaQn5O+egCMnL8DikO
	3x6eLTwcTCh6axPpvvmbMCH4jlYNHbWqWVk1+Kpo4QyBb9y7IU4FSbWo39mwZfSM
	ke1gws1SbkSgEBwfBhRk0gZD+Z3EoMtkUFypk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BNPuHiRO3X6ocMsr1NlapCSSzxrRT5ja
	7oyxjnaIiq86w5xZukXjJsflKMEefzFX2MOP7LzOJ5pa+72VBuyamcz6WcF+MK+V
	e3ZbUJlKv5Hi30Bu0MCKi7+rUExudNcnTgkWOtD4BnrR9nLpXHnbLNZXAzaTNrAO
	rOBGyoz8nlk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8A315BD5C;
	Mon, 16 Dec 2013 13:43:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECD065BD5B;
	Mon, 16 Dec 2013 13:43:17 -0500 (EST)
In-Reply-To: <1387059521-23616-3-git-send-email-naesten@gmail.com> (Samuel
	Bronson's message of "Sat, 14 Dec 2013 17:18:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EDED1DEE-6681-11E3-B9AE-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239342>

Samuel Bronson <naesten@gmail.com> writes:

> The -O flag really shouldn't silently fail to do anything when given a
> path that it can't read from.
>
> However, it should be able to read from un-mappable files, such as
> pipes/fifos, /dev/null (as we document in the next patch), or in fact
> *any* empty file (since Linux 2.6.12).

Could you enlighten the commit log readers a bit better here?  Those
who know the change in 2.6.12 (i.e. "'mmapping with length 0 must
fail', says SUSv3, so we fail") you have in mind would know what you
mean by "in fact any empty file" even if you did not have "(since
Linux 2.6.12)", but those who do not know it would not be helped
with just "(since Linux 2.6.12)".

> (Especially since we will be
> documenting "-O/dev/null" to override "diff.orderfile" when we add that.)
>
> (Note: "-O/dev/null" did have the right effect, since the existing error
> handling essentially worked out to "silently ignore the orderfile".)
>
> So lets toss all of that logic to get the file mmapped and just use
> strbuf_read_file() instead, which gives us decent error handling
> practically for free.

Sounds good.  In the longer term, we may want to move this
file-scope static to per-infocation "struct diff_options" and clean
up the storage used to hold the list of path patterns after we are
done with the diff, but that is outside the scope of this series.

Thanks.

> Signed-off-by: Samuel Bronson <naesten@gmail.com>
> ---
>  diffcore-order.c      | 23 ++++++++---------------
>  t/t4056-diff-order.sh | 23 +++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 15 deletions(-)
>
> diff --git a/diffcore-order.c b/diffcore-order.c
> index 23e9385..a63f332 100644
> --- a/diffcore-order.c
> +++ b/diffcore-order.c
> @@ -10,28 +10,21 @@ static int order_cnt;
>  
>  static void prepare_order(const char *orderfile)
>  {
> -	int fd, cnt, pass;
> +	int cnt, pass;
> +	struct strbuf sb = STRBUF_INIT;
>  	void *map;
>  	char *cp, *endp;
> -	struct stat st;
> -	size_t sz;
> +	ssize_t sz;
>  
>  	if (order)
>  		return;
>  
> -	fd = open(orderfile, O_RDONLY);
> -	if (fd < 0)
> -		return;
> -	if (fstat(fd, &st)) {
> -		close(fd);
> -		return;
> -	}
> -	sz = xsize_t(st.st_size);
> -	map = mmap(NULL, sz, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, 0);
> -	close(fd);
> -	if (map == MAP_FAILED)
> -		return;
> +	sz = strbuf_read_file(&sb, orderfile, 0);
> +	if (sz < 0)
> +		die_errno(_("failed to read orderfile '%s'"), orderfile);
> +	map = strbuf_detach(&sb, NULL);
>  	endp = (char *) map + sz;
> +
>  	for (pass = 0; pass < 2; pass++) {
>  		cnt = 0;
>  		cp = map;
> diff --git a/t/t4056-diff-order.sh b/t/t4056-diff-order.sh
> index 398b3f6..eb471e7 100755
> --- a/t/t4056-diff-order.sh
> +++ b/t/t4056-diff-order.sh
> @@ -61,12 +61,35 @@ test_expect_success "no order (=tree object order)" '
>  	test_cmp expect_none actual
>  '
>  
> +test_expect_success 'missing orderfile' '
> +	rm -f bogus_file &&
> +	test_must_fail git diff -Obogus_file --name-only HEAD^..HEAD
> +'
> +
> +test_expect_success 'unreadable orderfile' '
> +	touch unreadable_file &&
> +	chmod -r unreadable_file &&
> +	test_must_fail git diff -Ounreadable_file --name-only HEAD^..HEAD
> +'
> +
> +test_expect_success 'orderfile is a directory' '
> +	test_must_fail git diff -O/ --name-only HEAD^..HEAD
> +'
> +
>  for i in 1 2
>  do
>  	test_expect_success "orderfile using option ($i)" '
>  	git diff -Oorder_file_$i --name-only HEAD^..HEAD >actual &&
>  	test_cmp expect_$i actual
>  '
> +
> +	test_expect_success PIPE "orderfile is fifo ($i)" '
> +	rm -f order_fifo &&
> +	mkfifo order_fifo &&
> +	cat order_file_$i >order_fifo &
> +	git diff -O order_fifo --name-only HEAD^..HEAD >actual &&
> +	test_cmp expect_$i actual
> +'
>  done
>  
>  test_done

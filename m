From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/blame.c::find_copy_in_blob: no need to scan for region end
Date: Tue, 25 Feb 2014 09:51:45 -0800
Message-ID: <xmqq61o36pxq.fsf@gitster.dls.corp.google.com>
References: <1393084967-23408-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 25 18:51:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIMAe-0007SE-4b
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 18:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbaBYRvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 12:51:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37483 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193AbaBYRvu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 12:51:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A191C6DE2C;
	Tue, 25 Feb 2014 12:51:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=75TAq+uYLORC8KqVKLc9Q2u0ZuU=; b=RXUSgb
	g5JeHcqa4R5dM1gggamY+G6g/Nen+msKmSMHPuiT+PbkfyFR8g8AQheCNSZRyc3v
	YfG2XglYSDmytbSAttr25BvQ9Uz3ZDiQQOrNmZ/nLZy2Nntp4mwUrY2/XfOLANSc
	pONubur9Sw2vQgTcP0Qjnr1xJpo3A4eI6JdTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fqayOzfM54FQsMzFshAfmSn6T/CDQZ39
	yCEYbqlECVNWxBYzoNBId8gkLGW6BG0bXj4nB4xdvMcczi2ekFCzNY0XBRUtsgzf
	o512DfnW+VCQpvA87rbtCB3hDWJ/ow0BEo22D0jgzb9q4n2tDnifONbq+3JGhaZT
	DVptlGM81hY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8C2836DE2B;
	Tue, 25 Feb 2014 12:51:49 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A932C6DE29;
	Tue, 25 Feb 2014 12:51:48 -0500 (EST)
In-Reply-To: <1393084967-23408-1-git-send-email-dak@gnu.org> (David Kastrup's
	message of "Sat, 22 Feb 2014 17:02:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7FE6EB26-9E45-11E3-AA02-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242677>

David Kastrup <dak@gnu.org> writes:

> The region end can be looked up just like its beginning.
>
> Signed-off-by: David Kastrup <dak@gnu.org>
> ---
>  builtin/blame.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)

Yay, code reduction!  Thanks.

> diff --git a/builtin/blame.c b/builtin/blame.c
> index e44a6bb..96716dd 100644
> --- a/builtin/blame.c
> +++ b/builtin/blame.c
> @@ -939,7 +939,6 @@ static void find_copy_in_blob(struct scoreboard *sb,
>  			      mmfile_t *file_p)
>  {
>  	const char *cp;
> -	int cnt;
>  	mmfile_t file_o;
>  	struct handle_split_cb_data d;
>  
> @@ -950,13 +949,7 @@ static void find_copy_in_blob(struct scoreboard *sb,
>  	 */
>  	cp = nth_line(sb, ent->lno);
>  	file_o.ptr = (char *) cp;
> -	cnt = ent->num_lines;
> -
> -	while (cnt && cp < sb->final_buf + sb->final_buf_size) {
> -		if (*cp++ == '\n')
> -			cnt--;
> -	}
> -	file_o.size = cp - file_o.ptr;
> +	file_o.size = nth_line(sb, ent->lno + ent->num_lines) - cp;
>  
>  	/*
>  	 * file_o is a part of final image we are annotating.

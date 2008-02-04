From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/11] Use new decompress_all() helper in git
Date: Sun, 03 Feb 2008 18:07:46 -0800
Message-ID: <7vve55mq31.fsf@gitster.siamese.dyndns.org>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-2-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-3-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-4-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-5-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-6-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-7-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-8-git-send-email-mcostalba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 03:08:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLql5-0007Uu-8P
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 03:08:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755057AbYBDCHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 21:07:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755031AbYBDCHx
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 21:07:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45048 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755021AbYBDCHw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 21:07:52 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AFF41981;
	Sun,  3 Feb 2008 21:07:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AC2F1980;
	Sun,  3 Feb 2008 21:07:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72452>

Marco Costalba <mcostalba@gmail.com> writes:

> Only in two places is possible to really simplify
> diff --git a/index-pack.c b/index-pack.c
> index 880088e..30d7837 100644
> --- a/index-pack.c
> +++ b/index-pack.c
> @@ -169,24 +169,18 @@ static void *unpack_entry_data(unsigned long offset, unsigned long size)
>  	z_stream stream;
>  	void *buf = xmalloc(size);
>  
> -	memset(&stream, 0, sizeof(stream));
> -	stream.next_out = buf;
> -	stream.avail_out = size;
> -	stream.next_in = fill(1);
> -	stream.avail_in = input_len;
> -	inflateInit(&stream);
> +	decompress_alloc(&stream);
> +	decompress_into(&stream, buf, size);
>  
>  	for (;;) {
> -		int ret = inflate(&stream, 0);
> +		int ret = decompress_next_from(&stream, fill(1), input_len, Z_NO_FLUSH);

The input_len variable is changed as a side effect of calling
the fill() function.  Don't you have the same issue that you
handle with [10/11] here?

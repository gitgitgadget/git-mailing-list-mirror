From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/11] Convert builtin-pack/unpack
Date: Sun, 03 Feb 2008 18:08:02 -0800
Message-ID: <7vodaxmq2l.fsf@gitster.siamese.dyndns.org>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-2-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-3-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-4-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-5-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-6-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-7-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-8-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-9-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-10-git-send-email-mcostalba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 03:08:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLqlH-0007WD-Tw
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 03:08:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755069AbYBDCIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 21:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755066AbYBDCIJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 21:08:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45053 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755065AbYBDCIH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 21:08:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E15A1983;
	Sun,  3 Feb 2008 21:08:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CC6B1982;
	Sun,  3 Feb 2008 21:08:04 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72453>

Marco Costalba <mcostalba@gmail.com> writes:

> diff --git a/builtin-unpack-objects.c b/builtin-unpack-objects.c
> index 1e51865..c996560 100644
> --- a/builtin-unpack-objects.c
> +++ b/builtin-unpack-objects.c
> @@ -1,5 +1,6 @@
>  #include "builtin.h"
>  #include "cache.h"
> +#include "compress.h"
>  #include "object.h"
>  #include "delta.h"
>  #include "pack.h"
> @@ -61,23 +62,20 @@ static void use(int bytes)
>  static void *get_data(unsigned long size)
>  {
>  	z_stream stream;
> -	void *buf = xmalloc(size);
> +	unsigned char *buf = xmalloc(size);;

Why?  Your other changes (e.g. unpack_entry_data()::index-pack.c
in [08/11]) left the type of buf as it was, and I think the same
should be done here.

> -	memset(&stream, 0, sizeof(stream));
> -
> -	stream.next_out = buf;
> -	stream.avail_out = size;
> -	stream.next_in = fill(1);
> -	stream.avail_in = len;
> -	inflateInit(&stream);
> +	decompress_alloc(&stream);
> +	decompress_into(&stream, buf, size);
>  
>  	for (;;) {
> -		int ret = inflate(&stream, 0);
> +		/* fill() modifies len, so be sure is evaluated as first */
> +		void* tmp = fill(1);
> +		int ret = decompress_next_from(&stream, tmp, len, Z_NO_FLUSH);

(Style) that's "void *tmp".

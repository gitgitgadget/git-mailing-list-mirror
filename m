From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/11] Introduce stream compress helpers
Date: Sun, 03 Feb 2008 14:53:31 -0800
Message-ID: <7v8x21slck.fsf@gitster.siamese.dyndns.org>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 23:54:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLnjD-0001zN-KN
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 23:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753119AbYBCWxr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 17:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753103AbYBCWxr
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 17:53:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33281 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752848AbYBCWxq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 17:53:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A1AB367BA;
	Sun,  3 Feb 2008 17:53:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 19EAD67B7;
	Sun,  3 Feb 2008 17:53:42 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72416>

Marco Costalba <mcostalba@gmail.com> writes:

> When decompressing a zlib stream use this
> helpers instead of calling low level zlib
> function.
>
> This patch introduces the necessary framework,
> still no code change.
>
> This is the first step in generalizing compress and
> decompress functions avoiding zlib directly calls.

(Cosmetic)

Your log message lines are wrapped a bit too short, while some
of the patch lines are too long.

> diff --git a/compress.c b/compress.c
> new file mode 100644
> index 0000000..f6986c3
> --- /dev/null
> +++ b/compress.c
> @@ -0,0 +1,58 @@
> +#include "cache.h"
> +#include "compress.h"
> +
> +unsigned long compress_alloc(z_stream *stream, int level, unsigned long size)
> +{
> +	memset(stream, 0, sizeof(*stream));
> +	deflateInit(stream, level);
> +	return deflateBound(stream, size);
> +}

(Naming)

This is not about "allocation", but about "setup".

> +int compress_start(z_stream *stream,
> +                   unsigned char *in, unsigned long in_size,
> +                   unsigned char *out, unsigned long out_size)
> +{
> +	stream->next_out = (out ? out : xmalloc(out_size));
> +	stream->avail_out = out_size;
> +	stream->next_in = in;
> +	stream->avail_in = in_size;
> +	return Z_OK;
> +}

This returns Z_OK unconditionally and most callers do not even
bother checking the return value.  Shouldn't this be of type
void?

Especially the use of this in if() conditional, after [06/11]
changes its use in compress_all(), looks quite ugly.

> +unsigned long compress_free(z_stream *stream)
> +{
> +	deflateEnd(stream);
> +	return stream->total_out;
> +}

Eventually, this should check errors from deflateEnd() and
propagate that to the caller.

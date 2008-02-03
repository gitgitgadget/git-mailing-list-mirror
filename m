From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 02/11] Use new compress helpers in git files
Date: Sun, 03 Feb 2008 14:54:17 -0800
Message-ID: <7vr6ftr6qu.fsf@gitster.siamese.dyndns.org>
References: <1201952156-6764-1-git-send-email-mcostalba@gmail.com>
	<1201952156-6764-2-git-send-email-mcostalba@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 03 23:55:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLnjt-0002AH-EF
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 23:55:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753294AbYBCWy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 17:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbYBCWy3
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 17:54:29 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230AbYBCWy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 17:54:28 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B86186804;
	Sun,  3 Feb 2008 17:54:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 40BC86803;
	Sun,  3 Feb 2008 17:54:24 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72419>

Marco Costalba <mcostalba@gmail.com> writes:

> These are the 'easy' ones, where a signgle step
> compression is requested so that we can use only
> one call to compress_all()
>
> Signed-off-by: Marco Costalba <mcostalba@gmail.com>
> ---
>  archive-zip.c          |   28 +++-------------------------
>  builtin-pack-objects.c |   19 +++----------------
>  diff.c                 |   22 +++++-----------------
>  index-pack.c           |   20 +++-----------------
>  4 files changed, 14 insertions(+), 75 deletions(-)
>
> diff --git a/archive-zip.c b/archive-zip.c
> index 74e30f6..9071b86 100644
> --- a/archive-zip.c
> +++ b/archive-zip.c
> @@ -3,6 +3,7 @@
>   */
>  #include "cache.h"
>  #include "commit.h"
> +#include "compress.h"
>  #include "blob.h"
>  #include "tree.h"
>  #include "quote.h"
> @@ -97,33 +98,10 @@ static void copy_le32(unsigned char *dest, unsigned int n)
>  static void *zlib_deflate(void *data, unsigned long size,
>                            unsigned long *compressed_size)
>  {
> ...
> -	if (result != Z_STREAM_END) {
> -		free(buffer);
> -		return NULL;
> -	}
>  
> -	deflateEnd(&stream);
> -	*compressed_size = stream.total_out;
> +	unsigned char *buffer = NULL;
>  
> +	*compressed_size = compress_all(zlib_compression_level, data, size, &buffer);
>  	return buffer;
>  }

This used to leave *compressed_size untouched upon deflate
failure but now it sets it to zero.  Is this change in behaviour
safe?

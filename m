From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Decompression speed: zip vs lzo
Date: Fri, 11 Jan 2008 20:46:01 -0800
Message-ID: <7vzlvby7li.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
	<7v4pdmfw27.fsf@gitster.siamese.dyndns.org>
	<47855765.9090001@vilain.net>
	<alpine.LSU.1.00.0801092328580.31053@racer.site>
	<47856E8D.4010006@vilain.net> <4785A6DB.3080007@vilain.net>
	<20080110091607.GA17944@artemis.madism.org>
	<alpine.LFD.1.00.0801101332150.3054@xanadu.home>
	<alpine.LFD.1.00.0801101252030.3148@woody.linux-foundation.org>
	<478691EB.1080704@vilain.net>
	<alpine.LFD.1.00.0801101400550.3148@woody.linux-foundation.org>
	<47869C24.3000400@vilain.net>
	<alpine.LFD.1.00.0801101454440.3148@woody.linux-foundation.org>
	<4786BFCD.1000303@vilain.net>
	<alpine.LFD.1.00.0801101805540.3148@woody.linux-foundation.org>
	<47870CDF.4010606@vilain.net>
	<alpine.LFD.1.00.0801110759160.3148@woody.linux-foundation.org>
	<47881D44.9060105@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 05:47:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDYGp-0001p5-TA
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 05:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755906AbYALEqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 23:46:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754904AbYALEqb
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 23:46:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38521 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491AbYALEqa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 23:46:30 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8860040DD;
	Fri, 11 Jan 2008 23:46:27 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C4F6940DC;
	Fri, 11 Jan 2008 23:46:18 -0500 (EST)
In-Reply-To: <47881D44.9060105@vilain.net> (Sam Vilain's message of "Sat, 12
	Jan 2008 14:52:04 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70259>

Sam Vilain <sam@vilain.net> writes:

> If the uncompressed objects are clustered in the pack, then they might
> stream compress a lot better, should they be tranmitted over a http
> transport with gzip encoding.

That would only have been a sensible optimization in older
native pack protocol, where we always exploded the transferred
packfile.  However, these days, we tend to keep the packfile and
re-index at the receiving end (http transport never exploded the
packfile and it still doesn't).  When used that way, choosing
object layout in packfile in such a way to ignore recency order
and cluster objects by their delta chain, which you are
advocating to reduce the transfer overhead, is a bad tradeoff.
Your packs will be kept in the form you chose for transport,
which is a layout that hurts the runtime performance.  And you
keep using that suboptimal packs number of times, getting hurt
every time.

> @@ -433,7 +434,7 @@ static unsigned long write_object(struct sha1file *f,
>  		}
>  		/* compress the data to store and put compressed length in datalen */
>  		memset(&stream, 0, sizeof(stream));
> -		deflateInit(&stream, pack_compression_level);
> +		deflateInit(&stream, size >= compression_min_size ? pack_compression_level : 0);
>  		maxsize = deflateBound(&stream, size);
>  		out = xmalloc(maxsize);
>  		/* Compress it */

I very much like the simplicity of the patch.  If such a simple
approach can give us a clear performance gain, I am all for it.

Benchmarks on different repositories need to back that up,
though.

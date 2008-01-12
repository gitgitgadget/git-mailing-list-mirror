From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH decompress BUG] Fix decompress_next_from() wrong argument value
Date: Fri, 11 Jan 2008 23:31:43 -0800
Message-ID: <7vir1zwlcw.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550801111247l1ccf171ene5b53b8d6841a864@mail.gmail.com>
	<7vfxx3290v.fsf@gitster.siamese.dyndns.org>
	<e5bfff550801112306g6b8127dft80484c9fd8554992@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 08:32:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDaqv-0000my-2c
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 08:32:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758669AbYALHb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 02:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757668AbYALHb5
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 02:31:57 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44330 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031AbYALHb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 02:31:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 73B8C48D1;
	Sat, 12 Jan 2008 02:31:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C852348D0;
	Sat, 12 Jan 2008 02:31:50 -0500 (EST)
In-Reply-To: <e5bfff550801112306g6b8127dft80484c9fd8554992@mail.gmail.com>
	(Marco Costalba's message of "Sat, 12 Jan 2008 08:06:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70283>

"Marco Costalba" <mcostalba@gmail.com> writes:

> The only two points in the current code in master that I would like to
> report to you are a _possible_ missing inflateEnd() before a new
> inflateInit(), but I am not confident with that part of code to judge
> if is a bug or not, anyway that's the _possible_ diff.
>
> diff --git a/http-push.c b/http-push.c
> index 55d0c94..e0a4cc6 100644
> --- a/http-push.c
> +++ b/http-push.c
> @@ -307,6 +307,7 @@ static void start_fetch_loose(struct
> transfer_request *request)
>  	/* Reset inflate/SHA1 if there was an error reading the previous temp
>  	   file; also rewind to the beginning of the local file. */
>  	if (prev_read == -1) {
> +		inflateEnd(&request->stream);
>  		memset(&request->stream, 0, sizeof(request->stream));
>  		inflateInit(&request->stream);
>  		SHA1_Init(&request->c);

I think this could leak if request->stream already had
something in it, but I do not see anything that is done to it
after it is initialized and the code reaches to this point.

In fact, I suspect that it would make more sense to remove the
earlier memset() that clears request->stream and inflateInit(),
and moving the memset() and inflateInit() we see above out of
that if clause (before checking prev_read).

The same comment applies to the other hunk.

By the way, I was looking at the earlier two series from you
(compress and decompress), and noticed some of them were corrupt
with linewrap.  As I think they are good clean-up patches, I'd
like to apply them as one of the first series post 1.5.4.  As
such, this request is not urgent at all, but please resend with
a clean-up when 'master'/'next' reopens.

Thanks.

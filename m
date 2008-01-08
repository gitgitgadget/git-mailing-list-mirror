From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sideband.c: Use xmalloc() instead of variable-sized arrays.
Date: Tue, 08 Jan 2008 09:41:26 -0800
Message-ID: <7v4pdotdtl.fsf@gitster.siamese.dyndns.org>
References: <4783A3B2.3060801@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 08 18:42:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCISn-0008TP-KR
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 18:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbYAHRlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 12:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752246AbYAHRlm
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 12:41:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38696 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbYAHRll (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 12:41:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 28B5783B8;
	Tue,  8 Jan 2008 12:41:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C31A283AF;
	Tue,  8 Jan 2008 12:41:34 -0500 (EST)
In-Reply-To: <4783A3B2.3060801@viscovery.net> (Johannes Sixt's message of
	"Tue, 08 Jan 2008 17:24:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69898>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <johannes.sixt@telecom.at>
>
> How come we got along with this not very portable construct for so long?
> Probably because the array sizes were computed from the results of
> strlen() of string constants. Anyway, a follow-up patch will make the
> lengths really non-constant.
>
> Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
>  sideband.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/sideband.c b/sideband.c
> index 756bbc2..513d7b3 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -19,7 +19,10 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
>  {
>  	unsigned pf = strlen(PREFIX);
>  	unsigned sf = strlen(SUFFIX);
> -	char buf[pf + LARGE_PACKET_MAX + sf + 1];
> +	char *buf, *save;
> +
> +	save = xmalloc(sf);
> +	buf = xmalloc(pf + LARGE_PACKET_MAX + sf + 1);

I have to wonder if the malloc() overhead is small enough
compared to the network bandwidth to make a two malloc-free
pairs per packet a non-issue...

From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [msysGit] [PATCH 03/12] MinGW: Convert CR/LF to LF in tag signatures
Date: Wed, 2 Jul 2008 20:46:28 +0200
Message-ID: <200807022046.28141.johannes.sixt@telecom.at>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <1214987532-23640-3-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: prohaska@zib.de
X-From: git-owner@vger.kernel.org Wed Jul 02 20:47:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE7MV-0008O2-Mw
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 20:47:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbYGBSqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 14:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbYGBSqa
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 14:46:30 -0400
Received: from smtp3.srv.eunet.at ([193.154.160.89]:59191 "EHLO
	smtp3.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452AbYGBSq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 14:46:29 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp3.srv.eunet.at (Postfix) with ESMTP id 707DA10A790;
	Wed,  2 Jul 2008 20:46:28 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3B6001CA45;
	Wed,  2 Jul 2008 20:46:28 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <1214987532-23640-3-git-send-email-prohaska@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87178>

On Mittwoch, 2. Juli 2008, Steffen Prohaska wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On Windows, gpg outputs CR/LF signatures.  But since the tag
> messages are already stripped of the CR by stripspace(), it is
> arguably nicer to do the same for the tag signature.  Actually,
> this patch does not look for CR/LF, but strips all CRs
> from the signature.
>
> [ spr: ported code to use strbuf ]
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>
> ---
>  builtin-tag.c |   14 ++++++++++++++
>  1 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/builtin-tag.c b/builtin-tag.c
> index e675206..77977ba 100644
> --- a/builtin-tag.c
> +++ b/builtin-tag.c
> @@ -241,6 +241,20 @@ static int do_sign(struct strbuf *buffer)
>  	if (finish_command(&gpg) || !len || len < 0)
>  		return error("gpg failed to sign the tag");
>
> +#ifdef __MINGW32__
> +	/* strip CR from the line endings */
> +	{
> +		int i, j;
> +		for (i = j = 0; i < buffer->len; i++)
> +			if (buffer->buf[i] != '\r') {
> +				if (i != j)
> +					buffer->buf[j] = buffer->buf[i];
> +				j++;
> +			}
> +		strbuf_setlen(buffer, j);
> +	}
> +#endif
> +
>  	return 0;
>  }

Do we need the #ifdef __MINGW32__? Can't we just strip CRs unconditionally? It 
shouldn't hurt on Unix anyway.

-- Hannes

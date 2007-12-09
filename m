From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix off-by-one error: don't read the byte before a malloc'd buffer.
Date: Sun, 09 Dec 2007 10:15:34 -0800
Message-ID: <7vsl2bpwe1.fsf@gitster.siamese.dyndns.org>
References: <87hcitgpca.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sun Dec 09 19:16:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1QhI-0001TL-D0
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 19:16:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbXLISPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 13:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbXLISPv
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 13:15:51 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:38112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbXLISPu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 13:15:50 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 19E3B5B9D;
	Sun,  9 Dec 2007 13:15:45 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ACC05B9C;
	Sun,  9 Dec 2007 13:15:41 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67640>

Jim Meyering <jim@meyering.net> writes:

> * config.c (store_write_pair): Don't read value[-1].
>
> Signed-off-by: Jim Meyering <meyering@redhat.com>
> ---
>  config.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/config.c b/config.c
> index ed96213..6031b38 100644
> --- a/config.c
> +++ b/config.c
> @@ -652,7 +652,7 @@ static int store_write_pair(int fd, const char* key, const char* value)
>  	for (i = 0; value[i]; i++)
>  		if (value[i] == ';' || value[i] == '#')
>  			quote = 1;
> -	if (value[i-1] == ' ')
> +	if (i && value[i-1] == ' ')
>  		quote = 1;
>
>  	if (write_in_full(fd, "\t", 1) != 1 ||

Thanks.

The fix may be correct but the comment above the part the patch fixes is
very misleading and I wasted a few minutes checking to see what it is
doing is correct.

The "quote" variable does not really control quoting; the quoting with
backslash is always done for the value, and this check is about adding a
dq pair around it, so that the parser does not lose leading or trailing
SP or string after start-of-comment marker characters.

From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Files with colons under Cygwin
Date: Mon, 06 Oct 2008 08:54:44 +0200
Message-ID: <48E9B634.6040909@viscovery.net>
References: <c475e2e60810020702q573570dcp31a5dc18bf98ef30@mail.gmail.com> <20081004233945.GM21650@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Giovanni Funchal <gafunchal@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 08:58:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmk2t-0005BD-RU
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 08:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbYJFGyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2008 02:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751574AbYJFGyr
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 02:54:47 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42707 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356AbYJFGyr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2008 02:54:47 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KmjzQ-0003nj-MN; Mon, 06 Oct 2008 08:54:44 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 600BC4FB; Mon,  6 Oct 2008 08:54:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081004233945.GM21650@dpotapov.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97565>

Dmitry Potapov schrieb:
> Subject: [PATCH] correct verify_path for Windows
> 
> Colon and backslash in names may be used on Windows to overwrite files
> outside of the working directory.
> 
> Signed-off-by: Dmitry Potapov <dpotapov@gmail.com>
> ---
>  read-cache.c |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 901064b..972592e 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -701,6 +701,16 @@ inside:
>  			}
>  			return 0;
>  		}
> +#if defined(_WIN32) || defined(__CYGWIN__)
> +		/*
> +		 * There is a bunch of other characters that are not allowed
> +		 * in Win32 API, but the following two create a security hole
> +		 * by allowing to overwrite files outside of the working tree,
> +		 * therefore they are explicitly prohibited.
> +		 */
> +		else if (c == ':' || c == '\\')
> +			return 0;
> +#endif
>  		c = *path++;
>  	}
>  }

IIUC, verify_path() checks paths that were found in the database or the
index. As such, it checks for the integrity of the database. And paths
with backslashes or colons certainly do not violate the database integrity.

More precisely, the exchange of path names between the index and tree
objects (both directions) should not do this new check, nor if a path is
added to the index. The check is only meaningful[*] when a path is read
from the index or a tree object and "applied" to the working directory.
Unfortunately, I think there are lots of places where this happens.

[*] I say "meaningful" and not "necessary" because the situation is just
like when you grab some random SoftwarePackage.tar.gz, and run ./configure
without looking first what it is going to do.

-- Hannes

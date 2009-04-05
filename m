From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] replace_object: use the new generic "sha1_pos"
 function to lookup sha1
Date: Sun, 5 Apr 2009 15:19:25 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904051516170.10279@pacific.mpi-cbg.de>
References: <20090404225941.7fef76a7.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 15:20:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqSGX-0004LK-Hn
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 15:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754336AbZDENRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 09:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286AbZDENQ7
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 09:16:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:44697 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751369AbZDENQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 09:16:59 -0400
Received: (qmail invoked by alias); 05 Apr 2009 13:16:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 05 Apr 2009 15:16:56 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Y9KoFx/UYlEV4erYMT/NTvECpEcmoks+u+tOuAx
	WtfMXltYTV5Dd2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090404225941.7fef76a7.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115663>

Hi,

On Sat, 4 Apr 2009, Christian Couder wrote:

> instead of the specific one that was simpler but less efficient.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  replace_object.c |   24 +++++++++---------------
>  1 files changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/replace_object.c b/replace_object.c
> index 1227214..eb59604 100644
> --- a/replace_object.c
> +++ b/replace_object.c
> @@ -1,4 +1,5 @@
>  #include "cache.h"
> +#include "sha1-lookup.h"
>  #include "refs.h"
>  
>  static struct replace_object {
> @@ -7,23 +8,16 @@ static struct replace_object {
>  
>  static int replace_object_alloc, replace_object_nr;
>  
> +static const unsigned char *replace_sha1_access(size_t index, void *table)
> +{
> +	struct replace_object **replace = table;
> +	return replace[index]->sha1[0];
> +}

I have to agree with Junio that this is potentially slowing down things, 
as there is an additional redirection layer here.

If the tables are not too large, I'd prefer using a

	struct sha1_list_entry {
		unsigned char *sha1;
		void *object;
	};

Hmm.

Ciao,
Dscho

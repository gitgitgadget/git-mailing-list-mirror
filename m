From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] Off-by-one error in get_path_prefix(), found by Valgrind
Date: Wed, 7 Jun 2006 20:05:43 +0200
Message-ID: <20060607180543.GA26638@lsrfire.ath.cx>
References: <20060607170140.13372.64613.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 07 20:06:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fo2Pe-0008ON-4S
	for gcvg-git@gmane.org; Wed, 07 Jun 2006 20:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWFGSFp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Jun 2006 14:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbWFGSFp
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jun 2006 14:05:45 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:6594
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1751184AbWFGSFo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jun 2006 14:05:44 -0400
Received: by neapel230.server4you.de (Postfix, from userid 1000)
	id 90BCE14012; Wed,  7 Jun 2006 20:05:43 +0200 (CEST)
To: Pavel Roskin <proski@gnu.org>, Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060607170140.13372.64613.stgit@dv.roinet.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21446>

On Wed, Jun 07, 2006 at 01:01:40PM -0400, Pavel Roskin wrote:
> From: Pavel Roskin <proski@gnu.org>
> 
> Signed-off-by: Pavel Roskin <proski@gnu.org>
> ---
> 
>  builtin-tar-tree.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
> index 5f740cf..05da1f2 100644
> --- a/builtin-tar-tree.c
> +++ b/builtin-tar-tree.c
> @@ -166,8 +166,8 @@ static unsigned int ustar_header_chksum(
>  static int get_path_prefix(const struct strbuf *path, int maxlen)
>  {
>  	int i = path->len;
> -	if (i > maxlen)
> -		i = maxlen;
> +	if (i >= maxlen)
> +		i = maxlen - 1;
>  	while (i > 0 && path->buf[i] != '/')
>  		i--;
>  	return i;

Argh, yes.  Thanks, Pavel!  However, the other branch is incorrect, too:
accessing path->buf[path->len] is wrong, even if it's within the buffer.
In order to use a length variable to point to the end of some string we
need to subtract 1. *sigh*  So, how about this one instead?

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>

diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index 5f740cf..7663b9b 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -168,8 +168,9 @@ static int get_path_prefix(const struct 
 	int i = path->len;
 	if (i > maxlen)
 		i = maxlen;
-	while (i > 0 && path->buf[i] != '/')
+	do {
 		i--;
+	} while (i > 0 && path->buf[i] != '/');
 	return i;
 }
 

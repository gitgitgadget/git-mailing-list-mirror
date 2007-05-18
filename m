From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 12/16] builtin-fetch--tool: extend "native-store" for use in cloning
Date: Sat, 19 May 2007 00:52:34 +0200
Message-ID: <20070518225234.GI10475@steel.home>
References: <11795163053812-git-send-email-skimo@liacs.nl> <11795163072266-git-send-email-skimo@liacs.nl>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Sat May 19 00:52:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpBJS-0008V1-MZ
	for gcvg-git@gmane.org; Sat, 19 May 2007 00:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545AbXERWwi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 18:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755721AbXERWwh
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 18:52:37 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:48510 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755107AbXERWwh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 18:52:37 -0400
Received: from tigra.home (Fc8ca.f.strato-dslnet.de [195.4.200.202])
	by post.webmailer.de (klopstock mo13) (RZmta 6.5)
	with ESMTP id A046baj4IMNleW ; Sat, 19 May 2007 00:52:35 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 83BFD277BD;
	Sat, 19 May 2007 00:52:35 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 151E7D195; Sat, 19 May 2007 00:52:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11795163072266-git-send-email-skimo@liacs.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaEWow0t1E=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47675>

skimo@liacs.nl, Fri, May 18, 2007 21:25:01 +0200:
> @@ -261,7 +287,8 @@ static int fetch_native_store(FILE *fp,
>  			      const char *remote,
>  			      const char *remote_nick,
>  			      const char *refs,
> -			      int verbose, int force)
> +			      int verbose, int force,
> +			      int all, int use_separate_remote)
>  {
>  	char buffer[1024];
>  	int err = 0;
> @@ -294,8 +321,12 @@ static int fetch_native_store(FILE *fp,
>  			continue;
>  		}
>  
> -		local_name = find_local_name(cp, refs,
> -					     &single_force, &not_for_merge);
> +		if (all)
> +			local_name = construct_local_name(cp, remote_nick,
> +							  use_separate_remote);
> +		else
> +			local_name = find_local_name(cp, refs,
> +						     &single_force, &not_for_merge);

This code produces warning about possible uninitialized used of
single_force and not_for_merge. I used the patch below, but didn't
look into what the "all" does.

---
 builtin-fetch--tool.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-fetch--tool.c b/builtin-fetch--tool.c
index 12adb38..ebb49d9 100644
--- a/builtin-fetch--tool.c
+++ b/builtin-fetch--tool.c
@@ -273,7 +273,7 @@ static int fetch_native_store(FILE *fp,
 		int len;
 		char *cp;
 		char *local_name;
-		int single_force, not_for_merge;
+		int single_force = force, not_for_merge = 0;
 
 		for (cp = buffer; *cp && !isspace(*cp); cp++)
 			;
@@ -301,7 +301,7 @@ static int fetch_native_store(FILE *fp,
 		err |= append_fetch_head(fp,
 					 buffer, remote, cp, remote_nick,
 					 local_name, not_for_merge,
-					 verbose, force || single_force);
+					 verbose, single_force);
 	}
 	return err;
 }
-- 
1.5.2.rc3.83.gbbb0

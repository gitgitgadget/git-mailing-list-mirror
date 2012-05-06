From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] help.c::uniq: plug a leak
Date: Sun, 6 May 2012 04:12:14 -0400
Message-ID: <20120506081213.GA27878@sigill.intra.peff.net>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
 <1336287330-7215-2-git-send-email-rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 10:13:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQwaX-0004Og-0B
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 10:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab2EFIMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 May 2012 04:12:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59390
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148Ab2EFIMU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 May 2012 04:12:20 -0400
Received: (qmail 7478 invoked by uid 107); 6 May 2012 08:12:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 06 May 2012 04:12:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 May 2012 04:12:14 -0400
Content-Disposition: inline
In-Reply-To: <1336287330-7215-2-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197155>

On Sun, May 06, 2012 at 02:55:27PM +0800, Tay Ray Chuan wrote:

>  static void uniq(struct cmdnames *cmds)
>  {
> -	int i, j;
> +	int i, j, c = 0;
>  
>  	if (!cmds->cnt)
>  		return;
>  
>  	for (i = j = 1; i < cmds->cnt; i++)
> -		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
> +		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name)) {
> +
> +			/* The i-1 entry was the cth duplicate
> +			 * Guarantees c=0
> +			 */
> +			for (; c >= 1; c--)
> +				free(cmds->names[i - c]);
> +
>  			cmds->names[j++] = cmds->names[i];
> +		} else {
> +			c++;
> +		}
>  
>  	cmds->cnt = j;
>  }

Freeing the strings at the end of each run of duplicates is confusing to
read. And your implementation is buggy: if there are duplicates at the
very end of the list, you would never free them (you would need to check
'c' again at the end of the loop).

I think you avoided freeing as you go because that invalidates the i-1
element that we use in the comparison. However, we can observe that the
j-1 element can serve the same purpose, as it is either:

  1. Exactly i-1, when the loop begins (and until we see a duplicate).

  2. The same pointer that was stored at i-1 (if it was not a duplicate,
     and we just copied it into place).

  3. A pointer to an equivalent string (i.e., we rejected i-1 _because_
     it was identical to j-1).

So this shorter patch should be sufficient (though I didn't actually
test it):

diff --git a/help.c b/help.c
index 69d483d..d3868b3 100644
--- a/help.c
+++ b/help.c
@@ -43,9 +43,12 @@ static void uniq(struct cmdnames *cmds)
 	if (!cmds->cnt)
 		return;
 
-	for (i = j = 1; i < cmds->cnt; i++)
-		if (strcmp(cmds->names[i]->name, cmds->names[i-1]->name))
+	for (i = j = 1; i < cmds->cnt; i++) {
+		if (!strcmp(cmds->names[i]->name, cmds->names[j-1]->name))
+			free(cmds->names[i]);
+		else
 			cmds->names[j++] = cmds->names[i];
+	}
 
 	cmds->cnt = j;
 }

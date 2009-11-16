From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] http-backend: Fix access beyond end of string.
Date: Sun, 15 Nov 2009 17:36:54 -0800
Message-ID: <20091116013654.GX11919@spearce.org>
References: <1258233058-2348-1-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tarmigan Casebolt <tarmigan+git@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 02:37:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9qWa-0002EE-AI
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 02:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbZKPBgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 20:36:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751729AbZKPBgt
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 20:36:49 -0500
Received: from george.spearce.org ([209.20.77.23]:56630 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305AbZKPBgs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 20:36:48 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3E20E381D5; Mon, 16 Nov 2009 01:36:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1258233058-2348-1-git-send-email-tarmigan+git@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132980>

Tarmigan Casebolt <tarmigan+git@gmail.com> wrote:
> diff --git a/http-backend.c b/http-backend.c
> index f8ea9d7..ab9433d 100644
> --- a/http-backend.c
> +++ b/http-backend.c
> @@ -634,7 +634,7 @@ int main(int argc, char **argv)
>  			cmd = c;
>  			cmd_arg = xmalloc(n);
>  			strncpy(cmd_arg, dir + out[0].rm_so + 1, n);
> -			cmd_arg[n] = '\0';
> +			cmd_arg[n-1] = '\0';
>  			dir[out[0].rm_so] = 0;
>  			break;

Shouldn't this instead be:

diff --git a/http-backend.c b/http-backend.c
index 9021266..16ec635 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -626,7 +626,7 @@ int main(int argc, char **argv)
 			}
 
 			cmd = c;
-			cmd_arg = xmalloc(n);
+			cmd_arg = xmalloc(n + 1);
 			strncpy(cmd_arg, dir + out[0].rm_so + 1, n);
 			cmd_arg[n] = '\0';
 			dir[out[0].rm_so] = 0;

The cmd_arg string was simply allocated too small.  Your fix is
terminating the string one character too short which would cause
get_loose_object and get_pack_file to break.

-- 
Shawn.

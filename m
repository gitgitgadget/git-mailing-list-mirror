From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] filter-branch: Grok special characters in tag names
Date: Thu, 21 Aug 2008 11:38:20 -0500
Message-ID: <NWVPkDIELqWBHTU58gfzDqO8HR575ZDJVO2pYdPMtqv9aBLzMLvyZg@cipher.nrlssc.navy.mil>
References: <1219329911-31620-1-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Aug 21 18:40:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWDCk-0006vW-Bp
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 18:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753049AbYHUQjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 12:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752727AbYHUQjF
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 12:39:05 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40585 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752386AbYHUQjE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 12:39:04 -0400
Received: by mail.nrlssc.navy.mil id m7LGcLlr010694; Thu, 21 Aug 2008 11:38:21 -0500
In-Reply-To: <1219329911-31620-1-git-send-email-johannes.sixt@telecom.at>
X-OriginalArrivalTime: 21 Aug 2008 16:38:20.0743 (UTC) FILETIME=[52568570:01C903AC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93174>

Johannes Sixt wrote:

> diff --git a/git-filter-branch.sh b/git-filter-branch.sh
> index 2688254..81392ad 100755
> --- a/git-filter-branch.sh
> +++ b/git-filter-branch.sh
> @@ -412,15 +412,17 @@ if [ "$filter_tag_name" ]; then
>  		echo "$ref -> $new_ref ($sha1 -> $new_sha1)"
>  
>  		if [ "$type" = "tag" ]; then
> -			new_sha1=$(git cat-file tag "$ref" |
> +			new_sha1=$( ( printf 'object %s\ntype commit\ntag %s\n' \
> +						"$new_sha1" "$new_ref"
> +				git cat-file tag "$ref" |
>  				sed -n \
>  				    -e "1,/^$/{
> -					  s/^object .*/object $new_sha1/
> -					  s/^type .*/type commit/
> -					  s/^tag .*/tag $new_ref/
> +					  /^object /d
> +					  /^type /d
> +					  /^tag /d

Junio complained that my initial version of this was fragile which has
similarities with the above. Initially, I was blindly changing the first line
to contain "object...", second line to "type...", etc.

Would something like the following be equivalent _and_ clearer? Emphasis on "and"
because both are necessary, not because I strongly feel it to be so.

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index a324cf0..11c5c04 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -419,9 +419,12 @@ if [ "$filter_tag_name" ]; then
 			new_sha1=$(git cat-file tag "$ref" |
 				sed -n \
 				    -e "1,/^$/{
-					  s/^object .*/object $new_sha1/
-					  s/^type .*/type commit/
-					  s/^tag .*/tag $new_ref/
+					  /^object .*/c\\
+object $new_sha1
+					  /^type .*/c\\
+type commit
+					  /^tag .*/c\\
+tag $new_ref
 					}" \
 				    -e '/^-----BEGIN PGP SIGNATURE-----/q' \
 				    -e 'p' |


-brandon

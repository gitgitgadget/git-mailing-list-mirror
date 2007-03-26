From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] sha1_file.c (write_sha1_from_fd): Detect close failure.
Date: Mon, 26 Mar 2007 13:33:35 -0700
Message-ID: <7v8xdjwxr4.fsf@assigned-by-dhcp.cox.net>
References: <874po8umyk.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 22:33:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVvsq-0005Z7-Gk
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 22:33:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbXCZUdh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 16:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752916AbXCZUdh
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 16:33:37 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:47429 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbXCZUdg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 16:33:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326203336.PWDC22511.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 16:33:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fYZb1W00N1kojtg0000000; Mon, 26 Mar 2007 16:33:36 -0400
In-Reply-To: <874po8umyk.fsf@rho.meyering.net> (Jim Meyering's message of
	"Mon, 26 Mar 2007 15:57:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43181>

Jim Meyering <jim@meyering.net> writes:

> I stumbled across this in the context of the fchmod 0444 patch.
> At first, I was going to unlink and call error like the two subsequent
> tests do, but a failed write (above) provokes a "die", so I made
> this do the same.  This is testing for a write failure, after all.
>
> Signed-off-by: Jim Meyering <jim@meyering.net>
> ---
>  sha1_file.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 0897b94..42aef33 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2155,7 +2155,8 @@ int write_sha1_from_fd(const unsigned char *sha1, int fd, char *buffer,
>  	inflateEnd(&stream);
>
>  	fchmod(local, 0444);
> -	close(local);
> +	if (close(local) != 0)
> +		die("unable to write sha1 file");
>  	SHA1_Final(real_sha1, &c);
>  	if (ret != Z_STREAM_END) {
>  		unlink(tmpfile);
> --
> 1.5.1.rc1.51.gb08b

Hmph.  Not catching error from close() is wrong, so this is an
improvement, but it still leaves tmpfile on the filesystem,
doesn't it?

Looking at write_sha1_file(), which is in a sense more important
than this function, it is worse.  We should also detect error
from close(), nuke the temporary file and return an error there.

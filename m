From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Correct dir.c to compile on Solaris 9
Date: Sun, 15 Apr 2007 15:48:52 -0700
Message-ID: <7vbqhp2qzv.fsf@assigned-by-dhcp.cox.net>
References: <20070415043328.GA17285@spearce.org>
	<Pine.LNX.4.64.0704151824240.18846@racer.site>
	<200704152303.12435.Josef.Weidendorfer@gmx.de>
	<200704152354.55097.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 00:49:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdDXE-0006Ha-SG
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 00:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbXDOWsz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 18:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754034AbXDOWsy
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 18:48:54 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:39063 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754033AbXDOWsy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 18:48:54 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415224854.IBNR1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 18:48:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id naos1W00t1kojtg0000000; Sun, 15 Apr 2007 18:48:53 -0400
In-Reply-To: <200704152354.55097.robin.rosenberg.lists@dewire.com> (Robin
	Rosenberg's message of "Sun, 15 Apr 2007 23:54:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44536>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> The table lookup *is* faster (meastured), but that doesn't make a big difference
> on the total CPU used. The muliple-case-per line thing (both versions, however makes is hard
> to read.  
>
> -- robin
>
> diff --git a/dir.c b/dir.c
> index 7426fde..0780f23 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -423,12 +423,22 @@ static int cmp_name(const void *p1, const void *p2)
>   */
>  static int simple_length(const char *match)
>  {
> -       const char special[256] = {
> -               [0] = 1, ['?'] = 1,
> -               ['\\'] = 1, ['*'] = 1,
> -               ['['] = 1
> -       };
>         int len = -1;
> +       static const char special[256] = {
> +               1,0,0,0,0,0,0,0, /* nul */
> +               0,0,0,0,0,0,0,0,
> +               0,0,0,0,0,0,0,0,
> +               0,0,0,0,0,0,0,0,
> +               0,0,0,0,0,0,0,0,
> +               0,0,1,0,0,0,0,0, /* * */

I wonder if folding this into ctype.c::sane_ctype[] is an
option...

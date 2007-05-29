From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rev-parse: Identify short sha1 sums correctly.
Date: Tue, 29 May 2007 16:40:37 -0700
Message-ID: <7vabvn5hca.fsf@assigned-by-dhcp.cox.net>
References: <1180478596243-git-send-email-jbowes@dangerouslyinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed May 30 01:41:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtBJi-0001iO-Su
	for gcvg-git@gmane.org; Wed, 30 May 2007 01:41:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbXE2Xkk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 19:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbXE2Xkk
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 19:40:40 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:34258 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102AbXE2Xkj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 19:40:39 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070529234037.VSCW13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Tue, 29 May 2007 19:40:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5Bgd1X00S1kojtg0000000; Tue, 29 May 2007 19:40:38 -0400
cc: James Bowes <jbowes@dangerouslyinc.com>
In-Reply-To: <1180478596243-git-send-email-jbowes@dangerouslyinc.com> (James
	Bowes's message of "Tue, 29 May 2007 18:43:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48714>

James Bowes <jbowes@dangerouslyinc.com> writes:

> find_short_packed_object was not loading the pack index files.
> Teach it to do so.
>
> Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>

I think this is the proper fix of the problem I was unhappy
about with 'next', rather than reverting the lazy index
loading.  But I wonder how many _other_ places like this there
are that we might be missing...

Shawn, an Ack, and any ideas for futureproofing?

>  sha1_name.c |    7 +++++--
>  1 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 8dfceb2..7df01af 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -76,8 +76,11 @@ static int find_short_packed_object(int len, const unsigned char *match, unsigne
>  
>  	prepare_packed_git();
>  	for (p = packed_git; p && found < 2; p = p->next) {
> -		uint32_t num = p->num_objects;
> -		uint32_t first = 0, last = num;
> +		uint32_t num, last;
> +		uint32_t first = 0;
> +		open_pack_index(p);
> +		num = p->num_objects;
> +		last = num;
>  		while (first < last) {
>  			uint32_t mid = (first + last) / 2;
>  			const unsigned char *now;
> -- 
> 1.5.2.869.g6b3ba

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Move remote parsing into a library file out of builtin-push.
Date: Sat, 12 May 2007 00:51:08 -0700
Message-ID: <7v3b225vkj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705112238260.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat May 12 09:51:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmmNo-0003WA-Ay
	for gcvg-git@gmane.org; Sat, 12 May 2007 09:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755931AbXELHvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 03:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756658AbXELHvK
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 03:51:10 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:45581 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931AbXELHvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 03:51:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070512075110.YXKY26353.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sat, 12 May 2007 03:51:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id y7r71W00D1kojtg0000000; Sat, 12 May 2007 03:51:08 -0400
In-Reply-To: <Pine.LNX.4.64.0705112238260.18541@iabervon.org> (Daniel
	Barkalow's message of "Fri, 11 May 2007 22:39:23 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47027>

Daniel Barkalow <barkalow@iabervon.org> writes:

> The new parser is different from the one in builtin-push in two ways:
> the default is to use the current branch's remote, if there is one,
> before "origin"; and config is used in preference to remotes.

Please chuck my comment about describing differences in the
previous message---you did it already.  Sorry.

> diff --git a/remote.c b/remote.c
> new file mode 100644
> index 0000000..1dd2e77
> --- /dev/null
> +++ b/remote.c
> @@ -0,0 +1,203 @@
> +#include "cache.h"
> +#include "remote.h"
> +#include "refs.h"
> +
> +static struct remote **remotes;
> +static int allocated_remotes;
> +
> +#define BUF_SIZE (2084)
> +static char buffer[BUF_SIZE];

Heh, inherited a funny constant from the original...  I guess
most likely he meant 2048 ;-).

> +static void read_remotes_file(struct remote *remote)
> +{
> +	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
> +
> +	if (!f)
> +		return;
> +	while (fgets(buffer, BUF_SIZE, f)) {
> +...
> +	}
> +}

I sense a slight "FILE *" leak here...

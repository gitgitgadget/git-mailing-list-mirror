From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 2/2] annotate: Fix bug when parsing merges with differing real and logical parents.
Date: Mon, 7 Aug 2006 12:45:40 -0700
Message-ID: <20060807194539.GD15477@h4x0r5.com>
References: <20060807115000.GC15477@h4x0r5.com> <1154952684908-git-send-email-ryan@michonline.com> <11549526841904-git-send-email-ryan@michonline.com> <7virl42w6s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 21:47:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GAB3p-0001SG-6I
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 21:46:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWHGTqq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 15:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWHGTqq
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 15:46:46 -0400
Received: from h4x0r5.com ([70.85.31.202]:55306 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S932325AbWHGTqp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Aug 2006 15:46:45 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1GAB2i-0002ml-TV; Mon, 07 Aug 2006 12:45:40 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virl42w6s.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25035>

On Mon, Aug 07, 2006 at 12:16:27PM -0700, Junio C Hamano wrote:
> This does stop it from dying on Jeff King's bug report
> (<20060803203848.GA15121@coredump.intra.peff.net>) to annotate
> builtin-read-tree.c.  However,...
> 
> Comparing output between "annotate" and "blame -c" on the same
> file shows a rather interesting differences.

Yes, annotate is still mis-attributing things to merges that it should
not.  I was kind of hoping this fix would have a side-effect of fixing
it, but I had no logical reason to think it would.   I'm going to try
again at fixing it later this week, maybe the weekend, but I'm starting
to think that maybe blame has won. :)

> 
> (1) "annotate" blames the first line "/*" to d147e501 made on
>     2006-05-23, while "blame" annotates it with 8bc9a0c7 made on
>     2005-04-07.  As far as I remember this line has never been
>     touched by anybody during the life of the file, so the
>     latter sounds more plausible.
> 
> (2) The 13th line to #include "cache-tree.h" is blamed on
>     3f69d405 by "annotate", while annotation by "blame" reads
>     that it came from bad68ec9.
> 
>     3f69d405 is a merge to incorporate the line into "master"
>     branch.  "git show -M 3f69d405 -- builtin-read-tree.c read-tree.c"
>     starts with:
> 
>         diff --cc builtin-read-tree.c
>         index ec40d01,99e7c75..716f792
>         --- a/builtin-read-tree.c
>         +++ b/builtin-read-tree.c
>         @@@ -9,9 -9,9 +9,10 @@@
> 
>           #include "object.h"
>           #include "tree.h"
>         + #include "cache-tree.h"
> 	  #include <sys/time.h>
> 
>     Which means the line is new from the point of view of the
>     "master" branch, but existed in the branch that this commit
>     merges from (namely, jc/cache-tree) already.
> 
>     "git show -M bad68ec9 -- read-tree.c" shows that it is the
>     one that added the #include line to the history.
> 
> (3) The 14th line to #include <sys/time.h> is blamed on d147e501
>     by "annotate" but "blame" says it came from 744633cb.  It is
>     obvious the latter is correct, if you look at "git show" on
>     these commits.  The eye-candy was what made <sys/time.h>
>     necessary (it needed to do the progress-signal stuff).
> 
> In fact, "annotate" attributes too many lines to d147e501 (839
> lines).
> 
> Given that "git show -M d147e501 -- read-tree.c builtin-read-tree.c"
> shows only 2 insertions and 1 deletion, it does not sound
> right.  The commit adds #include "builtin.h" and changes the
> function name "main" to "cmd_read_tree".
> 
> On the other hand, "blame" attributes only 1 line to this
> commit; the line to #include "builtin.h".  The other change this
> commit introduces (main -> cmd_read_tree) is not counted because
> the third parameter to the function changes after this commit by
> a91af794 (which, by the way, both "annotate" and "blame" get
> right), and the line this commit introduces did not survive.
> 
> 
> 

-- 

Ryan Anderson
  sometimes Pug Majere

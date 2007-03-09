From: "=?ISO-8859-1?Q?Ilpo_J=E4rvinen?=" <ilpo.jarvinen@helsinki.fi>
Subject: Re: Diff output from a rewrite of a function
Date: Fri, 9 Mar 2007 10:39:41 +0200 (EET)
Message-ID: <Pine.LNX.4.64.0703090927310.22648@kivilampi-30.cs.helsinki.fi>
References: <Pine.LNX.4.64.0703082049060.19974@kivilampi-30.cs.helsinki.fi>
 <200703082301.35774.robin.rosenberg.lists@dewire.com>
 <7vbqj38gkp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 09 09:39:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPadm-0000c0-HR
	for gcvg-git@gmane.org; Fri, 09 Mar 2007 09:39:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993087AbXCIIjr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 03:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993085AbXCIIjr
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 03:39:47 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:41352 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993087AbXCIIjn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 03:39:43 -0500
Received: from kivilampi-30.cs.helsinki.fi (kivilampi-30.cs.helsinki.fi [128.214.9.42])
  (AUTH: PLAIN cs-relay, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by mail.cs.helsinki.fi with esmtp; Fri, 09 Mar 2007 10:39:41 +0200
  id 000601DA.45F11D4D.00002804
Received: by kivilampi-30.cs.helsinki.fi (Postfix, from userid 50795)
	id C2261EB365; Fri,  9 Mar 2007 10:39:41 +0200 (EET)
Received: from localhost (localhost [127.0.0.1])
	by kivilampi-30.cs.helsinki.fi (Postfix) with ESMTP id BED38EB364;
	Fri,  9 Mar 2007 10:39:41 +0200 (EET)
X-X-Sender: ijjarvin@kivilampi-30.cs.helsinki.fi
In-Reply-To: <7vbqj38gkp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41789>

On Thu, 8 Mar 2007, Junio C Hamano wrote:

> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> 
> > Increase the context size from the default three lines.  Something like
> > diff -U 7 old new will require larger chunks of unchanged code for diff
> > break up a hunk. With git you can do 
> >
> > GIT_DIFF_OPTS=-u7 git-diff-....
> 
> I think you can say "git diff -U7" to do what you are
> describing, but I do not think that does what you want. 

Tested both and as you predicted. It didn't do the trick... Tested even 
with 70... :-)

> I think what you want is a "negative context", which says "do not
> consider group of lines less than N lines as matching between
> preimage and postimage".  What Ilpo wants is to see something
> like this:
> 
> -	Deleted 1
> -	Deleted 2
> -	Deleted 3
> ...
> -	Deleted 400
> +	Added 1
> +	Added 2
> +	Added 3
> ...
> +	Added 500
> 	/* happens to match because this was left intact,too */
> -	Deleted 401
> -	Deleted 402
> -	Deleted 403
> +	Added 501
> 
> as if the small context lines that happen to match are also part
> of the change, like this:
> 
> -	Deleted 1
> -	Deleted 2
> -	Deleted 3
> ...
> -	Deleted 400
> -	/* happens to match because this was left intact,too */
> -	Deleted 401
> -	Deleted 402
> -	Deleted 403
> +	Added 1
> +	Added 2
> +	Added 3
> ...
> +	Added 500
> +	/* happens to match because this was left intact,too */
> +	Added 501

Yes, you are showing here exactly what I meant. IMHO the latter would be 
easier for everyone, especially for the review in mailinglists. It's very 
hard to find the correct part to comment from the messed up output, and in 
the worst case that could be split to two blocks anyway and then there 
will be deleted lines between the addition of the lines. Besides, the 
latter would describe the nature of the change much better rather than 
trying to be "too intelligent"... :-)

Though I guess that when the change is included to any repository (don't 
know enough about git internals to know for sure though), it will again 
perplex everyone looking it from the history because the diff tries again 
to be that intelligent :-)? So in the simplest format this is kind of 
helper for review only but that's the most important thing as commit 
message could then include a note or so that anyone who really wants, can 
create a better diff manually with correct options or whatever is 
required for that.

Main problem seems to be empty lines which you basically have in almost 
any code (or at least ought to have some of them in any non-trivial code) 
and they're always identical unless bad spacing exists. As I noted earlier 
also block closing lines and keywords seem the create identical lines 
easily even when you don't have any relation between the code in the 
different versions. It is quite common to say in any code:
		}
	}
or:
		break;
or:
		} else {
etc.

Four lines seem to be the largest I have but that's in the end of a 
function so it wouldn't be a big deal (as there are no deleted lines after 
that point). Here is a distribution of the synchronization (match) point 
sizes for a real change (the previous but quite similar version of the 
diff is available on netdev of linux kernel if somebody is that interested 
about it):
ijjarvin@glomgold-39:~$ sort tmp/syncpoints | uniq -c
     11 1
      5 2
      1 3
      1 4
ijjarvin@glomgold-39:~$ git-diff --stat HEAD^^ HEAD^ net/ipv4/tcp_input.c
 net/ipv4/tcp_input.c |  218 +++++++++++++++++++++++++++++++++++---------------
 1 files changed, 153 insertions(+), 65 deletions(-)
ijjarvin@kivilampi-30:~/work/src/submit$

Two of the syncpoints with length of two (and the four lines closing 
thingie) might be considered as ok. The intention of the new and old code 
is to do the same thing but using a totally different algorithm, and those 
two twoline blocks actually do logically the same thing, others do not, 
but due to language keywords and structure, they match. Though, I would 
not mind if a better diff output couldn't then keep those two lines as 
from original.

I could have tried to move the relevant functions to another place in the 
file but that's sort of hackish approach to a problem I hope my tools 
would be able to do if I ask it to (not sure if moving them would have 
worked anyway)...

Or alternatively doing a script that creates garbage after each line in 
the modified functions and then removes the garbage from the diff output 
or so... ;-)


I assume it is not possible currently since you didn't suggest anything?


-- 
 i.

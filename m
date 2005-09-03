From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Moved files and merges
Date: Sat, 3 Sep 2005 20:06:54 +0200
Message-ID: <20050903180654.GB2314@c165.ib.student.liu.se>
References: <4318E754.9000703@zytor.com> <7vek87djat.fsf@assigned-by-dhcp.cox.net> <7vek867e29.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 03 20:07:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBcQ3-0008Fv-H3
	for gcvg-git@gmane.org; Sat, 03 Sep 2005 20:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVICSHH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 3 Sep 2005 14:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbVICSHH
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Sep 2005 14:07:07 -0400
Received: from [85.8.31.11] ([85.8.31.11]:35268 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751150AbVICSHF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Sep 2005 14:07:05 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 56C354119; Sat,  3 Sep 2005 20:11:23 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EBcPm-0002HX-00; Sat, 03 Sep 2005 20:06:54 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vek867e29.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8041>

On Sat, Sep 03, 2005 at 01:25:50AM -0700, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > "H. Peter Anvin" <hpa@zytor.com> writes:
> >
> >> I currently have two klibc trees,
> >
> > I cloned them to take a look.  You_do_ seem to have a lot of
> > renames.
> 
> Well, I think I understand how your trees ancestry looks like,
> but still haven't come up with a good problem definition.  I am
> sorry that this message is not a solution for your problem but
> would end up to be just my rambling and thinking aloud.
> 
> The ancestry looks like this:
> 
>        ----#4-#5---#7   #0: 1.0.14 released, next version is 1.0.15
>       /      /              5691e96ebfccd21a1f75d3518dd55a96b311d1aa
>      /---#1-#3---#6     #1: Explain why execvpe/execlpe work the way they do.
>     //     /                1d774a8cbd8e8b90759491591987cb509122bd78
>   #0-----#2             #2: 1.1 released, next version is 1.1.1
>                             3a41b60f6730077db3f04cf2874c96a0e53da453
>                         #3: Merge of #2 into #1
>                             7ab38d71de2964129cf1d5bc4e071d103e807a0d
>                         #4: socketcalls aren't always *.S files; they can...
>                             f52be163e684fc3840e557ecf242270926136b67
>                         #5: Merge of #3 into #4
>                             2e2a79d62a96b6b0d4bc93697fe77cd3030cdfd9
>                         #6: Warnings cleanup
>                             f5260f8737517f19a03ee906cd64dfc9930221cd
>                         #7: Remove obsoleted files from merge
>                             59709a172ee58c9d529a8c4b6f5cf53460629cb3
> 
> and you are trying to merge #6 into #7 (or #7 into #6).  #6 does
> not have usr/kinit and nfsmount at the top; #7 has nfsmount
> under usr/kinit/.
> 
> The merge base of #6 and #7 is #3.  #3->#7 involves many renames
> like nfsmount/sunrpc.h -> usr/kinit/nfsmount/sunrpc.h, while
> #3->#6 involves no renames.  This can be seen by 
> 
>        $ git-diff-tree -M --diff-filter=R -r '#3' '#7' | wc -l
> 
> These renames are introduced by #5 merge, whose immediate
> ancestors are #3 and #4.
> 
> Now, there is a question.  When you merge #6 and #7, development
> between #3 and #7 have a lot of renames, while #3 and #6 do not.
> What should this merge do?  Should it follow the rename, and if
> so why?
> 

Maybe I am missing something... but why should the merge operation
ignore renames? Is there a merge case when ignoring renames is the
Right Thing to do?

Lets say the branches A and B has the common ancestor C which contains
a file named "foo". If A has renamed "foo" to "foobar" and B has made
some content changes to "foo" shouldn't the result be a file named
"foobar" with the content changes B made to "foo" in it?

As I see it when we rename 'foo' to 'foobar' we say that "this file
should from now on be named 'foobar'". Furthermore, when we make some
content changes to some file we say "this file should have this new
content instead of its old content". In particular I do not think the
user expresses an intent to keep the name of a file just because she
makes some changes to its contents. So IMHO the merge of "this file
should from now on be named 'foobar'" and "this file should have this
new content instead of its old content" should be "this file should
from now on be named 'foobar' and have this new content".

I think it is feasible to teach the merge machinery about those rename
cases, it probably isn't trivial to implement but I certainly think it
is possible. It may be the case that the user should be warned when
such automatic merges involving renames are performed though.


- Fredrik

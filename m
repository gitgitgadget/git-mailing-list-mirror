From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] git-log (internal): more options.
Date: Wed, 1 Mar 2006 07:43:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0603010730520.22647@g5.osdl.org>
References: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
 <Pine.LNX.4.64.0602281126340.22647@g5.osdl.org> <Pine.LNX.4.64.0602281251390.22647@g5.osdl.org>
 <7vr75nm8cl.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0602281504280.22647@g5.osdl.org>
 <7vbqwqgxo8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 16:44:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FETUO-0007BU-W6
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 16:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWCAPnc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 10:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWCAPnb
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 10:43:31 -0500
Received: from smtp.osdl.org ([65.172.181.4]:28382 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932398AbWCAPna (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Mar 2006 10:43:30 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k21FhRDZ008909
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 1 Mar 2006 07:43:27 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k21FhQfr004079;
	Wed, 1 Mar 2006 07:43:26 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqwqgxo8.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16980>



On Wed, 1 Mar 2006, Junio C Hamano wrote:
>
> This ports the following options from rev-list based git-log
> implementation:
> 
>  * -<n>, -n<n>, and -n <n>.  I am still wondering if we want
>     this natively supported by setup_revisions(), which already
>     takes --max-count.  We may want to move them in the next
>     round.  Also I am not sure if we can get away with not
>     setting revs->limited when we set max-count.  The latest
>     rev-list.c and revision.c in this series do not, so I left
>     them as they are.
> 
>  * --pretty and --pretty=<fmt>.
> 
>  * --abbrev=<n> and --no-abbrev.

Looks good.

I _suspect_ that we want to handle them all in setup_revision(), but I 
wasn't sure, so I left them in rev-list.c originally.

Most helpers that want a list of commits probably want the printing 
options too, and the ones that do not probably simply don't care (ie if 
they silently pass a "--pretty=raw" without it affecting anything, who 
really cares?)

> The previous commit already handles time-based limiters
> (--since, --until and friends).  The remaining things that
> rev-list based git-log happens to do are not useful in a pure
> log-viewing purposes, and not ported:
> 
>  * --bisect (obviously).
> 
>  * --header.  I am actually in favor of doing the NUL
>    terminated record format, but rev-list based one always
>    passed --pretty, which defeated this option.  Maybe next
>    round.
> 
>  * --parents.  I do not think of a reason a log viewer wants
>    this.  The flag is primarily for feeding squashed history
>    via pipe to downstream tools.

I can actually imagine using "--parents" as a way of parsing both the 
commit log and the history. Of course, any such use is likely in a script, 
at which point the script probably doesn't actually want "git log", but 
just a raw "git-rev-list".

After all, the only _real_ difference between "git log" and "git-rev-list" 
is the purely syntactic one (things like defaulting to HEAD in "git log" 
and requiring revisions in git-rev-list), and the use of PAGER.

To me, the question whether a flag would be parsed in the "revision.c" 
library or in the "rev-list.c" binary was more a question of whether that 
flag makes sense for other things than just "git log". 

For example, "git whatchanged" and "git diff" could both use 
setup_revision(), although "git diff" wouldn't actually _walk_ the 
revisions (it would just look at the "revs->commits" list to see what was 
passed in).

"git whatchanged" would obviously take all the same flags "git log" does, 
and "git diff" could take them and just test the values for sanity (ie 
error out if min/max_date is not -1, for example).

"git show" is like a "git-whatchanged" except it wouldn't walk the diffs 
(I considered adding a "--nowalk" option to setup_revisions(), which would 
just suppress the "add_parents_to_list()" entirely)

			Linus

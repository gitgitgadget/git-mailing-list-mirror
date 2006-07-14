From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Kernel headers git tree
Date: Fri, 14 Jul 2006 01:56:01 +0100
Message-ID: <1152838562.31372.58.camel@shinybook.infradead.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
	 <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 02:55:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1ByE-0007X5-Lr
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 02:55:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161052AbWGNAze (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 20:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWGNAze
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 20:55:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:29864 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751427AbWGNAzd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 20:55:33 -0400
Received: from shinybook.infradead.org ([81.187.2.165])
	by pentafluge.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1G1Bxs-00016k-6Z; Fri, 14 Jul 2006 01:55:32 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23863>

On Thu, 2006-07-13 at 17:39 -0700, Junio C Hamano wrote:
> With modern enough git, you can rewrite
>         KBUILDSHA=`git ls-tree $TREE -- Kbuild | cut -f3 -d\  | cut -f1`
> with
>         KBUILDSHA1=`git rev-parse $TREE:Kbuild`


Aha. Thanks.

> I am not sure what function incparent() is trying to do with
> this:
> 
>         git rev-list --max-count=1 --topo-order $1 -- . 

Find the latest ancestor commit which actually changed any files. The
first script has a similar line, except that it finds the latest
ancestor which changed anything in include/

Consider a kernel tree with commits A-->B-->C-->D, of which only A and C
change anything in include/ and in fact only C actually changes the
_exported_ headers after the unifdef and sed bits. 

The first script (extract-khdrs-git.sh) creates a 'stage1' branch which
only contains commits A'-->C', with the _exported_ header tree for each.

The second script (extract-khdrs-stage2.sh) then creates the master
branch with the same tree objects, but omitting the commits which don't
change anything. So it contains only commit C''

For an example of this, compare
http://git.kernel.org/git/?p=linux/kernel/git/dwmw2/kernel-headers.git
with
http://git.kernel.org/git/?p=linux/kernel/git/dwmw2/kernel-headers.git;a=shortlog;h=stage1

Btw, git-rev-list is _very_ slow at this. Even when the output is
actually HEAD, it takes my 2.3GHz G5 a _long_ time to give a result:

pmac /pmac/git/linux-2.6 $ git-rev-parse HEAD
ab6cf0d0cb96417ef65cc2c2120c0e879edf7a4a
pmac /pmac/git/linux-2.6 $ time git-rev-list --max-count=1 --topo-order HEAD -- include
ab6cf0d0cb96417ef65cc2c2120c0e879edf7a4a

real    0m18.840s

Is there a better way to do that step?

-- 
dwmw2

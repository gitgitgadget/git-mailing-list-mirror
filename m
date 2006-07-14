From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Kernel headers git tree
Date: Fri, 14 Jul 2006 10:38:35 +0100
Message-ID: <1152869915.3191.12.camel@pmac.infradead.org>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
	 <7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0607131800520.5623@g5.osdl.org>
	 <1152840456.31372.75.camel@shinybook.infradead.org>
	 <Pine.LNX.4.64.0607132251310.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 11:39:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1K8g-0003aH-Us
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 11:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWGNJi6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 05:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWGNJi6
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 05:38:58 -0400
Received: from canuck.infradead.org ([205.233.218.70]:3241 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964809AbWGNJi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 05:38:58 -0400
Received: from pmac.infradead.org ([81.187.2.168])
	by canuck.infradead.org with esmtpsa (Exim 4.62 #1 (Red Hat Linux))
	id 1G1K8J-0007Xl-CE; Fri, 14 Jul 2006 05:38:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607132251310.5623@g5.osdl.org>
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23881>

On Thu, 2006-07-13 at 22:52 -0700, Linus Torvalds wrote:
> Btw, I'm actually surprised that my path simplification didn't filter out 
> the "." and make it mean exactly the same as not giving a path at all. I 
> thought I had done that earlier, but if you say "-- ." matters, then it 
> obviously does..

In this specific case where I have a whole bunch of commits which don't
actually change anything, it definitely does make a difference...

hera /home/dwmw2 $ export GIT_DIR=/pub/scm/linux/kernel/git/dwmw2/kernel-headers.git
hera /home/dwmw2 $ git-rev-list --max-count=5 stage1
e4e2fcc2c333aac5f6331c1df256ff28d7ee76d7
32ca8021c5ab7b9d44e8a08aeb53e52af5223fec
6b8380885464e069ae22e1e04f4a905c9e918f4e
2dee58696cab32506f655cb94a63cf4b18a13b37
402429bc9ac5eb891f253f6dae1228338f7f0ea5
hera /home/dwmw2 $ git-rev-list --max-count=5 stage1 -- .
d1aba9314210d616cd2aa9ee91176c1dba6d3834
0b627fd403d6319fe50fbd8b95d5ea02017731fa
b29cfa21bbdfc25271ef446b9df94ed8b5425711
e2407b6a9a643b378700474c9079dd8620e820ed
c0df084d3e2ec0df6dafda8099e7c27c29760843

Junio is right -- if I can avoid creating commits that don't change any
files in the stage1 branch, then I don't have to do this. That would be
_hard_ though...

Currently, the selection of commits from your original tree to be
represented in the stage1 branch is simple -- it's "those commits which
touch include/". And 'rev-list -- include'  works nicely for that.

Yet what I actually want in the final result is "those commits which
change the result of the _exported_ headers". It's slightly less
realistic to want rev-list to find that for me directly from the
original kernel tree without having done the export step in stage1 --
what I need to do is create the exported header tree for each commit
which _might_ change it, then filter out the commits which don't
_actually_ change it.

The extra commits in the stage1 branch are cheap enough -- by definition
they don't lead to any extra tree or blob objects. I think the two-stage
export is probably the best approach, unless I'm missing something.

-- 
dwmw2

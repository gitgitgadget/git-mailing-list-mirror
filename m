From: Junio C Hamano <junkio@cox.net>
Subject: Re: Kernel headers git tree
Date: Fri, 14 Jul 2006 11:01:54 -0700
Message-ID: <7v64i0qd4d.fsf@assigned-by-dhcp.cox.net>
References: <1152835150.31372.23.camel@shinybook.infradead.org>
	<7v4pxlt3xg.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607131800520.5623@g5.osdl.org>
	<1152840456.31372.75.camel@shinybook.infradead.org>
	<Pine.LNX.4.64.0607132251310.5623@g5.osdl.org>
	<1152869915.3191.12.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 20:02:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1RzO-0001fz-9z
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 20:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422693AbWGNSB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 14:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422694AbWGNSB6
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 14:01:58 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:52879 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1422693AbWGNSB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 14:01:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060714180156.OSXD6303.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Jul 2006 14:01:56 -0400
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1152869915.3191.12.camel@pmac.infradead.org> (David Woodhouse's
	message of "Fri, 14 Jul 2006 10:38:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23902>

David Woodhouse <dwmw2@infradead.org> writes:

> Yet what I actually want in the final result is "those commits which
> change the result of the _exported_ headers". It's slightly less
> realistic to want rev-list to find that for me directly from the
> original kernel tree without having done the export step in stage1 --
> what I need to do is create the exported header tree for each commit
> which _might_ change it, then filter out the commits which don't
> _actually_ change it.
>
> The extra commits in the stage1 branch are cheap enough -- by definition
> they don't lead to any extra tree or blob objects. I think the two-stage
> export is probably the best approach, unless I'm missing something.

Since you are not building an exact parallel history with the
same topology (you are trying to cull the commits in the new
tree that do not change the resulting header files), I do not
see much point in the parent conversion loop in the first script
to compute CONVERTEDPARENTS.

How about making it simpler?

	* Keep the current HEAD of the "headers" branch at in
          refs/heads/kernel-headers

	* Whenever you see $UPSTREAM_GITDIR/refs/heads/master
          changes, you do your converttree to come up with the
          new header tree

	* See if the resulting tree changed by doing something
          like this:

                TREE=`converttree $INCDIR $KBUILDASMSHA`
                case "`git diff-tree --name-only kernel-headers $TREE`" in
                '')
                        # No changes in the result
                        exit
                esac

	  Stop processing here if there is no change.

	* Make a new commit, with its parent set to the current
          value of refs/heads/kernel-headers, perhaps with the
          same message as $UPSTREAM_GITDIR/refs/heads/master
          has as you do already.

	* Advance refs/heads/kernel-headers only when you
          actually make a new commit.

I would further suggest to record the value of the upstream
commit object name, $UPSTREAM_GITDIR/refs/heads/master,
somewhere in the commit message, by using "git describe".  This
will help people who use your converted headers to know which
released version of the Linus kernel the headers correspond to,
and also help you notice when the upstream is updated during the
next run.

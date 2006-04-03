From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Default remote branch for local branch
Date: Mon, 3 Apr 2006 15:57:35 +0200
Message-ID: <200604031557.35660.Josef.Weidendorfer@gmx.de>
References: <1143856098.3555.48.camel@dv> <200604030128.42680.Josef.Weidendorfer@gmx.de> <7vr74ff4oy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 15:58:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQPZ3-0007Mf-Gg
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 15:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWDCN5j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 09:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWDCN5j
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 09:57:39 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:11702 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S1751213AbWDCN5i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 09:57:38 -0400
Received: from dhcp-3s-61.lrr.in.tum.de (dhcp-3s-61.lrr.in.tum.de [131.159.35.61])
	by mail.in.tum.de (Postfix) with ESMTP id C92F02181;
	Mon,  3 Apr 2006 15:57:36 +0200 (MEST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.1
In-Reply-To: <7vr74ff4oy.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18326>

On Monday 03 April 2006 10:23, Junio C Hamano wrote:
> Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:
> 
> > On Sunday 02 April 2006 23:40, you wrote:
> >> > Let me try to understand this: the general idea is that
> >> >
> >> >   pull.origin = [<refspec> of] <remote> for <branch>
> >> >
> >> > specifies the default action of git-pull if we are on <branch>, ie.
> >> > a "git pull" then runs "git pull <remote> [<refspec>]".
> >> 
> >> Not quite.
> >> 
> >> It will be (if this were a serious proposal -- I am not
> >> absolutely convinced this is a good idea) more like "git fetch
> >> <remote>" followed by "git-merge HEAD the-refspec-named-there".
> >
> > So it is not really a <refspec>, but a <localbranch> which has to
> > appear in the .git/remotes file on the right side of a refspec on
> > a Pull line.
> 
> No, I meant <refspec> not <localbranch> here, because I do not
> want to force people to have tracking local branch.

Oh, ok. I just had to look up the manual regarding refspecs when
pulling/fetching again: "<ref>" is the same as "<ref>:" and does
not create/use any local branch.

> > All I wanted to remark is, that, with
> >
> >  URL: <remote-URL>
> >  Pull: refs/head/master:refs/head/remote1
> >  Pull: refs/head/other:refs/head/remote2
> >
> > the config
> >
> >  pull.origin = <remote> for refs/head/my-devel-for-remote2
> >
> > which does not use the [<refspec> of] part, always is bogus:
> > We get remote1 merged into my-devel-for-remote2 on a git-pull,
> > which is not what we want.
> 
> I think we are on the same page, if you just think of not having
> [<refspec> of] a short-hand for naming the first Pull: line.

Yes, I understand this. But I do not think that such an optional
shortcut is useful for config files entries. It complicates parsing/editors,
and seems to make it more confusing. Despite, I agree that such optional
shortcuts are nice for porcelain command lines.

As I see the use of "<refspec> of <remote>", I still think that specifying
a local branch is useful, too. So what about

  pull.origin = (<refspec> of <remote> | <localbranch>) for <branch>	

instead? We can distinguish the two cases by looking for the "of".
When the <refspec> is of the form <src>:<dst> (where <dst> is the local
branch), we probably want to sanity check against .git/remotes/.

> > Optionally, branching <new> off from <old> could add <new> as
> > topic branch of <old>: Thus, if you are on <old> and do git-pull,
> > you get <new> merged in.
> 
> I agree with Andreas on this part.

Yup. If we want to support topic branches with defaults, we should use
another config option. And now, I am not convinced about the usefulness
of this any more.

> Not if you made the [<refspec> of] part <localbranch>.  Then
> this configuration for default merge source per local branch
> feature is available only to people who are willing to use
> tracking branches.

Yes, I understand this now.

> I just wanted to mention that it would be handy to be able to
> take snapshots of tracking branch heads, but it does not really
> matter whether they are "your" local development branches or
> tracking branches.  Just a nightly or on-demand
> 
>          d="$GIT_DIR/refs/snapshot/`date '+%Y-%m-%d'`" &&
>          mkdir "$GIT_DIR/refs/snapshot/$d" &&
>          tar Ccf "$GIT_DIR/refs/" - heads |
>          tar Cxf "$d" 

Wow. For this, versioning of the /refs directory as subproject
would be good ;-)

Josef

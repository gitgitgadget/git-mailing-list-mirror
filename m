From: Junio C Hamano <junkio@cox.net>
Subject: Re: Default remote branch for local branch
Date: Mon, 03 Apr 2006 01:23:25 -0700
Message-ID: <7vr74ff4oy.fsf@assigned-by-dhcp.cox.net>
References: <1143856098.3555.48.camel@dv>
	<200604021817.30222.Josef.Weidendorfer@gmx.de>
	<7v7j67k65b.fsf@assigned-by-dhcp.cox.net>
	<200604030128.42680.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 03 10:23:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQKLT-0008Sh-Qp
	for gcvg-git@gmane.org; Mon, 03 Apr 2006 10:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWDCIX2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 04:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932397AbWDCIX2
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 04:23:28 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17295 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932374AbWDCIX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Apr 2006 04:23:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060403082326.GBAT25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Apr 2006 04:23:26 -0400
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200604030128.42680.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Mon, 3 Apr 2006 01:28:42 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18320>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Sunday 02 April 2006 23:40, you wrote:
>> > Let me try to understand this: the general idea is that
>> >
>> >   pull.origin = [<refspec> of] <remote> for <branch>
>> >
>> > specifies the default action of git-pull if we are on <branch>, ie.
>> > a "git pull" then runs "git pull <remote> [<refspec>]".
>> 
>> Not quite.
>> 
>> It will be (if this were a serious proposal -- I am not
>> absolutely convinced this is a good idea) more like "git fetch
>> <remote>" followed by "git-merge HEAD the-refspec-named-there".
>
> So it is not really a <refspec>, but a <localbranch> which has to
> appear in the .git/remotes file on the right side of a refspec on
> a Pull line.

No, I meant <refspec> not <localbranch> here, because I do not
want to force people to have tracking local branch.  The call to
merge in pull that happens immediately after fetch does not use
localbranch, but uses what's recorded in FETCH_HEAD, and if we
were to do this change the above change would most likely to
affect how each remote branch heads fetched are marked for (or
not for) merges.

> All I wanted to remark is, that, with
>
>  URL: <remote-URL>
>  Pull: refs/head/master:refs/head/remote1
>  Pull: refs/head/other:refs/head/remote2
>
> the config
>
>  pull.origin = <remote> for refs/head/my-devel-for-remote2
>
> which does not use the [<refspec> of] part, always is bogus:
> We get remote1 merged into my-devel-for-remote2 on a git-pull,
> which is not what we want.

I think we are on the same page, if you just think of not having
[<refspec> of] a short-hand for naming the first Pull: line.

> Optionally, branching <new> off from <old> could add <new> as
> topic branch of <old>: Thus, if you are on <old> and do git-pull,
> you get <new> merged in.

I agree with Andreas on this part.

>> A bigger thing is that I am trying to avoid _requiring_ tracking
>> branches.
>
> I don't think you force anything when you add functionality to git-pull
> for the config discussed here. Nobody *has* to use this config - it's
> a porcelain thingie.

Not if you made the [<refspec> of] part <localbranch>.  Then
this configuration for default merge source per local branch
feature is available only to people who are willing to use
tracking branches.

>> If you are not micromanaging your subsystem 
>> maintainers, you should not have to care where they were the
>> last time you pulled from them....
>> [...why not needing to use tracking branches is good...]

>> If we are going require tracking branches,
>
> I do not understand. Why should we require this?

I forgot to say "on the other hand" before that "If".

>> we could do a bit 
>> more with them, like remembering where the tip was when we
>> fetched the last time (or the time before that...) and diff with
>> that, but the tracking branch heads are not set up to do things
>> like that right now -- they are single pointers.

Actually I think this part is independent and I did not have to
mention.  There is no point complicating only the tracking
branches at all.

I just wanted to mention that it would be handy to be able to
take snapshots of tracking branch heads, but it does not really
matter whether they are "your" local development branches or
tracking branches.  Just a nightly or on-demand

         d="$GIT_DIR/refs/snapshot/`date '+%Y-%m-%d'`" &&
         mkdir "$GIT_DIR/refs/snapshot/$d" &&
         tar Ccf "$GIT_DIR/refs/" - heads |
         tar Cxf "$d" -

would do, and then you should be able to ask "where was my
'master' head yesterday?".

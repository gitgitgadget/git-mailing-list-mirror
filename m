From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSoC proposal for svn remote helper
Date: Fri, 8 Apr 2011 17:31:50 -0500
Message-ID: <20110408223150.GA27284@elie>
References: <BANLkTinYyxxkZpmEF2PYXMb_BjCVcbTkYw@mail.gmail.com>
 <BANLkTinHE-E5_mK8aKYv2f7yExVvfOFVRw@mail.gmail.com>
 <20110408052126.GA22256@elie>
 <BANLkTinWtqNYvZP2yamx831_U9KHZ4x3qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, artagnon@gmail.com, david.barr@cordelta.com,
	srabbelier@gmail.com, Eric Wong <normalperson@yhbt.net>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 00:32:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8KDn-0006eN-CS
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 00:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598Ab1DHWcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 18:32:01 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:43958 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab1DHWcA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Apr 2011 18:32:00 -0400
Received: by yia27 with SMTP id 27so1609638yia.19
        for <git@vger.kernel.org>; Fri, 08 Apr 2011 15:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=NpeIDb50tw2p3z+Za5qjFrq9W/Gqry89WqNJCeV5qGs=;
        b=sc6pnLeI20Iy8Af3Ug/P7Ew5/ZkHHMr9vFQA6aJQSm6kCsBDUic0Pg/97RB4j1R5JS
         CZmxMhddq4n/aPWFVifkaSMngd6+nak+ifM+ycUTo4agYp8uay7Rd1pajmi7EGOfi/0A
         w0Mvb3EeAXb0dEKWDhaapL+yFcu6Tiy3CoS88=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZEL5lNtrEQypjLu/3kIr+w0zJ7rJb+dvyAcreFRL25sQ8zIgPP7OAwI6behRJ/dfNU
         YKszsS/njX6M8c+IxBu9PYgm/OilOU9vd2JuZRvyaUpKFv+OVihkXyWI0Pwkz/2ubUmy
         NFOjPe6yJ5mYcDEwtHUcPBukYENe5d6QhNVMk=
Received: by 10.236.0.228 with SMTP id 64mr3432234yhb.446.1302301918262;
        Fri, 08 Apr 2011 15:31:58 -0700 (PDT)
Received: from elie (adsl-69-209-53-77.dsl.chcgil.ameritech.net [69.209.53.77])
        by mx.google.com with ESMTPS id a12sm1504798yhk.27.2011.04.08.15.31.55
        (version=SSLv3 cipher=OTHER);
        Fri, 08 Apr 2011 15:31:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTinWtqNYvZP2yamx831_U9KHZ4x3qA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171168>

Hi again,

Dmitry Ivankov wrote:

> I should have used different names for current git-svn.perl and what
> should be tracking svn repo in git somewhat better than git-svn.perl.
> Maybe call it git-svn-ng.

Ah, sorry I misunderstood.

> It should definitely support common
> workflows, but I think that it should not be too close in
> configuration and behavior details.

At the moment I am more concerned with what its guts will look like
than what features it will support.  A feature list is just a way to
advertise how good the guts are. ;-)

> I have an idea for it, quite raw, but could work.

The discussion here might also be helpful:
http://thread.gmane.org/gmane.comp.version-control.git/159235/focus=159264

> We are limited by svn:
> - commit isn't a push, it's rebase & push. So we don't control the parent ref.

Yes, this is unfortunate.  When I send in my change A, there is no
server-side locking to prevent someone else from making a change B
on the same branch first, with a semantically meaningless result.

svnrdump load has to deal with the same problem.  Possible
workarounds:

 * prevent pushes to the svn repository (using some out-of-band
   mechanism) before allowing git to push to it.  This is what svnsync
   users typically do.

 * lock directory, check parent, commit if okay, unlock directory.
   This is probably the best we can do.

 * extend the SVN RA protocol to provide a lock that is automatically
   removed if the connection is interrupted, and use that.

Ram, does the above (#2) make sense?  (I think this would be something
for svn fast-import to take care of; by the time the stream gets to
"svnrdump load" hopefully the relevant branches are already locked or
protected from contention some other way.)

So I think this is a problem but not insurmountable.  I think it's
even possible to ignore at first (by assuming exclusive access to the
target svn repo --- i.e., blame the user :)) as long as it is
documented.  Thanks for a reminder.

Reference: http://svn.apache.org/repos/asf/subversion/trunk/subversion/libsvn_ra_svn/protocol

> - there are no branches in svn. There are paths, but we can convert
> them to branches of another paths.

I think it's reasonable to assume a standard trunk / tags / branches
layout and simple "svn cp" records for new and renamed branches, at
least to start out.

> - there are no merges in svn. That's a trouble, but maybe we can try
> to use svn:mergeinfo to create and read multiple parent refs.

The hard part is distinguishing merges from cherry-picks.  Seems
optional to start out (i.e., a prototype can assume each commit has
a single parent).

> - we definitely want to keep everything needed inside svn, or we are
> sure to diverge in different clones sometime.

Right --- this means we have to make it very clear to the user when
they are creating history that will be unrepresentable in svn.

> So what we do:
> - get rid of svn revision: just have path@rev -> sha1 mapping
> separately, of course history of path@rev should look like the history
> of sha1

The current idea that's been floating in the air is to use a "git notes"
tree (see git-notes(1)) to store the mapping from git commit names to svn
path@rev specifications.  This way, (1) they can be easily shared but
(2) they are not part of the commit name.  So it is easy to discard
the mapping, or to adjust it when the project moves to a different svn
server.

Meanwhile svn-fe needs quick mapping in the other direction, revs ->
commits, for its work.  So one would want to cache the reverse mapping
(with the notes as the master copy).

> - learn to create and fetch back merge commits: try svn:mergeinfo

See above.

> - be sure to control the parents: don't let svn to commit on top of
> something different from git parent:

This requires more information from svn-fe (copyfrom info).  So either
svn-fe needs to take care of this itself, or the next program in the
pipeline would get some information from it (using an extension to the
fast-import format, an extra output stream, or extra data in comments,
"progress" commands, or the log message).

> -- if path wasn't changed in the repo while we were hacking, commit it
> and it'll come back as the same sha1

Hopefully. :)

> -- if it was, create a svn branch of our parent, commit there, and
> then create a merge commit of these two, commit it and get same merge
> history back

Yikes.  I don't think typical projects would like the resulting
history.

> -- and if we are commiting a merge, create/commit to branches as necessary

Yes, this is an interesting question.  Given a history like this (time
flowing left to right):

         E --- F --- G
        /             \
 A --- B --- C -- D -- H

where A is the latest rev of trunk/, how do we push this history to
svn?  Where is the name of the side branch recorded in the git
history?

On answer is that it's possible to learn the historical branch name by
parsing the commit message for "H".  Yuck.

I'd put off pushing merges to start.

> Not perfect, but it hardly can be cleaner to emulate git history in
> svn, and get it back unchanged. And it should be optional too, not all
> svn commits need this.

I think the cleanest solution is often to reject a push if it is not
obvious how to represent it remotely, just as though the remote server
had a hook that rejected it.

Jonathan

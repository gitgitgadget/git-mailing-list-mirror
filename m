From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: git clone, hardlinks and multiple users?
Date: Sat, 21 Jan 2012 16:54:05 -0600
Message-ID: <4F1B420D.7050800@gmail.com>
References: <jfc8eh$ck5$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Herbert <Marc.Herbert+news@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 21 23:54:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RojpK-00073Y-Vn
	for gcvg-git-2@lo.gmane.org; Sat, 21 Jan 2012 23:54:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab2AUWyL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Jan 2012 17:54:11 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54587 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab2AUWyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2012 17:54:09 -0500
Received: by ggnb1 with SMTP id b1so882205ggn.19
        for <git@vger.kernel.org>; Sat, 21 Jan 2012 14:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=KnGxNbfJtju/3COdkpYJ+cVuYhG9zegPTYNAx78rI0g=;
        b=qLzzavfKXv93A0BzhYJAWNNpi5nnZVoKheUTc5sgiELdS9x54LMNLBuJI+fxTiNL/J
         00xYklv2Pw7I6jM2V1h2yyushYGhMwvE5qNoc2YI0JneP+Gco/NdB6WrvRIp5bU01KfQ
         l08SfURs/jprnDoG0Yy/uLit7je24j8UV5zbU=
Received: by 10.236.146.4 with SMTP id q4mr4403971yhj.105.1327186448645;
        Sat, 21 Jan 2012 14:54:08 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id u47sm12970276yhl.0.2012.01.21.14.54.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 21 Jan 2012 14:54:08 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.25) Gecko/20111213 Thunderbird/3.1.17
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <jfc8eh$ck5$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188939>

On 1/20/2012 11:31 AM, Marc Herbert wrote:
> Hi,
>
> "git clone" is using hardlinks by default, even when cloning from a
> different user. In such a case the clone ends up with a number of
> files owned by someone else.
>
(I assume your using linux.) It sounds like you specified a url syntax
of /path/to/repo.git in your git-clone which tells git to use hardlinks.
  If you want your own copies then specify file:///path/to/repo.git in
git-clone (see git-clone manpage section "GIT URLS":
http://schacon.github.com/git/git-clone.html).

> Since only immutable objects are cloned this seems to work fine.
> However I would like to know if this "multiple users" case works by
> chance or by specification.
>
(I'm not an expert on hardlinks, linux metadata, or git, and haven't
used hardlinks at all with linux or git yet, but do have some experience
with git and permissions.)  I think if you plan your permissions to be
based on a primary group then it will "just work".  If its not as simple
as a single primary group, then read on for my non-expert conversational
input, or at least skim thru for pointers to the reliable manpage
references...

It sounds like part of your question may actually be a hardlink
question so perhaps this info on hardlinks is useful:
http://linfo.org/hard_link.html to you. In regards to git, it does not
track metadata.  However, it will track
"permissions" if you tell it to, but even then it only tracks the
executable bit to determine if its stored in the git repo as executable
or non-executable.  If you are "changing" the metadata because you
modified the file contents (or executable bit) then
you are creating a new object (in git) and not modifying the original
hardlinked object (in git or linux) or its metadata (in linux).  I
assume the working-tree (ie., WORKTREE/ of WORKTREE/.git repo) of the
clone is indeed a full copy of the files via git-checkout because the
manpage only claims to use hardlinks for the object store (ie.
.git/objects/) to save diskspace on the clone of the object store, not
the checkout of the worktree.  Worktree objects only get written
to the object store if you stage them to the index (git-add).  Then they
are stored in .git/objects/ according to the sha-1 of their
contents.  Therefore, if your worktree copy has a different owner and
you don't modify the contents or executable bit then you can't possibly
stage it because git does not detect a difference in content or
executable bit.  On the other hand, if you change the contents or the
executable bit then git will consider that a change and update the
object store, but it will be a new object and not the object
representing the previous version you hardlinked to when you cloned.  If
that new object is then in turn pushed to the origin repo and someone
else clones it using hardlinks then they may very well not
be able to access that object if its owner:group excludes them.  More
likely, if someone pushes an object with bad permissions then others
will get push errors because git stores objects in subdirs named after
the first two chars of the sha-1 which means other objects in that
subdir will also be inaccessible.  If you change permissions in regard
to executable bit on your files without editing contents then I don't
know if git will make a new copy or modify the original inode because
I'm not sure if the executable bit permissions is represented in the
sha-1 contents or not.  In the git-init manpage there are options for
permissions/sharing under the --shared option (not to be confused with
the --shared option of git-clone which it totally different).  The
git-clone equivalent appears to be "git-clone --config
core.sharedRepository=<your-value>".  Maybe these core.sharedRepository
settings in git are smart enough to handle the hardlink shared inode
metadata confusion.

> In other words, is there a guarantee that no later version of git or
>  no obscure option I haven't used yet will ever try to touch a
> hardlink in any way like for instance: trying update some metadata
> timestamp or, overwrite it with the same value by lack of
> optimization, or any other kind of side-effect that would obviously
> fail.
>
However, if you cd to .git/objects/ and use chmod to change the
permission directly then I think it would change the permissions on the
inodes your origin is storing as loose objects.  I'm not sure what it
would do for packed objects. There are clone options like --shared and 
--reference that have special notes on the manpage explaining how you 
could break things if you don't know what you're doing (that would 
include hardlinks but is not exclusive to hardlinks).

Hope this helps in some way.  Perhaps someone better informed will 
provide a more accurate and/or clear answer.  Let me know what
you find out because I too will have to become more concerned about
diskspace and clone optimization in the very near future.

v/r,
neal

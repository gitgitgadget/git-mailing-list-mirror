From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git submodules and commit
Date: Thu, 17 Jul 2008 11:12:55 -0400
Message-ID: <32541b130807170812s7586da8ejbeeee64806490b13@mail.gmail.com>
References: <320075ff0807160331j30e8f832m4de3e3bbe9c26801@mail.gmail.com>
	 <320075ff0807160332k5e49c256tb4191de628ecf41c@mail.gmail.com>
	 <32541b130807160843k25f1d7d3u8bfecd6c1c6eab91@mail.gmail.com>
	 <320075ff0807170247g7bb18252ma50b202e1d762296@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Nigel Magnay" <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 17:14:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJVB7-00047n-Ma
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 17:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754052AbYGQPM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 11:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755522AbYGQPM6
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 11:12:58 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:30142 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbYGQPM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 11:12:57 -0400
Received: by qw-out-2122.google.com with SMTP id 3so500375qwe.37
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 08:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=X1qB4giVAXTXpLJodm6DtbeWurJl4zF4LVXqDkupUiU=;
        b=D6BKUQaQ+j2CTg5NxsbDNVSVqlQxH33qq9jbgOTJV91k3oAVFtgYretqTQlqQTXDST
         oqub5pFcCdfpj4mWx1aMFwDPW/0MqNytHbE4Xq/yFuBAa4NH230zQNixOiemBG9M1kqv
         wh/cEdzsOuNltHzxOGz5LcIb4uscFpmwj7KbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=UrpQ5phkfmbooy/lujYRdb3SUrsImDF7GQjCbkxsRcGBOgj9xFNuxPr6sgJg/bjg/d
         i67uVnX0GHR4dGPYHh9cTFAJ0Nvxes/MHZYNE7MF/rv4VjBgh9D3PQWySSauavneSm+n
         WCRatvzgapJFWVFSl1BalmQr4EATFfynEPy2Q=
Received: by 10.151.143.3 with SMTP id v3mr583493ybn.244.1216307575865;
        Thu, 17 Jul 2008 08:12:55 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Thu, 17 Jul 2008 08:12:55 -0700 (PDT)
In-Reply-To: <320075ff0807170247g7bb18252ma50b202e1d762296@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88865>

On 7/17/08, Nigel Magnay <nigel.magnay@gmail.com> wrote:
> Yeah - this happens a lot. If someone else commits to the
>  super-project before you, it's always a conflict. What's annoying is
>  there's no way around it (though resolution is easy - force to current
>  - but it this is a big bit of what confuses my users. They say 'but I
>  already resolved the merges in the submodule itself'. I'm not sure
>  there's an easy way around it though - and this is part of my worry
>  that there's hidden complexity with trying to make it 'look like 1 big
>  repo').

This might not be as hard as it sounds.  We probably just need to
teach the supermodule how to merge gitlinks safely.  So basically, if
I moved the gitlink from A to B, and he moved it from A to C, then it
needs to check whether a fast forward merge already exists for the
submodule to combine B and C.  This is easier than it sounds, because
if I *already* ran my newest-git-modules script in the inner module,
then I've already manually resolved the merge in question, so that B
*does* actually contain C.

Right now, such a thing results in a conflict.  It isn't really a
conflict though, it's a fast forward, and the supermodule's merge
should ideally just notice that and run with it.

Sadly I know very little about the merge code.  But I would be happy
to help you test a patch that implemented this :)

A slightly more advanced version of the same would automatically walk
into the submodule and ask it to merge B and C.  I suspect that is way
more complicated than it sounds at first glance, though (particularly
if the new B or C gitlink doesn't have A as a parent at all, which
couldn't happen in a unified git repo, but is perfectly allowable with
submodules).

With anything like this, there's always the question of what happens
if you haven't done a "fetch" in the submodule yet; I think reverting
to the current behaviour is fine in that case, because I can make
newest-git-modules to always fetch before trying anything anyway.

> Yeah. I have an additional usecase, which is around pulling from
>  another user. If they've made changes in their tree(s) that they want
>  to get reviewed, normally I could do something like
>
>  git fetch ssh://joebloggs.computer/blah +refs/heads/*:refs/remotes/joebloggs/*
>
>  But if they've made cross-module changes, I'm SOL, as fetching their
>  super-project will have references to commits that aren't in the repo
>  mentioned in .gitmodules (only in joebloggs's tree) - so doing git
>  submodule update doesn't help. I have to go into each submodule and
>  explicitly fetch. It feels wierdly centralised for this otherwise
>  distributed tool.

One slightly non-obvious option here is to actually use the *same*
repo for all your supermodules and submodules, then use "." as the
repo path in your .gitmodules.  The original clone is huge that way,
but it makes it obvious how to get any objects that you're missing.

Then you could construct your submodules using --reference the
supermodule.  Thus, doing a "fetch" of your user's supermodule, you'll
also get all the objects it references.

Note that I've only basically tried out this technique.  I think it's
the one for me, but I haven't experimented with it enough to know any
pitfalls.  When I've brought it up on the list, it's been shot down
because it wouldn't work for gigantic mega-repositories like KDE where
the whole point of submodules is to *not* download all the modules
every time.  It works for me, though, because my software doesn't even
*build* unless I have all the modules.

(And before anyone asks, yes, it still makes sense to use submodules
because some of the modules are shared with other projects.)

> What's bugging me is I'm not sure that it's the right place. It seems
>  (to me) that having the only place that knows about submodules being
>  the 'git submodules' script isn't right. What users want is 'git fetch
>  <blah>' to do the lot - that, for the most, it ought to do the
>  submodule init, update and clever stuff automatically. That if 'git
>  fetch' is porcelain, then the porcelain needs to call the
>  git-submodule stuff.

There is some architectural elegance to the fact that the gitlink
stuff is almost completely abstract (just a number, really) in the
core of git, and is only made "real" by running git-submodule, which
actually extracts files and makes .git dirs and fetches submodules and
whatnot.

However, it's architectural elegance, not UI elegance.  As a user, I
mostly don't want to have to care whether a particular directory is a
"submodule" or not, so the extra push and commit and fetch steps
become tedious.  From the point of view of UI, I agree with you.

Perhaps this is a plumbing vs. porcelain issue.  I don't think
git-submodule has made an attempt to separate the two, since it seems
to be porcelain, but there's no "submodule plumbing" underneath
(AFAICS) that things like git-fetch and git-commit and git-push can
plug into.

>  But - perhaps it's best to approach it as scripts for now :)

I suspect so :)

> Hm - I'd be happy with the same commt message in all modules. What I
>  want is to be able to do (from the top) 'git commit -a' or the same
>  with the GUI, and see all the files to be committed regardless of
>  whether they're in a submodule or not.

That actually wouldn't work very well for me.  I do need the commits
separated, because that's why I'm using submodules in the first place
instead of the "subtree" merge strategy.

Basically, I'm still planning on contributing patches to my class
library upstream, and the patches need to talk about how they affect
the *library*, not what I changed in my application.  So I *would*
want to write separate commit messages in all cases.  I can see how
other people might not, though.

>  This is what the users want - something that mirrors 'svn ci' at the
>  top level - "Please Check All My stuff in".

Note that submodules are more like svn:externals, which also require
you to commit each module separately.  One big difference there is
that you don't need to commit to the supermodule each time you commit
to the submodule, but that's only because svn:externals by default
links to a branch, not to a particular revision.  The
revision-specific linking is very worthwhile, I think, so requiring an
extra commit is mostly okay here.

Perhaps automating the extra commit would be nice in some cases, but
for me, for example, I tend to combine my "update to newest version of
submodule" commit with some changes to the supermodule, since the
reason I updated was to implement this new feature.

Have fun,

Avery

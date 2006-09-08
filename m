From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Change set based shallow clone
Date: Thu, 7 Sep 2006 22:23:18 -0400
Message-ID: <9e4733910609071923tf1c49f6o70419e961e9eb66f@mail.gmail.com>
References: <9e4733910609071252ree73effwb06358e9a22ba965@mail.gmail.com>
	 <20060908010112.6962.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 08 04:23:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLW1k-0001BL-N0
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 04:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752037AbWIHCXU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 22:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752038AbWIHCXU
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 22:23:20 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:56995 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1752037AbWIHCXT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 22:23:19 -0400
Received: by nz-out-0102.google.com with SMTP id n1so218941nzf
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 19:23:19 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bq3GwksBnpOmApG+T+hayz/zZPwmaN9HHm3YRv+G+QQrhGXi426WNPNQFxsKcsFd9USJNvc2AhdR5FqsrDMzXre9woZxph8FgP4TNAUyhpgqsygwJ+0zoe2rWUNZ/FAu1ZGssWfTWLDfqwuccQvBaWeIZCdPIziBtTLfNmAQGJg=
Received: by 10.35.46.11 with SMTP id y11mr1830853pyj;
        Thu, 07 Sep 2006 19:23:18 -0700 (PDT)
Received: by 10.35.60.14 with HTTP; Thu, 7 Sep 2006 19:23:18 -0700 (PDT)
To: "linux@horizon.com" <linux@horizon.com>
In-Reply-To: <20060908010112.6962.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26672>

On 7 Sep 2006 21:01:12 -0400, linux@horizon.com <linux@horizon.com> wrote:
> > When the client wants a shallow clone it starts by telling the server
> > all of the HEADs and how many change sets down each of those HEADs it
> > has locally. That's a small amout of data to transmit and it can be
> > easily tracked. Let's ignore merged branches for the moment.
>
> When you say "change set", I'm going to assume you mean "commit object".
>
> Okay.  Now, the server hasn't heard of one or more of those commit
> objects, because they're local changes.  What then?

Toss them, if they don't exist on the server the server is going to be
able to send any objects for them.

> Another issue is that a client with a nearly-full copy has to do a full
> walk of its history to determine the depth count that it has.  That can
> be more than 2500 commits down in the git repository, and worse in the
> mozilla one.  It's actually pretty quick (git-show-branch --more=99999
> will do it), but git normally tries to avoid full traversals like the
> plague

Client would track this incrementally  and not recompute it each time.

> Oh, and was "for the moment" supposed to last past the end of your e-mail?
> I don't see what to do if there's a merge in the history and the depth
> on different sides is not equal.  E.g. the history looks like:
>
> ...a---b---c---d---e---f
>                   /     \
>       ...w---x---y       HEAD
>                         /
>         ...p---q---r---s
>
> Where "..." means that there are ancestors, but they're missing.
>
> > If you haven't updated for six months when the server walks backwards
> > for 10 change sets it's not going to find anything you have locally.
> > When this situation is encountered the server needs to generate a
> > delta just for you between one of the change sets it knows you have
> > and one of the 10 change sets you want. By generating this one-off
> > delta it lets you avoid the need to fetch all of the objects back to a
> > common branch ancestor. The delta functions as a jump over the
> > intervening space.
>
> Your choice of words keeps giving me the impression that you believe
> that a "change set" is a monolithic object that includes all the changes
> made to all the files.  It's neither monolithic nor composed of changes.
> A commit objects consists soley of metadata, and contains a pointer to
> a tree object, which points recursively to the entire project state at
> the time of the commit.

I was using change set to refer to snapshot.

> There is massive sharing of component objects between successive
> commits, but they are NOT stored as deltas relative to one another.

Yes, most of the sharing occurs via the tree structures.

> The pack-forming heuristics tend to achieve that effect, but it is not
> guaranteed or required by design.
>
> Please understand that, deep in your bones: git is based on snapshots,
> not deltas.
>
>
> But okay, so we've sent the client the latest 10 commits, with a dangling
> tail at the bottom.  (The files may have been sent as deltas against the
> old state, or just fresh compressed copies, but that doesn't matter.)
> Then the heads like "origin" have been advanced.
>
> So the old commit history is now unreferenced garbage; nothing points
> to it, and it will be deleted next time git-prune is run.  Is that
> the intended behavior?  Or should updates to an existing clone always
> complete the connections?

If you follow the links in what looks to be a dangling object sooner
or latter you will run into the root object or a 'not present' object.
If you hit one of those the objects are not dangling and should be
preserved.



Here is another way to look at the shallow clone problem. The only
public ids in a git tree are the head and tag pointers. Send these to
the client. Now let's modify the git tools to fault the full objects
in one by one from the server whenever a git operation needs the
object.  Dangling references would point to 'not-present' objects.

For a typical user using a model like this, how much of the Mozilla
repository would end up being faulted into their machine? Mozilla has
2M objects and 250K commits in a 450MB pack. My estimate is that a
typical user is going to touch less than 200K of the objects and maybe
less than 100K.

Of course always faulting in full objects is wasteful. A smart scheme
would be to try and anticipate with some read ahead and figure out
ways to send deltas. Tools like gitk would need to only touch the
objects needed to draw the screen and not run the full commit chain at
startup.

This experiment can be done fairly easily. Put all of the kernel
source into a single pack file.  Modify the git tools to set a bit in
the index file if an object is accessed. Use the pack for a few days
and then dump out the results.

-- 
Jon Smirl
jonsmirl@gmail.com

From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Rollback of git commands
Date: Tue, 27 Nov 2007 20:33:27 -0500
Message-ID: <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
	 <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 02:33:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxBoA-0006fv-4d
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 02:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760725AbXK1Bd3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 20:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760236AbXK1Bd3
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 20:33:29 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:32322 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786AbXK1Bd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 20:33:28 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1527739wah
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 17:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=8SIMUweNF9yBXRiYc/gDtydp8Ufci8WZcz6CdBMCpsM=;
        b=mUFgx7lVSRFencaLZiZZ1JtFQX6Dmrl7BSDCjbVlVMYrATVkxg5G+4jkVVM5U8z2UIRD59JQUxr801sONKPdlfIx+t7RvcjZHZxKMZhpEeiJBtDgjV511vzViYbDed2a0astT5UeqWpxWik2kVC7bbXx1n2caFHjxWuT9tYJ2ag=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oTrZ4Sy5hHhn4VpxSvISpEjX0YnQAcLE2sj70fLG2LRvZbVljIKHXr3/ZooUceHn91NCkYrn14CFeDAx58ZOzJ1oZH6kKV4LO02IKwCL6nJ6IVvnjntmKys53MyBgJnvc7g02RN3s8EVDgH2DB1RDrPOXrs5Ku/Lxt9XjJ2aPS0=
Received: by 10.115.47.1 with SMTP id z1mr267839waj.1196213607727;
        Tue, 27 Nov 2007 17:33:27 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Tue, 27 Nov 2007 17:33:27 -0800 (PST)
In-Reply-To: <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66283>

On 11/27/07, Junio C Hamano <gitster@pobox.com> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> > Could a rollback log be implemented in git? It would make things way
> > easier when you screw something up. You'd only roll back things that
> > impacted the object store, not things like checkout.
>
> The object store is append only, and if you disregard SHA-1 collisions,
> I do not think there is much you can gain from being able to roll back
> only object store.
>
> For example, you would want to be able to roll back where your 'master'
> branch was pointing at before you started that botched operation.  That
> is not in the object store at all (we have reflogs for that).
>
> Another example, you might have done quite an elaborate interactive add
> to stage only some changes to a path, but then accidentally said "git
> add" that path to stage the whole thing.  You may say "oops, that state
> was only in the index and now it is lost."  The blob that records the
> staged content _DOES_ exist in the object store in such a case so it is
> not lost --- there is nothing to roll back.  What you lost is a pointer
> into the object store (we do not have anything like reflog for
> individual index entry --- not that I would suggest adding one).
>
> Creating a blob that records all of .git/config, output from
> for-each-ref, output from "symbolic-ref HEAD" and output from ls-files
> -s every time you run _any_ git operation, and restore the state when
> you want to, would conceptually work, as you suggest, but I am not sure
> how practical it would be, performancewise, spacewise, and
> semanticswise.

I'm only looking for a command that would rollback the effect of
changes to the object store (you don't have to remove the objects).
Losing complex staging would be ok since it can be recreated.

Let's take my recent problem as an example. I typed 'git rebase
linus/master' instead of 'stg rebase linus/master'. Then I typed 'stg
repair'. The repair failed and left me in a mess. Both of these are
easy to rollback except for the fact that stg has stored a bunch of
state in .git/*.

After doing the commands I located my last commit before the rebase
and edited master back to  it. But my system was still messed up since
moving master got me out of sync with the state stg stored in .git/*.
The 'stg repair' command had changed the stored state.

Instead lets store the contents of .git/* (minus the data itself) as
objects. Then commit a new object after each command. Now rollback can
be accomplished by walking back this chain off commits. Rollback would
wipe out any staging, and effectively reset the working tree to match
the point rolled back to. I don't think we need to capture the entire
state of 'ls-file -s' to achieve this.

-- 
Jon Smirl
jonsmirl@gmail.com

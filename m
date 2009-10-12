From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Questions about the new
Date: Mon, 12 Oct 2009 23:54:18 +0200
Message-ID: <200910122354.18318.chriscool@tuxfamily.org>
References: <loom.20091012T115746-719@post.gmane.org> <4AD31EBF.6090307@viscovery.net> <4AD3619C.6010808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 13 00:08:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxT3q-0004FJ-NM
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 00:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbZJLVxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbZJLVxL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:53:11 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:46009 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932658AbZJLVxK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:53:10 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id F37E58183E0;
	Mon, 12 Oct 2009 23:52:27 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0C3A1818A16;
	Mon, 12 Oct 2009 23:52:25 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <4AD3619C.6010808@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130084>

On Monday 12 October 2009, Sergio Callegari wrote:
> Thanks Johannes for all the detailed explanations
>
> Johannes Sixt <j.sixt <at> viscovery.net> writes:

[...]

>  > With grafts you can only change parenthood; with replace entries you
>  > can change parenthood *and* all other aspects of a commit (message,
>  > author, committer, dates).
>  >
>  > Hence, replace entries are more general than grafts.
>
> Limiting the discussion to commit objects, I think there are two
> possible scenarios.
>
> 1) You create new commits objects as needed
> 2) You do not.
>
> If you follow 1), I believe grafts and replace entries have exactly the
> same flexibility.
>
> If I happen not to like commit B in A---B---C and I want A---B'---C
> where B' has
> completely different aspects from B I can either replace B by B' or
> graft away
> B, pretending that the parent of A is B

You mean "pretending that the parent of C is A", right?

> But there are many things that can be done with grafts merely adding a
> graft (e.g. cutting away a part of history, joining history),  that
> cannot be done with replace entries without creating new commits objects.

Yes, but when you create a graft, you add a new line in the graft file. You 
don't get the grafts for free.

> I was asking because I was wandering whether replace entries were first
> or later
> meant to make grafts deprecated. I hope not, because for a few things
> working on
> arcs seems still nice.

I don't think they will be deprecated soon. And anyway there will probably 
be a warning when a graft is used if it is deprecated.

[...]

>  > > Conversely, I guess
>  > > you can always simulate a replace entry with the graft mechanism,
>
> without the
>
>  > > need to add any extra commit object. Am I overlooking something?
>  >
>  > You cannot; see above.
>
> Well, I meant for what regards commit objects only.
>
> If I want to replace some commit X by some commit X' I merely need to
> modify the
> parent information of all the commits that are child of X so that they
> pretend
> to be child of X', or am I missing something?

If you use git replace you just need to create commit X' and then use "git 
replace X X'". If you use grafts, yes, you have to modify the parent 
information of all the commits that are child of X.

>  > You can even replace tree objects and blob objects
>  > using replace entries, IIUC, but you cannot do that with grafts.
>
> Definitely right!
>
>  > > 2) Is it currently possible to use a replace entry to replace a
>
> commit object
>
>  > > with nothing? Namely if B has A as its sole parent, is it possible
>
> to have a
>
>  > > replace entry such as A-sha1 becomes null, to pretend that B is a
>
> hierarchy
>
>  > > root?
>  >
>  > Sure. Just make a commit object that does not have parents.
>
> OK, you need to create a new commit object. At the beginning for some
> reason I
> thought that you could replace an object
> with "nothing" or 00000000000000000000000000000000000000000000
>
>  > > 3) If I remember correctly, there was a reason why grafts were not
>
> considered
>
>  > > suitable for transferring across repos. Can someone remind me about
>
> it? How
>
>  > > does the replace mechanism address this issue?
>  >
>  > The problem with grafts was that, for example, git-pack-objects
>
> obeyed the
>
>  > graft, and could create a broken repository by removing grafted-away
>  > objects. And since git-fsck also obeyed the graft, it did not notice
>  > the breakage.
>  >
>  > OTOH, history walkers (upload-pack, send-pack, pack-objects) and fsck
>  > never obey replace entries in the history. But they do keep track of
>  > them (and the history that they reference) because they are referenced
>
> from the
>
>  > refs/replace namespace.
>
> Thanks for the explanation. Can this be made possible for grafts too?
> Wouldn't
> it be a matter of having history walkers never obey grafts but keep track
> of them (i.e. of the history of the parenthood they reference)?

The problem is that grafts are special, so all the history walking commands 
should be changed to deal with them specially. With the replace mechanism, 
commits and refs are used, and all the commands already know how to deal 
with them.

> Like we have "annotated" or heavyweight tags living as objects in the
> database,
> would it be possible or make sense to have annotated grafts or replace
> entries,
> so that one can express why, by whom and when history was changed?

There is a patch series about "notes" floating around that deals with 
annotating any commit. So it could be used for that.

And anyway when you create the replacement commit, you can state in the 
commit message that it is a replacement commit, who created it, etc.

Regards,
Christian.

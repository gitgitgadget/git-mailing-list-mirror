From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 01:20:06 -0400
Message-ID: <32541b130806232220r292d691cn5bf5f9976126aa29@mail.gmail.com>
References: <alpine.LFD.1.10.0806232356340.2979@xanadu.home>
	 <1978205964779154253@unknownmsgid>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>, git@vger.kernel.org
To: "David Jeske" <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 07:21:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB0xo-00084H-Na
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 07:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751898AbYFXFUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 01:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751918AbYFXFUM
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 01:20:12 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:59178 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbYFXFUL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 01:20:11 -0400
Received: by fk-out-0910.google.com with SMTP id 18so2618236fkq.5
        for <git@vger.kernel.org>; Mon, 23 Jun 2008 22:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=pyit7o1PGRqBtOvxh/oRaaYdWQ7KembMa50bnLhXgg8=;
        b=hu2ETFuugO9BfWAzWiIsYLq5BKyKDzJ1fDISo74QK+l/AspyAAL/Kgxlf0VJ2vxygL
         RJUghYpTBDFL7/xzQhU/azmj6g4LQ38s3jVuyfkSs6ijQ6+aiEcl2gTl8woLVS4HRg5y
         wyqwa+fc+Je2W/QnWd/zCYhwkI9kMDDLBM17w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=aDa9c27H0w2ukrcDG4dQngWYsDG0XiJLDIzeyJoByild7HvD2k4YEGIAaBvhlQFOAP
         TAuPNTWbWwt0/Z7HLA3aD17fMPvY2/S1/Gt1e5dnPZsKFZfnwBjDdqBms0Vt7jNbqXhi
         CsIfAnmfXoTl2p2KVFuMPCSgvd6gt4slb08rk=
Received: by 10.82.187.2 with SMTP id k2mr543028buf.16.1214284806676;
        Mon, 23 Jun 2008 22:20:06 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Mon, 23 Jun 2008 22:20:06 -0700 (PDT)
In-Reply-To: <1978205964779154253@unknownmsgid>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85992>

On 6/24/08, David Jeske <jeske@google.com> wrote:
> I moved a branch around and then deleted it, and I don't see any record in the
>  reflog of where it was, or that it ever was.
>
>  Am I missing something about how branches are used? I see some language in "git
>  tag" about how attempts are made to assure that others can't move around
>  semi-immutable tags during push, but I don't see any such language about
>  branches. What prevents someone from accidentally deleting an old branch that
>  nobody is watching, but is important to the history and then not noticing as gc
>  silently deletes the old deltas?
>
>  I've had need to pull out versions several years old multiple times in my
>  career, so this is the kind of thing I'm thinking about.

git branches are actually a very different concept from branches in,
say, subversion.

In subversion, a branch is normally created so that you can do
parallel development, and then you merge whole batches of changes
(with 'svn merge') from one branch into another.  When you do this,
you create a single new commit in the destination branch that contains
*all* the changes.  So if you want to look back in history to see who
did which part of the change for what reason, you have to go back to
the branch you merged *from*.  Thus, it's very important in subversion
that old branches never disappear.

git's philosophy is different.  Branches are really just "temporary
tags".  A merge operation doesn't just copy data from one branch to
another: it actually joins the two histories together, so you can then
trace back through the exact history of the merged branches, commit by
commit.  "git log" will show each checkin to *either* branch
individually, instead of just one big "merge" checkin.

The end result is that even if you delete the source branch after
doing a merge, nothing is actually lost.  Thus, there's no reason for
git to try to make branches impossible to lose, as they are in svn.
In the event that you really needed that branch pointer, it's in the
reflog, as a few people have pointed out.

Another way to think of it is that svn's concept of a "branch" is
actually the "reflog" in git.  (svn records which data a particular
branch name points to over time, just like git's reflog does.)  git
branches are something else entirely; a git branch always points at
only a single commit, and has no history of its own.

Does that help?  Perhaps it only confuses the issue :)

Have fun,

Avery

From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Help breaking up a large merge.
Date: Thu, 18 Sep 2008 13:40:55 -0400
Message-ID: <32541b130809181040p4785f877s7502c578e46745d8@mail.gmail.com>
References: <20080918152154.GA27019@linode.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "David Brown" <git@davidb.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 19:42:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgNWR-0002lv-8j
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 19:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754968AbYIRRk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 13:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754929AbYIRRk5
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 13:40:57 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:10709 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755688AbYIRRk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 13:40:56 -0400
Received: by yx-out-2324.google.com with SMTP id 8so3798yxm.1
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 10:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=uYEbR7+zO8c75RnTx6fUWhtiYzVyZ2OTVHP3MeQAlLY=;
        b=LlqaVOBTcALg11tq79RCeID7FM2hyh+6Hhqm/wGlFjBJ7GK8cFaXBUCJlUqYAJ/fGY
         7901H3EslnPbbisfGJuPvWlBECaJjZHmQKZ8PHKH5wxswTvldKQAfqzMZXC7EESALMMG
         7x82DH7rQWxAr7Y462XLODYwGEsI06qJPzors=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=f+S15kYbYGslnkXu9e9K9CnONTNGTEpN8dVmOYaGJl6GHAT2XBq/r/InBcj98jgn1r
         VlkxA5/S68QluaTanOkDTMinLXd+wzTrh4KxfXcdfuawrNRY3+iS7e3i/muyP1HRLffL
         QLojbxHc9BI9ynJfRYAptPrUTQFxxzebnHZsE=
Received: by 10.150.137.9 with SMTP id k9mr1691281ybd.44.1221759655087;
        Thu, 18 Sep 2008 10:40:55 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Thu, 18 Sep 2008 10:40:55 -0700 (PDT)
In-Reply-To: <20080918152154.GA27019@linode.davidb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96227>

On Thu, Sep 18, 2008 at 11:21 AM, David Brown <git@davidb.org> wrote:
> The difficulty I'm having is that there are a lot of conflicts
> resulting from the merge (expected), and it would be nice to somehow
> be able to work on a smaller set of these conflicts at a time.
>
> Some of the conflicts are caused by a single change in the other tree.
> This is easy to cherry-pick into my tree, resolve, and then test those
> changes independently.

I've had the same sort of problem at work and I've gone through
several iterations trying to solve a problem.  The short version is
that all the solutions proposed here so far, plus some other ones I
thought of, don't seem to cut down the work for me :)

But here's one that has helped quite a bit, assuming that breaking up
the merge by *files* makes sense.

...

Let's say you have two branches, A and B, derived from a base X.  We
want to merge the branch with fewer changes on top of the branch with
more changes, because it'll be less work to divide up :)  Let's assume
the branch with fewer changes is A.

1) Generate a giant patch file using 'git diff X..A'.  Call the patch P.

2) Using an editor, divide up the patch by files/subdirs based on how
you want to subdivide the work.  Or alternatively, do that with 'git
diff' itself, but beware of accidentally forgetting to ask for some
files if you do it that way.  Call these n individual patches P1..Pn.

3) Create new branches called A1..An, copied directly from X.

4) Apply each patch P1..Pn to each branch A1..An.  (They will all
apply cleanly, because they are all patches against X in the first
place.)

5) Create new branches called B1..Bn, copied directly from *B*.

6) 'git merge' A1 into B1, A2 into B2, and so on.  Resolve the conflicts.

7) Create a new branch, TEST, copied from B.  Do an octopus merge from
B1..Bn.  There will be no conflicts, because those branches all make
mutually exclusive changes, and they're all based on B.  You now have
a combined branch containing A+B, but the history from A is missing.

8) Create a new patch, PFINAL, using 'git diff B..TEST'.  This is the
complete set of changes to turn B into A+B.

9) Checkout B.  'git merge A'; there will be conflicts.  'git checkout
HEAD .' to go back to B's files. Patch in PFINAL, and commit.

Now you have a single merge commit with all the changes, and the
history will be correct.

10) Optional: 'git merge B1..Bn' so that you don't lose the history of
the individual sub-merges (you might want to look at them later or use
them for blame purposes).  There shouldn't be any conflicts, as the
changes in those branches are identical to the changes you just
committed, and git will discard them in the extra merge.

10b) Optional advanced-only trick: amend the main commit so that it
looks like an octopus merge of B, A, and B1..Bn, instead of having a
separate fake merge commit.

Note that this also helps a lot (for me) even if it's just a single
person doing the merge: I like to do the library changes first, get
all the library unit tests passing, then move up to bigger and bigger
components.

Hope this helps.

Have fun,

Avery

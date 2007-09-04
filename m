From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Calculating tree nodes
Date: Tue, 4 Sep 2007 01:37:23 -0400
Message-ID: <9e4733910709032237y65ccafdai4889078533908fb0@mail.gmail.com>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com>
	 <20070904025153.GS18160@spearce.org>
	 <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
	 <Pine.LNX.4.64.0709040439070.28586@racer.site>
	 <9e4733910709032054y4407ce62o6b21935502bfacdb@mail.gmail.com>
	 <46a038f90709032121v54454c6fi500ee15497eec85c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 07:37:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISR6P-0000XP-FY
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 07:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbXIDFhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 01:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbXIDFhY
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 01:37:24 -0400
Received: from rv-out-0910.google.com ([209.85.198.184]:1696 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268AbXIDFhX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 01:37:23 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1090656rvb
        for <git@vger.kernel.org>; Mon, 03 Sep 2007 22:37:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J1zBA3paupmeQxUc3JAF+sK3p+PPiOjgb/2XDhO2uDHpO79h9wK977LyjuuFUJZxJ16voMcqZbPkZZXz/OZJlj2tauB2BuViIOpZV8CrLi8nkE5YLtw3Z0dlEEBm6Rg9G0ppnCP0kgyAvW8eaM5BIyqvnVSdxakSP33JKchv0yM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EgtWOaUMQoU0MWyWf0snDkEWaI603CTWfpFFjWLyl5XgIxLY9zJ/8GtjdpJk0NCO3sJ1UASLNoagZTNiBrlYcgUGFG0eCNB9w1ZeTZ2MnbDJqZUOtEvVbqSGEj65accpYgtzR/3oKmIQZG6txRmwkaDrZagcZQJk+cRbItJFazo=
Received: by 10.140.165.21 with SMTP id n21mr2255676rve.1188884243340;
        Mon, 03 Sep 2007 22:37:23 -0700 (PDT)
Received: by 10.141.44.16 with HTTP; Mon, 3 Sep 2007 22:37:23 -0700 (PDT)
In-Reply-To: <46a038f90709032121v54454c6fi500ee15497eec85c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57521>

On 9/4/07, Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On 9/4/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > Yes.  For performance reasons, since a simple commit would kill you in any
> > > reasonably sized repo.
> >
> > That's not an obvious conclusion. A new commit is just a series of
>
> Hi Jon!
>
> If you search the archives you'll find Linus explaining that the
> initial git had all the directory structure in one single "tree"
> object that held all the paths, not matter how deep. The problem with
> that was taht every commit generated a huge new tree object, so he
> switched to the current "nested trees" structure, which also has the
> nice feature of speeding up diffs/merges if whole subtrees haven't
> changed.

In my scheme the commit is only a list of SHA's. The paths are stored
as attributes of the file objects. Commits are just edits to the list
of SHA's in the commit objects. If these lists are kept sorted, then
the delta should be tiny. Just the info on the adds/deletes to the
list.

This is very different that a single tree blob that contains all of the paths.

Diffing two trees in the scheme is quite fast. Just get their commit
objects into RAM and compare the lists of SHAs.

> > edits to the previous commit. Start with the previous commit, edit it,
> > delta it and store it. Storing of the file objects is the same. Why
> > isn't this scheme fast than the current one?
>
> I think you're a bit confused between 2 different things:
>
>  - git is _snapshot_ based, so every commit-tree-blob set is
> completely independent. The "canonical" storage is each of those
> gzipped in .git/objects
>  - however, for performance and on-disk-footprint, we delta them (very
> efficiently I hear)

The systems are essential the same with a little reorganization. In
the current system the paths and SHA for a commit are spread over the
tree nodes.

In my scheme the path info is moved into the file object nodes and the
SHA list is in the commit node.

git still works exactly as it has before. I just moved things around
in the storage system. The only thing that should be impacted is
performance.


>
> So if you ask the GIT APIs about a tree, you end up dealing with the
> nested trees I describe. Similarly, if you ask for a blob, you get the
> blob. But internally git _is_ delta-compressing them.
>
> It's not compressing them immediately -- only when you run git gc. But
> from an API perspective, you don't have to worry about that.
>
> HTH
>
>
> martin
>


-- 
Jon Smirl
jonsmirl@gmail.com

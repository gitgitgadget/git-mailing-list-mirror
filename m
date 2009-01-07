From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [JGIT RFC] How read versions of a specific object
Date: Wed, 7 Jan 2009 15:23:23 +0600
Message-ID: <7bfdc29a0901070123q6b1b7d0at16d963ec9c9f97af@mail.gmail.com>
References: <7bfdc29a0901061944x454a9t1d01e6744f08cf78@mail.gmail.com>
	 <20090107040417.GA10790@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 10:24:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKUee-0002r4-BH
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 10:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753409AbZAGJX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 04:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752371AbZAGJX2
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 04:23:28 -0500
Received: from rn-out-0910.google.com ([64.233.170.186]:56868 "EHLO
	rn-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbZAGJXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 04:23:25 -0500
Received: by rn-out-0910.google.com with SMTP id k40so5638028rnd.17
        for <git@vger.kernel.org>; Wed, 07 Jan 2009 01:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kJEnHqEVWV/4h4xPxfIZt9ZgfDDDNzgREdP7yuEilMw=;
        b=dYN5sofN8UVeXttn1CNX0iw69FFEwua7hXVlekf4tLhOBqqmVCwbkCk+QCKdrYioV+
         rAG/VFbdIxmCP5zRXMcZCQqhXeeqUb//0hg4wWq4ymLnrteSI5suxubn3X130f/jH585
         Kp+m3ljKw4kQedY8y6uz+TBNvKaYQwKAKsO6A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wAzXOktbwIzWZpTdCzWjz7gzi9yfs64OAlAqRGfAgTLnzM4wkbqpIQBRk8BGrwiKBP
         dCOMyIfAXAbQaQq9f/IM3NPYrkH/VzuHO6bH9E5YiKgm20JGpRfonxdFIvrQCtaoU6fQ
         I7AAtR2FqMcanyXjwOEwtvG22cuz18qLV9m9E=
Received: by 10.150.201.2 with SMTP id y2mr21933582ybf.218.1231320203565;
        Wed, 07 Jan 2009 01:23:23 -0800 (PST)
Received: by 10.150.229.15 with HTTP; Wed, 7 Jan 2009 01:23:23 -0800 (PST)
In-Reply-To: <20090107040417.GA10790@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104778>

On Wed, Jan 7, 2009 at 10:04 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Imran M Yousuf <imyousuf@gmail.com> wrote:
>> I am trying to read all or n-th version of an object. Currently to do
>> this I am using the following piece of code, which has to walk to
>> every commit is present and from there prepare a set of its object id,
>> it is definitely expensive if the commit history is huge, is there a
>> faster/better way to achieve it?
>
> Not really. You can more efficiently use JGit and reduce some of
> the overheads, but that's about it.
>

Thanks Shawn, for pointing it out and it actually does improve the
performance, for every lookup its like 200ms.

Best regards,

Imran

>> for (int i = 0; i < App.OBJECT_COUNT;
>>             ++i) {
>>             ObjectWalk objectWalk = new ObjectWalk(repo);
>
> Don't use ObjectWalk, use a RevWalk.  You don't need it to keep
> track of tree or blob identities.  The ObjectWalk code has more
> overhead to do that bookkeeping.
>
>>                     Commit revision = repo.mapCommit(revObject.getId());
>>                     Tree versionTree = repo.mapTree(revision.getTreeId());
>>                     if (versionTree.existsBlob(isbn)) {
>>                         revisions.add(versionTree.findBlobMember(isbn).getId());
>
> Use a TreeWalk to do this.  Its quicker because it doesn't
> have to parse as much data to come up with the same result.
>
> More specifically there's a static factory method that sets up for
> a path limited walk and returns the TreeWalk pointing at that entry.
>
> You can use the fact that RevWalk.next() returns a RevCommit to get
> you the RevTree, which is the tree you need to give to the TreeWalk
> constructor (its the root level tree of the commit).
>
>
> But if App.OBJECT_COUNT is quite large and covers most of your
> objects, you are probably better off using a loop over the commits
> and diff'ing against the ancestor:
>
>        final HashMap<String, Set<ObjectId>> versions = ...;
>        final RevWalk rw = new RevWalk(repo);
>        final TreeWalk tw = new TreeWalk(repo);
>        rw.markStart(rw.parseCommit(repo.parse(HEAD)));
>        tw.setFilter(TreeFilter.ANY_DIFF);
>
>        RevCommit c;
>        while ((c = rw.next()) != null) {
>                final ObjectId[] p = new ObjectId[c.getParentCount() + 1];
>                for (int i = 0; i < c.getParentCount(); i++) {
>                        rw.parse(c.getParent(i));
>                        p[i] = c.getParent(i).getTree();
>                }
>                final int me = p.length -1;
>                p[me] = c.getTree();
>                tw.reset(p);
>                while (tw.next()) {
>                        if (tw.getFileMode(me).getObjectType() == Constants.OBJ_BLOB) {
>                                // This path was modified relative to the ancestor(s).
>                                //
>                                String s = tw.getPathString();
>                                Set<ObjectId> i = versions.get(s);
>                                if (i == null)
>                                        versions.put(s, i = new HashSet<ObjectId>());
>                                i.add(tw.getObjectId(me));
>                        }
>
>                        if (tw.isSubtree()) {
>                                // make sure we recurse into modified directories
>                                tw.enterSubtree();
>                        }
>                }
>        }
>
> --
> Shawn.
>



-- 
Imran M Yousuf
Entrepreneur & Software Engineer
Smart IT Engineering
Dhaka, Bangladesh
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557

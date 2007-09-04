From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git's database structure
Date: Tue, 4 Sep 2007 12:19:33 -0400
Message-ID: <9e4733910709040919u3d252b91s2785ed4d20086c88@mail.gmail.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
	 <46DD7FE4.1060908@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 04 18:19:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISb7q-0008Qc-Sm
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 18:19:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbXIDQTf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 12:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752688AbXIDQTf
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 12:19:35 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:64053 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752410AbXIDQTe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 12:19:34 -0400
Received: by wa-out-1112.google.com with SMTP id v27so2279273wah
        for <git@vger.kernel.org>; Tue, 04 Sep 2007 09:19:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HsZsdGt911+RkXRSZ/CsPh+OZ4EMJ9wuvDADJo+iYDhUMnr3NoOMwb/FOOto+3dEg0Rxop3OrGZdQeNflTTFjsSDyOjQrdUo7FhzuMG1ArDW7S08bN9MXdiaBes47aWwiYdzeqzHIYTBb8VQ56CJVwGxy9Ow+qlaW6klhuKh51s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WZ9tT7iY5LHKtgGCvlnoXzwZTWo50QU7964rAx5NeWqjohgfvtqdMlTxlrBJPnABbJuY3I8Y87lRKx+a8g3/FoaqLfgTyGn/jttKDNeEdx8Y0xW8BaHy/omUNqWpcusdT4SFWe3ANc2pTeWw7SNvrXoa0eSKiyEeHPAFI5A/ZtM=
Received: by 10.141.99.4 with SMTP id b4mr2351732rvm.1188922773087;
        Tue, 04 Sep 2007 09:19:33 -0700 (PDT)
Received: by 10.141.44.16 with HTTP; Tue, 4 Sep 2007 09:19:33 -0700 (PDT)
In-Reply-To: <46DD7FE4.1060908@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57607>

On 9/4/07, Andreas Ericsson <ae@op5.se> wrote:
> Jon Smirl wrote:
> > Let's back up a little bit from "Caclulating tree node".  What are the
> > elements of git's data structures?
> >
> > Right now we have an index structure (tree nodes) integrated in to a
> > base table. Integrating indexing into the data is not normally done in
> > a database. Doing a normalization analysis like this may expose flaws
> > in the way the data is structured. Of course we may also decide to
> > leave everything the way it is.
> >
> > What about the special status of a rename? In the current model we
> > effectively have three tables.
> >
> > commit - a set of all SHAs in the commit, previous commit, comment, author, etc
>
> > blob - a file, permissions, etc.
> > file names - name, SHA
>
> commit - SHA1 of its parent(s) and its root-tree, along with
>          author info and a free-form field
> blob - content addressable by *multiple trees*
> file names - List of path-names inside a tree object.
>
>
> To draw some sort of relationship model here, you'd have
>
> commit 1<->M roottree
> tree M<->M tree
> tree M<->M blob

By introducing tree nodes you have blended a specific indexing scheme
into the data. There are many other ways the path names could be
indexed hash tables, binary trees, etc.

This problem exists in files systems. Since the path names have been
encoded into the directory structures there is no way to query
something like "all files created yesterday" from a file system
without building another mapping table or a brute force search. I keep
using Google as an example, Google is indexing hierarchical URLs but
they do not use a hierarchical index to do it.

Databases keep the knowledge of how things are indexed out of the
data. A data structure analysis of git should remove the blended index
and start from the set theory.

> Assuming SHA1 never collides (collisions rule out any form of storage,
> so we might as well hope it never happens), that leaves us with this:
>
> Each root tree can only ever belong to a single commit, unless you
> intentionally force git to make completely empty commits. git
> won't complain about this, so long as you don't make two in the
> same second, because it relies more heavily on the DAG than on
> developer sanity.
>
> Each root tree can point to multiple sub-trees. The sub-trees can be
> linked to any number of root-trees.
>
> Blobs can be linked to any number of tree objects, or even multiple
> times to the same tree object. This wouldn't be possible if the
> blob objects had their own pathnames stored inside them, so to speak.
>
> >
> > The file name table is encoded as an index and it has been
> > intermingled with the commit table.
> >
> > Looking at this from a set theory angle brings up the question, do we
> > really have three tables and file names are an independent variable
> > from the blobs, or should file names be an attribute of the blob?
> >
>
> File names are not independant variables. They belong inside the
> table created for them, which is the tree objects.
>
> > How this gets structured in the db is an independent question about
> > how renames get detected on a commit. The current scheme for detecting
> > renames by comparing diffs is working fine. The question is, once we
> > detect a rename how should it be stored?
> >
>
> Do you realize that you're contradicting yourself in two upon each
> other following sentences here?
>
> Detecting renames after the fashion works fine. Not storing them
> is part of the "detect them by comparing diffs".
>
> > Ignoring the performance impacts and looking at the problem from the
> > set theory view point, should:
> > the pathnames be in their own table with a row for each alias
> > the pathnames be stored as an attribute of the blob
> >
> > Both of these are the same information, we're just looking at how
> > things are normalized.
> >
>
> Except that
>
> git init
> echo foo > a
> cp -a a b
> git add .
> git commit -m testing
> git count-objects
>
> yields 3 objects at the moment; A commit-object, a tree object and *one*
> blob object. With your scheme the 2 blob objects would differ, and there
> would be 4 of them. If you propose to ignore the path-name you have
> effectively broken support for having two identical files with different
> names in the same directory.
>
> Now, can you please tell me what gains you're hoping to see with this
> new layout of yours?
>
> --
> Andreas Ericsson                   andreas.ericsson@op5.se
> OP5 AB                             www.op5.se
> Tel: +46 8-230225                  Fax: +46 8-230231
>


-- 
Jon Smirl
jonsmirl@gmail.com

From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git's database structure
Date: Tue, 04 Sep 2007 17:55:16 +0200
Message-ID: <46DD7FE4.1060908@op5.se>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 17:55:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISakP-00024Z-En
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 17:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592AbXIDPzU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 11:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570AbXIDPzU
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 11:55:20 -0400
Received: from mail.op5.se ([193.201.96.20]:38826 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754515AbXIDPzT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 11:55:19 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 12E4419442E;
	Tue,  4 Sep 2007 17:55:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AFzb16BYDoUh; Tue,  4 Sep 2007 17:55:17 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id 585AE194424;
	Tue,  4 Sep 2007 17:55:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57602>

Jon Smirl wrote:
> Let's back up a little bit from "Caclulating tree node".  What are the
> elements of git's data structures?
> 
> Right now we have an index structure (tree nodes) integrated in to a
> base table. Integrating indexing into the data is not normally done in
> a database. Doing a normalization analysis like this may expose flaws
> in the way the data is structured. Of course we may also decide to
> leave everything the way it is.
> 
> What about the special status of a rename? In the current model we
> effectively have three tables.
> 
> commit - a set of all SHAs in the commit, previous commit, comment, author, etc

> blob - a file, permissions, etc.
> file names - name, SHA

commit - SHA1 of its parent(s) and its root-tree, along with
         author info and a free-form field
blob - content addressable by *multiple trees*
file names - List of path-names inside a tree object.


To draw some sort of relationship model here, you'd have

commit 1<->M roottree
tree M<->M tree
tree M<->M blob

Assuming SHA1 never collides (collisions rule out any form of storage,
so we might as well hope it never happens), that leaves us with this:

Each root tree can only ever belong to a single commit, unless you
intentionally force git to make completely empty commits. git
won't complain about this, so long as you don't make two in the
same second, because it relies more heavily on the DAG than on
developer sanity.

Each root tree can point to multiple sub-trees. The sub-trees can be
linked to any number of root-trees. 

Blobs can be linked to any number of tree objects, or even multiple
times to the same tree object. This wouldn't be possible if the
blob objects had their own pathnames stored inside them, so to speak.

> 
> The file name table is encoded as an index and it has been
> intermingled with the commit table.
> 
> Looking at this from a set theory angle brings up the question, do we
> really have three tables and file names are an independent variable
> from the blobs, or should file names be an attribute of the blob?
> 

File names are not independant variables. They belong inside the
table created for them, which is the tree objects.

> How this gets structured in the db is an independent question about
> how renames get detected on a commit. The current scheme for detecting
> renames by comparing diffs is working fine. The question is, once we
> detect a rename how should it be stored?
> 

Do you realize that you're contradicting yourself in two upon each
other following sentences here?

Detecting renames after the fashion works fine. Not storing them
is part of the "detect them by comparing diffs".

> Ignoring the performance impacts and looking at the problem from the
> set theory view point, should:
> the pathnames be in their own table with a row for each alias
> the pathnames be stored as an attribute of the blob
> 
> Both of these are the same information, we're just looking at how
> things are normalized.
> 

Except that

git init
echo foo > a
cp -a a b
git add .
git commit -m testing
git count-objects

yields 3 objects at the moment; A commit-object, a tree object and *one*
blob object. With your scheme the 2 blob objects would differ, and there
would be 4 of them. If you propose to ignore the path-name you have
effectively broken support for having two identical files with different
names in the same directory.

Now, can you please tell me what gains you're hoping to see with this
new layout of yours?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

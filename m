From: Erik Bernoth <erik.bernoth@gmail.com>
Subject: Understanding Git Under The Hood: Trees
Date: Thu, 15 Aug 2013 12:29:13 +0200
Message-ID: <CAB46HOnsOdYyt3sEe=iv3AJu_BDpTqCLKUpTBFQSnVGMZc8r8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 15 12:29:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9unv-0003nL-Uz
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 12:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754235Ab3HOK3Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 06:29:16 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:51076 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab3HOK3P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 06:29:15 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so271679eek.22
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 03:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=DGEoKfzsb2lQTbpdZcfPZCFiBgEkNK7ozHEuJwkdTgM=;
        b=jhVWoNeD5gOTEemoogemWAUelFnzzSRvw0wpowFsKSPIdlVohMEHIsdETbRzAc6Zmg
         sI+ENXefmzEOK+8TOPM6ym0VceB98X7pJZHqCFkZGkoAvJcbsZLls1lu3JWdOncHQV2D
         YER8N2SziUyrQU45OrX7gVFQOSLDh/SSpjFIyXbVZkaz7KLk9s3feQggsYNCzURB1aLB
         JFP+OmlqPbUIcJeu4JrM9Kd77Nh/kbL7du4Db0Hy6k4gmObbblvdAht4+Ew47YIu7yPA
         Ud9nKIwGqpfyTI/6GiKURK21eCH85eAWFvIl4RXSLuw/v0m7EWLHz6WKKEG2OL3WiSd5
         0Uwg==
X-Received: by 10.15.63.75 with SMTP id l51mr19360334eex.32.1376562554086;
 Thu, 15 Aug 2013 03:29:14 -0700 (PDT)
Received: by 10.223.4.70 with HTTP; Thu, 15 Aug 2013 03:29:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232340>

Hi,

I'm currently trying to understand the inner workings of git better by
writing a git clone in Python. I find it rather hard to understand how
to efficiently use trees.

What I understand is this: Trees are in essence blobs with a specific
content. The content is a relation between other blobs names, types
and modes. With these lines they can refer to other blobs and trees
and thus make a tine filesystem.

Now I constructed a system to read and write blobs and have an index
file that potentially references to a top tree object, which
represents the currently cached repository state. I can add and remove
files from the index manually, by creating the blob of the file and
working my way up adding or updating trees until I hit the one
referenced in INDEX. My algorithm to automate it is really ugly, error
prone and inefficient, though. I also have a hard time to find my way
around in C files, so maybe some people here in the list could explain
the algorithm in Git to me.

suppose we have the following Index:

INDEX
 -> tree
       -> tree "a/"
           -> blob "b.txt"
       -> tree "c/"
           -> blob "d.txt"

Now you want to stage a file with the following reference "a/e/g.txt".

One approach would be to walk top-down, splitting the path into its
elements and looking for the corresponding trees, either retrieving an
existing tree or creating a new one. Then finally create the blob
"g.txt" and be done with it. This seems rather inefficient, though,
because each created or updated tree means that all trees way back up
need to be updated as well, once for every step in the loop.

The other way is to go bottom-up, first creating the blob, then
creating trees up to the project root folder. But then I don't see a
way to find which tree elements already exist and need to be updated.

So the only algorithm I can come up with is this:
 1. walk down the tree with help of the path string to the tree that
is closest to the file I want to store. On the way remember all the
trees on the path from INDEX to the resulting file. (In the example
above I'd like to get the hash of the "a/" tree)
 2. create the blob (in the example with the context of g.txt)
 3. create the trees bottom-up until one step before the tree found in
1. (in the example create a "e/" tree, containing the "g.txt"'s blob)
 4. Add the resulting tree from 3. to the one found in 1. and create
the updated hash
 5. Now with help of the list from 1. walk the existing trees
bottom-up and update each one with the new hashes until INDEX is hit.
 6. Update INDEX.


Alltogether the idea of trees looked really simple and recursive which
makes me quite unhappy with the algorithm I came up with.


What is the algorithm to stage single files in Git itself?
How

Also: I thought to myself, why not just make a function that returns
the relative path to the repository root folder and consider that
string the file name, drop the idea of trees at all and add the
information that is traditionally stored in tree objects directly in a
commit object. Wouldn't that be much simpler and still accomplish the
same? I think the idea of keeping information in separate small files
instead of single big files was dropped at one point anyway, when
pack-files were introduced.


Cheers
Erik

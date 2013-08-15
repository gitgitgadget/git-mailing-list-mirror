From: Andreas Ericsson <ae@op5.se>
Subject: Re: Understanding Git Under The Hood: Trees
Date: Thu, 15 Aug 2013 14:40:51 +0200
Message-ID: <520CCC53.4090308@op5.se>
References: <CAB46HOnsOdYyt3sEe=iv3AJu_BDpTqCLKUpTBFQSnVGMZc8r8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erik Bernoth <erik.bernoth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 15 14:41:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9wrN-0003ET-AC
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 14:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754223Ab3HOMk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 08:40:57 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42348 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab3HOMk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 08:40:56 -0400
Received: by mail-lb0-f174.google.com with SMTP id w20so590986lbh.5
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 05:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=bF0ZAQMTlHl+he1Xtut7ZzGAOAIObO/1iJQpDGcYWH0=;
        b=nLWfgM9krRUnWUTcsvWnPpMtVdcbMo5JDBXumeK/LjmyBfK5I8HtEJNCHl3cGmkTbU
         V276yfHiigNAnLIETBSJH13/KzmomxC2Qay+34xgvBpbdFIXxyh6+/LMXKxSqTyns3Xb
         OuShtmVzSHgFnk1b4lcQ7PtMgp2g42ENr2APURuhNSrIscKn9tdcqDXYYhTMXTqsgO+Z
         FVMH4urPQERfsfGUW7q3bUZ2nfFXcm8JUke2ipp6YVK18WYEdCcWHhIf6VMZEgJdzWM7
         4UvZhbU5hG6WNjPFjyHzc0fsPX+LbUcifEWwmd6moKkHfTOHdn2ozY7GOIiZ2H+2+1N3
         gtQg==
X-Gm-Message-State: ALoCoQmcTw5JKWwwLxMCv4kpjBqgVuG0nlj5eSNfIftmVm6FodsEigkXlTHIiAb93wopPJ1fY1vn
X-Received: by 10.152.115.242 with SMTP id jr18mr1340660lab.40.1376570454668;
        Thu, 15 Aug 2013 05:40:54 -0700 (PDT)
Received: from lenix.dev.op5.com. (sth-vpn1.op5.com. [193.201.96.49])
        by mx.google.com with ESMTPSA id db5sm18100712lac.10.2013.08.15.05.40.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 05:40:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <CAB46HOnsOdYyt3sEe=iv3AJu_BDpTqCLKUpTBFQSnVGMZc8r8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232345>

On 2013-08-15 12:29, Erik Bernoth wrote:
> Hi,
>
> I'm currently trying to understand the inner workings of git better by
> writing a git clone in Python. I find it rather hard to understand how
> to efficiently use trees.
>
> What I understand is this: Trees are in essence blobs with a specific
> content. The content is a relation between other blobs names, types
> and modes. With these lines they can refer to other blobs and trees
> and thus make a tine filesystem.
>
> Now I constructed a system to read and write blobs and have an index
> file that potentially references to a top tree object, which
> represents the currently cached repository state. I can add and remove
> files from the index manually, by creating the blob of the file and
> working my way up adding or updating trees until I hit the one
> referenced in INDEX. My algorithm to automate it is really ugly, error
> prone and inefficient, though. I also have a hard time to find my way
> around in C files, so maybe some people here in the list could explain
> the algorithm in Git to me.
>
> suppose we have the following Index:
>
> INDEX
>   -> tree
>         -> tree "a/"
>             -> blob "b.txt"
>         -> tree "c/"
>             -> blob "d.txt"
>
> Now you want to stage a file with the following reference "a/e/g.txt".
>
> One approach would be to walk top-down, splitting the path into its
> elements and looking for the corresponding trees, either retrieving an
> existing tree or creating a new one. Then finally create the blob
> "g.txt" and be done with it. This seems rather inefficient, though,
> because each created or updated tree means that all trees way back up
> need to be updated as well, once for every step in the loop.
>
> The other way is to go bottom-up, first creating the blob, then
> creating trees up to the project root folder. But then I don't see a
> way to find which tree elements already exist and need to be updated.
>
> So the only algorithm I can come up with is this:
>   1. walk down the tree with help of the path string to the tree that
> is closest to the file I want to store. On the way remember all the
> trees on the path from INDEX to the resulting file. (In the example
> above I'd like to get the hash of the "a/" tree)
>   2. create the blob (in the example with the context of g.txt)
>   3. create the trees bottom-up until one step before the tree found in
> 1. (in the example create a "e/" tree, containing the "g.txt"'s blob)
>   4. Add the resulting tree from 3. to the one found in 1. and create
> the updated hash
>   5. Now with help of the list from 1. walk the existing trees
> bottom-up and update each one with the new hashes until INDEX is hit.
>   6. Update INDEX.
>
>
> Alltogether the idea of trees looked really simple and recursive which
> makes me quite unhappy with the algorithm I came up with.
>
>
> What is the algorithm to stage single files in Git itself?

You seem to believe that the in-memory representation of trees have to
be the same as the on-disk one. That's simply not true. Git cheats
outrageously with internal formats for pretty much everything in order
to squeeze out more performance.

You also seem to believe that a tree is more than one directory.
That's not true either.

So... Each tree that's updated can (and does) have an in-memory link
to its parent directory. Whenever we update a directory and create a
commit from it, we make sure to write them out from right to left (ie, 
children before parents), so that we're never in a state where a tree on 
disk can't find any of its content blobs in the same object storage.

With that information in hand, I'm sure you can quite easily create an
algorithm that turns out a bit prettier than what you have now.

>
> Also: I thought to myself, why not just make a function that returns
> the relative path to the repository root folder and consider that
> string the file name, drop the idea of trees at all and add the
> information that is traditionally stored in tree objects directly in a
> commit object.

Because commit objects must have parents and things like that. Also,
the idea of trees containing trees saves a *huge* amount of disk I/O
and space when updating a project with many subdirectories.

> Wouldn't that be much simpler and still accomplish the
> same?

Simpler; Yes. More efficient; No.

The commit that changed the tree structure from flat to hierarchical
dates back to April of 2005. It's commit number 25 in the history of
git and solves one of the first real problems from live-testing git
on the kernel repository, which was that tree-files got so huge when
they had to be rewritten in their entirety that creating a new commit
took several seconds.

> I think the idea of keeping information in separate small files
> instead of single big files was dropped at one point anyway, when
> pack-files were introduced.
>

Not really. We strive hard to minimize disk I/O whenever we can. The
packfiles actually reduce I/O, since it lets the kernel use the disk's
builtin caches a lot better, and read-ahead works to our advantage.

Btw, when I say "minimize disk I/O", I really mean "minimize user wait",
although disk I/O is certainly (often) the largest part of that.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.

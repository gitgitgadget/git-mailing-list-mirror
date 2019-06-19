Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E7CE1F462
	for <e@80x24.org>; Wed, 19 Jun 2019 13:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729642AbfFSNZX (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 09:25:23 -0400
Received: from codesynthesis.com ([142.44.161.217]:50146 "EHLO
        codesynthesis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfFSNZX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 09:25:23 -0400
Received: from [10.5.0.1] (unknown [178.219.147.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by codesynthesis.com (Postfix) with ESMTPSA id 6ECC05E6B7;
        Wed, 19 Jun 2019 13:25:21 +0000 (UTC)
To:     git@vger.kernel.org
Cc:     Boris Kolpackov <boris@codesynthesis.com>
From:   Karen Arutyunov <karen@codesynthesis.com>
Subject: Updating local tags: bugs and general feasibility
Organization: Code Synthesis
Message-ID: <981804d3-1485-f100-7b0e-8f1bc58226a5@codesynthesis.com>
Date:   Wed, 19 Jun 2019 16:25:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I'm trying to configure my git client to update local tags with the 
remote ones. Prior to git 2.20 the following option in ~/.gitconfig did 
the job:

[remote "origin"]
	tagopt = --tags

So the following commands worked as expected and the local tag gets updated:

# Create remote repository.
#
$ git init foo.git
$ touch foo.git/README
$ git -C foo.git/ add README
$ git -C foo.git/ commit -m "Release 1.0.0"
$ git -C foo.git/ tag -a -m "Tag version 1.0.0" "v1.0.0"

# Create local repository.
#
$ git clone foo.git

# Update remote repository moving the tag.
#
$ echo "TODO" >foo.git/README
$ git -C foo.git/ commit -a -m "Revision 1.0.0+1"
$ git -C foo.git/ tag -a -f -m "Tag version 1.0.0+1" "v1.0.0"
Updated tag 'v1.0.0' (was 3b773b1)

# Update local repository moving the tag.
#
$ git -C foo pull
...
t [tag update]      v1.0.0     -> v1.0.0
...

Staring with git 2.20 the last command expectedly (according to the 
git-fetch documentation) fails:

$ git -C foo pull
...
  ! [rejected]        v1.0.0     -> v1.0.0  (would clobber existing tag)

Replacing the tagopt option in ~/.gitconfig with the following helps and 
the above git-pull command succeeds:

[remote "origin"]
	fetch = +refs/tags/*:refs/tags/*

(This approach is recommended by several stackoverflow answers and
  studying git documentation gives the impression that it is the proper
  way to accomplish this.)

However, starting with git 2.21 in the presence of this configuration 
option I'm no longer able to clone any repository that contains tags:

$ git clone foo.git
Cloning into 'foo'...
done.
fatal: multiple updates for ref 'refs/tags/v1.0.0' not allowed
fatal: the remote end hung up unexpectedly

But still can succeed by running:

$ git init foo
$ git -C foo remote add origin ../foo.git
$ git -C foo fetch
...
 >From ../foo
  * [new tag]         v1.0.0     -> v1.0.0
  * [new branch]      master     -> origin/master
$ git -C foo checkout master

Note that the git version at the tip of the master branch (a6a95cd) 
behaves the same way.

Is it a bug or am I somehow misusing this fetch configuration option?

Yet another strange thing I've noticed (that also happens for git 
versions prior to 2.20) is that removing a remote tag also removes the 
local tag in the presence of this fetch configuration option:

$ git -C foo tag
v1.0.0
$ git -C foo push origin :v1.0.0
$ git -C foo tag

Is it a bug or does the fetch option somehow also affects the push 
operation?

The more general question: is overwriting tags, while generally not 
recommended, nevertheless a valid approach for some sensible use cases 
(e.g., a tag that always refers to the latest stable version or some 
such) or is this not going to be supported long term and we are on our 
own trying to accomplish this?

If the approach is considered to be valid, are there any plans to allow 
configuring a remote git repository in a way that when it is 
pulled/fetched, the local tags get updated without any additional 
configuration effort from the user?

Thanks,
Karen

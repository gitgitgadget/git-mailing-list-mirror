From: xmeng@cs.wisc.edu
Subject: Re: A generalization of git blame
Date: Wed, 26 Sep 2012 23:18:10 -0500
Message-ID: <a71b0f99366188f023e5bc8a5f704184.squirrel@webmail.cs.wisc.edu>
References: <89ccf5dd776edc648d488c20214e1105.squirrel@webmail.cs.wisc.edu>
    <CC2642CD25C542A18FB55E7BD58F95E5@PhilipOakley>
    <7vsja5vh2z.fsf@alter.siamese.dyndns.org>
    <72fc15c78ddb6b5c9e95f6b0cd925a26.squirrel@webmail.cs.wisc.edu>
    <7vfw64txa1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Philip Oakley" <philipoakley@iee.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 06:18:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TH5YQ-0002Xh-Fn
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 06:18:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab2I0ESQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 00:18:16 -0400
Received: from sandstone.cs.wisc.edu ([128.105.6.39]:55956 "EHLO
	sandstone.cs.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747Ab2I0ESP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 00:18:15 -0400
Received: from webmail.cs.wisc.edu (slappy.cs.wisc.edu [128.105.7.37])
	by sandstone.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id q8R4I9TJ007115;
	Wed, 26 Sep 2012 23:18:10 -0500
Received: from 108.249.32.195
        (SquirrelMail authenticated user xmeng)
        by webmail.cs.wisc.edu with HTTP;
        Wed, 26 Sep 2012 23:18:10 -0500
In-Reply-To: <7vfw64txa1.fsf@alter.siamese.dyndns.org>
User-Agent: SquirrelMail/1.4.22
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206459>

> It largely depends on how the user would interact with your program,
> which is totally unclear as we haven't seen any part of it.  I do
> not think we have enough information to answer the question at this
> point.

Do you mean it largely depends on the diversity of options on input and
output formats? Currently I just take a path and output lists like:

53: (1da177e4c3f41524e886b7f1b8a0c1fc7321cac2,Linus Torvalds)
(201b6264ff3865090747f58f48e087c3a35e0dbc,Christoph Lameter)
(e2bdb933ab8b7db71c318a4ddcf78a9fffd61ecb,Hugh Dickins)
54: (7cf9c2c76c1a17b32f2da85b50cd4fe468ed44b5,Nick Piggin)
(e2bdb933ab8b7db71c318a4ddcf78a9fffd61ecb,Hugh Dickins)
55: (e2bdb933ab8b7db71c318a4ddcf78a9fffd61ecb,Hugh Dickins)
56: (1da177e4c3f41524e886b7f1b8a0c1fc7321cac2,Linus Torvalds)

This shows for all lines in the specified file, all commits that have
changed a line.

I know this is not enough for a tool. So this is case, does "how the user
would interact with your program" mean that I should add more options like
which revision to start, some parameters in the algorithm, choice on
different diff algorithms, and options for customizing the contents of
output?

> If it is a trivial script that largely depends on what we already
> ship, I would not mind carrying it in contrib/.  If it is anything
> substantial and substantially useful, however, I would suspect that
> you are better off not be in in my tree, but rather want to be
> independent.  Finishing it to be useful for your purpose, publishing
> it somewhere people can take a look at and adding a pointer to
> https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools is
> probably where you would want to start.

I think it would be helpful for our discussion if I first briefly
introduce my approach. It starts at the current head and tracks all the
lines in the specified file. It then goes along the commit graph
topologically. For any two commits A and B connected by an edge from A to
B (commit B is the parent of commit A) and if A is not a merge commit, it
first calls the tree-diff interface to get the added lines  in A and
deleted lines in B, and detect renaming. Then it applies ldiff algorithm
(http://sourceforge.net/projects/ldiff/ . It is in perl. I adapt it into c
in my program) to match the added lines and deleted lines. The result is
that now we have some added lines, some deleted lines and some changed
lines. For added lines, I know the this commit is the last one to change
it. For changed lines, I add this commit to the final result and keep
tracking them. Currently I ignore those deleted lines. But if A is a merge
commit, it doesn't change authorship except for merge conflicts.

I did start with implementing my approach with python. The script keeps
calling git-log to get the diff and then apply ldiff. The problem is I
cannot store whole git-log result in the memory. Even the diff contents of
a specified file can explode my memory. So then I only query for a small
amount of commits each time. This makes my program extremely slow. It
takes about half hour to analyze a file in a project with 15000 commits.

Then I refactor my code based on git internal api. It turns out to work
very well. Now the program can finish in 10sec instead of half hour. And
now I can also apply my tool to larger project like linux kernel.

So if I want other people to use my tool, I firstly add an entry on the
webpage, and then other interested people can get my tool by cloning from
my git branch?


>  (1) We won't know how useful and interesting your contribution be
>      for our audience, until we see it; and
>
>  (2) If you truly believe in your work (find it useful, find writing
>      it fun, etc.), that would be incentive enough for you to work
>      on it, whether or not the result will land in my tree.  You
>      should instead aim for something so brilliant that we would
>      come to you begging for your permission to include it in our
>      project.
>
> I think it applies to your inquiry as well.

You are definitely right. Actually I have spent a lot of time on my tool.
I just want to know if there are some issues that I should know, otherwise
it will prevent me from publishing it or prevent it from becoming a
standard git built-in tool.

Thanks

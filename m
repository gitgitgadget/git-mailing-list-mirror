From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] git-branch: display sha1 on branch deletion
Date: Fri, 12 Dec 2008 17:17:44 -0600
Message-ID: <AeIdfC6dcUaLaDHDaAdSq8Mxz6QoUdeypSUI24erUEyAHVz4HeTSCw@cipher.nrlssc.navy.mil>
References: <uTIFnEi0iyLKcAungf7u1Gu2xl50j9i-AMiZaQp-QTs1q-ppgyHZoelGLgvK7BFKpYE03BLRHJ4@cipher.nrlssc.navy.mil> <20081212194349.GA5486@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 13 00:19:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBHIH-0003fz-E5
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 00:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183AbYLLXRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 18:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbYLLXRw
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 18:17:52 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50093 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbYLLXRw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 18:17:52 -0500
Received: by mail.nrlssc.navy.mil id mBCNHijx002522; Fri, 12 Dec 2008 17:17:44 -0600
In-Reply-To: <20081212194349.GA5486@sigill.intra.peff.net>
X-OriginalArrivalTime: 12 Dec 2008 23:17:44.0621 (UTC) FILETIME=[D699DDD0:01C95CAF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102965>

Jeff King wrote:
> On Fri, Dec 12, 2008 at 01:29:01PM -0600, Brandon Casey wrote:
> 
>> Make it easier to recover from a mistaken branch deletion by displaying the
>> sha1 of the branch's tip commit.
> 
> I think this is reasonable behavior, but I have two comments:
> 
>> -			printf("Deleted %sbranch %s.\n", remote, argv[i]);
>> +			printf("Deleted %sbranch %s (%s).\n", remote, argv[i],
>> +                                sha1_to_hex(sha1));
> 
> 1. Any reason not to use find_unique_abbrev(sha1, DEFAULT_ABBREV) here?

I didn't consider using find_unique_abbrev(). I used the same format
that 'git stash drop' uses. There is enough room for a 20-char branch
name without overflowing an 80-char line (unless you're deleting a
remote branch). I kind of like the exactness of the full sha1 in this
case.

>    The full 40-character sha1 kind of dominates the line, especially if
>    you have short branch name. And this is not really for long-term
>    usage, but rather "oops, I didn't mean to have just deleted that".

Actually, I'm more worried about line wrapping with a long branch name
than a short branch name being dominated by the 40-char sha1. I'd even
consider dropping the the word "branch " from the "Deleted branch ..."
message since the user already knows that a branch is being deleted.
So, this word-wrapping argument holds weight with me.

We read left to right and the sha1 is delimited by parenthesis, so I'm
not sure if the sha1 is dominating the line to the extent that it would
cause confusion.

For comparison:

  $ git stash drop
  Dropped refs/stash@{0} (a8381dd3d3ea4e7bc83c2bfe7d1c27fa180632ee)

compared to:

  $ git branch -d my_branch_name
  Deleted branch my_branch_name (ca26e31d5442f3d1ef8ae1cb69970fb31ed4b841).

or

  $ git branch -d my_branch_name
  Deleted branch my_branch_name (ca26e31d).

or

  $ git branch -d my_branch_name
  Deleted my_branch_name (ca26e31d5442f3d1ef8ae1cb69970fb31ed4b841).

But since the longest branch that has been merged in the git history
was 40 characters, maybe it does make sense to abbreviate the sha1.

> 2. I wonder if it is confusing to new users to simply say "Delete branch
>    $branch ($sha1)". We haven't deleted $sha1, just the branch pointer.
>    $sha1 is probably still in the HEAD reflog, if not in another branch.
>    Maybe something like "(was $sha1)" would be appropriate.
>
> I don't know if '2' is a big deal. I haven't been a new user for a long
> time, so I didn't personally find it confusing (especially with '1' so
> that you actually notice the branch name rather than the gigantic sha1).

  Deleted branch my_branch_name (was ca26e31d).

I don't find it confusing (obviously) without the addition of "was ", but
I too haven't been a new user in a while.

-brandon

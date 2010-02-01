From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Partially private repository?
Date: Mon, 01 Feb 2010 09:20:47 +0100
Message-ID: <4B668EDF.5030409@viscovery.net>
References: <78d8a6b51001291401ib93976el25c03694d53aaced@mail.gmail.com>	 <32541b131001291410g252ddff4lbf04ac7c1d2d33fc@mail.gmail.com> <78d8a6b51001312059s1811b631y838679a3f63188b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Daed Lee <daed@thoughtsofcode.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 09:20:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbrWk-0003Dh-Aa
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 09:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab0BAIUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 03:20:52 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:59581 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab0BAIUv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 03:20:51 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NbrWa-0001FX-D4; Mon, 01 Feb 2010 09:20:48 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 16D2B1660F;
	Mon,  1 Feb 2010 09:20:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <78d8a6b51001312059s1811b631y838679a3f63188b0@mail.gmail.com>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138592>

Daed Lee schrieb:
> On Fri, Jan 29, 2010 at 5:10 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
>> On Fri, Jan 29, 2010 at 5:01 PM, Daed Lee <daed@thoughtsofcode.com> wrote:
>>> Hi, I'm wondering if git can handle the following use. I have a
>>> project that started as private experiment, but has morphed into
>>> something I'd like to release publicly. I want to give others access
>>> to the repository, but only to commits after a certain cutoff date.
>>> Commits prior to that date have things like hardcoded file paths,
>>> emails, etc. that I'd like to keep private.
>>>
>>> I suppose the easiest thing to do would be to create a new repository,
>>> add the project files to it, and make that public, however I'd like to
>>> keep my private commit history along with the public commit history
>>> going forward in a single repository if possible. Is there a way to do
>>> this with git?
>> You should probably split your history into two pieces: the "before"
>> and "after" parts.  To split out the "after" part, you could use
>> git-filter-branch
>> (http://www.kernel.org/pub/software/scm/git/docs/v1.6.0.6/git-filter-branch.html).

Sidenote: http://www.kernel.org/pub/software/scm/git/docs/git.html is the
most up-to-date version with pointers to older versions. The page for
filter-branch has an example how to prune history with grafts.

>>  Then, in your private copy of the repo, you could reattach the
>> "before" part of the history using git grafts.

That is, you use grafts twice: Once to split off the "after" part, again
to re-attach it locally.

> Going forward, if I made changes to my private repository (containing
> the "before" and "after" parts) and pushed to the public repository
> (containing only the "after" part), would this only push the commits
> in the "after" part? Essentially, I want to develop in my private
> repository and see my "before" and "after" changes when I "git
> log/show", but only push the "after" changes to the public repository.

The thing is that grafts are an old mechanism, and they do not always do
the right thing. In particular, when you push the "after" part that you
have spliced with the "before" part using a graft, then the objects in the
"before" part will be pushed as well. But since the remote repository does
not have the graft, these objects are inaccessible - *except* when offer
access via dumb protocols (rsync or dumb http).

There is a newer mechanism: 'git replace'. It does the right thing. That
is, after you have split the "before" and "after" parts (using a graft and
filter-branch), you splice them together using 'git replace'.

Here is a recipe that should do it (not tested, try it on a clone):

--- 8< ---
# interesting commits
first_after=first-commit-of-the-after-part  # all 40 digits!
before=$first_after^
git tag first-after $first_after

# split using a graft
echo $first_after > .git/info/grafts
git filter-branch --tag-name-filter=cat -- --all --not $before

# reattach
git replace first-after $first_after
--- 8< ---

We know that the old $first_after has the right parenthood that we need to
re-attach the split histories. We tag $first_after, and make sure the tag
gets rewritten. Then we can use the tag name in the 'git replace' call:
The tag name points to the rewritten (parentless) commit, and $first_after
is the old commit whose parent points to "before".

> I've also been looking into private branches. Could I do something
> like keep my "before" changes on a private branch, and then do all
> future development on a public branch?

You can, and you *must* do that, i.e., you must have a branch (or tag)
that points to the last commit on the "before" part. Otherwise, it is all
too easy to garbage-collect this part.

But you must make sure that you never merge a private branch into the
public history.

-- Hannes

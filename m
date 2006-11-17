X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: linux@horizon.com
Subject: Re: [DRAFT] Branching and merging with git
Date: 16 Nov 2006 20:13:19 -0500
Message-ID: <20061117011319.6738.qmail@science.horizon.com>
References: <7vslgj2bug.fsf@assigned-by-dhcp.cox.net>
NNTP-Posting-Date: Fri, 17 Nov 2006 01:13:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vslgj2bug.fsf@assigned-by-dhcp.cox.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31653>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GksIK-00063U-Ms for gcvg-git@gmane.org; Fri, 17 Nov
 2006 02:13:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424856AbWKQBNV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 20:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424857AbWKQBNV
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 20:13:21 -0500
Received: from science.horizon.com ([192.35.100.1]:39723 "HELO
 science.horizon.com") by vger.kernel.org with SMTP id S1424856AbWKQBNU (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 20:13:20 -0500
Received: (qmail 6739 invoked by uid 1000); 16 Nov 2006 20:13:19 -0500
To: junkio@cox.net, linux@horizon.com
Sender: git-owner@vger.kernel.org

> I find it very balanced to point out the quirks people
> would find difficult and explain why things are so by including
> historical notes in appropriate places when needed.

I'm trying; I've been following git since day 1, so occasionally an
obsolete fact gets stuck in my head.

If anyone has any advice on how and why one would invoke git-merge
directly (the one why I know is to do a >2-way merge), that would
be appreciated.

> I have finished only the first half because it's not my git day
> today, but so far...

Well, thank you for your time!

>> * Naming revisions
>>...
>> Second, you can refer to a head or tag name.  Git looks in the
>> following places, in order, for a head:
>> 	1) .git
>> 	2) .git/refs
>> 	3) .git/refs/heads
>> 	4) .git/refs/tags
> 
> You might want to check this with the array in sha1_name.c::get_sha1_basic().
> I think tags comes earlier than heads.

Quite right.  It's

        static const char *fmt[] = {
                "%.*s",
                "refs/%.*s",
                "refs/tags/%.*s",
                "refs/heads/%.*s",
                "refs/remotes/%.*s",
                "refs/remotes/%.*s/HEAD",
                NULL
        };

>> 2) Revert changes to a small number of files.
>>
>> 	git checkout [<revision>] [--] <paths>
>>    will copy the version of the <paths> from the index to the working
>>    directory.  If a <revision> is given, the index for those paths will
>>    be updated from the given revision before copying from the index to
>>    the working tree.
>>
>>    Unlike the version with no <paths> specified, this does NOT update
>>    HEAD, even if <paths> is ".".
> 
> It's great that you talk correctly about the latest feature-fix
> that is queued for maint but not yet pushed out.

Um... there's a fix in there?  I thought that's how it always worked.

> "If there's a side branch which does NOT touch the paths..." I think.

Ah, yes, I added include/scsi to the example to illustrate how
mutiple paths worked and didn't update the later paragraph.

>> * Alternate branch naming
>>
>> The original git scheme mixes tracking branches with all the other heads.
>> This requires that you remember which branches are tracking branches and
>> which aren't.  Hopefully, you remember what all your branches are for,
>> but if you track a lot of remote repositories, you might not remember
>> what every remote branch is for and what you called it locally.
> 
> I think you wanted to mention .git/refs/remotes hierarchy and
> separate-remote here, but haven't elaborated yet...

Yes, sorry.  I meant to research that and update this (I've never used
it before), but I forgot.

>> * Remote tags
>>
>> TODO: Figure out how remote tags work, under what circumstances
>> they are fetched, and what git does if there are conflicts.
> 
> refs/tags namespace is not policed at all by git and is treated
> as a global namespace, controlled mostly by social convention
> that your "upstream" (or central distribution point) supplies
> tags for people who use it to synchronize to share.  Also, since
> there is no guarantee that tags point at commits (v2.6.11-tree
> tag is a pointer to a tree object, for example), there is no
> farst-forward check performed for them.
> 
> The rule we use to autofollow tags currently is:
> 
> When you use shorthand fetch (or pull), we find tags that do not
> exist locally, and if the object they point at are already found
> in the repository then we fetch them automatically.  So for
> example, if you are only tracking my 'maint' and not 'master'
> nor 'next', and if you have tags up to v1.4.3.2, your "git fetch
> origin" would update your copy of 'maint' and bring the commits
> reachable from the tip of my 'maint'.  After that it notices
> that v1.4.3.3, v1.4.3.4, v1.4.3.5 tags are in my repository but
> missing from yours. It also notices that now you have
> v1.4.3.3^{}, v1.4.3.4^{} and v1.4.3.5^{} in your repository, so
> it issues another round of "git fetch" internally to fetch these
> three tags.  At the same time it would also notice that I have
> v1.4.4 tag that you do not have, but v1.4.4^0 commit is not
> something you would get by fetching 'maint', so it would not
> fetch it automatically.

Ah, okay.  Actually, v2.6.11-tree is a tag object
(5dc01c595e6c6ec9ccda4f6f69c131c0dd945f8c) which points
to a tree object (c39ae07f393806ccf406ef966e9a15afc43cc36a).

I was wondering if git only shared refs/tags that pointed to
heavyweight tag objects and not lightweight tags.

That appears to be the case:

mkdir a b
cd a
git-init-db
echo "Hello, world" > hello
git add hello
git commit -m "Initial commit"
git tag light
git tag -a -m "Test tag" heavy
cd ../b
git-init-db
echo "URL: ../a" > .git/remotes/a
echo "Pull: master:origin" >> .git/remotes/a
git fetch a

But!  It only fetches tags if you specify a destination branch name.
I hadn't noticed that before, but "git-fetch <url> foo" and
"git-fetch <url> foo:foo" do different things on the receiver.
Didn't they used to be synonyms?
(I think it's a net gain in flexibility.)

Oh!  Also, the git-pull man page says that multiple branch names are
allowed, even though the SYNOPSIS line says no.

I also need to mention that if you want to pull a remote tag,
you need to prefix it with "tags/".  For some reason, the search

From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Thu, 14 May 2009 11:37:37 +0200
Message-ID: <op.utwyczlf1e62zd@merlin.emma.line.org>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
 <op.utwdsutn1e62zd@merlin.emma.line.org>
 <7v8wl01iev.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Erik Faye-Lund" <kusmabite@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 11:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4XNu-0006q8-0R
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 11:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694AbZENJhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 05:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbZENJhm
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 05:37:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:48331 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752422AbZENJhl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 05:37:41 -0400
Received: (qmail invoked by alias); 14 May 2009 09:37:40 -0000
Received: from e177047208.adsl.alicedsl.de (EHLO mandree.no-ip.org) [85.177.47.208]
  by mail.gmx.net (mp041) with SMTP; 14 May 2009 11:37:40 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX19zdbpJk3xzPTSdRjHB/1BqifYX7p05YxEAtOB21H
	jdApEbxhfL+K49
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id F119E94459;
	Thu, 14 May 2009 11:37:37 +0200 (CEST)
In-Reply-To: <7v8wl01iev.fsf@alter.siamese.dyndns.org>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119176>

Am 14.05.2009, 05:18 Uhr, schrieb Junio C Hamano <gitster@pobox.com>:

> "Matthias Andree" <matthias.andree@gmx.de> writes:
>
>> Am 14.05.2009, 02:53 Uhr, schrieb Matthias Andree  
>> <matthias.andree@gmx.de>:
>>
>>> 2. how do I trash the accidentally created 2nd "baz" tag object,
>>> i. e.  remove it from the (packed) object database? Of course, I can
>>> hack some  script (or use a text editor) to grind this
>>> git-fast-export into shape  and re-importing it...
>>
>> OK, that worked: I traced (with git cat-file) the tree through all
>> tagged  tag until the first tagged commit, and hack packed-refs (or
>> refs/tags/foo)  to point to the commit object, and afterwards prune
>> the dangling tag.
>>
>> However, the other questions remain. I'd think git tag should
>> dereference  its 2nd non-option argument to a commit before laying
>> down the tag...
>
> No.  You can tag any object, and a tag is an object.  You can point a
> signed tag with your own signed tag to attest your own belief on that
> other guy's tag, be it "it's genuine", "the tagged commit suits my need",
> etc.

OK, so I can tag/sign any object, fine.

HOWEVER, I see two problems here (yes, they are corner cases):

#1: git tag -f ("replace tag") fails to "replace" a heaviweight tag if I  
try to replace a tag by itself (or create a cycle by some other means).

The new "foo" is unique in refs (OK), but it's *not unique* in objects  
(FAIL), as the old "foo" is referenced by the new "foo" and bears the same  
tag name.

It screws the repo, breaking the uniqueness of tags. Basically, git tag -f  
is implementing a half-baked, non-working "rebase tag objects"  
functionality.



#2: related: git tag -d cannot reliably delete tag objects

Same here: if another tag object references the tag object I'm deleting,  
we only delete the ref, but not the tag object. It doesn't (cannot) become  
dangling.



Watch:

$ cd $(mktemp -d)
$ git init
Initialized empty Git repository in /tmp/tmp.GBjHED4Xj8/.git/
$ date >a
$ git add a
$ git commit -m "new file a" -a
[master (root-commit) 4481a15] new file a
  1 files changed, 1 insertions(+), 0 deletions(-)
  create mode 100644 a
$ LANG=C git tag foo -m "add tag foo" -s
[GPG passphrase query]
$ LANG=C git tag foo foo -m "add tag foo" -s
fatal: tag 'foo' already exists

-> this is ok, now let's break uniqueness:

$ LANG=C git tag foo foo -m "add tag foo" -s -f
[GPG passphrase query]
$ git rev-list --objects --all
4481a15d999b1b13066fe932e35ea05b8b1027a6
72f3463f5a8089ac91001d458ceffb6d4e1056ee foo
2e326d8a210536b7cd1f2bc77e3e29d7231f9ec4 foo
995773fc9b649922936e110207e6abb904cc18e8
15a9779d8f787428e57830410c7842e5449dfd33 a
$ git show-ref
4481a15d999b1b13066fe932e35ea05b8b1027a6 refs/heads/master
72f3463f5a8089ac91001d458ceffb6d4e1056ee refs/tags/foo
$ git cat-file tag 72f346
object 2e326d8a210536b7cd1f2bc77e3e29d7231f9ec4
type tag
tag foo
tagger Matthias Andree <matthias.andree@gmx.de> 1242289836 +0200

add tag foo
-----BEGIN PGP SIGNATURE-----
...
$
$ git cat-file tag 2e326d
object 4481a15d999b1b13066fe932e35ea05b8b1027a6
type commit
tag foo
tagger Matthias Andree <matthias.andree@gmx.de> 1242289732 +0200

add tag foo
-----BEGIN PGP SIGNATURE-----
...


So what we get is (root/parents first, then children):

objects:  4481a1 (commit) <- 2e326d (tag "foo") <- 72f346 (tag "foo")
refs:     heads/master                             tags/foo

Whoops. "foo" is there twice, and it's referenced from a current ref.
We have *not* *replaced* it. *If* we did, we should have got:

objects:  4481a1 (commit) <- 72f346 (tag "foo")
refs:     heads/master       tags/foo
with a dangling tag 2e326d

> I thought there was a breakage report followed by a fix to the  
> fast-export that mishandled a tag that points at another tag not too  
> long ago.  Do you have 1982467 (builtin-fast-export.c: handle nested  
> tags, 2009-03-23)?

I have that beast (how do I QUICKLY check if that is reachable from  
refs/master? git log | grep isn't exactly quick), but I think that's  
unrelated. The real problem is the tag name is no longer unique, and we  
must prevent that.

Let's screw with the tag objects even more (fresh repo, some "otherfile"):

$ git tag -m "old tag1" -a tag1
$ git tag -m "tag2" -a tag2 tag1
$ git tag -m "new tag1" tag1 tag2
fatal: tag 'tag1' already exists
$ git tag -f -m "new tag1" tag1 tag2
$ git rev-list --objects tag1
69bf327c5d172fc8e4f63acf4d2e01c474824ce4
8e7a1997726fc5158954569134d2cafad710f6fe tag1
38aea56fec319d8c259a80157dde2432d2d09b2b tag2
9756f6fa98a5cce2aab1f6a6e7dd4de515626e19 tag1
d758baa57a7ef20d44df0535bef1a91bb3dc4f62
d3d8863b140f43f7c07050b9f2e210d41e73edb1 otherfile
$ git show-ref
69bf327c5d172fc8e4f63acf4d2e01c474824ce4 refs/heads/master
8e7a1997726fc5158954569134d2cafad710f6fe refs/tags/tag1
38aea56fec319d8c259a80157dde2432d2d09b2b refs/tags/tag2
$ gitk
$ git cat-file tag 8e7a
object 38aea56fec319d8c259a80157dde2432d2d09b2b
type tag
tag tag1
tagger Matthias Andree <matthias.andree@gmx.de> 1242292320 +0200

new tag1
$ git cat-file tag 38ae
object 9756f6fa98a5cce2aab1f6a6e7dd4de515626e19
type tag
tag tag2
tagger Matthias Andree <matthias.andree@gmx.de> 1242292301 +0200

tag2
$ git cat-file tag 9756
object 69bf327c5d172fc8e4f63acf4d2e01c474824ce4
type commit
tag tag1
tagger Matthias Andree <matthias.andree@gmx.de> 1242292293 +0200

old tag1

Hu, there's a nice cycle:

69bf (commit) <- 9756 ('old' tag1) <- 38ae (tag2) <- 8e7a (tag1)

Now, more fun - watch the inconsistency:

$ git tag -d tag1
Deleted tag 'tag1'
$ git tag -d tag1
error: tag 'tag1' not found.

Ha! As if... now watch this:
$ git rev-list --objects  --all | while read a b ; do echo "$a $(git  
cat-file -t $a) $b" ; done
69bf327c5d172fc8e4f63acf4d2e01c474824ce4 commit
38aea56fec319d8c259a80157dde2432d2d09b2b tag tag2
9756f6fa98a5cce2aab1f6a6e7dd4de515626e19 tag tag1
d758baa57a7ef20d44df0535bef1a91bb3dc4f62 tree
d3d8863b140f43f7c07050b9f2e210d41e73edb1 blob otherfile

The tag object "tag1" is still there. WHOOPS!!!

I appreciate that this isn't trivial to solve, but I presume anything that  
walks the object database and uses tags can fail - including, but not  
limited to, git fast-export.

Either git tag -f/-d should complain and refuse if it cannot  
replace/remove the tag because it wouldn't become dangling (other  
dependencies on it, best to list them), or it would have to recursively  
trash all its children, too - and perhaps require -f -f be specified for  
this recursive replacing/removal.

-- 
Matthias Andree

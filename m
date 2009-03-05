From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: What's cooking in git.git (Mar 2009, #01; Tue, 03)
Date: Thu, 5 Mar 2009 07:43:49 +0100
Message-ID: <200903050743.49858.chriscool@tuxfamily.org>
References: <7vprgzdlom.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 07:47:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf7Ma-0007c9-Sw
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 07:47:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbZCEGos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Mar 2009 01:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752388AbZCEGor
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 01:44:47 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:36180 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752297AbZCEGoq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Mar 2009 01:44:46 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CD4B481803B;
	Thu,  5 Mar 2009 07:44:37 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id DC71B8180DA;
	Thu,  5 Mar 2009 07:44:34 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vprgzdlom.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112257>

Le mardi 3 mars 2009, Junio C Hamano a =C3=A9crit :
> * cc/replace (Mon Feb 2 06:13:06 2009 +0100) 11 commits
>  - builtin-replace: use "usage_msg_opt" to give better error messages
>  - parse-options: add new function "usage_msg_opt"
>  - builtin-replace: teach "git replace" to actually replace
>  - Add new "git replace" command
>  - environment: add global variable to disable replacement
>  - mktag: call "check_sha1_signature" with the replacement sha1
>  - replace_object: add a test case
>  - object: call "check_sha1_signature" with the replacement sha1
>  - sha1_file: add a "read_sha1_file_repl" function
>  - replace_object: add mechanism to replace objects found in
>    "refs/replace/"
>  - refs: add a "for_each_replace_ref" function
>
> I think the code is much cleaner than the first round, but I am not
> convinced it is doing the right thing in the connectivity traverser.
> Independent review sorely needed.

I haven't look much at connectivity traverser lately but I think I
should first describe some of the issues in other areas.

There are command to reproduce all the steps. (You have to use pu.)

#
# Let's start by creating a good environment to test a few things:
#

$ cd git/t
$ sed -e 's/test_done/exit 1\ntest_done/' t6050-replace.sh > tt.sh
$ ./tt.sh
*   ok 1: set up buggy branch
*   ok 2: replace the author
*   ok 3: tag replaced commit
*   ok 4: "git fsck" works
*   ok 5: repack, clone and fetch work
*   ok 6: "git replace" listing and deleting
*   ok 7: "git replace" replacing
=46ATAL: Unexpected exit with code 1
$ cd trash\ directory.tt

#
# Now let's see what happens when we replace an object:
#

$ git rev-parse HEAD
ffccc9d552388844dbe94a361c07e7cb1731e12f
$ git cat-file commit ffccc
tree 5c37393794868bc8e708cccd7c9d9aaa7a5e53cb
parent 14ac020163ea60a9d683ce68e36c946f31ecc856
author A U Thor <author@example.com> 1112912353 -0700
committer C O Mitter <committer@example.com> 1112912353 -0700

hello: again 3 more lines
$ git ls-tree 5c37
100644 blob 47ea9c3df4682ae7d2c9139fa9ac6dbc9b6eb43d    hello
$ git cat-file blob 47ea9c3df4682ae7d2c9139fa9ac6dbc9b6eb43d |=20
sed -e 's/line 7/changed line 7/' > new_hello
$ cat new_hello | git hash-object -t blob --stdin -w
201722c515afacad101b62525a9e57899eac5182
$ git replace 47ea9c3df4682ae7d2c9139fa9ac6dbc9b6eb43d=20
201722c515afacad101b62525a9e57899eac5182

#
# So now the tree of the current commit has a blob that is replaced.
# The problem is that we don't see it, except if we "touch" the file:=20
#

$ git diff
$ touch hello
$ git diff
diff --git a/hello b/hello
--- a/hello
+++ b/hello
@@ -4,7 +4,7 @@ line 3
 line 4
 line 5
 line 6
-changed line 7
+line 7
 line 8
 line 9
 line 10

#
# And now we cannot create a commit with the above diff:
#

$ git commit hello
=2E..
nothing added to commit but untracked files present (use "git add" to t=
rack)
$ git add hello
$ git status
=2E..
nothing added to commit but untracked files present (use "git add" to t=
rack)

#
# So I am not sure if that is a big problem, because that happens only
# if we want to commit something exactly like what we replaced. And in
# this case the best thing to do might be to simply remove the replace
# ref.
#

$ git replace -d 47ea9c3df4682ae7d2c9139fa9ac6dbc9b6eb43d
$ git diff
$ touch hello
$ git diff

#
# We got back to a normal situation.
#
# Now let's try something different
# First let's replace the current commit:
#

$ git rev-parse HEAD
ffccc9d552388844dbe94a361c07e7cb1731e12f
$ git cat-file commit ffccc | sed -e "s/A U/O/" | git hash-object -t=20
commit --stdin -w
$ git cat-file commit dd1ca
tree 5c37393794868bc8e708cccd7c9d9aaa7a5e53cb
parent 14ac020163ea60a9d683ce68e36c946f31ecc856
author O Thor <author@example.com> 1112912353 -0700
committer C O Mitter <committer@example.com> 1112912353 -0700

hello: again 3 more lines
$ git replace HEAD dd1ca

#
# Let's create a commit based on the current one:
#

$ echo 'line 17' >> hello
$ git commit -m 'Add line 17' hello
[master 8f60c7e] Add line 17
 1 files changed, 1 insertions(+), 0 deletions(-)
$ git rev-parse HEAD^
ffccc9d552388844dbe94a361c07e7cb1731e12f
$ git reset --hard HEAD^
HEAD is now at dd1ca8e hello: again 3 more lines

#
# We are now on the replacement commit, though before the last
# command we were on a commit on top of the original one.
#

$ echo 'line 17' >> hello
$ git commit -m 'Add line 17' hello
[master c4a823a] Add line 17
 1 files changed, 1 insertions(+), 0 deletions(-)

#
# We build on top of the replacement commit, not the original one.
# This means that the original one may be dangling:
#

$ git fsck --full --no-reflogs
dangling commit 8f60c7ee5d6e0379ff813a26a2479289605eb935
=2E..

#
# Of course on a published history, where "git replace" might
# be most usefull, you don't want to use "git reset --hard". So
# this might not be a big problem either.
#

Anyway, thanks in advance for advise/opinion about this.

Best regards,
Christian.

From: =?ISO-8859-1?Q?Fran=E7ois_Beausoleil?= <francois@teksol.info>
Subject: correct git merge behavior or corner case?
Date: Mon, 20 Apr 2009 10:50:25 -0400
Message-ID: <2FE32A75-C0D9-4156-B5D2-61AC6C086E5F@teksol.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 20 16:52:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lvuqq-0005a3-L9
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 16:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132AbZDTOu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 10:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756005AbZDTOu3
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 10:50:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:62474 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755909AbZDTOu2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 10:50:28 -0400
Received: from [192.168.142.100] ([24.201.176.134])
 by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KIE007HTMI9J400@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 20 Apr 2009 10:49:22 -0400 (EDT)
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116996>

Hi all,

I'm the author of http://blog.teksol.info/2009/04/15/beware-of-gits-con=
tent-tracking.html

In http://article.gmane.org/gmane.comp.version-control.git/116954, =20
Johannes was very critical of me, so here's the full story.

I cloned the repository and branched master to do some integration =20
work.  On the integration branch, I created an empty file.  At one =20
point, I merged from master and had some conflicts.  While resolving =20
the conflicts, I happened to notice a file that didn't exist on master =
=20
had been modified.

=46ull transcript follows:

$ git checkout -b merge-tracking-reproduce =20
5b8520419833635c61bdfb9abbbdc086df512388 # integration branch
$ git merge 5ed60ecabd585972003084e07401f598d00f5a1d # master branch

$ git status
# On branch merge-tracking-reproduce
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
=2E..
#       modified:   vendor/plugins/acts_as_money/LICENSE
#
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
=2E.. a couple of conflicts, they don't matter

$ git diff --cached vendor/plugins/acts_as_money/LICENSE
diff --git a/vendor/plugins/acts_as_money/LICENSE b/vendor/plugins/=20
acts_as_money/LICENSE
index e69de29..a273c73 100644
--- a/vendor/plugins/acts_as_money/LICENSE
+++ b/vendor/plugins/acts_as_money/LICENSE
@@ -0,0 +1,4 @@
+one:
+  user: active
+  name: name
+  description: description

$ git log 5b8520419833635c61bdfb9abbbdc086df512388 -- vendor/plugins/=20
acts_as_money/LICENSE # on integration branch
commit c25787637b6ac5d8f0783cf1688c9ce6fb135659
Author: Fran=E7ois Beausoleil <francois@teksol.info>
Date:   Thu Apr 9 14:15:03 2009 -0400

     Added Quirky dependencies

$ git log 5ed60ecabd585972003084e07401f598d00f5a1d -- vendor/plugins/=20
acts_as_money/LICENSE # on master branch
# empty, no file by that name on master

$ git log "-Sdescription: description" =20
5b8520419833635c61bdfb9abbbdc086df512388 # on integration branch

$ git log "-Sdescription: description" =20
5ed60ecabd585972003084e07401f598d00f5a1d # on master branch
commit 36d2a29d0c3c3a2a51db5f3be9faea7cea7ff3c1
Author: Michael Lacy <mike@kluster.com>
Date:   Tue Apr 14 10:16:50 2009 -0400

     quirky voting

$ git diff 36d2a29d0c3c3a2a51db5f3be9faea7cea7ff3c1^..=20
36d2a29d0c3c3a2a51db5f3be9faea7cea7ff3c1 -- vendor/gems/thoughtbot-=20
shoulda-2.10.1/test/fixtures/products.yml
diff --git a/vendor/gems/thoughtbot-shoulda-2.10.1/test/fixtures/=20
products.yml b/vendor/gems/thoughtbot-shoulda-2.10.1/test/fixtures/
index e69de29..a273c73 100644
--- a/vendor/gems/thoughtbot-shoulda-2.10.1/test/fixtures/products.yml
+++ b/vendor/gems/thoughtbot-shoulda-2.10.1/test/fixtures/products.yml
@@ -0,0 +1,4 @@
+one:
+  user: active
+  name: name
+  description: description

Regarding Anders reproduction recipe, no file was deleted.  I'm trying =
=20
to write a reproduction script, but haven't managed to reproduce it =20
just yet.  The steps I *think* happened are thus:

cd $(mktemp -d repo.XXXXXX)
git init
touch README
git add README
git commit --message "First commit"
git checkout -b integration
mkdir -p vendor/a
touch vendor/a/LICENSE
git add vendor/a/LICENSE
git commit --message "Adding LICENSE"
git checkout master
mkdir -p vendor/b
touch vendor/b/COPYING
git add vendor/b/COPYING
git commit --message "Adding COPYING"
echo "adding some content" > vendor/b/COPYING
git commit --all --message "Updated COPYING"
git checkout integration
git merge master
git diff HEAD^..HEAD

But the bug isn't reproduced with these steps.  If you want access to =20
the repository, please contact me privately and I'll give you access.

Johannes, you were right: I should have found the right avenue for =20
posting this question and done so.  If not immediately, at least the =20
next day.  It was late, I had other things to do, I just decided to =20
post a quick note.  Call me lazy, yes.  Incompetent, that's going a =20
bit too far.  I hope my competence can be redeemed in your eyes.

Have a nice day!
--
=46ran=E7ois Beausoleil
http://blog.teksol.info/
http://piston.rubyforge.org/

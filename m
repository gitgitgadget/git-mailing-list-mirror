From: Brian Ericson <bericson@ptc.com>
Subject: a diff equivalent to show?
Date: Tue, 05 Jun 2012 11:39:43 -0500
Message-ID: <4FCE364F.1030307@ptc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 18:49:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbwwl-0001Op-FO
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 18:49:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503Ab2FEQt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 12:49:27 -0400
Received: from irp2.ptc.com ([12.11.148.84]:33451 "EHLO irp2.ptc.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754024Ab2FEQt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 12:49:27 -0400
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jun 2012 12:49:27 EDT
X-IronPort-AV: E=Sophos;i="4.75,718,1330923600"; 
   d="scan'208";a="116772675"
Received: from hq-ex3fe3.ptcnet.ptc.com ([132.253.201.67])
  by irp2.ptc.com with ESMTP; 05 Jun 2012 12:39:44 -0400
Received: from bericson.ptcnet.ptc.com ([132.253.201.117]) by hq-ex3fe3.ptcnet.ptc.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 5 Jun 2012 12:39:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
X-OriginalArrivalTime: 05 Jun 2012 16:39:44.0130 (UTC) FILETIME=[CFC05E20:01CD4339]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199265>

Is there a way I can get the same results (files & diff content) using 
"git diff" that I can get using "git show"?  I ask because I want show's 
basic results (changes it represents via, for example, --name-status), 
but need the options and output of diff.

I'm interested, in particular, in three merge cases involving merges to 
master from "other" (see example repo below):
* other changed file (10241ee as "First merge.")
* master changed file (178f994 as "Second merge.")
* Conflicting merge resolved by keeping my changes (bc1291a as "Third 
merge.")

In all three cases, "show" shows no changes (via git show bc1291a 
178f994 10241ee).  However, I can't consistently get diff to replicate 
the show's result, as shown via
function differ() {
   local RESULT=$( git --no-pager diff --name-status $1 )
   printf "%-29s -- %s\n" "$1" "${RESULT:-OK}"
}

for commit in bc1291a 178f994 10241ee
do
   #Shouldn't this work?
   differ $commit^!
   #Should be equivalent to previous
   differ "^$commit^@ $commit"
   #Yet another way of representing the same thing.
   differ "^$commit^1 ^$commit^2 $commit"
   #Hrm...  This is also equivalent?!
   differ "^$commit^1 $commit"
   #I probably should (better) understand why order matters...
   differ "$commit ^$commit^@"
   #Thrown in for good measure.
   differ "^$commit^2 $commit"
   echo
done

which produces:
10241ee^!                     -- M    file
^10241ee^@ 10241ee            -- M    file
^10241ee^1 ^10241ee^2 10241ee -- M    file
^10241ee^1 10241ee            -- M    file
10241ee ^10241ee^@            -- OK
^10241ee^2 10241ee            -- OK

178f994^!                     -- A    unrelated_file
^178f994^@ 178f994            -- A    unrelated_file
^178f994^1 ^178f994^2 178f994 -- A    unrelated_file
^178f994^1 178f994            -- A    unrelated_file
178f994 ^178f994^@            -- OK
^178f994^2 178f994            -- M    file

bc1291a^!                     -- OK
^bc1291a^@ bc1291a            -- OK
^bc1291a^1 ^bc1291a^2 bc1291a -- OK
^bc1291a^1 bc1291a            -- OK
bc1291a ^bc1291a^@            -- M    file
^bc1291a^2 bc1291a            -- M    file

Tangentially, it seems odd to me that $commit^! seems equivalent to 
^$commit^1 $commit.  What's also odd to me is that, removing 
--name-status, "git --no-pager diff 10241ee^!" shows a "-1" -- exactly 
the opposite of what I'd expect ("+1"):
diff --git a/file b/file
index d00491f..e69de29 100644
--- a/file
+++ b/file
@@ -1 +0,0 @@
-1

Example repo to demonstrate:
git init && touch file && git add file && git commit -m 'Empty file.'
git checkout -b other && echo 1 >> file && git commit -am 'other 
appended 1 to file.'
git checkout master && git merge --no-ff -m 'First merge.'
git checkout master && git merge --no-ff -m 'First merge.' other
echo 2 >> file && git commit -am 'master appended 2 to file'
git checkout other && touch unrelated_file && git add unrelated_file && 
git commit -m 'other added unrelated_file.'
git checkout master && git merge -m 'Second merge.' other
echo 3 >> file && git commit -am 'master appended 3 to file'
echo 4 >> file && git commit -am 'master appended 4 to file'
git checkout other && echo 3 >> file && git commit -am 'other appended 3 
to file'
git checkout master && git merge other ; git checkout HEAD file && git 
commit #Edit commit to make first line "Third merge."

Here is the resulting tree:
*   bc1291a Third merge.
|\
| * 11ce5db other appended 3 to file
* | 9c92ac7 master appended 4 to file
* | 4bd6eda master appended 3 to file
* |   178f994 Second merge.
|\ \
| |/
| * fb424bf other added unrelated_file.
* | d854a9e master appended 2 to file
* |   10241ee First merge.
|\ \
| |/
| * 0d73874 other appended 1 to file.
|/
* 468a04b Empty file.

I am using git version 1.7.10.2.

From: =?ISO-8859-1?Q?Lasse_K=E4rkk=E4inen?= <tronic+dfhy@trn.iki.fi>
Subject: Proper tracking of copies in git log and others
Date: Sat, 04 Jul 2009 19:24:56 +0300
Message-ID: <4A4F8258.5070701@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 04 18:25:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MN832-00030r-AT
	for gcvg-git-2@gmane.org; Sat, 04 Jul 2009 18:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbZGDQY5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jul 2009 12:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbZGDQY4
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Jul 2009 12:24:56 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:46280 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752228AbZGDQYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Jul 2009 12:24:55 -0400
Received: from trn.iki.fi (84.250.38.215) by jenni2.inet.fi (8.5.014)
        id 49F5CB64026A7171 for git@vger.kernel.org; Sat, 4 Jul 2009 19:24:57 +0300
Received: from trn.iki.fi (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP id 509544573E7F0
	for <git@vger.kernel.org>; Sat,  4 Jul 2009 19:24:53 +0300 (EEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by trn.iki.fi (Postfix) with ESMTP
	for <git@vger.kernel.org>; Sat,  4 Jul 2009 19:24:52 +0300 (EEST)
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122720>

Getting full history of a file, including that beyond copies, is rather 
important and apparently not currently supported by git tools.

An example use case:

# Create repository
mkdir courses
cd courses
git init
# Course 2007
mkdir -p 2007/exercise1
echo Hello > 2007/exercise1/description.txt
mkdir 2007/exercise2
echo World > 2007/exercise2/description.txt
git add 2007
git commit -m "Course 2007"
# Course 2008
mkdir -p 2008/exercise1
echo New one > 2008/exercise1/description.txt
git add 2008
git commit -m "Course 2008 exercise 1 (new)"
cp -R 2007/exercise1 2008/exercise2
git add 2008/exercise2
git commit -a -m "Course 2008 exercise 2 (from 2007 exercise 1)"
# Course 2009
cp -R 2008 2009
git add 2009
git commit -m "Course 2009 recycled entirely from 2008"

Now, if we do git log --follow 2009/exercise2/description.txt or 
2009/exercise2, it only prints the "Course 2009" commit instead of the 
full history because --follow doesn't follow copies. What we actually 
want is:

commit 9e17341497b29735bc55b6631b43db6e2f50ed30
Author: Lasse Karkkainen <tronic@trn.iki.fi>
Date:   Sat Jul 4 19:05:57 2009 +0300

     Course 2009 recycled entirely from 2008

commit 8fd13a8667f0bc5c4851b366864a207fa85519bc
Author: Lasse Karkkainen <tronic@trn.iki.fi>
Date:   Sat Jul 4 19:05:57 2009 +0300

     Course 2008 exercise 2 (from 2007 exercise 1)

commit 593346660872ada80ba751688fffc7af7a31e124
Author: Lasse Karkkainen <tronic@trn.iki.fi>
Date:   Sat Jul 4 19:05:57 2009 +0300

     Course 2007

Note: the "Course 2008 exercise 1 (new)" commit is not listed, as it is 
unrelated to 2009/exercise2.

Some nice people from #git suggested various commands that would find 
the previous version (e.g. 2008/exercise2) etc, but none of those got 
even close to getting this full history over multiple copies, with log 
messages.

It would be useful if the git tools could produce history like this with 
all the tools (log, blame, gitk, etc), preferably with proper branching 
guesses (guesses because there is no info on where the copy came from), 
but even a linear history (sorted by commit time?) would do much better 
than not having anything.

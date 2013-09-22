From: Jonathon Mah <jmah@me.com>
Subject: Re: [PATCH 2/2] grep: use slash for path delimiter, not colon
Date: Sun, 22 Sep 2013 12:15:21 -0700
Message-ID: <99F7DE7C-A8D7-4EDF-B9C5-8DB143BFDB53@me.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: phil.hord@gmail.com, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 22 22:15:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNq40-0008Cu-Mf
	for gcvg-git-2@plane.gmane.org; Sun, 22 Sep 2013 22:15:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab3IVUPZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Sep 2013 16:15:25 -0400
Received: from nk11p08mm-asmtp002.mac.com ([17.158.58.247]:61020 "EHLO
	nk11p08mm-asmtp002.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752093Ab3IVUPY convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Sep 2013 16:15:24 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Sun, 22 Sep 2013 16:15:24 EDT
Received: from [192.168.120.59]
 (c-50-136-133-171.hsd1.ca.comcast.net [50.136.133.171])
 by nk11p08mm-asmtp002.mac.com
 (Oracle Communications Messaging Server 7u4-27.08(7.0.4.27.7) 64bit (built Aug
 22 2013)) with ESMTPSA id <0MTJ00GLPK5LOF20@nk11p08mm-asmtp002.mac.com> for
 git@vger.kernel.org; Sun, 22 Sep 2013 19:15:24 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.10.8794,1.0.431,0.0.0000
 definitions=2013-09-22_02:2013-09-22,2013-09-22,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=7.0.1-1308280000 definitions=main-1309220127
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235171>

> >     HEAD:/some/path/to/foo.txt
> >     HEAD:some/path/to/foo.txt
> 
> With my patch it prints the latter.
> 
> This is because get_sha1_with_context("HEAD:"...) returns an empty
> 'path' string.  The code decides to use ':' as the delimiter in that
> case, but it sees there already is one at the end of "HEAD:".

A few days ago I came across the same "surprising" output of git-grep, tried to adjust the code to print "git show"-able object names, and ran into similar subtleties. I just found this thread, and Jeff's code handles more cases than mine did (I didn't try Phil's initial patch), but I can add some more test cases with non-showable output (again related to git-grep's path scoping):

$ git grep -l cache HEAD:./ | head -1
HEAD:./:.gitignore

$ cd Documentation
$ git grep -l cache HEAD | head -1
HEAD:CodingGuidelines

$ git grep -l cache HEAD:Documentation/CodingGuidelines
../HEAD:Documentation/CodingGuidelines
(woah!)

Sorry that I don't yet have anything useful to suggest! But I can tell the story of my use case:

I have a large repository (1.6GB bare) which I don't work on, but which contains code that I need to refer to. A checkout is ~600MB and 27k files, which I'd like to avoid (it's redundant data, and would slow down backups of my drive). I found myself "git-grep"ping through parts of the tree, looking through the results, and then "git-show"ing interesting files. Having a real object name in the grep output allows copy-and-paste of the object path.



Jonathon Mah
me@JonathonMah.com

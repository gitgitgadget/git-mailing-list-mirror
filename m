From: Edward Thomson <ethomson@microsoft.com>
Subject: Merge with staged and unstaged changes
Date: Wed, 20 Feb 2013 19:17:52 +0000
Message-ID: <A54CE3E330039942B33B670D971F85740396B267@TK5EX14MBXC254.redmond.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 20:24:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8FHG-0003s1-Ec
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 20:24:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758862Ab3BTTYB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 14:24:01 -0500
Received: from na01-by2-obe.ptr.protection.outlook.com ([207.46.100.28]:56085
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758718Ab3BTTYA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Feb 2013 14:24:00 -0500
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Feb 2013 14:24:00 EST
Received: from BL2FFO11FD008.protection.gbl (10.173.161.200) by
 BL2FFO11HUB004.protection.gbl (10.173.161.22) with Microsoft SMTP Server
 (TLS) id 15.0.620.12; Wed, 20 Feb 2013 19:18:28 +0000
Received: from TK5EX14HUBC101.redmond.corp.microsoft.com (131.107.125.37) by
 BL2FFO11FD008.mail.protection.outlook.com (10.173.161.4) with Microsoft SMTP
 Server (TLS) id 15.0.620.12 via Frontend Transport; Wed, 20 Feb 2013 19:18:28
 +0000
Received: from TK5EX14MBXC254.redmond.corp.microsoft.com ([169.254.2.84]) by
 TK5EX14HUBC101.redmond.corp.microsoft.com ([157.54.7.153]) with mapi id
 14.02.0318.003; Wed, 20 Feb 2013 19:17:52 +0000
Thread-Topic: Merge with staged and unstaged changes
Thread-Index: AQHOD576PkYsSA9sEkyCP3OW/l2NPA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.3.0.121105
x-originating-ip: [157.54.51.35]
Content-ID: <9D619F869789D54DA411F94FD8380CD5@microsoft.com>
X-Forefront-Antispam-Report: CIP:131.107.125.37;CTRY:US;IPV:CAL;IPV:NLI;EFV:NLI;SFV:NSPM;SFS:(189002)(199002)(20264002)(46102001)(74502001)(20776003)(77982001)(74662001)(55846006)(44976002)(46406002)(76482001)(33656001)(56816002)(80022001)(47446002)(66066001)(16406001)(65816001)(63696002)(79102001)(59766001)(23726001)(51856001)(54316002)(53806001)(47976001)(49866001)(50986001)(31966008)(4396001)(47736001)(47776003)(56776001)(54356001)(50466001)(550254004);DIR:OUT;SFP:;SCL:1;SRVR:BL2FFO11HUB004;H:TK5EX14HUBC101.redmond.corp.microsoft.com;RD:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-OriginatorOrg: microsoft.onmicrosoft.com
X-Forefront-PRVS: 07630F72AD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216713>

Hi-

I've been investigating the cases where merge is allowed to proceed when
there are staged changes in the index or unstaged files in the working
directory.  There are cases where I find the behavior surprising and I
hope I can get clarification.  There are also two cases that I will report
as bugs, where it appears that the unstaged file contents are deleted.

For these cases below, please consider the contents of a single path.
In the tables below, we will show the contents of a file across each input
and output of the merge - consider that we're merging a single file in
some branch "theirs" into the current branch "ours" and that these two
branches have a common ancestor "anc".  The state of that file in our
index and workdir are represented by "idx" and "wd", respectively.
Unless otherwise noted, these cases are true for both git-merge-resolve
and git-merge-recursive.


For completeness and illustration purposes, I'll included the cases where
there are no changes staged or unstaged.  These succeed, as expected:

   input                                 result
   anc ours theirs idx wd  merge result  idx wd
1  A   A    B      A   A   take B        B   B
2  A   B    A      B   B   take A        A   A

Merge is also expected to proceed if the contents of our branch are the
merge result, and there are unstaged changes for that file in the workdir.
In this case, the file remains unstaged:

   input                                 result
   anc ours theirs idx wd  merge result  idx wd
3  A   B    A      B   C   take B        B   C


What was surprising to me was that my merge can proceed if I stage a change
that is identical to the merge result.  That is, if my merge result would
be to take the contents from "theirs", then my merge can proceed if I've
already staged the same contents:

   input                                 result
   anc ours theirs idx wd  merge result  idx wd
4  A   A    B      B   B   take B        B   B
5  A   A    B      B   C   take B        B   C

This seems unexpected - is there a use-case that this enables or is
this accidental?


Another surprising result was that if I have deleted a file (and staged
the deletion or not) then the merge will proceed and the file in question
will be recreated.  Consider "X" to be a missing file:

   input                                 result
   anc ours theirs idx wd  merge result  idx wd
6  A   A    B      A   X   take B        B   B
7  A   A    B      X   X   take B        B   B

I wouldn't have expected a file I deleted to be recreated with the other
branch's contents.  Is this behavior also intentional?


Finally, there are cases when you have staged a deletion of the file and
you have unstaged changes in your workdir where the merge will silently
delete the unstaged data.  If there is a conflict, the xdiff output will
overwrite the unstaged file:

   input                                 result
   anc ours theirs idx wd  merge result  idx wd
8  A   B    C      X   D   conflict      X   diff3_file

And similarly, while git-merge-recursive (only) will also remove my
untracked file when there are no changes in our branch but the file was
deleted in their branch:

   input                                 result
   anc ours theirs idx wd  merge result  idx wd
9  A   A    X      X   B   delete file   X   X


I trust the last two cases, where data is lost, are bugs to report, but
could I get clarification on the other situations?

Thanks-

-ed

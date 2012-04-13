From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: [BUG] svn-fe: incorrect handling of files with newlines in them
Date: Fri, 13 Apr 2012 23:13:22 +0100
Message-ID: <4F88A502.9080207@pileofstuff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060507010803020804090602"
To: Git Mailing List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 14 00:14:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIokm-0007uD-A4
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 00:14:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887Ab2DMWN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 18:13:28 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:36296 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751253Ab2DMWN1 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Apr 2012 18:13:27 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120413221325.QAAZ23305.mtaout02-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Fri, 13 Apr 2012 23:13:25 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120413221325.WRRM10211.aamtaout01-winn.ispmail.ntl.com@[192.168.0.2]>;
          Fri, 13 Apr 2012 23:13:25 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=yXtjXN6ItgYA:10 a=T_OkDejd9mgA:10 a=u4BGzq-dJbcA:10 a=mV9VRH-2AAAA:8 a=fHBOcJy1otTAmP3w_fEA:9 a=97ze5LVlPPo9DaBLD6IA:7 a=wPNLvfGTeEIA:10 a=kHZCkw_-PAsW9TN2rxsA:9 a=NajxTEViUZ2KkU9D:21 a=RVNbzoqZEYw9Rqb6:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195449>

This is a multi-part message in MIME format.
--------------060507010803020804090602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This issue arguably isn't that important - I'm raising it to see whether
people think it's an edge case worth bothering with.

Before version 1.2.0, SVN allowed you to create files and directories
with newlines in them.  So far as I can tell, directories with newlines
are still technically allowed to this day, it's just that the interface
doesn't let you create new ones.  svn-fe silently ignores anything after
the newline (at least in the test I ran).

You will need to install SVN 1.1.4 or below to fully replicate the
issue.  Full instructions at the end, but I've attached a dump file in
case you have better things to do with your time.  To replicate the
svn-fe part of the issue:


# Directory containing your git.git:
GIT_GIT="$HOME/git/git"

mkdir newline-in-file.git
cd newline-in-file.git
$GIT_GIT/git init

# (now save the dump to this directory)

mkfifo backchannel
$GIT_GIT/contrib/svn-fe/svn-fe < newline-in-file.dump 3<backchannel | \
    $GIT_GIT/git fast-import --cat-blob-fd=3 3>backchannel
$GIT_GIT/git log -p


Expected: `git log -p` tells you about "readme.txt
Node-kind: dir" (with a newline in the filename)

Observed: `git log -p` tells you about "readme.txt" (with no newline in
the filename)

Note that I've used the intentionally provocative filename
$'readme.txt\nNode-kind: dir', but svn-fe doesn't fall for the trick.
The dump format doesn't escape the filename at all, so it would probably
fall for something cleverer like a 'copyfrom' line.  To be honest I'm
not sure how you'd even detect such a filename.

If the consensus is that this bug isn't fixable, I'd recommend putting a
note to that effect in "contrib/svn-fe/svn-fe.txt".



Steps to create the SVN dump (assuming a bash shell):

DOWNLOADS_DIRECTORY="$HOME/some_directory"
mkdir "$DOWNLOADS_DIRECTORY"
cd "$DOWNLOADS_DIRECTORY"
wget http://archive.apache.org/dist/subversion/subversion-1.1.4.tar.gz
tar zxf subversion-1.1.4.tar.gz
cd subversion-1.1.4/
./configure
make
cd "$DOWNLOADS_DIRECTORY"
SVN_DIR="$DOWNLOADS_DIRECTORY/subversion-1.1.4/subversion"
"$SVN_DIR/svnadmin/svnadmin" create repo
"$SVN_DIR/clients/cmdline/svn" co "file://$PWD/repo/" checkout
cd checkout/
touch $'readme.txt\nNode-kind: dir'
"$SVN_DIR/clients/cmdline/svn" add *
"$SVN_DIR/clients/cmdline/svn" ci -m "File with newline in its name"
cd -
"$SVN_DIR/svnadmin/svnadmin" dump repo > newline-in-file.dump


	- Andrew

--------------060507010803020804090602
Content-Type: text/plain;
 name="newline-in-file.dump"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="newline-in-file.dump"

SVN-fs-dump-format-version: 2

UUID: 00a1cdd4-95bd-0410-8002-ed56cec4f7c2

Revision-number: 0
Prop-content-length: 56
Content-length: 56

K 8
svn:date
V 27
2012-04-13T21:05:24.866169Z
PROPS-END

Revision-number: 1
Prop-content-length: 130
Content-length: 130

K 7
svn:log
V 29
File with newline in its name
K 10
svn:author
V 6
andrew
K 8
svn:date
V 27
2012-04-13T21:05:26.548735Z
PROPS-END

Node-path: readme.txt
Node-kind: dir
Node-kind: file
Node-action: add
Prop-content-length: 10
Text-content-length: 0
Text-content-md5: d41d8cd98f00b204e9800998ecf8427e
Text-content-sha1: da39a3ee5e6b4b0d3255bfef95601890afd80709
Content-length: 10

PROPS-END



--------------060507010803020804090602--

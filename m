From: Jeremy Morton <admin@game-point.net>
Subject: Fixing the p4merge launch shell script
Date: Wed, 03 Oct 2012 00:38:35 +0100
Message-ID: <506B7AFB.1070700@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 03 02:02:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJCQB-0000LO-Ad
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 02:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771Ab2JCAC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 20:02:29 -0400
Received: from ip.game-point.net ([208.100.1.149]:52177 "EHLO
	ip.game-point.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932747Ab2JCAC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 20:02:28 -0400
X-Greylist: delayed 1525 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Oct 2012 20:02:28 EDT
Received: from 87-194-212-214.bethere.co.uk ([87.194.212.214]:3265 helo=[192.168.0.101])
	by ip.game-point.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <admin@game-point.net>)
	id 1TJC1S-0006Se-57
	for git@vger.kernel.org; Wed, 03 Oct 2012 00:37:06 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ip.game-point.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - game-point.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206853>

Hi,

I've noticed that the p4merge shell script could do with some 
improvement when it comes to merging.  Because p4merge throws up an 
error when one of the files it's given to diff is "/dev/null", git needs 
to create a temporary empty file and pass that to p4merge when diffing a 
file that has been created/deleted (eg. create file, git add ., git diff 
--cached).

At the moment, the hack I'm using, which works, is to create a 
c:/blank.txt file which is an empty file, and modify 
"libexec/git-core/mergetools/p4merge" to start with this:

diff_cmd () {
	if [ ! -f "$LOCAL" ]
	then
		LOCAL="C:/blank.txt"
	fi
	if [ ! -f "$REMOTE" ]
	then
		REMOTE="C:/blank.txt"
	fi
	"$merge_tool_path" "$LOCAL" "$REMOTE"
}

Obviously, this isn't good enough because c:/blank.txt probably won't 
exist on the system.  It would be nice for the temporary blank file to 
have the same extension as the one that's been added, so we could diff 
(say) c:/users/jez/Temp/abc123_newFile.foo 
c:/development/bar/newfile.foo.  However, I can't see a way to do this 
purely from within the shell script (even `mktemp` doesn't exist on all 
systems so that isn't good enough).  I believe git needs to create this 
temporary blank file itself, much like it creates a temporary file for 
the previous version of a file that's been modified when it's being 
diff'd.  It then needs to expose the location of this temporary file as 
a variable; say $LOCALBLANK.  So, we would be able to modify the shell 
script to this:


diff_cmd () {
	if [ ! -f "$LOCAL" ]
	then
		LOCAL=$LOCALBLANK
	fi
	if [ ! -f "$REMOTE" ]
	then
		REMOTE=$REMOTEBLANK
	fi
	"$merge_tool_path" "$LOCAL" "$REMOTE"
}

Thoughts?  Is there an easier way to do this?

-- 
Best regards,
Jeremy Morton (Jez)

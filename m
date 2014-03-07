From: "Paul Lotz" <plotz@lsst.org>
Subject: RE: difftool sends malformed path to exernal tool on Windows
Date: Fri, 7 Mar 2014 09:07:15 -0700
Message-ID: <019d01cf3a1f$4ebfe5f0$ec3fb1d0$@lsst.org>
References: <011301cf2c2d$90442810$b0cc7830$@lsst.org> <20140221103821.GA21414@gmail.com> <000801cf317f$ac1be2b0$0453a810$@lsst.org> <CAJDDKr751=c2AOBfjbg2_im6UCBvwWSVjJ7QX8=76vXMsLSw4g@mail.gmail.com> <00bc01cf3737$b1474280$13d5c780$@lsst.org> <20140305082517.GA86532@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "'Git Mailing List'" <git@vger.kernel.org>
To: "'David Aguilar'" <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 17:07:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLxIy-0005Q7-CO
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 17:07:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753504AbaCGQHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 11:07:18 -0500
Received: from mail.lsstcorp.org ([140.252.15.63]:24917 "EHLO mail.lsst.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbaCGQHQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Mar 2014 11:07:16 -0500
Received: from PaulLaptop ([140.252.119.210]) by mail.lsst.org with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 7 Mar 2014 09:07:15 -0700
In-Reply-To: 
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQKjFvigrE20EroY6kKNjpOQ6fvyewFLrX1WAgzPQL4CYaLXiQFsR5ekASz0zTABbh7Kf5jgA/wg
Content-Language: en-us
X-OriginalArrivalTime: 07 Mar 2014 16:07:15.0680 (UTC) FILETIME=[4EC27E00:01CF3A1F]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243615>

David,

I investigated further and found that \"$LOCAL\" \"$REMOTE\" return the remote and local files (reversed).  (One can easily see this in my 2/28 e-mail.)  Reversing these (\"$REMOTE\" \"$LOCAL\") does indeed reverse the output.  It is easy to work around this issue, but how can this be?

Paul

-----Original Message-----
From: Paul Lotz [mailto:plotz@lsst.org] 
Sent: Wednesday, March 5, 2014 3:28 PM
To: 'David Aguilar'
Cc: 'Git Mailing List'
Subject: RE: difftool sends malformed path to exernal tool on Windows

David,

We did succeed in getting a script to work.  The local Git guru started with your script (he independently sent me something very similar) and added some tricks to make things work.

The contents of the shell script ended up as:
___
#!/bin/bash

# Method to determine absolute path
# The -W option on the pwd command is necessary to return the Windows version of the path.
# Leaving off the -W option will result in a conversion of temp directory to a Linux-specific 'tmp' path.
# Piping the result through tr '/' '\\' translates the forward slashes to backslashes.
# Windows understands forward slashes, but LVCompare.exe does not.
abspath () {
	(
		DIR=$(dirname "$1")
		FN=$(basename "$1")
		cd "$DIR"
		printf "%s/%s" "$(pwd -W)" "$FN" | tr '/' '\\'
	)
}

lvcompare="C:\\Program Files (x86)\National Instruments\\Shared\\LabVIEW Compare\\LVCompare.exe"
local=$(abspath "$1")
remote=$(abspath "$2")
exec "$lvcompare" -nobdpos -nofppos "$local" "$remote"
# For the options, see http://zone.ni.com/reference/en-XX/help/371361H-01/lvhowto/configlvcomp_thirdparty/.
___

This works, but the solution seems to me nontrivial.

I will post this solution in Git with LabVIEW threads tomorrow, but I thought I'd see if you have any suggestions before I do that.

Thanks much!

Paul

-----Original Message-----
From: David Aguilar [mailto:davvid@gmail.com]
Sent: Wednesday, March 5, 2014 1:25 AM
To: Paul Lotz
Cc: 'Git Mailing List'
Subject: Re: difftool sends malformed path to exernal tool on Windows

On Mon, Mar 03, 2014 at 04:24:15PM -0700, Paul Lotz wrote:
> David,
> 
> OK, I did as you suggested, and the results were revealing.
> 
> First, I replaced "echo" with "cat".  Result: The contents of both files appeared in the Git Bash Window.
> 
> Then I tried calling LVCompare from the Git Bash and Windows Command Prompt windows with variations on the paths.
> 
> Here are the most relevant results:
> First from the Windows Command Prompt:
> 1) This command works:
> C:\LSST_TS\SystemSW\M2AADT>"C:\Program Files (x86)\National 
> Instruments\Shared\L abVIEW Compare\LVCompare.exe"
> C:\Users\Paul\AppData\Local\Temp\Typedefs_TestStat
> us_Before.ctl C:\LSST_TS\SystemSW\M2AADT\Typedefs\TestStatus.ctl
> [General note:
> I saved a copy of the temp file and replaced the hex string with the 
> string 'Before' to make the file stick around.  The paths are 
> otherwise the same.]

This is aligns with: http://zone.ni.com/reference/en-XX/help/371361H-01/lvhowto/configlvcomp_thirdparty/

	"lvcompare.exe <absolute path to VI 1> ..."

The key thing is the mention of absolute paths.

What is happening is that lvcompare.exe (or likely it's a Windows thing) changes its current directory to its installation directory under Progra~1.

That means the relative paths passed in by difftool won't be found.

The way to fix it is to redirect your difftool config to a script that makes all paths absolute.  This script can then call the real lvcompare.exe.

You just need to tweak the lvcompare part in your .gitconfig to look like this:

[difftool "lvcompare"]
	cmd = ~/bin/lvcompare.sh \"$LOCAL\" \"$REMOTE\"


... and install an executable lvcompare.sh shell script in in your $HOME/bin.  Something like this:

#!/bin/sh

abspath () {
	(
		cd "$(dirname "$1")" &&
		printf "%s/%s" "$(pwd)" "$(basename "$1")"
	)
}

lvcompare="C:\\Program Files (x86)\National Instruments\\Shared\\LabVIEW Compare\\LVCompare.exe"
local=$(abspath "$1")
remote=$(abspath "$2")
exec "$lvcompare" "$local" "$remote"

> 2) C:\LSST_TS\SystemSW\M2AADT>"C:\Program Files (x86)\National 
> Instruments\Shared\L abVIEW Compare\LVCompare.exe"
> C:\Users\Paul\AppData\Local\Temp\Typedefs_TestStat
> us_Before.ctl Typedefs\TestStatus.ctl
> 
> Result: Error message with reference to C:\Program Files 
> (x86)\National Instruments\Shared\L abVIEW 
> Compare\supportVIs\_prolvcmp.llb\Typedefs\TestStatus.ctl
> 
> Observation: The second path has to be the full path, not the relative path we get back using "echo".

Yes, that's what it looks like.
--
David

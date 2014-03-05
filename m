From: David Aguilar <davvid@gmail.com>
Subject: Re: difftool sends malformed path to exernal tool on Windows
Date: Wed, 5 Mar 2014 00:25:18 -0800
Message-ID: <20140305082517.GA86532@gmail.com>
References: <011301cf2c2d$90442810$b0cc7830$@lsst.org>
 <20140221103821.GA21414@gmail.com>
 <000801cf317f$ac1be2b0$0453a810$@lsst.org>
 <CAJDDKr751=c2AOBfjbg2_im6UCBvwWSVjJ7QX8=76vXMsLSw4g@mail.gmail.com>
 <00bc01cf3737$b1474280$13d5c780$@lsst.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: 'Git Mailing List' <git@vger.kernel.org>
To: Paul Lotz <plotz@lsst.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 09:25:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL791-0003YS-Ni
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 09:25:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751721AbaCEIZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 03:25:35 -0500
Received: from mail-pd0-f181.google.com ([209.85.192.181]:49615 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511AbaCEIZe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 03:25:34 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so752238pdj.12
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 00:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=AIXM+wUG1eTYOtThDmsSjqcPm+eGY+tkksqj58qeUDk=;
        b=kV3AD+5d8VRwS50RdaU2NB0b/NJhPkwpL/8BWmx+7PzktqxSbvi+pjP6jfvfeht/qS
         Dq/rQ9DCw/P6lyInfzBKMSCN/69viND+XXdtXWBjbGJH3oidsLQcve7U5KxpzuR+zmxD
         Z+M1dQZjZVb3lWS5wSgGaRuYVi3tVtEyG0NdxlkSRRvPJuct21uLfbbdXceuts1osfHe
         SFAyoddoo/Mf8XoI8mdCaQUhuq0Z7mr1M68Mj3XOOpkMHH1dtoJ7jbY3Mi3n82kPMvU9
         Cg43rU/RK1D5uA9XHBdRzznwAMoeziebY51uuONZa7eZH1aGCKbfhDSseg8rmhabYFim
         OKsw==
X-Received: by 10.68.198.36 with SMTP id iz4mr5132441pbc.109.1394007934373;
        Wed, 05 Mar 2014 00:25:34 -0800 (PST)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id tu3sm10570315pab.1.2014.03.05.00.25.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 05 Mar 2014 00:25:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <00bc01cf3737$b1474280$13d5c780$@lsst.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243426>

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
> C:\LSST_TS\SystemSW\M2AADT>"C:\Program Files (x86)\National Instruments\Shared\L
> abVIEW Compare\LVCompare.exe" C:\Users\Paul\AppData\Local\Temp\Typedefs_TestStat
> us_Before.ctl C:\LSST_TS\SystemSW\M2AADT\Typedefs\TestStatus.ctl
> [General note:
> I saved a copy of the temp file and replaced the hex string with the string 'Before' to make the file stick around.  The paths are otherwise the same.]

This is aligns with: http://zone.ni.com/reference/en-XX/help/371361H-01/lvhowto/configlvcomp_thirdparty/

	"lvcompare.exe <absolute path to VI 1> ..."

The key thing is the mention of absolute paths.

What is happening is that lvcompare.exe (or likely it's a
Windows thing) changes its current directory to its installation
directory under Progra~1.

That means the relative paths passed in by difftool won't be found.

The way to fix it is to redirect your difftool config to a script
that makes all paths absolute.  This script can then call the real
lvcompare.exe.

You just need to tweak the lvcompare part in your .gitconfig
to look like this:

[difftool "lvcompare"]
	cmd = ~/bin/lvcompare.sh \"$LOCAL\" \"$REMOTE\"


... and install an executable lvcompare.sh shell script in in
your $HOME/bin.  Something like this:

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

> 2) C:\LSST_TS\SystemSW\M2AADT>"C:\Program Files (x86)\National Instruments\Shared\L
> abVIEW Compare\LVCompare.exe" C:\Users\Paul\AppData\Local\Temp\Typedefs_TestStat
> us_Before.ctl Typedefs\TestStatus.ctl
> 
> Result: Error message with reference to C:\Program Files (x86)\National Instruments\Shared\L
> abVIEW Compare\supportVIs\_prolvcmp.llb\Typedefs\TestStatus.ctl
> 
> Observation: The second path has to be the full path, not the relative path we get back using "echo".

Yes, that's what it looks like.
-- 
David

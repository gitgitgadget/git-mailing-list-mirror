From: "David Tweed" <david.tweed@gmail.com>
Subject: clarification on git-update-index --remove
Date: Thu, 4 Jan 2007 19:29:32 +0000
Message-ID: <e1dab3980701041129l3944df8ep985141d8f436d0a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jan 04 20:29:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2YHR-0004TJ-Uj
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 20:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbXADT3f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 14:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751026AbXADT3e
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 14:29:34 -0500
Received: from nz-out-0506.google.com ([64.233.162.236]:45807 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXADT3e (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 14:29:34 -0500
Received: by nz-out-0506.google.com with SMTP id s1so3136242nze
        for <git@vger.kernel.org>; Thu, 04 Jan 2007 11:29:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=V58RCdMgga2F/JxilJwMtbQ4LS3eOZlYP31x4bI8ivThBTiDvzGpBquZytD38FNF5OA238vaZyG6JDq05Fpb3PwtZblUr0DbvE0NBC4xsbuXKpONuupJuRLxCL/XudENY9k/YsJmGcRp44rY1rarwFXGkqVdWBo8+IKybKWFwwI=
Received: by 10.65.192.16 with SMTP id u16mr14593567qbp.1167938972842;
        Thu, 04 Jan 2007 11:29:32 -0800 (PST)
Received: by 10.65.160.13 with HTTP; Thu, 4 Jan 2007 11:29:32 -0800 (PST)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35949>

Hi, can someone who understands the index in git please clarify something
for me? Looking at the documentation it's not totally clear which entites
are referred to by "removed" and what that then implies.

from git-1.4.4.3/Documentation/git-update-index.txt <<<<<<<<<<<
--remove::
	If a specified file is in the index but is missing then it's
	removed.
	Default behavior is to ignore removed file.
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

I currently take this to mean

"With --remove, if there is a filepath in the index
and that filepath is in the list of files being fed to this instance
of git-update-index but in the working directory tree that filepath
does not currently exist, then upon termination remove the
filepath's record from the index.
[This means at the next commit it will not be present
at all in the set of files recorded via this commit.]

Default behaviour in that situation is to leave the index's
current record unaltered.
[This means that that filename will be, upon a commit,
recorded as having whatever sha-content the index currently records
it as having.]"

If this reading is right, this means that I have to pass the names of
files that have been removed otherwise they'll stay with their "last
contents before removal"? I'm currently finding removed files
"stay around in snapshots with their ultimate contents", and I now
_think_ this is the reason but I'm not sure.

(In case anyone's wants to know the context, I traced through and
distilled git-commit.sh to what I think
I need (rexpressed in python) with the core "make snapshot" code being

<<<<<<<<<<<<<<<<
    p1=loggedPopen(["git-update-index","-z","--add","--remove","--stdin"],
                   stdin=PIPE)
    for (d,fs) in files.iteritems(): # enters only "to be recorded" items
        for f in fs:
            p1.stdin.write(os.path.join(d,f)+"\0")
    p1.stdin.close()
    p1.wait()
    tree=loggedPopen(["git-write-tree"],stdout=PIPE).communicate()[0].rstrip()
    commit=loggedPopen(["git-commit-tree",tree,"-p","HEAD"],
                       stdin=PIPE,stdout=PIPE).communicate("cv")[0].rstrip()
<<<<<<<<<<<<<<<<<

Here files contains the set of files to be recorded in the current snapshot,
structured as (directory,set of files in directory).)

Many thanks for any insight,
-- 
cheers, dave tweed__________________________
david "DOT" tweed "AT" gmail "DOT" com
Rm 124, School of Systems Engineering, University of Reading.
Details are all that matters; God dwells there, and you never get to
see Him if you don't struggle to get them right. -- Stephen Jay Gould

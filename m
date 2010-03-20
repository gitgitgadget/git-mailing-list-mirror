From: Bo Yang <struggleyb.nku@gmail.com>
Subject: GSoC draft proposal: Line-level history browser
Date: Sat, 20 Mar 2010 17:18:22 +0800
Message-ID: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 20 10:18:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsupR-0008LL-AV
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 10:18:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962Ab0CTJSZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 05:18:25 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:15698 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920Ab0CTJSY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 05:18:24 -0400
Received: by qw-out-2122.google.com with SMTP id 8so785500qwh.37
        for <git@vger.kernel.org>; Sat, 20 Mar 2010 02:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=Hq6p+7wyqaXQh39QKSe0EXqKntnm8C/oOponcS/3qC8=;
        b=M7s6vxrkFnAZIvWRsgG1bT4qyvzZmpwxVulgjM3u4mxLx/Pi9/5E8B/+NUXRKc+fLZ
         LRygCTy66Pmp9CgNfqFDY7vgHJUgpLfTB/hIapn2U6z5IFPc4Rkkzoz/0Up7EDbiKxHX
         sCQAQ2zx7XwbKGG6GZ5rDzRrRqVPKLRJlEzlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=IeNTCDk4YoOoU1042Wn4D9WO+Fq8opiSVC+SvPdQ6vaLQwUlKaWiygpgxboglTHO6m
         YV1vWU4ApnlQXHURI+0STkbZueloO+lj6BLCcSZU+vsMll1J5KSNxS2crAcBJf+CE8zl
         efNmiQhLZOSTySA6WHi70nE1+tq7OWWEtoIIs=
Received: by 10.229.222.14 with SMTP id ie14mr2024240qcb.95.1269076702367; 
	Sat, 20 Mar 2010 02:18:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142698>

Hi,

I am very interested in the project 'Line-level history browser',
after some days consideration, now I made up a draft of my proposal, I
think it is helpful to send it to the list before submitting it. Could
you please give me some advise?

-----------------------------------------------
Draft proposal: Line-level History Browser

=====Purpose of this project=====
"git blame" can tell us who is responsible for a line of code, but it
can't help if we want to get the detail of how the lines of code have
evolved as what it is now.
This project will add a new utility for git called 'git line-log'. It
can trace the history of any line range of certain file at any
revision. For simplity, users can run the command like: ' git line-log
builtin/diff.c 6..8 ', he will get the change history of code between
line 6 and line 8 of the diff.c file. And for each history entry, it
will provide the commits, the diff block which contains changes of
users' interested lines.
This utility will trace all the modification history of interested
lines and stop until it finds the root of the lines, which is a point
where all the new code is added from scratch. Also, the users can
specify how deeply he wants this utility to trace. And this tool will
treat code move just like modification too, so it will follow the code
move inside one file.
Note that, the history may not always be a single thread of commits.
If there are more than one commit which produce the specified line
range, the thread of history will split. And this utility will stop
and provide all commits with its code changes to the user, let the
user to select which one to trace next.

=====Work and technical issues=====
==Command options==
This new tool should be used for exploring the history of changes for
certain line range of code in one file.

git line-log [options] <file> <line range>

Options:
1. Since it will output commit description, it will contain the option
used to control whether we should show the whole commit message or
just a short title.
2. Option whether we should display only the 'user interested lines'
diff block [default] or display the whole diff with the interested
area colorfully displayed.
3. The max depth we trace into the commit history.
4. The revision of the <file>. This is very useful when the current
interested line range is produced by more than one commit. The user
can use this option to specify the file revision and trace down from
that revision and the line range.

<line range>
Its format should be <start pos>..<end pos> or just a <line number>.

==Design and implementation==
Git store all the blobs instead of code delta, so we should traverse
the commit history and directly access the tree/blob objects to
compute the code delta and search for the diff which contains the
interested lines. Since git use libxdiff to format its diff file, we
should iterate through all xdiff's diff blocks and find what the code
looks like before the commit. Here, we will find a new line range
which is the origin code before this commit. And then start another
search from the current commit and the new line range. Recursively, we
can find all the modification history. We will stop when we find that
the current interested line range is added from scratch and is not
moved from other place of the file. We may also stop the traverse when
we reach the max search depth. Also, if the thread of change history
split into two or more commits, we stop and provide the users all the
related commits and corresponding line range.

For implementation related stuff, this tool heavily depends on
libxdiff. Because we will search our interested lines through xdiff's
output to find the right diff trunk to display and trace down. So, how
we search the xdiff's diff blocks is very important. After reading
some libxdiff document and code, I find that libxdiff output all the
diff blocks as string into a memory file. If we parse the diff block
string to find the changed lines, it is very inefficient. So, I
suggest changing xdiff's xdl_diff function to let it store some meta
data for each diff trunk. I think this will be very helpful for the
performance of this tool.

Generally,
1. xdiff/xdiffi.c will get changed to make xdl_diff store some desired
meta data and pass it to caller.
2. builtin/line-log.c will be added to complete most of the new
features, the most important function here may be cmd_linelog.
3. git.c will be changed to add this new utility to the front end.
4. Documents will be updated to introduce this new tool.

=====About me=====
I am Bo Yang, a Chinese graduate student majoring in Computer Science
of NanKai University. I have touched some open source software since 5
years ago and began to contribute code to open source community from
three years ago. I have contributed to Mozilla/Mingw/Netsurf.
Technically, I am experienced in C/Bash Shell. I have attended last
year's GSoC with Netsurf project. In that project, I have completed
most of a DOM library in C.
I begin to use git for source code revision from about two years ago.
I use Git for track my Mozilla trunk source code. Because updating
Mozilla code by CVS in my school is very slow. So, I write one script
to automatically updating the trunk with CVS at mid-night, when the
network flow is fast, on the server, and then use Git to maintain the
code. Then I use Git in my PC to clone/update the source code from my
local server and that is very fast. I use Git to track my changes to
the code and some bug fixes. It is an excellent tool for
branch/history, I think.
Git is my lovely daily tool for revision control. I have much
experience with it and have read "Git Internals" and also get some
basic knowledge about Git's code base. And I think the line-level
history explorer is really suitable for me and I can make a good start
with this project in Git community.
-----------------------------------------------

Any feedback from you will be appreciated very much, thanks a lot!

Regards!
Bo
-- 
My blog: http://blog.morebits.org

From: Bo Yang <struggleyb.nku@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 11:52:58 +0800
Message-ID: <41f08ee11003212052p6b0a7495j2e38f24839541ffb@mail.gmail.com>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>
	 <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>
	 <4BA544FC.7050007@gmail.com>
	 <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
	 <4BA61CF9.7040104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes.Schindelin@gmx.de, gitster@pobox.com, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 04:53:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtYhR-0001Yq-WF
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 04:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754101Ab0CVDxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 23:53:04 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:65108 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754057Ab0CVDxB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 23:53:01 -0400
Received: by qyk9 with SMTP id 9so2980935qyk.1
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 20:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=4O+cU7fYdaVmMZDM4TU0kFOU/52+Yaglzf4c1ztr/uY=;
        b=BGdj2zal43edXU/uCAJaVyecEsQKSUM6fNnby7TLYEY/eO8J+J60O2A63bw0Sd9SE8
         0k4/oFZWixapHbRUhYohCzL5KXhPuRAooh4Z1YIgueMmLWK2MxoiARCtjBr4fPdCXWm1
         l1+4pjKQBqYnM69VJ8PXIPa5n+/KY/bpVr5fU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jAIQQJA/amHQwPLW0rNmYXiyVhZUa8Ij+0wsTvmWrHWkQUsouxXJhwViqrk5L6LzVY
         d2ycEXcTqwL8zyh27FfBPnBTebDLIFKt5vAOtikLv6Bs8ekw7jNBthcRcZIOHMOrxb/7
         jX4/ORQeJr8WUba2LnZ7CtAwwQgsby4DxSo7s=
Received: by 10.229.11.220 with SMTP id u28mr417095qcu.64.1269229978586; Sun, 
	21 Mar 2010 20:52:58 -0700 (PDT)
In-Reply-To: <4BA61CF9.7040104@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142893>

Hi all,

     Thanks a lot for your precious advice and based on that, I have
prepared a new version of my proposal, generally it provide a detailed
options which I want to add to 'git log' and a new syntax for
supporting multi line ranges in any file at any revision. Also, this
version provide a milestones and timeline for this project. Thanks
again for your advice and I appreciate your feedback very much for
this version.

-----------------------------------------------------------------------
Draft proposal(v2): Line-level History Browser

=====Purpose of this project=====
"git blame" can tell us who is responsible for a line of code, but it
can't help if we want to get the detail of how the lines of code have
evolved as what it is now.
This project will add a new feature for 'git log' to display line
level history. It can trace the history of any line range of certain
file at any revision. For simplity, users can run the command like: '
git log -L builtin/diff.c:6,8 ', he will get the change history of
code between line 6 and line 8 of the diff.c file. And for each
history entry, it will provide the commits, the diff block which
contains changes of users' interested lines.
This utility will trace all the modification history of interested
lines and stop until it finds the root of the lines, which is a point
where all the new code is added from scratch. Also, the users can
specify how deeply he wants this utility to trace. And this tool will
treat code move just like modification too, so it will follow the code
move inside one commit.
Note that, the history may not always be a single thread of commits.
If there are more than one commit which produce the specified line
range, the thread of history will split. And this utility will stop
and provide all commits with its code changes to the user, let the
user to select which one to trace next.

=====Work and technical issues=====
==Command options==
This new feature should be used for exploring the history of changes
for certain line range of code in one file.

git log [-m<num>] [-I] [-d depth] [--fuzzy]  -L file1@rev1:<start
pos>,<end pos>  file2@rev2:<start pos>,<end pos>

Options:
1. -m<num>, option to control whether we should follow code movement.
If one -m is given, we follow code movement inside file, when more
than one '-m' is given, we follow the movement between files in one
commit. The <num> is used to specify the lower bound for the number of
lines of moved code. If it is not given, we set it as 1.
2. -I, option to control whether we should display only the 'user
interested lines' diff block [default] or display the whole diff with
the interested area colorfully displayed.
3. -d, option to control the max depth we trace into the commit history.
4. --fuzzy, option to control whether fuzzy code copy mathing is used.
5. '-L' to control whether we run a simple log or we want a line level log.
6. Files and lines. I propose to use such a syntax to specify the
files at revision and line range, <file>@<revision>:<start pos>,<end
pos>. This looks a little complex, but I think it is neccessary
because we will support multiple file at any version and any line
range finally. The revision can be any revision format of Git and the
<pos> can be a number, or a posix regex, just like what 'git blame'
do.
7. And we will support code copy detect, too. The option which control
whether we trace code copy does exist in current 'git log', which is
the option '-C'. Similiarly, one '-C' is used to trace code copy of
new added code inside one commit. Two '-C' will trace any code copy
inside commit tree.

==Design and implementation==
Git store all the blobs instead of code delta, so we should traverse
the commit history and directly access the tree/blob objects to
compute the code delta and search for the diff which contains the
interested lines. Since git use libxdiff to format its diff file, we
should iterate through all xdiff's diff blocks and find what the code
looks like before the commit. This will be done using the callback
mechanism. Here, we will find a new line range which is the origin
code before this commit. And then start another search from the
current commit and the new line range. Recursively, we can find all
the modification history. We will stop when we find that the current
interested line range is added from scratch and is not moved from
other place of the file. Here, if the user want to trace code copy,
more work will be done to find the possible code copy. We may also
stop the traverse when we reach the max search depth. Also, if the
thread of change history split into two or more commits, we stop and
provide the users all the related commits and corresponding line
range.

Generally,
1. New callback for xdi_diff to parse the diff hunk and store line
level history info.
2. builtin/line-log.c will be added to complete most of the new features.
3. builtin/log.c will be changed to add this new utility to the front end.
4. Documents will be updated to introduce this new tool.

=====Milestones and Timeline=====
In this summer, we will add support of line level history browser for
only one file. The multiple ranges support is currently not in this
project.

The milestones of the project are:
1. Simple modification change history.
2. Code movement inside one file detect.
3. Code movement inside one commit but not a file.
4. Code copy of modified file in one commit.
5. Code copy of any place in one commit tree.
6. Fuzzy matching support.

And the timeline will be:
April 26 - May 23:   Catch up with Git code base and study the
implementation of blame.c and log.c thouroughly.

May 24 - June 21 :   Complete a version which supports code
modifcation trace but without code movement and code copy support.

June 22 - June 29:   Complete a version which supports code movement
inside one file.

June 30 - July 7:    Complete a version which supports code movement
between files inside one commit.

July 8 - July 15:    Complete a version which supports code copy of
modified file in one commit.

July 16 - July 23:   Complete a version which supports code copy of
any file in one commit tree.

July 24 - August 7:  Complete fuzzy matching of code movement and copy detect.

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

---------------------------------------------------
Thank you very much!

Regards!
Bo

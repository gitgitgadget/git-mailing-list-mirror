From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Mon, 22 Mar 2010 20:24:54 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003221924110.7596@pacific.mpi-cbg.de>
References: <41f08ee11003200218u59c45b6dl82a8eb56cc289256@mail.gmail.com>  <81b0412b1003201335g7b37c51mfa3e2280210ebb7e@mail.gmail.com>  <4BA544FC.7050007@gmail.com>  <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>  <4BA61CF9.7040104@gmail.com>
 <41f08ee11003212052p6b0a7495j2e38f24839541ffb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 22 20:25:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtnFN-0006FA-QJ
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 20:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755019Ab0CVTZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 15:25:00 -0400
Received: from mail.gmx.net ([213.165.64.20]:57827 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754908Ab0CVTY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Mar 2010 15:24:58 -0400
Received: (qmail invoked by alias); 22 Mar 2010 19:24:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 22 Mar 2010 20:24:53 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GA2NQaGsGj9yO1ZW3XRP68EVplvrF19Nq45ttgE
	hGx+BI6w0CdQaa
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <41f08ee11003212052p6b0a7495j2e38f24839541ffb@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142958>

Hi,

On Mon, 22 Mar 2010, Bo Yang wrote:

> Draft proposal(v2): Line-level History Browser
> 
> =====Purpose of this project=====
> "git blame" can tell us who is responsible for a line of code, but it
> can't help if we want to get the detail of how the lines of code have
> evolved as what it is now.
> This project will add a new feature for 'git log' to display line
> level history. It can trace the history of any line range of certain
> file at any revision. For simplity, users can run the command like: '
> git log -L builtin/diff.c:6,8 ', he will get the change history of
> code between line 6 and line 8 of the diff.c file. And for each
> history entry, it will provide the commits, the diff block which
> contains changes of users' interested lines.

I would not be too specific here about the exact syntax. I would rather 
have an example where this might be useful.

In git.git, for example, you could point to pretty_print_commit() which 
was split out from commit.c into pretty.c in 93fc05e(Split off the pretty 
print stuff into its own file), and mention that it is hard to verify 
without much hassle that the code split was really only a code split, 
rather than a split with an evil change.

Or you could point to 691f1a2(replace direct calls to unlink(2) with 
unlink_or_warn), where code was refactored, into a new function 
(unfortunately in two commits, so it might be a case not covered by your 
project) and it might be somebody's task to find out the original author 
for that function.

Basically, I would like to have a structure in the proposal like this: 
what? why? how? when?

> This utility will trace all the modification history of interested
> lines and stop until it finds the root of the lines, which is a point
> where all the new code is added from scratch. Also, the users can
> specify how deeply he wants this utility to trace. And this tool will
> treat code move just like modification too, so it will follow the code
> move inside one commit.
>
> Note that, the history may not always be a single thread of commits.
> If there are more than one commit which produce the specified line
> range, the thread of history will split.

Do not forget the case where there are more than one source of a code 
move. Think "refactoring".

> =====Work and technical issues=====
> ==Command options==
> This new feature should be used for exploring the history of changes
> for certain line range of code in one file.
> 
> git log [-m<num>] [-I] [-d depth] [--fuzzy]  -L file1@rev1:<start
> pos>,<end pos>  file2@rev2:<start pos>,<end pos>

I would like this not to be specified too much here. For example, we do 
not know yet, whether the matching will be fuzzy, or whether we find 
something cleverer than that.

So, I suggest to list not the command line options, but what you intend to 
support. I.e.:

> Options:
>
> 1. -m<num>, option to control whether we should follow code movement.  
>    If one -m is given, we follow code movement inside file, when more 
>    than one '-m' is given, we follow the movement between files in one 
>    commit. The <num> is used to specify the lower bound for the number 
>    of lines of moved code. If it is not given, we set it as 1.

Here you do not need to say that it is -m<num>, but that you want to 
support following code movements both inside and between files, but only 
optionally, for performance reasons (or some such).

In any case, this would probably just reuse the -M option.

> 2. -I, option to control whether we should display only the 'user 
>    interested lines' diff block [default] or display the whole diff with 
>    the interested area colorfully displayed.

It would be more in line with the diff options to use -U, but you do not 
have to state that. Just talk about a configurable amount of context.

> 3. -d, option to control the max depth we trace into the commit history.

Again, there are better options for "git log" already, but you do not need 
to be too explicit on the syntax side. Just say that you want to be able 
to use as many of "git log"s options as make sense in the context of 
line-level history.

> 4. --fuzzy, option to control whether fuzzy code copy mathing is used.

See above.

> 5. '-L' to control whether we run a simple log or we want a line level 
>    log.

See above.

> 6. Files and lines. I propose to use such a syntax to specify the files 
>    at revision and line range, <file>@<revision>:<start pos>,<end pos>. 
>    This looks a little complex, but I think it is neccessary because we 
>    will support multiple file at any version and any line range finally. 
>    The revision can be any revision format of Git and the <pos> can be a 
>    number, or a posix regex, just like what 'git blame' do.

See above.

> 7. And we will support code copy detect, too. The option which control 
>    whether we trace code copy does exist in current 'git log', which is 
>    the option '-C'. Similiarly, one '-C' is used to trace code copy of 
>    new added code inside one commit. Two '-C' will trace any code copy 
>    inside commit tree.

Again, do not be too specific about details that have to be fleshed out 
while working on the project. For example, we do not know yet whether it 
would make more sense to look for code movements automatically when we 
detected a deletion, and maybe fall back automatically to detecting code 
copies when we found an inter-file move.

> ==Design and implementation==
> Git store all the blobs instead of code delta, so we should traverse
> the commit history and directly access the tree/blob objects to
> compute the code delta and search for the diff which contains the
> interested lines.

s/ed/ing/

> Since git use libxdiff to format its diff file, we should iterate 
> through all xdiff's diff blocks and find what the code looks like before 
> the commit. This will be done using the callback mechanism. Here, we 
> will find a new line range which is the origin code before this commit. 
> And then start another search from the current commit and the new line 
> range.
>
> Recursively, we can find all the modification history. We will stop when 
> we find that the current interested line range is added from scratch and 
> is not moved from other place of the file. Here, if the user want to 
> trace code copy, more work will be done to find the possible code copy. 
> We may also stop the traverse when we reach the max search depth.
>
> Also, if the thread of change history split into two or more commits, we 
> stop and provide the users all the related commits and corresponding 
> line range.

Good.

> Generally,
> 1. New callback for xdi_diff to parse the diff hunk and store line
> level history info.
> 2. builtin/line-log.c will be added to complete most of the new features.
> 3. builtin/log.c will be changed to add this new utility to the front end.
> 4. Documents will be updated to introduce this new tool.

Good.

> =====Milestones and Timeline=====
> In this summer, we will add support of line level history browser for
> only one file. The multiple ranges support is currently not in this
> project.
> 
> The milestones of the project are:
> 1. Simple modification change history.

IMHO this should be split into

	1a) have an initial version which does nothing else than parse
	    git-log options and a single additional -L, requiring exactly
	    one file to be specified

	1b) implement the xdiff callback and identify the commits touching
	    the line range (this is not completely trivial due to merges)

> 2. Code movement inside one file detect.

Again, this has to be split a little bit. Code can split, and it can also 
unite. So, a single line range can easily become multiple ones.

> 3. Code movement inside one commit but not a file.

s/but not a file/between files/

> 4. Code copy of modified file in one commit.

You mean code copy from somewhere in the same file?

> 5. Code copy of any place in one commit tree.
> 6. Fuzzy matching support.

For fuzzy matching support, I would add some ideas, such as trying to 
match alpha-numeric characters, or matching longest words or some such. 
Also mention the possibility that this might be infeasible. In any case, 
give an example what case this is trying to help with.

> And the timeline will be:
> April 26 - May 23:   Catch up with Git code base and study the
> implementation of blame.c and log.c thouroughly.

Hmm. Maybe it would be better to be more precise. Like: 1st week: follow 
the bird's eye view on Git's source code. 2nd week, analyze the rev-list 
machinery (probably first looking at the code of merge-base, for easier 
understanding), 3rd week, have a look at builtin/log.c, 4th week, 
understand blame.c

> May 24 - June 21 :   Complete a version which supports code
> modifcation trace but without code movement and code copy support.
> 
> June 22 - June 29:   Complete a version which supports code movement
> inside one file.
> 
> June 30 - July 7:    Complete a version which supports code movement
> between files inside one commit.
> 
> July 8 - July 15:    Complete a version which supports code copy of
> modified file in one commit.
> 
> July 16 - July 23:   Complete a version which supports code copy of
> any file in one commit tree.
> 
> July 24 - August 7:  Complete fuzzy matching of code movement and copy detect.

This should probably adjusted a bit to my suggestions above.

Ciao,
Dscho

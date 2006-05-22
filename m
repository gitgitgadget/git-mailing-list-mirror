From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] tagsize < 8kb restriction
Date: Mon, 22 May 2006 12:18:04 -0700
Message-ID: <7vac99c1hv.fsf@assigned-by-dhcp.cox.net>
References: <4471CF23.1070807@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 21:18:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiFus-00076L-Vm
	for gcvg-git@gmane.org; Mon, 22 May 2006 21:18:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbWEVTSH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 22 May 2006 15:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751144AbWEVTSH
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 15:18:07 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:33444 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751147AbWEVTSG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 May 2006 15:18:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060522191805.IZVL18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 May 2006 15:18:05 -0400
To: =?iso-8859-1?Q?Bj=F6rn?= Engelmann <BjEngelmann@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20521>

Bj=F6rn Engelmann <BjEngelmann@gmx.de> writes:

> I am currently working on an interface for source code quality assura=
nce
> tools to automatically scan newly commited code. Since it is the only
> way to add data (scan-results) to an already-existing commit, I decid=
ed
> to use tags for that.
>
> Since the scan-results will most definitly exeed the 8kb-limit, I wou=
ld
> like to remove this artificial restriction.

Lifting the limit is good, but I am not sure if the use of tags
for that purpose is appropriate (or any git object for that
matter).  I'll talk about that at the end.

> What I found odd when writing the patch was that main() in mktag.c us=
es
> xread() to read from stdin (which respects EAGAIN and EINTR return
> values), but index_pipe() in sha1_file.c just uses read() for doing
> merely the same thing. For unifying both routines i found that xread(=
)
> might be the better choice.

Good.

> Removing the restriction was pretty straightforward but do you think
> this would break something in other places ?

I do not think so offhand.

Now, about the usage of such a long tag for your purpose.

As you noticed, commits and tags are the only types of objetcs
that can refer to other commits structurally.  But there are
cases where you do not even need nor want structural reference.
=46or example, 'git cherry-pick' records the commit object name of
the cherry-picked commit in the commit message as part of the
text -- such a commit does not have structural reference to the
original commit, and we would not _want_ one.  I have a strong
suspicion that your application does not need or want structural
reference to commits, and it might be better to merely mention
their object names as part of the text the application produces,
just like what 'git cherry-pick' does.

Presumably you will have one such tag per commit, and by default
'fetch' (both cg and git) tries to follow tags, which means
anybody who fetches new revision would automatically download
this QA data -- that is one implication of using a tag to store
this information.  Without knowing the nature of it, I am not
sure if everybody who tracks the source wants such baggage.  If
not, then use of a tag for this may not be appropriate.

Another question is if the QA data expected to be amended or
annotated later, after it is created.

If the answer is yes, then you probably would not want tags --
you can create a new tag that points at the same commit to
update the data, but then you have no structural relationships
given by git between such tags that point at the same commit.
You could infer their order by timestamp but that is about it.
I think you are better off creating a separate QA project that
adds one new file per commit on the main project, and have the
file identify the commit object on the main project (either
start your text file format for QA data with the commit object
name, or name each such QA data file after the commit object
name).  Then your automated procedure could scan and add a new
file to the QA project every time a new commit is made to the
main project, and the data in the QA project can be amended or
annotated and the changes will be version controlled.

If the answer is no, then it is probably better to just use an
append-only log file that textually records which entry
corresponds to which commit in the project.  If it is not
version controlled, and if it is not part of the main project, I
do not see much point in putting the data under git control and
in the same project.

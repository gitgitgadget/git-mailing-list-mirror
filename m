From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: make leftmost column of blame less cluttered.
Date: Wed, 4 Oct 2006 08:59:28 -0700 (PDT)
Message-ID: <20061004155928.57310.qmail@web31809.mail.mud.yahoo.com>
References: <7vsli4jy8o.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 04 18:01:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GV99u-0007cC-0E
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 17:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161284AbWJDP7c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Oct 2006 11:59:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161300AbWJDP7b
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Oct 2006 11:59:31 -0400
Received: from web31809.mail.mud.yahoo.com ([68.142.207.72]:25991 "HELO
	web31809.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161301AbWJDP73 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Oct 2006 11:59:29 -0400
Received: (qmail 57312 invoked by uid 60001); 4 Oct 2006 15:59:28 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SZrusFfr6TDTw2Oyaqo00DPAhZg6YPBZBW1ST9Ovp2bH7muPWe3+tiPJMQ1P/f9Se+YIbjc59zYJG6SkKqV5zmzJFgl5hXIopYVjaAps90PKTnW1Chid9Z00zzIgX/SlZIF+i+EptfI/kG7gjqM88KA4SnhWqhjT4q2EE6kPzEI=  ;
Received: from [71.80.233.118] by web31809.mail.mud.yahoo.com via HTTP; Wed, 04 Oct 2006 08:59:28 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vsli4jy8o.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28326>

--- Junio C Hamano <junkio@cox.net> wrote:
>  (1) grouping clue comes solely from the zebra shading;
>      placement of commit-8 does not have anything to do with the
>      grouping.  It was just that the old interface had N
>      commit-8 links for a group that consists of N lines.  I
>      made it to approximately N/20 links, and you are in favor
>      of having 1 link per group.

Yes, either 1 or infinity is fine with me.

>  (2) commit-8 is the only visually obviously clickable thing to
>      get to the commit.  Having them only on the first line in
>      the group means for a large group it would scroll off the
>      top after reading all the lines in the group through to
>      decide it is worth inspecting; think of a case where one
>      commit added 80 lines of code and each line is shown in
>      14-dot high font on 1024x768 display which would give you
>      50 lines or so at most.

Yes, I completely understand the problem you're describing
here and have seen even more extreme examples of it.

Consider the general common case where files have had
commits since the initital commit and have various blocks-per-commit.
The eye gets accomodated to seeing one leading commit-8 _per commit block_.

All of a sudden now, it would also see "leading" commit-8
every arbitrary-N rows, leading the brain to believe that this
is a commit-block, while it is not.

This breaks this learned assumption, and makes it confusing
if this is a block-commit or if it is the _previous_ commit.

> Put it another way, it is a redundancy just like the same set of
> links people place at the top and the bottom of a page.  It is
> redundant in the sense that you can always scroll to either one,
> but having closer to the mouse pointer helps accessing them.  It

I use PgUp in this case.

> > The middle ground as it seems to me, neither infinity nor 1, is
> > to just use the block-per-commit-coloring and use your idea of printing
> > the commit-8 only on the leading block row with mouse-over author
> > and date info. That's an excellent idea.*
> 
> I am not quite sure what you mean by this.

Well, you introduced this paramenter N to decide how large the
limit is where one needs to print another redundant commit-8.  Yes?

Analyse N and its impact on output:
  1) N approaches infinity (extreme case)
  2) N = 1 (extreme case)
  3) N = something in between (20 is what you had selected)

1) When N approaces infinity, we get the behaviour that there is
no redunant printing of the commit-8 every N rows, since one cannot
have infinite rows. (i.e. N doesn't equal any positive integer)
The commit-8 is printed only on the first row of the commit-block.

2) When N is set to 1, we get the old behaviour, where the same
commit-8 is printed on every line of the commit-block.  The redundancy
is of order the number of rows of the commit-block.  The extremes
are:
  i) Same commit-8 on every line of the file, meaning there were no
     commits since the inital commit.
  ii) Every line was touched by a commit which didn't touch any
     other line. Every line has a different commit.
In both extremes we get a commit-8 per line.

3) Set N to some integer, 1 < N. The question is what should that
integer be?

That's a very interesting question.

Suppose you set N to some positive integer k > 1.

WLG, consider a text file of at least 4*k lines, with 3 commits,
such that commit 1 touches lines 0 to k-1, commit 2 touches
lines k to 3*k-1, and commit 3 touches lines 3k to 4*k-1.

Here is a picture, wlg:

1 : line 0
    ...
    line k-1
2 : line k
    ...
    line 2k-1
2 : line 2k
    ...
    line 3k-1
3:  line 3k
    ...
    line 4k-1

Notice that commit 2 is printed at line 2k as well as line k.
This is inconsistent with the assumption that a leading
commit-8 is different than the previous one, and introduces
a new commit-block.

That is, there is no good arbitration for N other than 1 or
infinity, such that the brain doesn't need to break the assumption
that a leading commit introduces a block of different commit than
the previous. And this is indeed what the "zebra" coloring is all
about.

The more extreme case is where you'd have a very large file with
many large commits touching an integer line of lines multiple of k,
such that the smallest commit-block is at least 2k lines.

Then you'd get this confusing patchwork of zebra coloring and in
each block you'd get at least two commit-8 which are the same,
confusing if it is different than the previous or not, since
commit-8s appear at least every k lines.

All I'm saying is that I'd rather keep the leading commit-8 consistent
with the "zebra" coloring.

    Luben

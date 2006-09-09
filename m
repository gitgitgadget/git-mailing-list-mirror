From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Change set based shallow clone
Date: Sat, 9 Sep 2006 15:00:08 +0200
Message-ID: <e5bfff550609090600k4e4b1ae0s1cbee5e3fa01cba@mail.gmail.com>
References: <20060909103157.23388.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 15:00:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GM2RW-0008Hj-0g
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 15:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932149AbWIINAN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 09:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWIINAM
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 09:00:12 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:50765 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932149AbWIINAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 09:00:09 -0400
Received: by py-out-1112.google.com with SMTP id n25so1293658pyg
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 06:00:08 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FPuLACtIpBGrziFu77qf8TMW0QDbqmT7OHsl5zXGYYOq/WuutTzU5xoxVLEAGI/ZBX7wA0iXpJD6lH71DuvpzY1qGCURpm3jU12GbBe/puCQP1S4GTDN9QtCWC7DCC2mECLxf+BiimfJX1vENiqqJb4++/G0zcwKno0XV88sC84=
Received: by 10.35.10.17 with SMTP id n17mr4902646pyi;
        Sat, 09 Sep 2006 06:00:08 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Sat, 9 Sep 2006 06:00:08 -0700 (PDT)
To: "linux@horizon.com" <linux@horizon.com>
In-Reply-To: <20060909103157.23388.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26746>

On 9 Sep 2006 06:31:57 -0400, linux@horizon.com <linux@horizon.com> wrote:
> > If the out of order revisions are a small amount of the total then
> > could be possible to have something like
> >
> > git rev-list --topo-order --with-appended-fixups HEAD
> >
> > Where, while git-rev-list is working _whithout sorting the whole tree
> > first_, when finds an out of order revision stores it in a fixup-list
> > buffer and *at the end* of normal git-rev-lsit the buffer is flushed
> > to receiver, so that the drawing logic does not change and the out of
> > order revisions arrive at the end, already packed, sorted and prepared
> > by git-rev-list.
>
> I don't think I understand your proposal.  The problem arises when
> git-rev-list finds a commit that it should have listed before something
> that it has already output.
>
> Just for example:
>
> Commit D: Ancestor B
> Commit B: Ancestor A
> Commit C: Ancestor B
>
> Commit C is the problem, because if git-rev-list has already output B,
> there's no way to back up and insert it in the right place.
>
> How is waiting to output the already-behind-schedule commit C going
> to help anything?

It helps in a number of ways from receiver point of view.

- Receiver doesn't need to keep a sorted list of loaded revisions.

- Receiver doesn't need to stop parsing input and redraw the graph in
the middle of the loading.

- Receiver doesn't need to  check for possible out of order commits
when loading data, but can be assured data that arrives is
--topo-order consistent (although my not be complete)

- Split the in order parsing code (performance critical and common
case) from fixup-code (run at the end and on a small set of commits).

- Much faster implementation because the sorting is done only in
git-rev-list and only once.

Following your example my suggestion was something like this:

Instead of:

git-rev-list HEAD

Commit D: Ancestor B
Commit B: Ancestor A
Commit C: Ancestor B
Commit A: Ancestor E
Commit E: Ancestor F
Commit F: Ancestor G
....
Commit V: Ancestor Z

git-rev-list --topo-order ----with-appended-fixups HEAD

sends something like:

Commit D: Ancestor B
Commit B: Ancestor A
Commit A: Ancestor E
Commit E: Ancestor F
Commit F: Ancestor G
....
Commit V: Ancestor Z
(* end of correct sorted commits and start of out of order commits*)
Commit C: Ancestor B
......
Commit  N: Ancestor M

So that receiver drawing code designed with working with --topo-order
kind output could as usual draws the graph until Commit V: Ancestor Z
(but without waiting for git-rev-list latency!!) and the new fixup
code could *at the end* loop across *already sorted* fixup set:

Commit C: Ancestor B
......
Commit  N: Ancestor M

and update the graph in one go. Of course some flag/syntax should be
introduced to trigger the end of sorted code and beginning of fixups
in git-rev-list output stream.

       Marco

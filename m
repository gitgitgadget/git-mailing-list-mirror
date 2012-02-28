From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH] commit: allow {--amend|-c foo} when {HEAD|foo} has empty message
Date: Tue, 28 Feb 2012 10:20:08 +0100
Message-ID: <87haybco1j.fsf@thomas.inf.ethz.ch>
References: <8529824c8569a8a0b4c4caf3a562750925758e74.1330419275.git.trast@student.ethz.ch>
	<20120228090540.GB5757@sigill.intra.peff.net>
	<20120228091422.GC5757@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 28 10:20:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2JEJ-0002h2-Mb
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 10:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754289Ab2B1JUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 04:20:13 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:7533 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753784Ab2B1JUL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 04:20:11 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 10:20:07 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 10:20:08 +0100
In-Reply-To: <20120228091422.GC5757@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 28 Feb 2012 04:14:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191705>

Jeff King <peff@peff.net> writes:

> On Tue, Feb 28, 2012 at 04:05:40AM -0500, Jeff King wrote:
>
>> >  	} else if (use_message) {
>> >  		buffer = strstr(use_message_buffer, "\n\n");
>> > -		if (!buffer || buffer[2] == '\0')
>> > +		if (!amend && !edit_message && (!buffer || buffer[2] == '\0'))
>> >  			die(_("commit has empty message"));
>> 
>> Hmm. So "buffer" used to never be NULL (because we would die if it is),
>> and now we might not die if we are doing an amend, no? And the next line
>> is:
>> 
>> >  		strbuf_add(&sb, buffer + 2, strlen(buffer + 2));
>> 
>> Doesn't this need to handle the case of NULL buffer (i.e., when it does
>> not already have "\n\n" in it)?
>
> I wrote that after looking at just your patch. Looking at
> builtin/commit.c, I think use_message_buffer will always be a re-encoded
> commit object. So that strstr should _never_ fail unless the commit
> object is corrupt. So the right thing is probably:
>
>   buffer = strstr(use_message_buffer, "\n\n");
>   if (!buffer)
>           die(_("commit object has invalid format"));
>   if (!amend && !edit_message && buffer[2] == '\0))
>           die(_("commit has empty message"));

Interesting.  After I got your mail, I started poking around, and it
turns out we're in a funny situation here.  I did this:

  $ git cat-file commit HEAD
  tree 205f6b799e7d5c2524468ca006a0131aa57ecce7
  parent c4938d8e6d23e3a8fe10e6466ecd827662c14846
  author Thomas Rast <trast@student.ethz.ch> 1330417798 +0100
  committer Thomas Rast <trast@student.ethz.ch> 1330417798 +0100

  $ git cat-file commit HEAD | grep -v '^$' | git hash-object -w -t commit --stdin
  f68fcc1996173a9e04bd45d42abbb7c85c79546d
  $ git reset --hard f68fcc1996173a9e04bd45d42abbb7c85c79546d

So now I'm at a commit which does not have that \n\n.  And poking around
gives a very confusing picture:

  $ git fsck
  Checking object directories: 100% (256/256), done.
  $ git show
  Segmentation fault
  $ git log
  Segmentation fault
  $ git format-patch -1
  0001-.txt
  $ cat 0001-.txt  # no output!
  $ git bundle create test.bdl HEAD
  error: rev-list died of signal 11
  error: rev-list died
  $ git rev-list HEAD
  f68fcc1996173a9e04bd45d42abbb7c85c79546d
  c4938d8e6d23e3a8fe10e6466ecd827662c14846
  $ git rev-list --pretty=oneline HEAD
  Segmentation fault

So either there's a lot to be fixed, or fsck needs to catch this.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

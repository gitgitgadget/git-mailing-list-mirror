From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v2 0/4] A new library for plumbing output
Date: Sat, 17 Apr 2010 05:53:00 -0400
Message-ID: <20100417095259.GA23110@coredump.intra.peff.net>
References: <20100411231824.67460.24844.julian@quantumfyre.co.uk>
 <7viq7toh12.fsf@alter.siamese.dyndns.org>
 <20100415065700.GA27542@coredump.intra.peff.net>
 <201004151107.33892.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	git@vger.kernel.org, Eric Raymond <esr@thyrsus.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 17 11:53:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O34im-00020I-5l
	for gcvg-git-2@lo.gmane.org; Sat, 17 Apr 2010 11:53:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755547Ab0DQJxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 05:53:35 -0400
Received: from peff.net ([208.65.91.99]:43071 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755160Ab0DQJxe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 05:53:34 -0400
Received: (qmail 15512 invoked by uid 107); 17 Apr 2010 09:53:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 17 Apr 2010 05:53:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 17 Apr 2010 05:53:00 -0400
Content-Disposition: inline
In-Reply-To: <201004151107.33892.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145126>

On Thu, Apr 15, 2010 at 11:07:32AM +0200, Jakub Narebski wrote:

> Well, IMVHO output of "git status --short" / "git status --porcelain"
> (without '-z') is very hard to parse.  Even assuming that in the case
> of ambiguity filenames are quoted (which also means that in the case of
> ambiguity whether they are quoted they must be quoted), the fact that

For the record, they are properly quoted in the non-z form.

> [some reasons it's hard to parse]

Yeah, I don't disagree with your reasons (which are largely the same as
Eric's). I just don't think it's "oh no this is useless and we have to
start again" hard.

> What was the reason behind choosing " -> " as separator between pair[1]
> of filenames in rename, instead of using default "git diff --stat" format
> i.e. 'arch/{i386 => x86}/Makefile' for "git status --short" which is
> meant for end user, and for "git status --porcelain" the same format 
> that raw diff format, i.e. with TAB as separator between filenames,
> and filename quited if it contains TAB (then TAB is relaced by '\t',
> and does not appear in filename, therefore you can split on TAB)?

I don't know Junio's reason for using " -> " in --short; probably
because it was the format used in non-short status. For --porcelain, it
was simply because I used exactly --short. I assumed that --short was
suitable for parsing (which it _is_, it just has some rough edges), and
wanted to provide an option right away that would keep the output
stable, so we didn't run into the usual problem of people wanting to
enhance the human-readable interface, but being blocked by script
compatibility.

> IMVHO "git status --porcelain -z" format is not easy to parse either.
> (The same can be said for "git diff --raw -z" output format.)  You
> can't just split on record separator; you have to take into account
> status to check if there are two filenames or one.

Yep, I agree. I think the JSON approach is the best solution, as it is
separating syntax from semantics.

> [1] A question: we have working area version, index version, and HEAD
>     version of file.  Isn't it possible for *each* of them to have 
>     different filename?  What about the case of rename/rename merge
>     conflict?

Good question. The answer is no, the three different versions can't have
three filenames on the same line, because we don't do rename detection
between the working tree and the index. Which makes sense. Consider
something like this:

  mkdir repo && cd repo && git init
  echo content >one
  git add one && git commit -m one
  mv one two && git add -A
  mv two three
  git status

We will see the movement of "one -> two" between the index and HEAD. In
theory we could see the movement of "three -> two" between the index and
working tree. But "three" isn't tracked, so instead we see "two" deleted
and "three" untracked. We can mark "three" with intent-to-add to note
that we are interested in it, but then it is not a new file any more
(since it has an index entry), and is therefore not eligible for rename
detection.

As for a rename/rename conflict, it gets represented in the index as
both deleting the source and then each side adding its new version with
a conflict. So:

  mkdir repo && cd repo && git init
  echo content >one
  git add one && git commit -m base
  git mv one two && git commit -m two
  git checkout -b other HEAD^
  git mv one three && git commit -m three
  git merge master
  git status

generates:

  # On branch other
  # Unmerged paths:
  #       both deleted:       one
  #       added by us:        three
  #       added by them:      two

and an equivalent short-status form.

> Although if possible I'd like to have it wrapped in utility macros,
> like parseopt, so one does not need to write output_str / output_int
> etc.... but currently it is very, very vague sketch of an idea, rather
> than realized concept.

I'm not sure I understand what utility macros you would want.

-Peff

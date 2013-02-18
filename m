From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Mon, 18 Feb 2013 18:46:05 +0100
Message-ID: <87k3q5zfaa.fsf@pctrast.inf.ethz.ch>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	"Jakub Narebski" <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Michael Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Jens Lehmann" <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 18 18:46:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7UnU-0006rG-A0
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 18:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398Ab3BRRqL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 12:46:11 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:20348 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756158Ab3BRRqK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 12:46:10 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Mon, 18 Feb
 2013 18:46:02 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Mon, 18 Feb 2013 18:46:05 +0100
In-Reply-To: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
	"Mon, 18 Feb 2013 18:23:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216487>

Thomas Rast <trast@inf.ethz.ch> writes:

> * We should prepare an "ideas page"[...]
>     https://github.com/trast/git/wiki/SoC-2013-Ideas

>From where I'm currently sitting, I won't have the time to mentor this
year.  So my two earlier proposals are essentially up for grabs:

1. Improving parallelism in various commands
   -----------------------------------------
 
   Git is mostly written single-threaded, with a few commands having
   bolted-on extensions to support parallel operation (notably git-grep,
   git-pack-objects and the core.preloadIndex feature).
 
   We have recently looked into some of these areas and made a few
   optimizations, but a big roadblock is that pack access is entirely
   single-threaded.  The project would consist of the following steps:
 
    * In preparation (the half-step): identify commands that could
      benefit from parallelism.  `git grep --cached` and `git grep
      COMMIT` come to mind, but most likely also `git diff` and `git log
      -p`.  You can probably find more.
 
    * Rework the pack access mechanisms to allow the maximum possible
      parallel access.
 
    * Rework the commands found in the first step to use parallel pack
      access if possible.  Along the way, document the improvements with
      performance tests.
 
   The actual programming must be done in C using pthreads for obvious
   reasons.  At the very least you should not be scared of low-level
   programming.  Prior experience and access to one or more multi-core
   computers is a plus.

This one is probably still a contender.  However, it might be worth
first looking into whether using libgit2 for pack reading would be
easier and faster, since it is written to be reentrant from the ground
up.


2. Improving the `git add -p` interface
   ------------------------------------

   The interface behind `git {add|commit|stash|reset} {-p|-i}` is shared
   and called `git-add--interactive.perl`.    This project would mostly
   focus on the `--patch` side, as that seems to be much more widely
   used; however, improvements to `--interactive` would probably also be
   welcome.

   The `--patch` interface suffers from some design flaws caused largely
   by how the script grew:

    * Application is not atomic: hitting Ctrl-C midway through patching
      may still touch files.

    * The terminal/line-based interface becomes a problem if diff hunks
      are too long to fit in your terminal.

    * Cannot go back and forth between files.

    * Cannot reverse the direction of the patch.

    * Cannot look at the diff in word-diff mode (and apply it normally).

   Due to the current design it is also pretty hard to add these features
   without adding to the mess.  Thus the project consists of:

    * Come up with more ideas for features/improvements and discuss them
      with users.

    * Cleanly redesigning the main interface loop to allow for the above
      features.

    * Implement the new features.

   As the existing code is written in Perl, that is what you will use for
   this project.

This has already featured twice, and resulted in proposals that were
insufficiently advanced and too little work for a GSoC.  If nobody feels
like extending it to a bigger project, I'll just scrap it.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch

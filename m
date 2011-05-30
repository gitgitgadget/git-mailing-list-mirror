From: Shawn Pearce <spearce@spearce.org>
Subject: Re: blame --reverse selecting wrong commit
Date: Mon, 30 May 2011 10:57:54 -0700
Message-ID: <BANLkTikvmQgW=x0GYY6Yu=BnOgG+RXOCug@mail.gmail.com>
References: <BANLkTikuFEg686VH_RojEe-zmBZRBOx6eA@mail.gmail.com>
 <BANLkTimAij28ibW3DV2HaHPK5z0D-CrDHQ@mail.gmail.com> <BANLkTimXppE9sCW8tMntbD8p5-bRVFLHmQ@mail.gmail.com>
 <7vlixoofaj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 30 19:58:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR6jN-0005Sw-C0
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 19:58:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753039Ab1E3R6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 13:58:16 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42988 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab1E3R6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 13:58:16 -0400
Received: by vxi39 with SMTP id 39so2780520vxi.19
        for <git@vger.kernel.org>; Mon, 30 May 2011 10:58:15 -0700 (PDT)
Received: by 10.52.88.228 with SMTP id bj4mr5046930vdb.57.1306778295078; Mon,
 30 May 2011 10:58:15 -0700 (PDT)
Received: by 10.52.167.228 with HTTP; Mon, 30 May 2011 10:57:54 -0700 (PDT)
In-Reply-To: <7vlixoofaj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174765>

On Sun, May 29, 2011 at 23:47, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> Rereading commit 85af7929ee ("git-blame --reverse"), it seems you left
>> this an "exercise for the reader"... and in the past 3 years, no
>> reader has stepped forward to implement the exercise as a patch to
>> blame. *sigh*
>
> Yeah.
>
> It has always been my opinion that asking for "one commit past the blamed
> one" is a undefined request (after all, blame for the line fell on that
> commit exactly why the next commit does _not_ have any corresponding
> line), so that is why I punted there.

I don't think its undefined. Normally with blame/annotate we want to
discover who put this line here, that is who did the insertion or
replacement that made this line show up in the result file. Under
these circumstances its clear to everyone that this is the commit with
the "+" in its unified diff on that line. :-)

A reverse blame/annotate would want to say who removed this line in
history. That's very well defined by everyone as the commit with the
"-" in its unified diff on that line.

The notion of who deleted the line may seem less well defined than who
added it, because when you flip the history graph around you have
these forks exiting a single revision (an anti-merge as it were)...
and any of those forks could have caused the deletion in question. Or
all of them may have caused it. If more than one is responsible for
the deletion, who do you blame?

The same problem of multiple parties at fault exists in the normal
forward case too. When a normal merge commit is reached, both sides
may have added the exact same line independently... and the merge
result will now contain identical content. Currently blame chooses to
traverse only the first parent history in this case, ignoring the
other parents, and never showing that side branch. Its not any
different than the fork problem during deletion.

> Now we seem to have found one interested reader, eh? ;-)

Well, I implemented --reverse "correctly" in JGit last night. With my
patch series applied, `jgit blame --reverse` will produce annotations
for who deleted the line, rather than the last surviving revision.

The catch is, its slightly more expensive than forward because we pass
blame down *all* paths of a fork, rather than only the one that was
identical. This prevents pruning of side branches like we do in the
normal forward case, making for a larger amount of history to examine
during the reverse traversal. The incremental output also may produce
more than one "source" for a given line, if different side branches
deleted that line independently of one another. We smooth that out in
our final result object for the command line case by showing only the
earliest deletion, and discarding the other candidates.

I still need to write a bunch of unit tests around the Java code, but
the algorithm worked as expected on the section of graph I started
this thread with. It may be worth back-porting to C Git, but now that
--reverse is already shipping with its current "last surviving
revision" results, I'm not sure we can change the results without
causing some major confusion to users.

-- 
Shawn.

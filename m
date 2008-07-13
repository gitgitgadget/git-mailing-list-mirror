From: "Sverre Rabbelier" <alturin@gmail.com>
Subject: Re: [RFH] Finding all commits that touch the same files as a specific commit
Date: Sun, 13 Jul 2008 16:43:21 +0200
Message-ID: <bd6139dc0807130743y178a865amebcf130a68283854@mail.gmail.com>
References: <bd6139dc0807120858vc058451lb10933b5225c8521@mail.gmail.com>
	 <7viqvavao4.fsf@gitster.siamese.dyndns.org>
Reply-To: sverre@rabbelier.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailinglist" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 16:44:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI2oM-0006SR-8J
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 16:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbYGMOnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 10:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbYGMOnW
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 10:43:22 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:13049 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753466AbYGMOnW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 10:43:22 -0400
Received: by wf-out-1314.google.com with SMTP id 27so4479854wfd.4
        for <git@vger.kernel.org>; Sun, 13 Jul 2008 07:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nRl24iZZZg9MgP/fq1Iv92g9XKwrlfzEbV9vJSoJP8E=;
        b=j+YFC5Bxl3p42RuJGhUZKB2/ijwTXrwUrjUddx4keS7dwjNx4LBGOxgJNnu739O7+E
         CsKMYcT9dQz64XjKbg/i/qNHp8YccXSwoWIQQkhyfpTguO7/dcgEURU6Y+tCiWDSIxS1
         ponw0DanVr87u9QfAeJgfHbeZ4wzj9KOLpi0U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=flHN2UPu4abmF3TQ9TU2bq1aRFFyxIG7zn0+Gqw+7UTaQhlas8e6oAizrwOclzRg8a
         YusnXpF4Jr3UeCr/P3AySS55ai1nI0NCtWq2HC9BGwVEkOLHBfDyMyPgYUAguN/t0yro
         PfI1EIBgKmB4LIHVj0Wkfe/38UjkWLdT0ZVEc=
Received: by 10.142.127.10 with SMTP id z10mr3883069wfc.263.1215960201480;
        Sun, 13 Jul 2008 07:43:21 -0700 (PDT)
Received: by 10.143.38.17 with HTTP; Sun, 13 Jul 2008 07:43:21 -0700 (PDT)
In-Reply-To: <7viqvavao4.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88315>

On Sun, Jul 13, 2008 at 3:24 AM, Junio C Hamano <gitster@pobox.com> wrote:

<explanation of the git log traversal machinery snipped>

> In order to follow renames reliably in a merge heavy history, you need to
> keep track of the pathname the file you are interested in appears as _in
> each commit_.  As you traverse down the history, you pass down the
> pathname to the parent you visit, so while you are traversing from 'x' to
> earlier 'x', you will keep following "git-gui/git-gui.sh", while you
> traverse down to 'o', you will inspect "git-gui.sh".
>
> The data structure the revision traversal machinery uses does not support
> this "path-per-commit" natively.

Would it be possible to go for a slightly less complicated approach
and instead of passing replacing the tracked file, append it? We
already have a list of files we are tracking, so I assume the data
structure does support that. Such would run with the risk of tracking
too much (e.g., you rename a.txt => b.txt, and then later on
create/rename a new a.txt which is then tracked as well).

> This is the reason "git-blame" uses its own traversal engine.  It keeps
> track of <commit, path> pairs so that it can mark which line came from
> what path in what commit.  When copy/move detection are used, we can even
> notice that the contents we are interested in came from more than one file
> in the same commits, and the data structure supports it (i.e. it is not
> just a pointer to a single string from "struct commit").

So what could be done is use a blame-like mechanism that invokes
rename detection on each interesting commit and then record that
information? Purely hypothetical though, since I know neither and have
no time to do so.

> For the purpose of "git log" traversal and the "file renames" people
> usually talk about, this is overkill; you should however be able to
> backport the basic idea to revision machinery, if you really cared.

Right, that'd teach git log how to follow across renames in an
intelligent manner that works also for non-linear histories at the
cost of using up more memory and cpu?

> In a real history, "file rename" is a very ill defined concept and is not
> always useful in practice.  I did a fairly detailed analysis on one
> real-world history more than two years ago, which is found here:
>
>    http://thread.gmane.org/gmane.comp.version-control.git/13746/focus=13769

Aye, I agree that a 'rename' is hard to define and that a lot of
effort could be put into supporting 'renames' that are not trivial
(e.g., more complex than 'git mv foo.txt bar.txt').

> In our own "git.git" history, the evolution of what finally landed in
> revision.c is interesting.  The interesting part of content movement never
> involved any file renames --- only bits and pieces migrated over across
> many files.  That is not something "file rename tracking", even with an
> extension to the revision traversal machinery to keep one path per commit
> to record the file you are interested in, can ever give meaningful
> explanation of the history.  You need a lot more fine grained "blame"
> traversal machinery for that.

This makes sense, but it (using blame traversal machinery) is overkill
for what I am interested in. What I think would be a good goal in
supporting is the subtree merge strategy. It would be nice if 'git log
--follow-subtree-merge refspec -- filefilter' or such would Just Work
(TM). Perhaps that the hunk-tracking I am working on with Dscho could
help make 'git log --numstat' more accurate. Those two combined (git
log being able to follow across subtree merges and being able to
recognise hunks being moved) would be all that I need.


-- 
Cheers,

Sverre Rabbelier

From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/WIP v2 00/14] inotify support
Date: Tue, 28 Jan 2014 17:46:56 +0700
Message-ID: <CACsJy8AuJQTYdHX0080DXWOWBr7MiDhYkNQ4mMAiPjLi3OTfQQ@mail.gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com> <87mwirewd7.fsf@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Tue Jan 28 11:47:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W86CZ-0008Q4-F1
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jan 2014 11:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbaA1Kr1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jan 2014 05:47:27 -0500
Received: from mail-qa0-f49.google.com ([209.85.216.49]:58475 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbaA1Kr0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jan 2014 05:47:26 -0500
Received: by mail-qa0-f49.google.com with SMTP id w8so219096qac.8
        for <git@vger.kernel.org>; Tue, 28 Jan 2014 02:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6mN0/E5ftwWzEif5XwQ7VarANQ3YRmoIa/8WcxCbQfA=;
        b=cB6fIe/klue1GeqmUgTtM0GWcRSHfKOUaXNLgkN653UMPE9G7MV5QPPvs6ormSAqUC
         B9dKEwMLPimw/TMnNM+ecQO+gQc7dqia2yDqwqiN5p+ebmBOmdbTFXS8vwt5tTBumpp7
         +Cn7vNZuYb78YnpyBrK3hgN2zf6ifo7eqTpiA5bSfRc56uhg2YOuKcSVWd3VdgBOVmcP
         hc1uxViebzgVA26QOkIt6HqZzle/qw3ngLbXi38TtWKhAdvZXm0lUyuGHNe7RKDMmZ3n
         0FdvB1vxqNAd+UXvfW8EewpBW0xPiZEd96rLtH2qLYUPz+g7eSADwSLK7bPb2NkzWW/Z
         Frbw==
X-Received: by 10.229.219.5 with SMTP id hs5mr1089904qcb.9.1390906046252; Tue,
 28 Jan 2014 02:47:26 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Tue, 28 Jan 2014 02:46:56 -0800 (PST)
In-Reply-To: <87mwirewd7.fsf@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241183>

On Mon, Jan 20, 2014 at 12:04 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> There's also the problem of ordering guarantees between the socket and
> inotify.  I haven't found any, so I would conservatively assume that the
> socket messages may in fact arrive before inotify, which is a race in
> the current code.  E.g., in the sequence 'touch foo; git status' the
> daemon may see
>
>   socket                    inotify
>   < hello...
>   < status
>   > new <empty list>
>                             touch foo
>
> I think a clever way to handle this would be to add a new command:
>
>   Wait::
>     This command serves synchronization.  Git creates a file of its
>     choice in $GIT_DIR/watch (say, `.git/watch/wait.<random>`).  Then it
>     sends "wait <path>".  The watcher MUST block until it has processed
>     all change notifications up to and including <path>.

Assuming that the time between foo is touched and the time an event is
put in the daemon's queue is reasonably small, would emptying the
event queue at "hello" be enough? To my innocent eyes (at the kernel),
it seems inotify handling happens immediately after an fs event, and
it's uninterruptable (or at least not interruptable by another user
space process, I don't think we need to care about true interrupts).
If that's true, by the time the "touch syscall" is finished, the event
is already sitting in the daemon's queue.

The problem with wait.<random> is we need to tell the daemon to expect
it. Otherwise if the daemon processes the "wait.<random>" even before
"wait" is sent, it would try to wait for the (lost) "wait.<random>"
event forever. An extension is git touch wait.<random> regularly. Or
to keep a queue of processed "wait.*" events. Both look ugly imo.
Another option is send "expect wait.<random>" first, wait for ack,
touch wait.<random>, then send "wait", which is too much.
-- 
Duy

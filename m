From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 9 Jun 2013 22:06:54 +0530
Message-ID: <CALkWK0koyDS3m2B9fdnwv5e_gT3zp9y+MB9TwVN4kHEr9HkRZw@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
 <CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
 <CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
 <20130609151235.GA22905@serenity.lan> <CAMP44s0L9nQxp5OeK8uT4Ls5WUerCjVpR9uONUcOwvTD6k7Jfg@mail.gmail.com>
 <20130609160225.GB22905@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jun 09 18:37:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulicj-0002cP-Tt
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:37:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752668Ab3FIQhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:37:39 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:57757 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347Ab3FIQhf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:37:35 -0400
Received: by mail-ie0-f175.google.com with SMTP id a13so1468601iee.6
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ZRtIwrGcEYHNcptPRWHb7CWGvGoQaME2QcQqVzvHm54=;
        b=QkM20V/J4LynhCuKqzbwR7TJOglFSO//GHA+dup0yI9xIQLzUSjM3GcMVhIbN+gULN
         dXOsLIbLyqU/1heHo/geWJqGyp/8JwgMBeYq8s3NMv691510noLlWhMbegbNJI3X3zP4
         YEOOk7j9N5+EGP0KhbMnwvY0XPnqtHgqKfJR641vgtAVAgkErSmNfmpuHkWiTcI4LITT
         qr0y+l+wxw22RQPFkZ0zBIu7sw8GlPIGI7QaNjNkaUAYoONW2VvL2x6/OQ+2BnkvpPnJ
         choo7rs6JiaAYzLbDaG1nXFcYaa2Dof/VCaOdmM+yrtdjafC76J4ekEe9YDOl46fsRhN
         mzDQ==
X-Received: by 10.50.56.20 with SMTP id w20mr2510334igp.40.1370795854575; Sun,
 09 Jun 2013 09:37:34 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 9 Jun 2013 09:36:54 -0700 (PDT)
In-Reply-To: <20130609160225.GB22905@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226971>

John Keeping wrote:
> How is it only useful for builtin commands?  By that logic everything
> belongs in builtin/ because it's all only used by builtin commands (I
> realise that is what you're arguing towards).

sequencer.c is merely a common API for builtins to invoke
"continuations": i.e. stop the program persisting enough state to let
to user continue, allow the user to do whatever conflict resolutions
using whatever tools, allow the user to continue the original
operation.  sequencer.c provides a uniform UI
(--continue|--skip|--abort), and a uniform way to persist state
(.git/sequencer/todo).  It mainly abstracts out the boring details of
reading/writing the todo lines.

Currently, sequencer.c has no callers other than those in
builtin/revert.c.  In its current shape, it's incapable of being used
by anything else: while an external ruby script (possibly a rebase
implementation) could call into the sequencer to persist state, I
don't think it is going to happen anytime soon.

We might get a proper public api sequencer sometime in the distant
future, but don't confuse that with the current shape of sequencer.c.

> But we make a distinction between things that are specific to one
> command (especially argument parsing and user interaction) and more
> generally useful features.  Copying notes around in the notes tree is
> generally useful so why shouldn't it be in notes.c with the other note
> manipulation functions?  The current API may not be completely suitable
> but that doesn't mean that it cannot be extracted into notes.c.  In
> fact, other than the commit message saying "Notes added by 'git notes
> copy'" I don't see what's wrong with the current functions being
> extracted as-is.

Sure, notes could have a better public api and so could a lot of other
things: worktree operations like reset and checkout come to mind.

The problem is that we seem to be at some frozen in some sort of
stalemate, and some reorganization is definitely required.  What would
you suggest?

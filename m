From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sat, 8 Jun 2013 13:22:41 -0500
Message-ID: <CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 20:22:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlNmp-0001Qi-Se
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 20:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418Ab3FHSWn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jun 2013 14:22:43 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:58092 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752360Ab3FHSWn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jun 2013 14:22:43 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so2456249lbi.26
        for <git@vger.kernel.org>; Sat, 08 Jun 2013 11:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vL+kMxfdAuBJyvyws/yDbNwaS1VOYGNxegUm19fwbIM=;
        b=eJf5zkWn+hRm7vOHQPxKUxNFOWsCiEf0FhnPQFDRn3BlEny2JLfrIjDQl0b+KOtltW
         5qlMqBLVfNF56eM9MG1DMF0iAjwTwGFSx7R3v4I0no850GOCOFslUlGKfIqxr657UjN4
         ulJbtwExMPikKzC0PeKGBagb0A/XzBSqcj2p+VuZUZo/j/qKHPv8zBboeuUdna1UwC9G
         nhlkpo6fhlmDDPt+PB88hZihxL/tzF0Mfymp6l9hbApfTCjkh7E5r2uoYD4O7AKE5vQ+
         pz1Z/aSyUy5xHYPbvtOU471d1596z5eGVVxYqvk/UDJH2dcV5KcTDn60x3r/K/MaYat4
         fIQA==
X-Received: by 10.152.22.130 with SMTP id d2mr1222439laf.33.1370715761343;
 Sat, 08 Jun 2013 11:22:41 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sat, 8 Jun 2013 11:22:41 -0700 (PDT)
In-Reply-To: <CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226851>

On Sat, Jun 8, 2013 at 1:02 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> There's no libgit, and there will never be, every object file in Git is
>> the same, and there's wish to organize them in any way; they are *all*
>> for the 'git' binary and its builtin commands.
>
> Nice joke patch to illustrate your point ;)

It's not a joke. This is seriously the direction the others say is the
correct one.

One direction or the other, the problem that top-level objects can't
access code from builtin objects must be fixed. And if the others
don't want to fix it by properly splitting code between library-like
objects, and builtin objects, there's only one other way to fix it;
this way.

> On a more serious note, please be a little more patient while everyone
> copes with what you're attempting.

I don't think patience will help. What do you suggest? Wait until the
problem fixes itself? (I'll be waiting until the end times). Wait
until somebody changed their opinion by themselves? (I don't see that
happening).

> I've already made it clear that
> I'm in favor of moving forward with your plan to lib'ify git.

Unfortunately you are the only one.

> The
> problem is that you're sending your changes in fragmented comments and
> diffs, and nobody is able to piece together what the big picture is.
>
> Please write one cogent email (preferably with code included)
> explaining your plan.

The plan is simple; make libgit.a a proper library, starting by
clarifying what goes into libgit.a, and what doesn't. If there's any
hopes of ever having a public library, it's clear what code doesn't
belong in libgit.a; code that is meant for builtins, that code belongs
in builtins/lib.a, or similar.

But to be honest, I don't really care, all I want is the problem of
the bogus split to be solved. One way to solve it is going the proper
library way, but the other is to stash everything together into git.a.
Both ways solve the problem.

Give this a try:

--- a/sequencer.c
+++ b/sequencer.c
@@ -14,6 +14,7 @@
 #include "merge-recursive.h"
 #include "refs.h"
 #include "argv-array.h"
+#include "builtin.h"

 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"

@@ -102,6 +103,17 @@ static int has_conforming_footer(struct strbuf
*sb, struct strbuf *sob,
        return 1;
 }

+static void copy_notes(const char *name)
+{
+       struct notes_rewrite_cfg *cfg;
+
+       cfg = init_copy_notes_for_rewrite(name);
+       if (!cfg)
+               return;
+
+       finish_copy_notes_for_rewrite(cfg);
+}
+
 static void remove_sequencer_state(void)
 {
        struct strbuf seq_dir = STRBUF_INIT;
@@ -997,6 +1009,8 @@ static int pick_commits(struct commit_list
*todo_list, struct replay_opts *opts)
                        return res;
        }

+       copy_notes("cherry-pick");
+
        /*
         * Sequence of picks finished successfully; cleanup by
         * removing the .git/sequencer directory

What happens?

libgit.a(sequencer.o): In function `copy_notes':
/home/felipec/dev/git/sequencer.c:110: undefined reference to
`init_copy_notes_for_rewrite'
/home/felipec/dev/git/sequencer.c:114: undefined reference to
`finish_copy_notes_for_rewrite'

It is not the first time, nor the last that top-level code needs
builtin code, and the solution is easy; organize the code. Alas, this
simple solution reject on the basis that we shouldn't organize the
code, because the code is not meant to be organized.

Cheers.

-- 
Felipe Contreras

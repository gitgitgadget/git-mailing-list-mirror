From: John Keeping <john@keeping.me.uk>
Subject: Re: git gui replaces amend message when prepare-commit-msg hook is
 used
Date: Thu, 4 Jul 2013 12:19:01 +0100
Message-ID: <20130704111901.GI9161@serenity.lan>
References: <CAGHpTBKOX8G1PZqE2njQ1UbFJeC_L6WxjnTC5NyT8LSbiBNGXw@mail.gmail.com>
 <20130704103440.GH9161@serenity.lan>
 <CAGHpTB+ObJjqvQ-xfQOdGG+ZSZdCijVZXh1NBp97TZ=hO-QVgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Orgad Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 13:19:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuhZC-0001O3-6v
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 13:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756529Ab3GDLTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 07:19:10 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34092 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752984Ab3GDLTI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 07:19:08 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 49E65CDA590;
	Thu,  4 Jul 2013 12:19:08 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N4kMcmnwaYzB; Thu,  4 Jul 2013 12:19:07 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 25A11CDA57D;
	Thu,  4 Jul 2013 12:19:07 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 1D2DD161E4D5;
	Thu,  4 Jul 2013 12:19:07 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z4gajwEFh2Cu; Thu,  4 Jul 2013 12:19:06 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 777FB161E418;
	Thu,  4 Jul 2013 12:19:03 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CAGHpTB+ObJjqvQ-xfQOdGG+ZSZdCijVZXh1NBp97TZ=hO-QVgQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229572>

On Thu, Jul 04, 2013 at 01:59:10PM +0300, Orgad Shaneh wrote:
> On Thu, Jul 4, 2013 at 1:34 PM, John Keeping <john@keeping.me.uk> wrote:
> > On Thu, Jul 04, 2013 at 12:47:28PM +0300, Orgad Shaneh wrote:
> >> Hi,
> >>
> >> If a prepare-commit-msg hook is used, git gui executes it for "New Commit".
> >>
> >> If the "New Commit" is selected, and then immediately "Amend" (before
> >> the hook returns), when the hook returns the message is replaced with
> >> the one produced by the hook.
> >
> > I think this is a problem with the hook you are running.  The hook is
> > given arguments specifying the message file and optionally the source of
> > whatever is already in the file (see githooks(5) for details).
> >
> > It sounds like your hook is blindly overwriting the file, rather than
> > preserving its contents in the cases where you wish to do so.
> 
> Let me try to explain.
> 
> When git gui is executed, it calls the prepare-commit-msg script with
> .git/PREPARE_COMMIT_MSG as an argument.
> 
> When amend is selected, the hook is *not* called at all (what would it
> prepare? The message is already committed)
> 
> Use the following hook to reproduce:
> --- snip ---
> #!/bin/sh
> 
> sleep 5
> echo "$@" >> /tmp/hook.log
> echo 'Hello hook' > "$1"
> --- snip ---
> 
> Now run git gui (or press F5 if it is already running), and before 5
> seconds pass, click Amend last commit. You'll see the commit's
> message, but when the 5 seconds pass it is replaced with "Hello hook".
> That's the bug.

Yes, and that's a bug in the hook.  The hook is called with a second
argument "commit" but it is ignoring this and blindly overwriting the
message.  githooks(5) says:

    prepare-commit-msg
        This hook is invoked by git commit right after preparing the default
        log message, and before the editor is started.

        It takes one to three parameters. The first is the name of the
        file that contains the commit log message. The second is the
        source of the commit message, and can be: message (if a -m or -F
        option was given); template (if a -t option was given or the
        configuration option commit.template is set); merge (if the
        commit is a merge or a .git/MERGE_MSG file exists); squash (if a
        .git/SQUASH_MSG file exists); or commit, followed by a commit
        SHA1 (if a -c, -C or --amend option was given).

        If the exit status is non-zero, git commit will abort.

        The purpose of the hook is to edit the message file in place,
        and it is not suppressed by the --no-verify option. A non-zero
        exit means a failure of the hook and aborts the commit. It
        should not be used as replacement for pre-commit hook.

Your problem is that your hook script is not checking $2 so it is
overwriting the message even when you do not want to do so.

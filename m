From: Jeff King <peff@peff.net>
Subject: [PATCH] add--interactive: leave main loop on read error
Date: Mon, 15 Dec 2014 11:35:27 -0500
Message-ID: <20141215163527.GA15136@peff.net>
References: <CAN9HoQH5=z-d=J1HCA2UwGuFek21X6qCd_jFEkNpE6GiE50oNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Benjamin Quorning <bquorning@zendesk.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 17:35:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0YcS-0004gr-Ds
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 17:35:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751860AbaLOQfb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 11:35:31 -0500
Received: from cloud.peff.net ([50.56.180.127]:52790 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751731AbaLOQf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 11:35:29 -0500
Received: (qmail 28032 invoked by uid 102); 15 Dec 2014 16:35:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Dec 2014 10:35:29 -0600
Received: (qmail 15094 invoked by uid 107); 15 Dec 2014 16:35:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Dec 2014 11:35:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Dec 2014 11:35:27 -0500
Content-Disposition: inline
In-Reply-To: <CAN9HoQH5=z-d=J1HCA2UwGuFek21X6qCd_jFEkNpE6GiE50oNg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261409>

On Mon, Dec 15, 2014 at 03:41:45PM +0100, Benjamin Quorning wrote:

> Reproduction steps:
> 
> 1. A repository with a changed file, but no staged changes.
> 2. Execute `git checkout --patch`
> 3. When asked, press `e` to edit a chunk (opens an external editor in my case)
> 4. With the editor still open, click ctrl-C in the terminal.
> 5. The diff that was being edited, and the command prompt ("discard
> this hunk from worktree" etc) is printed to the screen, over and over
> again.
> 6. I have to grep and kill this process: /usr/bin/perl
> /usr/local/Cellar/git/2.2.0/libexec/git-core/git-add--interactive
> --patch=checkout --

Thanks, I could reproduce this pretty easily with:

  GIT_EDITOR='f() { sleep 60; }; f' git checkout -p

(and then hit 'e', and ^C). Explanation and fix are below.

-- >8 --
The main hunk loop for add--interactive will loop if it does
not get a known input. This is a good thing if the user
typed some invalid input. However, if we have an
uncorrectable read error, we'll end up looping infinitely.
We can fix this by noticing read errors (i.e., <STDIN>
returns undef) and breaking out of the loop.

One easy way to trigger this is if you have an editor that
does not take over the terminal (e.g., one that spawns a
window in an existing process and waits), start the editor
with the hunk-edit command, and hit ^C to send SIGINT. The
editor process dies due to SIGINT, but the perl
add--interactive process does not (perl suspends SIGINT for
the duration of our system() call).

We return to the main loop, but further reads from stdin
don't work. The SIGINT _also_ killed our parent git process,
which orphans our process group, meaning that further reads
from the terminal will always fail. We loop infinitely,
getting EIO on each read.

Note that there are several other spots where we read from
stdin, too. However, in each of those cases, we do something
sane when the read returns undef (breaking out of the loop,
taking the input as "no", etc). They don't need similar
treatment.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-add--interactive.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index 1fadd69..c725674 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1356,6 +1356,7 @@ sub patch_update_file {
 		  $patch_mode_flavour{TARGET},
 		  " [y,n,q,a,d,/$other,?]? ";
 		my $line = prompt_single_character;
+		last unless defined $line;
 		if ($line) {
 			if ($line =~ /^y/i) {
 				$hunk[$ix]{USE} = 1;
-- 
2.2.0.465.ge0d36f1.dirty

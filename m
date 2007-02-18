From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sat, 17 Feb 2007 17:47:00 -0800
Message-ID: <7v3b54p78r.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180107250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vbqjsqpgs.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180135240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vsld4p99g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180210490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 18 02:47:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIb92-0004S0-G7
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 02:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993061AbXBRBrF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 20:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993057AbXBRBrF
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 20:47:05 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:33515 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993061AbXBRBrD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 20:47:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070218014701.HRRQ22948.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 20:47:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qpn01W00K1kojtg0000000; Sat, 17 Feb 2007 20:47:01 -0500
In-Reply-To: <Pine.LNX.4.63.0702180210490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 18 Feb 2007 02:15:06 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40050>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> > On Sat, 17 Feb 2007, Junio C Hamano wrote:
>> > ...
>> >> But I think Jeff is right.  It would make sense to let apply
>> >> and perhaps 'diff', if we can somehow merge 'diff2' into it,
>> >> still read from $HOME/.gitconfig if available.
>> >
>> > Yes, especially if you are soo used to colours as I grew to be used to 
>> > them. This was literally one of the reasons I wrote diff2 in the first 
>> > place. Another was --color-words.
>> 
>> True.  Paches welcome ;-).
>
> I sent it out already... It was titled "[PATCH] Add `git diff2`, a GNU 
> diff workalike" ;-)

I thought we were talking about making 'git apply' to read from
$HOME/.gitconfig even outside a git repository.

A funny thing is that I was suspecting that calling git_config()
would fail if you are not in a git repository after you called
setup_git_directory_gently() with no_git_ok).  The lower level
does return error because ".git/config" does not exist, but it
does not call error() to say why it failed.  Callers typically
ignore the return value from the function, so it ends up
working.

So this simple patch is the welcomed one for now ;-)

-- >8 --

diff --git a/builtin-apply.c b/builtin-apply.c
index 6ed257d..20fb5bd 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2622,11 +2622,9 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 
 	prefix = setup_git_directory_gently(&is_not_gitdir);
 	prefix_length = prefix ? strlen(prefix) : 0;
-	if (!is_not_gitdir) {
-		git_config(git_apply_config);
-		if (apply_default_whitespace)
-			parse_whitespace_option(apply_default_whitespace);
-	}
+	git_config(git_apply_config);
+	if (apply_default_whitespace)
+		parse_whitespace_option(apply_default_whitespace);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];

-- 8< --

> The longer I think about it, the more I am convinced that trying to 
> integrate diff2 into diff _will_ lead to errors due to my trained, but 
> disobeying, fingers.
>
> I also debated with myself calling it diff-two or diff-direct (both not 
> really convincing), or even diff-file (too similar to diff-files), but I 
> could not come up with a better name than diff2. Which is also very easy 
> to write, I have to say.

Hmmmmmmmmmmmmmmmmmmmm.

I do agree diff-file is too confusing with diff-files, but...

In any case, I am done for the evening, and your patch did not
apply to any of the well-known versions, so perhaps I can take a
rest and have dinner and hope to find a respun one that
everybody on the list agrees with its name in my mailbox later?
;-)

I've parked the --color --check one at near the tip of 'pu', but
it appears its handling of whitespace warning is broken.

For example, from a patch that does this (I replaced a HT with =
and SP with _):

        @@ -1,6 +1,6 @@
         # The default target of this Makefile is...
         all:
        -
        +_=ab_
         # Define NO_OPENSSL
         # This also implies
         #

I get:

        Makefile:3: space before tab.white space at end: +=ab_
                    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~     ~

where ~ are colored in whitespace warning color.

	

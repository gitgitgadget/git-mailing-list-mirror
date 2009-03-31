From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] AIX 5.2 - bug with 1.6.2.1
Date: Tue, 31 Mar 2009 06:37:04 -0400
Message-ID: <20090331103703.GA1589@coredump.intra.peff.net>
References: <3930158b0903301647o790f7381l37ba61089713ce80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Pierre Poissinger <pierre.poissinger@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 12:38:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LobMl-0007jx-Od
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 12:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752548AbZCaKhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 06:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbZCaKhQ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 06:37:16 -0400
Received: from peff.net ([208.65.91.99]:44703 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637AbZCaKhP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 06:37:15 -0400
Received: (qmail 9494 invoked by uid 107); 31 Mar 2009 10:37:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 31 Mar 2009 06:37:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Mar 2009 06:37:04 -0400
Content-Disposition: inline
In-Reply-To: <3930158b0903301647o790f7381l37ba61089713ce80@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115249>

[I'm cc'ing the git-list; please send bug reports there]

On Tue, Mar 31, 2009 at 01:47:47AM +0200, Pierre Poissinger wrote:

> Looks like the patch posted here
> http://osdir.com/ml/git/2009-01/msg01128.html
> (around d8e96fd86d415554a9c2e09ffb929a9e22fdad25 I think - too late to
> look for it - love google that gave me this guy as first hit...)
> 
> breaks git on AIX 5.2 with gcc 2.9 :-(

Wow, I didn't know people were still using the 2.9 branch of gcc.

> Nothing new to pack.
> trace: built-in: git 'prune-packed'
> The end...
> fatal: unable to run 'git-repack'
> error: waitpid 155256: code 128 (Error 0)
> error: failed to run repack

Hmm. Can you confirm the status being passed back by run_command? The
following patch should do it:

diff --git a/git.c b/git.c
index c2b181e..a99c31b 100644
--- a/git.c
+++ b/git.c
@@ -413,6 +413,7 @@ static void execv_dashed_external(const char **argv)
 	 * OK to return. Otherwise, we just pass along the status code.
 	 */
 	status = run_command_v_opt(argv, 0);
+	fprintf(stderr, "run_command produced status %d\n", status);
 	if (status != -ERR_RUN_COMMAND_EXEC) {
 		if (IS_RUN_COMMAND_ERR(status))
 			die("unable to run '%s'", argv[0]);

> The bottom line: Looks like my box really don't like the run-command
> error define as:
> #define IS_RUN_COMMAND_ERR(x) ((x) <= -ERR_RUN_COMMAND_FORK)
> 
> it will trigger even with x==0 :-)

That seems very wrong. I wonder if it is a problem with the signedness
of enums in that version of gcc. Can you run the following program and
report on its output?

-- >8 --
#include <stdio.h>
enum { FOO = 10000 };
int main()
{
  printf("-FOO: %d\n", -FOO);
  printf("0 <= -FOO: %d\n", 0 <= -FOO);
  printf("-10000 <= -FOO: %d\n", -10000 <= -FOO);
  return 0;
}
-- 8< --

> So, following patch simply change this define to
> #define IS_RUN_COMMAND_ERR(x) ((x) > ERR_RUN_COMMAND_FORK)

That's not right; x is going to be a large negative value. You could
try:

  #define IS_RUN_COMMAND_ERR(x) ((-x) > ERR_RUN_COMMAND_FORK)

The other option is to rework run_command to just return positive values
(which should be fine as long as they remain out of the range of normal
exit codes).

-Peff

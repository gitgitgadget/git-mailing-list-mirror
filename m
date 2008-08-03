From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Subject: Re: [PATCH] Use line buffering for standard output
Date: Mon, 04 Aug 2008 00:48:51 +0200
Message-ID: <87hca1ogto.fsf@cup.kalibalik.dk>
References: <1217798768-18021-1-git-send-email-mail@cup.kalibalik.dk>
	<alpine.LFD.1.10.0808031444270.3668@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Aug 04 00:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPmOl-0006yj-2k
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 00:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757591AbYHCWsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 18:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757485AbYHCWsy
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 18:48:54 -0400
Received: from mail.hotelhot.dk ([77.75.163.100]:38559 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486AbYHCWsy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 18:48:54 -0400
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id C25A114062;
	Mon,  4 Aug 2008 00:48:49 +0200 (CEST)
Received: from dylle (router.kalibalik.dk [192.168.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 834251405A;
	Mon,  4 Aug 2008 00:48:49 +0200 (CEST)
In-Reply-To: <alpine.LFD.1.10.0808031444270.3668@nehalem.linux-foundation.org> (Linus Torvalds's message of "Sun\, 3 Aug 2008 14\:46\:18 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91282>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 3 Aug 2008, Anders Melchiorsen wrote:
>>
>> By always setting stdout to line buffering, we make the output work
>> identically for all output devices.
>
> Please don't.
>
> This is a huge peformance issue for things like
>
> 	git log -p > file
>
> where we really want it to be fully buffered.
>
> So please just find the place where we do a fork() without flushing
> pending output...

Sure. The sledgehammer approach was partly to get some advice on the
proper solution. I now realize that you have generally been careful
about this, and so a single flush should be enough.

Below are two alternative proposals, one local and one global. Both of
them fix the problem for me, but maybe you were even thinking about a
third place?

For the run-command.c one, I was not sure whether to put it inside or
outside the ifdef, and I also was not sure whether to add it for
start_command(). Not having other testcases, and not knowing Windows,
this is the way it ended up.


Cheers,
Anders.



From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Date: Mon, 4 Aug 2008 00:21:49 +0200
Subject: [PATCH] Flush stdout in init-db

Before this change, clone outputs "Initialized empty ..." twice
if output is piped.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 builtin-init-db.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index baf0d09..954c7e9 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -315,11 +315,13 @@ int init_db(const char *template_dir, unsigned int flags)
 		git_config_set("receive.denyNonFastforwards", "true");
 	}
 
-	if (!(flags & INIT_DB_QUIET))
+	if (!(flags & INIT_DB_QUIET)) {
 		printf("%s%s Git repository in %s/\n",
 		       reinit ? "Reinitialized existing" : "Initialized empty",
 		       shared_repository ? " shared" : "",
 		       get_git_dir());
+		fflush(stdout);
+	}
 
 	return 0;
 }



From: Anders Melchiorsen <mail@cup.kalibalik.dk>
Date: Mon, 4 Aug 2008 00:35:40 +0200
Subject: [PATCH] Flush standard output in start_async

This prevents double output in case stdout is redirected.

Signed-off-by: Anders Melchiorsen <mail@cup.kalibalik.dk>
---
 run-command.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/run-command.c b/run-command.c
index a3b28a6..67be079 100644
--- a/run-command.c
+++ b/run-command.c
@@ -304,6 +304,9 @@ int start_async(struct async *async)
 	async->out = pipe_out[0];
 
 #ifndef __MINGW32__
+	/* Flush output before fork() to avoid cloning the buffer */
+	fflush(stdout);
+
 	async->pid = fork();
 	if (async->pid < 0) {
 		error("fork (async) failed: %s", strerror(errno));

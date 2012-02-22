From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/2] bundle: use a strbuf to scan the log for boundary commits
Date: Wed, 22 Feb 2012 21:25:53 +0100
Message-ID: <87hayivcmm.fsf@thomas.inf.ethz.ch>
References: <a795f6dca5e7c3fc5f9212becda4a46116c502b7.1329939233.git.trast@student.ethz.ch>
	<fa1553d59714fd89fdab1bf54af19ac631a30a8c.1329939233.git.trast@student.ethz.ch>
	<7vlinuaaab.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>,
	Jannis Pohlmann <jannis.pohlmann@codethink.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 22 21:26:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0IlF-0005C2-0Z
	for gcvg-git-2@plane.gmane.org; Wed, 22 Feb 2012 21:26:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170Ab2BVUZ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Feb 2012 15:25:56 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:2260 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138Ab2BVUZz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 15:25:55 -0500
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 22 Feb
 2012 21:25:52 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (84.73.49.17) by CAS22.d.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 22 Feb
 2012 21:25:52 +0100
In-Reply-To: <7vlinuaaab.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 22 Feb 2012 12:22:04 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [84.73.49.17]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191280>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>>   # v2 git bundle
>>   $(git rev-list --pretty=oneline --boundary <ARGS> | grep ^-)
>>
>> git-bundle actually spawns exactly this rev-list invocation, and does
>> the grepping internally.
>>
>> There was a subtle bug in the latter step: it used fgets() with a
>> 1024-byte buffer.  If the user has sufficiently long subjects (e.g.,
>> by not adhering to the git oneline-subject convention in the first
>> place), the 'oneline' format can easily overflow the buffer.
>
> Thanks for diagnosing this, but I wonder if it even needs --pretty=oneline
> to begin with, except for debugging purposes.
>
> Do we ever use the subject string read from the rev-list output in any
> way?
>
> In other words, I am wondering if the right patch to minimally fix the
> issue starting from older releases is something along this line instead:

Not sure.  The only use I could think of would be to google for the
subjects, in the hope of finding some repository that has the commit you
are looking for.  Other than that...

In any case the --pretty=oneline is very deliberate, as we can see from
the commit below.  It just doesn't give a reason :-)

commit 239296770dae75e21c179733785731ec6ffae1f5
Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Date:   Fri Feb 23 03:17:51 2007 +0100

    git-bundle: record commit summary in the prerequisite data

diff --git a/builtin-bundle.c b/builtin-bundle.c
index 191ec55..d74afaa 100644
--- a/builtin-bundle.c
+++ b/builtin-bundle.c
@@ -267,7 +267,7 @@ static int create_bundle(struct bundle_header *header, const char *path,
 		int argc, const char **argv)
 {
 	int bundle_fd = -1;
-	const char **argv_boundary = xmalloc((argc + 3) * sizeof(const char *));
+	const char **argv_boundary = xmalloc((argc + 4) * sizeof(const char *));
 	const char **argv_pack = xmalloc(4 * sizeof(const char *));
 	int pid, in, out, i, status;
 	char buffer[1024];
@@ -282,10 +282,11 @@ static int create_bundle(struct bundle_header *header, const char *path,
 	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
 
 	/* write prerequisites */
-	memcpy(argv_boundary + 2, argv + 1, argc * sizeof(const char *));
+	memcpy(argv_boundary + 3, argv + 1, argc * sizeof(const char *));
 	argv_boundary[0] = "rev-list";
 	argv_boundary[1] = "--boundary";
-	argv_boundary[argc + 1] = NULL;
+	argv_boundary[2] = "--pretty=oneline";
+	argv_boundary[argc + 2] = NULL;
 	out = -1;
 	pid = fork_with_pipe(argv_boundary, NULL, &out);
 	if (pid < 0)


-- 
Thomas Rast
trast@{inf,student}.ethz.ch

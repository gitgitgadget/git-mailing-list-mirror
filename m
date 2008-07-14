From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] shortlog: support --pretty=format: option
Date: Mon, 14 Jul 2008 19:08:52 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807141907590.8950@racer>
References: <20080714144243.GA21079@elte.hu> <20080714092215.0efd7fa3.akpm@linux-foundation.org> <20080714163141.GA21068@elte.hu> <20080714094422.e7ae255a.akpm@linux-foundation.org> <alpine.LFD.1.10.0807140948220.3305@woody.linux-foundation.org>
 <alpine.LFD.1.10.0807141019010.3305@woody.linux-foundation.org> <alpine.DEB.1.00.0807141844160.8950@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ingo Molnar <mingo@elte.hu>,
	Git Mailing List <git@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jul 14 20:09:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KISUo-00051t-WB
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 20:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498AbYGNSIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 14:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755366AbYGNSIy
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 14:08:54 -0400
Received: from mail.gmx.net ([213.165.64.20]:53717 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754865AbYGNSIw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 14:08:52 -0400
Received: (qmail invoked by alias); 14 Jul 2008 18:08:50 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp004) with SMTP; 14 Jul 2008 20:08:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18cK+oQOREc/3o4a9ilPn4LDETakgQVZlThePgSLk
	eq/7RxFJKGLCPL
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0807141844160.8950@racer>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.43
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88442>


With this patch, the user can override the default setting, to print
the commit messages using a user format instead of the onelines of the
commits.  Example:

	$ git shortlog --pretty='format:%s (%h)' <commit>..

Note that shortlog will only respect a user format setting, as the other
formats do not make much sense.

Wished for by Andrew Morton.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Mon, 14 Jul 2008, Johannes Schindelin wrote:

	> Note that I do not think it would be all that hard to teach 
	> shortlog the --pretty option.

	Well...

 builtin-shortlog.c |   11 +++++++++++
 shortlog.h         |    1 +
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 0136202..f8bcbfc 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -154,6 +154,15 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	if (!author)
 		die("Missing author: %s",
 		    sha1_to_hex(commit->object.sha1));
+	if (log->user_format) {
+		struct strbuf buf = STRBUF_INIT;
+
+		pretty_print_commit(CMIT_FMT_USERFORMAT, commit, &buf,
+			DEFAULT_ABBREV, "", "", DATE_NORMAL, 0);
+		insert_one_record(log, author, buf.buf);
+		strbuf_release(&buf);
+		return;
+	}
 	if (*buffer)
 		buffer++;
 	insert_one_record(log, author, !*buffer ? "<none>" : buffer);
@@ -271,6 +280,8 @@ parse_done:
 		usage_with_options(shortlog_usage, options);
 	}
 
+	log.user_format = rev.commit_format == CMIT_FMT_USERFORMAT;
+
 	/* assume HEAD if from a tty */
 	if (!nongit && !rev.pending.nr && isatty(0))
 		add_head_to_pending(&rev);
diff --git a/shortlog.h b/shortlog.h
index 31ff491..6608ee8 100644
--- a/shortlog.h
+++ b/shortlog.h
@@ -11,6 +11,7 @@ struct shortlog {
 	int wrap;
 	int in1;
 	int in2;
+	int user_format;
 
 	char *common_repo_prefix;
 	int email;
-- 
1.5.6.2.511.ge432a

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] fast-import: treat SIGUSR1 as a request to access
 objects early
Date: Mon, 22 Nov 2010 02:16:02 -0600
Message-ID: <20101122081601.GA9722@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Raja R Harinath <harinath@hurrynot.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>,
	Gabriel Filion <lelutin@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 22 09:16:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKRZb-0000yu-3q
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 09:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179Ab0KVIQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 03:16:14 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63904 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab0KVIQN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 03:16:13 -0500
Received: by gxk23 with SMTP id 23so3880596gxk.19
        for <git@vger.kernel.org>; Mon, 22 Nov 2010 00:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=aiJAXNlKE+TW9Fqfh8PffbtnKMu8hzsMt4zlpgKwSVg=;
        b=J3Yzugm8ZAq8SipmoQoPuuN1qV2SQe26XMQwvKC2dk+ezoQeIGaIe/Vg4uG8OLESwM
         GrScKZpFDnUhZpxaf3WgOCgdShRDnP4SHJ/Vcgin2HdU4KDXg/y+pJk3q64boo11mr4r
         e/PQXDAOYgf1qUUe6nuKEQzp58W+q7p5365OM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=WLw/XT0HIeToXpowA5L1WuGwcy2gGu17ME92Qx78MV2zLiL51KgvZcTKCFkRIP4Lwe
         MlxG/c1rea8hCWoh0kKDOnccogAxeQW1eTnNNd095B3Rq368asldCH1bbBLcGbuWgSpC
         URPjSLTUB6TlqcmNnLJ3eXinu3mpISDdK2su4=
Received: by 10.150.49.8 with SMTP id w8mr8475114ybw.240.1290413772420;
        Mon, 22 Nov 2010 00:16:12 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 55sm3104705yhl.32.2010.11.22.00.16.10
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 22 Nov 2010 00:16:11 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161882>

It can be tedious to wait for a multi-million-revision import.
Unfortunately it is hard to spy on the import because fast-import
works by continuously streaming out objects, without updating the pack
index or refs until a checkpoint command or the end of the stream.

So allow the impatient operator to request checkpoints by sending a
signal, like so:

	killall -USR1 git-fast-import

When receiving such a signal, fast-import would schedule a checkpoint
to take place after the current top-level command (usually a "commit"
or "blob" request) finishes.

Caveats: just like ordinary checkpoint commands, such requests slow
down the import.  Switching to a new pack at a suboptimal moment is
also likely to result in a less dense initial collection of packs.
That's the price.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thoughts?

 Documentation/git-fast-import.txt |    8 +++++++
 fast-import.c                     |   42 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index 5d0c245..526670a 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -1233,6 +1233,14 @@ and lazy loading of subtrees, allows fast-import to efficiently import
 projects with 2,000+ branches and 45,114+ files in a very limited
 memory footprint (less than 2.7 MiB per active branch).
 
+Signals
+-------
+Sending *SIGUSR1* to the 'git fast-import' process ends the current
+packfile early, simulating a `checkpoint` command.  The impatient
+operator can use this facility to peek at the objects and refs from an
+import in progress, at the cost of some added running time and worse
+compression.
+
 
 Author
 ------
diff --git a/fast-import.c b/fast-import.c
index 77549eb..4779e3a 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -361,6 +361,9 @@ static uintmax_t next_mark;
 static struct strbuf new_data = STRBUF_INIT;
 static int seen_data_command;
 
+/* Signal handling */
+static volatile sig_atomic_t checkpoint_requested;
+
 static void parse_argv(void);
 
 static void write_branch_report(FILE *rpt, struct branch *b)
@@ -500,6 +503,33 @@ static NORETURN void die_nicely(const char *err, va_list params)
 	exit(128);
 }
 
+#ifndef SIGUSR1	/* Windows, for example */
+
+static void set_checkpoint_signal(void)
+{
+	/* nothing */
+}
+
+#else
+
+static void checkpoint_signal(int signo)
+{
+	checkpoint_requested = 1;
+}
+
+static void set_checkpoint_signal(void)
+{
+	struct sigaction sa;
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler = checkpoint_signal;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_RESTART;
+	sigaction(SIGUSR1, &sa, NULL);
+}
+
+#endif
+
 static void alloc_objects(unsigned int cnt)
 {
 	struct object_entry_pool *b;
@@ -2689,14 +2719,20 @@ static void parse_reset_branch(void)
 		unread_command_buf = 1;
 }
 
-static void parse_checkpoint(void)
+static void do_checkpoint(void)
 {
+	checkpoint_requested = 0;
 	if (object_count) {
 		cycle_packfile();
 		dump_branches();
 		dump_tags();
 		dump_marks();
 	}
+}
+
+static void parse_checkpoint(void)
+{
+	do_checkpoint();
 	skip_optional_lf();
 }
 
@@ -2953,6 +2989,7 @@ int main(int argc, const char **argv)
 	prepare_packed_git();
 	start_packfile();
 	set_die_routine(die_nicely);
+	set_checkpoint_signal();
 	while (read_next_command() != EOF) {
 		if (!strcmp("blob", command_buf.buf))
 			parse_new_blob();
@@ -2974,6 +3011,9 @@ int main(int argc, const char **argv)
 			/* ignore non-git options*/;
 		else
 			die("Unsupported command: %s", command_buf.buf);
+
+		if (checkpoint_requested)
+			do_checkpoint();
 	}
 
 	/* argv hasn't been parsed yet, do so */
-- 
1.7.2.3

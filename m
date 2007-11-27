From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Do not generate full commit log message if it not going to
	be used
Date: Tue, 27 Nov 2007 22:44:25 +0100
Message-ID: <20071127214425.GA3156@steel.home>
References: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com> <474C0105.3010908@viscovery.net> <81b0412b0711270448s6534a849u86bcb161d4d7b3fe@mail.gmail.com> <7vfxyrd2x2.fsf@gitster.siamese.dyndns.org> <81b0412b0711271018m6419b076n269a0175494fac84@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristian =?iso-8859-15?Q?H=F8gsberg?= <krh@redhat.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 22:44:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix8Ee-0006Z5-AA
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 22:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210AbXK0Vod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 16:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757794AbXK0Vod
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 16:44:33 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:28503 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757310AbXK0Voc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 16:44:32 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg79ik=
Received: from tigra.home (Fcbf4.f.strato-dslnet.de [195.4.203.244])
	by post.webmailer.de (fruni mo40) (RZmta 14.3)
	with ESMTP id L00326jARGolRc ; Tue, 27 Nov 2007 22:44:25 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 8B8E1277AE;
	Tue, 27 Nov 2007 22:44:25 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 24B6256D22; Tue, 27 Nov 2007 22:44:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <81b0412b0711271018m6419b076n269a0175494fac84@mail.gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66264>

Like when it is already specified through -C, -F or -m to git-commit.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---

Alex Riesen, Tue, Nov 27, 2007 19:18:56 +0100:
> On 27/11/2007, Junio C Hamano <gitster@pobox.com> wrote:
> > ... When no_edit is in effect, I think these two places can
> > be replaced with an equivalent of "diff-index --cached HEAD --" (which
> > should not hit the work tree at all) to see if there is anything to be
> > committed.  For initial commit the check would obviously be "is the
> > index empty?" instead.
> 
> This is of course very useful optimization, and will speed up things
> everywhere (and especially here).

Could not stop myself. Hopefully didn't beat anyone to it :)
Almost all code shamelessly stolen from builtin-diff-index.c.
Builds, runs, passes all the tests. That !active_nr is
micro-optimization, but a nice one: clearly don't reread.

Preprocessor trickery in DIFF_OPT_* macros is disgusting, it breaks
Vim word completion and trying to use many flags in one expression
looks just ugly. What was wrong is inline functions?

 builtin-commit.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index a35881e..8167ce4 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -367,6 +367,30 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 
 	strbuf_release(&sb);
 
+	if (no_edit) {
+		static const char *argv[] = { NULL, "HEAD", NULL };
+		struct rev_info rev;
+		unsigned char sha1[40];
+		int is_initial;
+
+		fclose(fp);
+
+		if (!active_nr && read_cache() < 0)
+			die("Cannot read index");
+
+		if (get_sha1("HEAD", sha1) != 0)
+			return !!active_nr;
+
+		init_revisions(&rev, "");
+		rev.abbrev = 0;
+		(void)setup_revisions(2, argv, &rev, NULL);
+		DIFF_OPT_SET(&rev.diffopt, QUIET);
+		DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
+		(void)run_diff_index(&rev, 1 /* cached */);
+
+		return !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
+	}
+
 	if (in_merge && !no_edit)
 		fprintf(fp,
 			"#\n"
-- 
1.5.3.6.1006.g08f2

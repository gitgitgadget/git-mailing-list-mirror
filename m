From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Do not generate full commit log message if it is not going
	to be used
Date: Wed, 28 Nov 2007 22:13:08 +0100
Message-ID: <20071128211308.GB3173@steel.home>
References: <81b0412b0711270254i58be4d2fi5021767d99fcb753@mail.gmail.com> <474C0105.3010908@viscovery.net> <81b0412b0711270448s6534a849u86bcb161d4d7b3fe@mail.gmail.com> <7vfxyrd2x2.fsf@gitster.siamese.dyndns.org> <81b0412b0711271018m6419b076n269a0175494fac84@mail.gmail.com> <20071127214425.GA3156@steel.home> <Pine.LNX.4.64.0711281211130.27959@racer.site> <20071128211059.GA3173@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Kristian =?iso-8859-15?Q?H=F8gsberg?= <krh@redhat.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 28 22:13:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxUDv-0008Dt-Dv
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 22:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756082AbXK1VNO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 16:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755892AbXK1VNO
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 16:13:14 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:52858 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166AbXK1VNM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 16:13:12 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBg79ik=
Received: from tigra.home (Fcbf4.f.strato-dslnet.de [195.4.203.244])
	by post.webmailer.de (fruni mo58) (RZmta 14.3)
	with ESMTP id p0039bjASGXrr8 ; Wed, 28 Nov 2007 22:13:09 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 13F0B277AE;
	Wed, 28 Nov 2007 22:13:09 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id AEE6656D22; Wed, 28 Nov 2007 22:13:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071128211059.GA3173@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66428>

Like when it is already specified through -C, -F or -m to git-commit.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Alex Riesen, Wed, Nov 28, 2007 22:10:59 +0100:
> Johannes Schindelin, Wed, Nov 28, 2007 13:18:10 +0100:
> > Besides, would this not be more elegant as
> > 
> > 		setup_revisions(0, NULL, &rev, "HEAD");
> 
> Hmm... And I was so puzzled as to what that "def" argument could
> possibly mean... Still am, in fact. But it works.
> 
> > > +		(void)run_diff_index(&rev, 1 /* cached */);
> > 
> > (void)?
> 
> I'll remove them and resubmit. Stupid custom.
> 

Here it goes.

 builtin-commit.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index a35881e..1a9a256 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -367,6 +367,28 @@ static int prepare_log_message(const char *index_file, const char *prefix)
 
 	strbuf_release(&sb);
 
+	if (no_edit) {
+		struct rev_info rev;
+		unsigned char sha1[40];
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
+		setup_revisions(0, NULL, &rev, "HEAD");
+		DIFF_OPT_SET(&rev.diffopt, QUIET);
+		DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
+		run_diff_index(&rev, 1 /* cached */);
+
+		return !!DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES);
+	}
+
 	if (in_merge && !no_edit)
 		fprintf(fp,
 			"#\n"
-- 
1.5.3.6.1014.g3543

From: Kacper Kornet <draenog@pld-linux.org>
Subject: Re: [PATCH v2 2/3] Allow for MERGE_MODE to specify more then one
 mode
Date: Wed, 28 Nov 2012 05:36:09 +0100
Message-ID: <20121128043608.GA17470@camk.edu.pl>
References: <1354057217-65886-1-git-send-email-draenog@pld-linux.org>
 <1354057217-65886-3-git-send-email-draenog@pld-linux.org>
 <7v7gp6jwsn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Aaron Schrab <aaron@schrab.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 05:36:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdZO6-0003MJ-DG
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 05:36:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225Ab2K1Eg1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 23:36:27 -0500
Received: from moat.camk.edu.pl ([148.81.175.50]:35227 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751937Ab2K1Eg0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 23:36:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id E35835F004A;
	Wed, 28 Nov 2012 05:34:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WKFXi7WCOFzD; Wed, 28 Nov 2012 05:34:39 +0100 (CET)
Received: from gatekeeper2.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 2217F5F0047;
	Wed, 28 Nov 2012 05:34:39 +0100 (CET)
Received: by gatekeeper2.camk.edu.pl (Postfix, from userid 1293)
	id B28C443CFD; Wed, 28 Nov 2012 05:36:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v7gp6jwsn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210701>

On Tue, Nov 27, 2012 at 06:17:28PM -0800, Junio C Hamano wrote:
> Kacper Kornet <draenog@pld-linux.org> writes:

> > Presently only one merge mode exists: non-fast-forward. But in future
> > the second one (transpose-parents) will be added, so the need to read
> > all lines of MERGE_MODE.

> > Signed-off-by: Kacper Kornet <draenog@pld-linux.org>
> > ---
> >  builtin/commit.c | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)

> > diff --git a/builtin/commit.c b/builtin/commit.c
> > index 273332f..ee0e884 100644
> > --- a/builtin/commit.c
> > +++ b/builtin/commit.c
> > @@ -1427,7 +1427,6 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
> >  	unsigned char sha1[20];
> >  	struct ref_lock *ref_lock;
> >  	struct commit_list *parents = NULL, **pptr = &parents;
> > -	struct stat statbuf;
> >  	int allow_fast_forward = 1;
> >  	struct commit *current_head = NULL;
> >  	struct commit_extra_header *extra = NULL;
> > @@ -1481,11 +1480,12 @@ int cmd_commit(int argc, const char **argv, const char *prefix)

> >  		if (!reflog_msg)
> >  			reflog_msg = "commit (merge)";
> > -		if (!stat(git_path("MERGE_MODE"), &statbuf)) {
> > -			if (strbuf_read_file(&sb, git_path("MERGE_MODE"), 0) < 0)
> > -				die_errno(_("could not read MERGE_MODE"));
> > -			if (!strcmp(sb.buf, "no-ff"))
> > -				allow_fast_forward = 0;
> > +		if((fp = fopen(git_path("MERGE_MODE"), "r"))) {

> Style: s/if((fp/if ((fp/;

> > +			while (strbuf_getline(&m, fp, '\n') != EOF) {
> > +				if (!strcmp(m.buf, "no-ff"))
> > +					allow_fast_forward = 0;
> > +			}
> > +			fclose(fp);

> This needs a bit more careful planning for interacting with other
> people's programs, I suspect.

> Your updated builtin/merge.c may write an extra LF after no-ff to
> make this parser to grok it, but it is entirely plausible that
> people have their own Porcelain that writes "no-ff" without LF
> (because that is what we read from this file, and I suspect the
> current code would ignore "no-ff\n").

> At least strbuf_getline() would give us "no-ff" when either "no-ff"
> or "no-ff\n" terminates the file, so updated code would be able to
> grok what other people would write, but if other people want to read
> MERGE_MODE we write, at least we shouldn't break them when we only
> write no-ff in it (once you start writing "reverse-parents" in the
> file, they will be broken anyway, as they do not currently expect
> such token in this file).

At this stage in the patch series the format of MERGE_MODE is not
changed - "no-ff" is printed without "\n". What should be changed is the
next patch. Relevant part should read:

diff --git a/builtin/merge.c b/builtin/merge.c
index a96e8ea..5ceb291 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -993,6 +999,8 @@ static void write_merge_state(struct commit_list *remoteheads)
 	if (fd < 0)
 		die_errno(_("Could not open '%s' for writing"), filename);
 	strbuf_reset(&buf);
+	if (reversed_order)
+		strbuf_addf(&buf, "reversed-order\n");
 	if (!allow_fast_forward)
 		strbuf_addf(&buf, "no-ff");
 	if (write_in_full(fd, buf.buf, buf.len) != buf.len)

This way when only no-ff is specified all parsers should be happy. If
reversed-order is specified together no-ff the "external" parser
probably would fail. Which in my opinion is a good think at this point,
as it can't correctly interpret MERGE_MODE anyway.

-- 
  Kacper

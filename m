From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 0/2] finding the fork point from reflog entries
Date: Thu, 24 Oct 2013 22:50:53 +0100
Message-ID: <20131024215053.GF10779@serenity.lan>
References: <xmqqhac6o5hj.fsf@gitster.dls.corp.google.com>
 <1382641884-14756-1-git-send-email-gitster@pobox.com>
 <20131024205434.GC10779@serenity.lan>
 <xmqqa9hymkma.fsf@gitster.dls.corp.google.com>
 <20131024213134.GD10779@serenity.lan>
 <20131024214007.GE10779@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 23:51:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZSo8-0002OX-Fm
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 23:51:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354Ab3JXVvD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 17:51:03 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:59594 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab3JXVvC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 17:51:02 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 9E3746064EA;
	Thu, 24 Oct 2013 22:51:01 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5+hsJmiBJexW; Thu, 24 Oct 2013 22:51:01 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 936A3198005;
	Thu, 24 Oct 2013 22:50:55 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20131024214007.GE10779@serenity.lan>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236632>

On Thu, Oct 24, 2013 at 10:40:07PM +0100, John Keeping wrote:
> On Thu, Oct 24, 2013 at 10:31:35PM +0100, John Keeping wrote:
> > On Thu, Oct 24, 2013 at 02:20:29PM -0700, Junio C Hamano wrote:
> > > John Keeping <john@keeping.me.uk> writes:
> > > 
> > > > On Thu, Oct 24, 2013 at 12:11:22PM -0700, Junio C Hamano wrote:
> > > >> The first one is a clean-up of the code to parse command line
> > > >> options to "git merge-base".  Options such as "--independent",
> > > >> "--is-ancestor" and "--octopus" are mutually exclusive and it is
> > > >> better expressed in terms of the recently introduced OPT_CMDMODE.
> > > >> 
> > > >> The second one implements the entire logic of the for loop we see in
> > > >> "git pull --rebase" directly using get_merge_bases_many() and
> > > >> postprocessing the result.
> > > >
> > > > Nice!  I tried this in the case where the target commit happens to be
> > > > the 63rd reflog entry:
> > > >
> > > > $ time sh -c 'for rev in $(git rev-list -g origin/master 2>/dev/null)
> > > > do
> > > >     git merge-base --is-ancestor $rev b2edae0 && break
> > > > done
> > > > '
> > > >
> > > > real    0m3.772s
> > > > user    0m3.338s
> > > > sys     0m0.440s
> > > >
> > > > $ time git merge-base --reflog origin/master b2edae0
> > > >
> > > > real    0m0.156s
> > > > user    0m0.138s
> > > > sys     0m0.018s
> > > 
> > > The real question is if the C code computes the same as the shell
> > > loop.
> > 
> > And in fact it doesn't - if you replace the "break" with "echo $rev" the
> > shell version prints b2edae0... but the C version prints nothing (and
> > exists with status 1).
> 
> To clarify: the particular commit in the calls above happens to be the
> oldest entry in the reflog, if I pick a newer entry then it works.
> 
> It seems that for_each_reflog_ent isn't returning the oldest entry;
> revs.nr is 62 whereas "git rev-list -g origin/master | wc -l" gives 63.

The following patch on top fixes it, but I'm sure it can be done in a
neater way.

-- >8 --
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 7b9bc15..f6f1f14 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -98,7 +98,17 @@ static int collect_one_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
 				  int tz, const char *message, void *cbdata_)
 {
 	struct rev_collect *revs = cbdata_;
-	struct commit *commit = lookup_commit(nsha1);
+	struct commit *commit;
+
+	if (!revs->nr) {
+		commit = lookup_commit(osha1);
+		if (commit) {
+			ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
+			revs->commit[revs->nr++] = commit;
+		}
+	}
+
+	commit = lookup_commit(nsha1);
 	if (commit) {
 		ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
 		revs->commit[revs->nr++] = commit;

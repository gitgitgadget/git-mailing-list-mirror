From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 16:22:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702271605290.12485@woody.linux-foundation.org>
References: <E1HM1XL-00071C-N5@candygram.thunk.org>
 <Pine.LNX.4.63.0702271356040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227154241.GA8228@thunk.org> <Pine.LNX.4.63.0702272053080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070227223929.GA9027@thunk.org> <86vehnnpy2.fsf@blue.stonehenge.com>
 <7vfy8rb2do.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Theodore Tso <tytso@mit.edu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 28 01:22:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMCai-0006wf-Dv
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 01:22:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbXB1AWm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 19:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbXB1AWm
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 19:22:42 -0500
Received: from smtp.osdl.org ([65.172.181.24]:58965 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbXB1AWl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 19:22:41 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1S0MXhB024001
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 27 Feb 2007 16:22:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1S0MWY1001267;
	Tue, 27 Feb 2007 16:22:32 -0800
In-Reply-To: <7vfy8rb2do.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.447 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40860>



On Tue, 27 Feb 2007, Junio C Hamano wrote:

> merlyn@stonehenge.com (Randal L. Schwartz) writes:
> 
> >>>>>> "Theodore" == Theodore Tso <tytso@mit.edu> writes:
> >
> > Theodore> And I'm still not sure why
> >
> > Theodore> 	git show v1.5.0..v1.5.0.1 
> >
> > Theodore> doesn't throw an error, and why it prints what it does...
> >
> > Wait, that doesn't throw an error?
> >
> > (tries it)
> >
> > OK, how is that different from git-diff ?
> 
> I do not think there is any difference.  "show" is about
> multiple points, not ranges.  "diff" is about multiple
> (typically two) points, and not ranges.

Well, I do think Ted has a good point. Having negative refs makes no sense 
for the "no-walk" case (aka "git show").

So when we do

	git show v1.4.4..v1.5.0

that's an illogical thing to do, since "git show" is defined to be a 
non-revision-walking action, which means the range operator be pointless 
and wrong. The fact that we happily accept it (and then _only_ show 
v1.5.0, which is the positive end of the range) is quite arguably not very 
logical.

We should complain, and say that you can only do "no_walk" with positive 
refs. Negative object refs really don't make any sense unless you walk 
the obejct list (or you're "git diff" and know about ranges explicitly).

Something like this (although I don't know if my message is necessarily 
the best possible one).

		Linus

---
diff --git a/revision.c b/revision.c
index 4cf697e..b84c066 100644
--- a/revision.c
+++ b/revision.c
@@ -116,6 +116,8 @@ void mark_parents_uninteresting(struct commit *commit)
 
 void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
 {
+	if (revs->no_walk && (obj->flags & UNINTERESTING))
+		die("object ranges do not make sense when not walking revisions");
 	add_object_array(obj, name, &revs->pending);
 	if (revs->reflog_info && obj->type == OBJ_COMMIT)
 		add_reflog_for_walk(revs->reflog_info,

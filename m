From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] doc: enhance git describe --tags help
Date: Tue, 30 Sep 2008 12:04:49 -0700
Message-ID: <20080930190449.GG21310@spearce.org>
References: <ce513bcc0809280648s352cda3fj5eb35b6e9cd40af9@mail.gmail.com> <20080928135526.GG5302@artemis.corp> <ce513bcc0809280729p47cc3790nb77b3cae8b805221@mail.gmail.com> <20080928143949.GH5302@artemis.corp> <20080928150318.GI5302@artemis.corp> <20080928151259.GJ5302@artemis.corp> <20080929150127.GB18340@spearce.org> <20080930095641.GA9001@strlen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pierre Habouzit <madcoder@debian.org>,
	Erez Zilber <erezzi.list@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	open-iscsi@googlegroups.com, Junio C Hamano <gitster@pobox.com>
To: Uwe Kleine-KKKnig <ukleinek@strlen.de>
X-From: git-owner@vger.kernel.org Tue Sep 30 21:06:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkkXr-0005lk-IX
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 21:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753101AbYI3TEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 15:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbYI3TEu
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 15:04:50 -0400
Received: from george.spearce.org ([209.20.77.23]:55312 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbYI3TEu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 15:04:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 788F73835F; Tue, 30 Sep 2008 19:04:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080930095641.GA9001@strlen.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97143>

Uwe Kleine-KKKnig <ukleinek@strlen.de> wrote:
> On Mon, Sep 29, 2008 at 08:01:27AM -0700, Shawn O. Pearce wrote:
> > --tags::
> > 	If a lightweight tag exactly matches, output it.  If no
> > 	annotated tag is found in the ancestry but a lightweight
> > 	tag is found, output the lightweight tag.
>
> IMHO --tags should behave as Erez expected (because it's what I
> expected, too).  As --tags currently behaves it's only usable in very
> rare cases (most of the time it only makes a difference on repos without
> any annotated tag).
> 
> When do you pass --tags?  Only if a lightweight tag is OK for an answer.
> And then I would prefer a "near" lightweight tag to a "farer" annotated
> one.

I don't disagree.  I've been tempted to write a patch to change the
behavior of git-describe so that --tags and --all control what names
are inserted into the candidate list, but don't control the ordering
of their selection.

I think this is all that is needed to make the behavior do what you
and Erez expected.  But its a pretty big change in the results if
you are passing in --all or --tags today.

--8<--
[WIP] Change meaning of --tags and --all

---
 builtin-describe.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index ec404c8..fd54fec 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -15,8 +15,8 @@ static const char * const describe_usage[] = {
 };
 
 static int debug;	/* Display lots of verbose info */
-static int all;	/* Default to annotated tags only */
-static int tags;	/* But allow any tags if --tags is specified */
+static int all;	/* Any valid ref can be used */
+static int tags;	/* Either lightweight or annotated tags */
 static int longformat;
 static int abbrev = DEFAULT_ABBREV;
 static int max_candidates = 10;
@@ -112,8 +112,6 @@ static int compare_pt(const void *a_, const void *b_)
 {
 	struct possible_tag *a = (struct possible_tag *)a_;
 	struct possible_tag *b = (struct possible_tag *)b_;
-	if (a->name->prio != b->name->prio)
-		return b->name->prio - a->name->prio;
 	if (a->depth != b->depth)
 		return a->depth - b->depth;
 	if (a->found_order != b->found_order)
-- 
1.6.0.2.513.g6dbd


-- 
Shawn.

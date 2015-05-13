From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "HEAD -> branch" decoration doesn't work with "--decorate=full"
Date: Wed, 13 May 2015 10:11:58 -0700
Message-ID: <xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com>
References: <55534D95.60609@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git discussion list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 13 19:12:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsaCW-0004cd-S1
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 19:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933423AbbEMRME (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 13:12:04 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:38010 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932687AbbEMRMC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 13:12:02 -0400
Received: by igbhj9 with SMTP id hj9so50979102igb.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=300y4j+ns7AZ4uBq0G+ASBnrLu094FkXr3x1DuGY8Uo=;
        b=NTlzmxQa9/mHZEahZ9rOHZFirpr1VTai69m6xjg1Y7R4tfydJamsaysgm/quYCT4ey
         w/2TfafO87dCOzdLb/HoCCeE3L6ObgVgUpGEpF2Ndda/sc5FaO5xM2bLO1sgQDalhVt6
         EiCmarkMa5VTlOY68Ck6xxuxTObJxAGa3OVFSid3+ODf4/XDbpXtKojBF3fQFWsG9zs/
         me/E0Yt4sdFeZKWkeWkBVXrR5dfuS0voOaYElBZzJ7youTwsitoMJJc3hpwYBoIbTBfu
         cFtYjOcq4P27+vygcyV075Pi1fLBHihOCzdzzdvLXupOJyTMqCSVcsBVLxJTyJ7Fqu01
         AmKA==
X-Received: by 10.107.133.132 with SMTP id p4mr14475764ioi.40.1431537121821;
        Wed, 13 May 2015 10:12:01 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3cfa:54ee:8e48:89ad])
        by mx.google.com with ESMTPSA id r4sm4005457igh.9.2015.05.13.10.11.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 13 May 2015 10:12:00 -0700 (PDT)
In-Reply-To: <55534D95.60609@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 13 May 2015 15:11:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268992>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> The new-style "HEAD -> branch" style decoration doesn't work when
> "--decorate=full" is used:
>
>> $ bin-wrappers/git show --oneline --decorate
>> c518059 (HEAD -> master, gitster/master) Merge branch 'maint'
>> 
>> $ bin-wrappers/git show --oneline --decorate=full
>> c518059 (HEAD, refs/remotes/gitster/master, refs/heads/master) Merge branch 'maint'
>
> I would have expected the second invocation to show "HEAD ->
> refs/heads/master".
>
> Was that an oversight or a conscious decision?

I actually think this ultimately comes from a poor design of the
name-decorations infrastructure.  The program is expected to call
load_ref_decorations() only once and make the choice between the
full/short at that point, which is passed to add_ref_decoration() to
record either 'refs/heads/master' or 'master' in the singleton
name_decoration decoration.  But it does not store which one was
chosen by the caller of load_ref_decorations() anywhere in the
subsystem.

When current_pointed_by_HEAD() wants to see if decorations on an
object, e.g. 'master', matches what 'HEAD' resolves to, it cannot
tell if the original set-up was done for the full decoration, and
the current code just assumes (without even realizing that it is
making that assumption) the decoration must have been set up for the
short ones.

Perhaps something like this, but I am not committing it without
tests or a proper log messge.

I moved "static loaded" outside as it is in the same category as the
global name-decoration and decoration-flags, i.e. to be initialised
once at the beginning to a fixed setting and then be used with that
setting.


 log-tree.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 2c1ed0f..92259bc 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -13,6 +13,8 @@
 #include "line-log.h"
 
 static struct decoration name_decoration = { "object names" };
+static int decoration_loaded;
+static int decoration_flags;
 
 static char decoration_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -146,9 +148,9 @@ static int add_graft_decoration(const struct commit_graft *graft, void *cb_data)
 
 void load_ref_decorations(int flags)
 {
-	static int loaded;
-	if (!loaded) {
-		loaded = 1;
+	if (!decoration_loaded) {
+		decoration_loaded = 1;
+		decoration_flags = flags;
 		for_each_ref(add_ref_decoration, &flags);
 		head_ref(add_ref_decoration, &flags);
 		for_each_commit_graft(add_graft_decoration, NULL);
@@ -196,8 +198,19 @@ static const struct name_decoration *current_pointed_by_HEAD(const struct name_d
 	branch_name = resolve_ref_unsafe("HEAD", 0, unused, &rru_flags);
 	if (!(rru_flags & REF_ISSYMREF))
 		return NULL;
-	if (!skip_prefix(branch_name, "refs/heads/", &branch_name))
-		return NULL;
+
+	if ((decoration_flags == DECORATE_SHORT_REFS)) {
+		if (!skip_prefix(branch_name, "refs/heads/", &branch_name))
+			return NULL;
+	} else {
+		/*
+		 * Each decoration has a refname in full; keep
+		 * branch_name also in full, but still make sure
+		 * HEAD is a reasonable ref.
+		 */
+		if (!starts_with(branch_name, "refs/"))
+			return NULL;
+	}
 
 	/* OK, do we have that ref in the list? */
 	for (list = decoration; list; list = list->next)

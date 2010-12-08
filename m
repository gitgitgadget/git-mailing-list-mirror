From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: cherry-pick / pre-commit hook?
Date: Wed, 8 Dec 2010 16:05:14 -0600
Message-ID: <20101208220514.GA8865@burratino>
References: <m2wrnktcl2.wl%dave@boostpro.com>
 <20101208175324.GB5687@burratino>
 <m2oc8wt0xc.wl%dave@boostpro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 23:05:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQS8o-0004nr-TV
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 23:05:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523Ab0LHWFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 17:05:30 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:37846 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab0LHWF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 17:05:28 -0500
Received: by qwa26 with SMTP id 26so1808298qwa.19
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 14:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3ELnJpSZXx6+x6DKt1BgGypz2N2ahwqhhVo/JdgGR5g=;
        b=qv3iDCh3m2rkHZXujWVIwVt6B3t4ql3T4Xo4UqXUCE3CIhv0qv1Vt/esIaD37biMT4
         eXODcNHnFDyQOmuYsKHmdS657RF4X7gq6ULv9+qOyrtOa0DeYfK0sJUediV4U0yeXcH4
         cKlYcZZWwsMFEB06tPzXJX+89WfPhYPc/M6gM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Hk5UQqk81GIOY+/tOom6Z9YEJx+YVE6qw3Gwdta4xqPyrd9I8NFmyrlX4AhSX6weE5
         ICP+1vvKRWntrH449RWQIMebUBfECtAk4ssAEs+rPwYkZCXQIgaSuYb/BFJvaCn+ePm2
         W/XUDiG7ItkrV5Bvh7lAioNKKxod7/rw4248E=
Received: by 10.224.176.67 with SMTP id bd3mr7607802qab.110.1291845927856;
        Wed, 08 Dec 2010 14:05:27 -0800 (PST)
Received: from burratino (adsl-69-209-58-175.dsl.chcgil.ameritech.net [69.209.58.175])
        by mx.google.com with ESMTPS id t17sm656256qcp.14.2010.12.08.14.05.26
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 14:05:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m2oc8wt0xc.wl%dave@boostpro.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163227>

Dave Abrahams wrote:

> You're going to love this: I had sent a pull request upstream and the
> maintainer of the project rejected my changes because I didn't follow
> some formatting convention he didn't tell me about ;-).  So I set up a
> commit hook that would prevent me from making the same mistake again,
> and cherry-picked the changes one-by-one.

Funny.  Maybe "cherry-pick --no-commit" followed by ordinary commit
would be appropriate?  That way, when the checks fail, you are in a
position to clean them up.

If the conventions were whitespace related, "git rebase --whitespace=fix"
might be even more useful.

Just for kicks, here is the cherry-pick --verify for picky
cherry-pickers.

-- 8< --
Subject: cherry-pick/revert: learn --verify to run pre-commit and commit-msg hooks

The main purpose of the pre-commit and commit-msg hooks is to avoid
introducing regressions in whitespace style, encoding, and so forth;
and it would make cherry-picking unnecessarily difficult, without
preventing regressions, to unconditionally apply the same standards to
existing code.  For this reason, in v0.99.6~51 (2005-08-29), git
learned to skip the usual hooks when cherry-picking or reverting an
existing commit.

But sometimes the checks are wanted anyway.  For example, with this
patch applied, you can safely fetch some new contributor's code:

	$ git cherry-pick -s --verify HEAD..FETCH_HEAD

while allowing the pre-commit and commit-msg hooks to run their usual
checks so the result can error out if the patches are not clean.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Untested.  Please feel free to add some documentation and tests and
submit it for real if this looks like a good idea. :)

 builtin/revert.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index bb6e9e8..511b2ea 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -36,7 +36,7 @@ static const char * const cherry_pick_usage[] = {
 	NULL
 };
 
-static int edit, no_replay, no_commit, mainline, signoff, allow_ff;
+static int edit, no_replay, no_commit, verify, mainline, signoff, allow_ff;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
 static int commit_argc;
@@ -67,6 +67,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
 		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 		OPT_STRING(0, "strategy", &strategy, "strategy", "merge strategy"),
+		OPT_BOOLEAN(0, "verify", &verify, "let hooks intervene before commiting"),
 		OPT_END(),
 		OPT_END(),
 		OPT_END(),
@@ -375,7 +376,8 @@ static int run_git_commit(const char *defmsg)
 	int i = 0;
 
 	args[i++] = "commit";
-	args[i++] = "-n";
+	if (!verify)
+		args[i++] = "-n";
 	if (signoff)
 		args[i++] = "-s";
 	if (!edit) {
-- 
1.7.2.4

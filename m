From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git branch -M" regression in 1.7.7?
Date: Fri, 25 Nov 2011 20:30:02 -0600
Message-ID: <20111126023002.GA17652@elie.hsd1.il.comcast.net>
References: <CALxtSbRbwkVDKJcXiKY9rHYCjA3XGgCytbXQnRhQvbEnY8SpjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Soeren Sonnenburg <sonne@debian.org>,
	Conrad Irwin <conrad.irwin@gmail.com>
To: =?utf-8?B?4piCSm9zaCBDaGlhICjosKLku7vkuK0p?= <joshchia@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 26 03:30:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RU81z-0006OM-4e
	for gcvg-git-2@lo.gmane.org; Sat, 26 Nov 2011 03:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450Ab1KZCaL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Nov 2011 21:30:11 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:46967 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726Ab1KZCaK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Nov 2011 21:30:10 -0500
Received: by ywa9 with SMTP id 9so1627032ywa.19
        for <git@vger.kernel.org>; Fri, 25 Nov 2011 18:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=JQybMyv6DfIUwbjnNBgZGV2fYkXUaQFLDbO13FnEVUk=;
        b=e8tHosfj+zbH3SI7f2mPn8FHEDGZ6o43QKkvLjgITa7EpXZod5t0gKqUpffRCBjzNa
         T3inZC0Oiyt8x4gbXU0gIgwDhtDgxB6nw9f+09iw5ihW1ei+Vdc6JqhRXa8lFyGlqqRK
         7+lYI+ys66ePMvjzPN8mP5Sln6Cd2VbSvMEbc=
Received: by 10.236.22.136 with SMTP id t8mr52081721yht.30.1322274609758;
        Fri, 25 Nov 2011 18:30:09 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id m29sm38812238yhi.20.2011.11.25.18.30.08
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Nov 2011 18:30:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALxtSbRbwkVDKJcXiKY9rHYCjA3XGgCytbXQnRhQvbEnY8SpjA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185944>

Hi,

Josh Chia (=E8=B0=A2=E4=BB=BB=E4=B8=AD) wrote:

> On git 1.7.7.3, when I try to "git branch -M master" when I'm already
> on a branch 'master', I get this error message:
> Cannot force update the current branch
>
> On 1.7.6.4, the command succeeds.
>
> Is this intended?

Yes, but it probably wasn't a good idea.  How about this patch?

A reproduction recipe (preferrably in the form of a patch to
t/t3200-branch.sh would be welcome.

-- >8 --
Subject: treat "git branch -M master master" as a no-op again

Before v1.7.7-rc2~1^2~2 (Prevent force-updating of the current branch,
2011-08-20), commands like "git branch -M topic master" could be used
even when "master" was the current branch, with the somewhat
counterintuitive result that HEAD would point to some place new while
the index and worktree kept the content of the old commit.  This is
not a very sensible operation and the result is what almost nobody
would expect, so erroring out in this case was a good change.

However, there is one exception to the "it's usually not obvious what
it would mean to overwrite the current branch by another one" rule.
Namely:

	git branch -M master master

is clearly meant to be a no-op, even if you are on the master branch.
And in the latter case, it can be abbreviated:

	git branch -M master

This seems like a valuable exception to allow, because then "git
branch -M foo" would _always_ be allowed --- either 'foo' is not the
current branch, and it does the obvious thing, or 'foo' is the current
branch, and nothing happens.

Buildbot uses this idiom and was broken in 1.7.7 (it would emit the
message "Cannot force update the current branch").

Reported-by: Soeren Sonnenburg <sonne@debian.org>
Reported-by: Josh Chia (=E8=B0=A2=E4=BB=BB=E4=B8=AD)
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/branch.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 51ca6a02..24f33b24 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -568,6 +568,7 @@ static void rename_branch(const char *oldname, cons=
t char *newname, int force)
 	unsigned char sha1[20];
 	struct strbuf oldsection =3D STRBUF_INIT, newsection =3D STRBUF_INIT;
 	int recovery =3D 0;
+	int clobber_head_ok;
=20
 	if (!oldname)
 		die(_("cannot rename the current branch while not on any."));
@@ -583,7 +584,13 @@ static void rename_branch(const char *oldname, con=
st char *newname, int force)
 			die(_("Invalid branch name: '%s'"), oldname);
 	}
=20
-	validate_new_branchname(newname, &newref, force, 0);
+	/*
+	 * A command like "git branch -M currentbranch currentbranch" cannot
+	 * cause the worktree to become inconsistent with HEAD, so allow it.
+	 */
+	clobber_head_ok =3D !strcmp(oldname, newname);
+
+	validate_new_branchname(newname, &newref, force, clobber_head_ok);
=20
 	strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 		 oldref.buf, newref.buf);
--=20
1.7.8.rc3

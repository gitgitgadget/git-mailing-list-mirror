From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] hooks/pre-commit: check for cycles in dependencies
Date: Thu, 4 Jun 2009 23:33:19 +0200
Message-ID: <36ca99e90906041433je1b4ce8ob121b70a2ed5e669@mail.gmail.com>
References: <1244148073-2313-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Thu Jun 04 23:35:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCKar-0006Z1-93
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 23:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754696AbZFDVdT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2009 17:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754539AbZFDVdT
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 17:33:19 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:42895 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753188AbZFDVdS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2009 17:33:18 -0400
Received: by bwz9 with SMTP id 9so1073218bwz.37
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lHgyCZPaCNqPjrYFo5zoZSJMUu3YnnV0mhRdETHBhzA=;
        b=Ngpwp+sfAGEYuyQjSs6SG5m4K7mpmgRBSBSxW0m7+jQcQQ7jowFfUuaSvxlCWG6Pei
         0knV9B0McHcpIijq1J0C4uBgdy0a7cEpJ1FHMYZTr/X2g9KvqgVJkkkCjG4u8DM0TQ/k
         HEIpOkTL+1/3cjgFcwcwqHXWWqx2jCVdkYz4I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jDUmEGV0YJCgP28DRE6wFCzlQVRWscuCyBQKibYr5e3SiVQaPSfnQ3WIOZoR5f6Y/4
         ztb1eluVdFBxZ4xhuGrpVFz+88zLCL78OkKWVg6/v9/XUVhsUYwdE2khOLIP/NU1ZA9u
         oEkEk9pP09dFwydhiCeZKYwJrhFVbj7WQTEa8=
Received: by 10.223.117.14 with SMTP id o14mr1696705faq.21.1244151199154; Thu, 
	04 Jun 2009 14:33:19 -0700 (PDT)
In-Reply-To: <1244148073-2313-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120714>

On Thu, Jun 4, 2009 at 22:41, Bert Wesarg <bert.wesarg@googlemail.com> =
wrote:
> Only newly added dependencies needs to be considered. =C2=A0For each =
of these deps
> check if there is a path from this dep to the current HEAD.
>
> Use recursive_dep() for this task. =C2=A0Even if recursive_dep() uses=
 a DFS-like
> traversal it will not run into an infty-loop if there would be a cycl=
e, because
> recursive_dep() takes .topdeps only from committed trees. =C2=A0And i=
t is required
> that the committed dependency graph is acyclic.
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> ---
> =C2=A0hooks/pre-commit.sh | =C2=A0 30 ++++++++++++++++++++++++++++--
> =C2=A01 files changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/hooks/pre-commit.sh b/hooks/pre-commit.sh
> index 9d677e9..8e05a4e 100644
> --- a/hooks/pre-commit.sh
> +++ b/hooks/pre-commit.sh
> @@ -20,7 +20,8 @@ tg_util
> =C2=A0if head_=3D$(git symbolic-ref -q HEAD); then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case "$head_" in
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0refs/heads/*)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 git rev-parse -q --verify "refs/top-bases${head_#refs/heads}" >=
/dev/null || exit 0;;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 head_=3D"${head_#refs/heads/}"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 git rev-parse -q --verify "refs/top-bases/$head_" >/dev/null ||=
 exit 0;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0exit 0;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
> @@ -35,4 +36,29 @@ fi
> =C2=A0[ -s "$root_dir/.topmsg" ] ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0die ".topmsg is missing"
>
> -# TODO: Verify .topdeps for valid branch names and against cycles
> +check_cycle_name()
> +{
> + =C2=A0 =C2=A0 =C2=A0 [ "$head_" !=3D "$_dep" ] ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die "TopGit depend=
encies form a cycle: perpetrator is $_name"
> +}
> +
> +# only check newly added deps
> +# check if a path exists to the current HEAD
> +git diff --cached "$root_dir/.topdeps" |
> + =C2=A0 =C2=A0 =C2=A0 awk '
> +BEGIN =C2=A0 =C2=A0 =C2=A0{ in_hunk =3D 0; }
> +/^@@ / =C2=A0 =C2=A0 { in_hunk =3D 1; }
> +/^\+/ =C2=A0 =C2=A0 =C2=A0{ if (in_hunk =3D=3D 1) printf("%s\n", sub=
str($0, 2)); }
> +/^[^@ +-]/ { in_hunk =3D 0; }
> +' |
> + =C2=A0 =C2=A0 =C2=A0 while read newly_added; do
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # deps can be non-=
tgish but we can't run recurse_deps() on them
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ref_exists "refs/t=
op-bases/$newly_added" ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue
I think we need also a test to check against self-loops, i.e.:
                     [ "$head_" !=3D "$newly_added" ] ||
                         die "Can't have myself as dep"

Can you please squash this in.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # recurse_deps use=
s dfs but takes the .topdeps from the tree,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # therefor no inft=
y-loop in the cycle-check
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 no_remotes=3D1 rec=
urse_deps check_cycle_name "$newly_added"
> + =C2=A0 =C2=A0 =C2=A0 done
> +
> +
> +# TODO: Verify .topdeps for valid branch names
> --
> tg: (99f2ef6..) bw/check-for-dep-cycle (depends on: master)
>

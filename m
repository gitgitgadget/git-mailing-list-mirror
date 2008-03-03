From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH 2/3] git-submodule - Allow adding a submodule in-place
Date: Mon, 3 Mar 2008 21:14:17 +0800
Message-ID: <46dff0320803030514y3b7b1860h18094f99619ff671@mail.gmail.com>
References: <1202576245-284-1-git-send-email-mlevedahl@gmail.com>
	 <1202576245-284-2-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mark Levedahl" <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 14:15:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWAVQ-0006ba-4h
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 14:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbYCCNOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 08:14:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbYCCNOW
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 08:14:22 -0500
Received: from wr-out-0506.google.com ([64.233.184.235]:3657 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbYCCNOV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 08:14:21 -0500
Received: by wr-out-0506.google.com with SMTP id c49so2061wra.21
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 05:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MZosirGz0HUEaSNZBcUefFXFO+KVy7ae1UrJNOMdUHY=;
        b=UJrgSjQUK4NpEXVcD1jWymdSvES0CWXkw9iTj94fk8378ejkGF+RCTD+HI5RvgsVAXzOf+yknd6eFw6V6wasiJtkY1SoTdfbGs5QOB2JZuJ6eiLCHnyCOq7Zv2ksBSU9msWDabQFvaKq+poEbXbExFNdZCxLPMivt1SBvrUjwFM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YbeIDgpoqZ4DCXJ9nQy0INfYsj/fdbAceVsXHP5GUxvkgNS8LSNzYNC1X/FYsgw3Nln1BKXz0jOcoKNNnDab6xC3qH2bw1fi6nb719h40HP6M/3Y5GlRTp0Xc9Q92tPZGzXfcl14oBUnvCNnpFBrBelJqSfaCCNdaYiPp2xc82g=
Received: by 10.100.125.12 with SMTP id x12mr4075932anc.109.1204550057786;
        Mon, 03 Mar 2008 05:14:17 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Mon, 3 Mar 2008 05:14:17 -0800 (PST)
In-Reply-To: <1202576245-284-2-git-send-email-mlevedahl@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75925>

On Sun, Feb 10, 2008 at 12:57 AM, Mark Levedahl <mlevedahl@gmail.com> wrote:
> When working in top-level project, it is useful to create a new submodule
>  as a git repo in a subdirectory, then add that submodule to top-level in
>  place.  This allows "git submodule add <intended url> subdir" to add the
>  existing subdir to the current project.  The presumption is the user will
>  later push / clone the subdir to the <intended url> so that future
>  submodule init / updates will work.
>
>  Absent this patch, "git submodule add" insists upon cloning the subdir
>  from a repository at the given url, which is fine for adding an existing
>  project in but less useful when adding a new submodule from scratch to an
>  existing project.  The former functionality remains, and the clone is
>  attempted if the subdir does not already exist as a valid git repo.
>
>  Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
>  ---
>   Documentation/git-submodule.txt |    5 ++-
>   git-submodule.sh                |   57 +++++++++++++++++++++++---------------
>   2 files changed, 37 insertions(+), 25 deletions(-)
>
>  diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
>  index 4fc17f6..85d7dd3 100644
>  --- a/Documentation/git-submodule.txt
>  +++ b/Documentation/git-submodule.txt
>  @@ -18,8 +18,9 @@ COMMANDS
>   --------
>   add::
>         Add the given repository as a submodule at the given path
>  -       to the changeset to be committed next.  In particular, the
>  -       repository is cloned at the specified path, added to the
>  +       to the changeset to be committed next.  If path is a valid
>  +       repository within the project, it is added as is. Otherwise,
>  +       repository is cloned at the specified path. path is added to the
>         changeset and registered in .gitmodules.   If no path is
>         specified, the path is deduced from the repository specification.
>         If the repository url begins with ./ or ../, it is stored as
>  diff --git a/git-submodule.sh b/git-submodule.sh
>  index b97bf18..4c86a3c 100755
>  --- a/git-submodule.sh
>  +++ b/git-submodule.sh
>  @@ -166,23 +166,6 @@ cmd_add()
>                 usage
>         fi
>
>  -       case "$repo" in
>  -       ./*|../*)
>  -               # dereference source url relative to parent's url
>  -               realremote=${remote:-$(get_default_remote)}
>  -               realrepo=$(resolve_relative_url $repo) || exit 1
>  -               ;;
>  -       *)
>  -               # Turn the source into an absolute path if
>  -               # it is local
>  -               if base=$(get_repo_base "$repo"); then
>  -                       repo="$base"
>  -               fi
>  -               realremote=origin
>  -               realrepo=$repo
>  -               ;;
>  -       esac
>  -
>         # Guess path from repo if not specified or strip trailing slashes
>         if test -z "$path"; then
>                 path=$(echo "$repo" | sed -e 's|/*$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
>  @@ -190,15 +173,43 @@ cmd_add()
>                 path=$(echo "$path" | sed -e 's|/*$||')
>         fi
>
>  -       test -e "$path" &&
>  -       die "'$path' already exists"
>  -
>         git ls-files --error-unmatch "$path" > /dev/null 2>&1 &&
>         die "'$path' already exists in the index"
>
>  -       module_clone "$path" "$realrepo" "$realremote" || exit
>  -       (unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "$realremote/$branch"}) ||
>  -       die "Unable to checkout submodule '$path'"
>  +       # perhaps the path exists and is already a git repo, else clone it
>  +       if test -e "$path"
>  +       then
>  +               if test -d "$path/.git" &&
>  +               test "$(unset GIT_DIR; cd $path; git rev-parse --git-dir)" = ".git"
>  +               then
>  +                       echo "Adding existing repo at '$path' to the index"
>  +               else
>  +                       die "'$path' already exists and is not a valid git repo"
>  +               fi
>  +       else
>  +               case "$repo" in
>  +               ./*|../*)
>  +                       # dereference source url relative to parent's url
>  +                       realremote=${remote:-$(get_default_remote)}
>  +                       realrepo=$(resolve_relative_url $repo) || exit 1
>  +                       ;;
>  +               *)
>  +                       # Turn the source into an absolute path if
>  +                       # it is local
>  +                       if base=$(get_repo_base "$repo")
>  +                       then
>  +                               repo="$base"
>  +                       fi
>  +                       realremote=origin
>  +                       realrepo=$repo
>  +                       ;;
>  +               esac
>  +
>  +               module_clone "$path" "$realrepo" "$realremote" || exit
>  +               (unset GIT_DIR; cd "$path" && git checkout -q ${branch:+-b "$branch" "$realremote/$branch"}) ||
>  +               die "Unable to checkout submodule '$path'"
>  +       fi
>  +
>         git add "$path" ||
>         die "Failed to add submodule '$path'"
>
>  --

I think it's a very useful patch. But why has it sleeped for over one month?



-- 
Ping Yin

From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5] git-completion.bash: add support for path completion
Date: Sun, 21 Apr 2013 05:14:38 -0500
Message-ID: <CAMP44s1TjTiZ9HsXn9YiJ8E6+jC=s+g_tps6AY2ixrrgX=0jnw@mail.gmail.com>
References: <1357930123-26310-1-git-send-email-manlio.perillo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, gitster@pobox.com, szeder@ira.uka.de,
	peff@peff.net
To: Manlio Perillo <manlio.perillo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 12:14:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTrID-0006zX-9C
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 12:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071Ab3DUKOk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 06:14:40 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:61013 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab3DUKOj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 06:14:39 -0400
Received: by mail-lb0-f169.google.com with SMTP id p11so4847174lbi.28
        for <git@vger.kernel.org>; Sun, 21 Apr 2013 03:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=X5OAhm7KkrIUBHWxt7HfGOQ+oWuC7Xn7KXhOBeKa7VE=;
        b=Y9zDxkjX3QVPKrDO2GsBznV7X20HMftM5P3qOqNYdj3Gz1nlsi1jAose1hT0II/wEo
         cWziAZCw+Vi/TIjhawZV31EngvB/+vKAymXaADX8o+BL9SyvWYr5wUgQ8sHiDwADervO
         77VP/ILOypPpiUF9FaE4W2VDGIRK8YTYSv7RRQtovCqxZoCLp8SBy8cSUWmpWpBf3Wpl
         wU/Hc/2cS1UpqsryGdNAVly0+4O9Y/lWis2SoVbFHpcJizdMmmt3EftkQZikUiTFZKXJ
         T3sSv0MDPMtrbZ9uvs1RkCfLFECj7oAJksou8ryviGoPZGq/1VhyeoQptSKeo32S+9QC
         EZSA==
X-Received: by 10.112.146.133 with SMTP id tc5mr11114006lbb.88.1366539278262;
 Sun, 21 Apr 2013 03:14:38 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Sun, 21 Apr 2013 03:14:38 -0700 (PDT)
In-Reply-To: <1357930123-26310-1-git-send-email-manlio.perillo@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221939>

On Fri, Jan 11, 2013 at 12:48 PM, Manlio Perillo
<manlio.perillo@gmail.com> wrote:
> The git-completion.bash script did not implemented full, git aware,
> support to complete paths, for git commands that operate on files within
> the current working directory or the index.

> +__git_index_file_list_filter_compat ()
> +{
> +       local path
> +
> +       while read -r path; do
> +               case "$path" in
> +               ?*/*) echo "${path%%/*}/" ;;
> +               *) echo "$path" ;;
> +               esac
> +       done
> +}
> +
> +__git_index_file_list_filter_bash ()
> +{
> +       local path
> +
> +       while read -r path; do
> +               case "$path" in
> +               ?*/*)
> +                       # XXX if we append a slash to directory names when using
> +                       # `compopt -o filenames`, Bash will append another slash.
> +                       # This is pretty stupid, and this the reason why we have to
> +                       # define a compatible version for this function.
> +                       echo "${path%%/*}" ;;

Which version of bash is that? It works perfectly fine here with or
without the /.

> +# __git_index_files accepts 1 or 2 arguments:
> +# 1: Options to pass to ls-files (required).
> +#    Supported options are --cached, --modified, --deleted, --others,
> +#    and --directory.
> +# 2: A directory path (optional).
> +#    If provided, only files within the specified directory are listed.
> +#    Sub directories are never recursed.  Path must have a trailing
> +#    slash.
> +__git_index_files ()
> +{
> +       local dir="$(__gitdir)" root="${2-.}"
> +
> +       if [ -d "$dir" ]; then
> +               __git_ls_files_helper "$root" "$1" | __git_index_file_list_filter |
> +                       sort | uniq
> +       fi
> +}
> +
> +# __git_diff_index_files accepts 1 or 2 arguments:
> +# 1) The id of a tree object.
> +# 2) A directory path (optional).
> +#    If provided, only files within the specified directory are listed.
> +#    Sub directories are never recursed.  Path must have a trailing
> +#    slash.
> +__git_diff_index_files ()
> +{
> +       local dir="$(__gitdir)" root="${2-.}"
> +
> +       if [ -d "$dir" ]; then
> +               __git_diff_index_helper "$root" "$1" | __git_index_file_list_filter |
> +                       sort | uniq
> +       fi
> +}

These two are exactly the same, except one calls
__git_ls_files_helper, and the other one __git_diff_index_helper,
can't we make another argument that is and select one or the other
based on that?

>  __git_heads ()
>  {
>         local dir="$(__gitdir)"
> @@ -430,6 +543,46 @@ __git_complete_revlist_file ()
>  }
>
>
> +# __git_complete_index_file requires 1 argument: the options to pass to
> +# ls-file
> +__git_complete_index_file ()
> +{
> +       local pfx cur_="$cur"
> +
> +       case "$cur_" in
> +       ?*/*)
> +               pfx="${cur_%/*}"
> +               cur_="${cur_##*/}"
> +               pfx="${pfx}/"
> +
> +               __gitcomp_file "$(__git_index_files "$1" "$pfx")" "$pfx" "$cur_"
> +               ;;
> +       *)
> +               __gitcomp_file "$(__git_index_files "$1")" "" "$cur_"
> +               ;;
> +       esac
> +}
> +
> +# __git_complete_diff_index_file requires 1 argument: the id of a tree
> +# object
> +__git_complete_diff_index_file ()
> +{
> +       local pfx cur_="$cur"
> +
> +       case "$cur_" in
> +       ?*/*)
> +               pfx="${cur_%/*}"
> +               cur_="${cur_##*/}"
> +               pfx="${pfx}/"
> +
> +               __gitcomp_file "$(__git_diff_index_files "$1" "$pfx")" "$pfx" "$cur_"
> +               ;;
> +       *)
> +               __gitcomp_file "$(__git_diff_index_files "$1")" "" "$cur_"
> +               ;;
> +       esac
> +}

These are also exactly the same, we could pass the argument to the
function above.

-- 
Felipe Contreras

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH, 4th version] git-branch: register where to merge from, when branching off a remote branch
Date: Fri, 02 Mar 2007 01:52:29 -0800
Message-ID: <7vtzx4ezvm.fsf@assigned-by-dhcp.cox.net>
References: <es450f$d58$1@sea.gmane.org>
	<Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>
	<45E68897.8000607@lu.unisi.ch>
	<81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
	<45E68EDE.2090405@lu.unisi.ch>
	<81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
	<45E69297.8070001@lu.unisi.ch>
	<81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>
	<45E69EEE.8070905@lu.unisi.ch>
	<81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
	<7vvehls1h9.fsf@assigned-by-dhcp.cox.net>
	<45E70041.1030705@lu.unisi.ch>
	<Pine.LNX.4.63.0703012240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<45E7DC04.5010701@lu.unisi.ch> <45E7E53E.5020704@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 10:53:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HN4Ri-0000qL-G0
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 10:53:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422984AbXCBJwk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 04:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422989AbXCBJwk
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 04:52:40 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:44474 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422984AbXCBJwa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 04:52:30 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070302095230.NXGZ2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Fri, 2 Mar 2007 04:52:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id VlsV1W00K1kojtg0000000; Fri, 02 Mar 2007 04:52:30 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41175>

Paolo Bonzini <paolo.bonzini@gmail.com> writes:

> A rather standard (in 1.5) procedure for branching off a remote archive
> is:

Much easier to read, thanks.

Although I'll still nitpick a few points...

>
>   git checkout -b branchname remote/upstreambranch
>   git config --add branch.branchname.remote remote
>   git config --add branch.branchname.merge refs/heads/upstreambranch

Probably a rather standard procedure would be to fork from
remote tracking branch of where you cloned from, i.e. under
'remotes/origin'.  I think the above examples are a bit easier
to read if you said:

    In order to track and build on top of a branch 'topic' you
    track from your upstream repository, you often would end up
    doing this sequence:

    $ git checkout -b topic origin/topic
    $ git config --add branch.branchname.remote origin
    $ git config --add branch.branchname.merge refs/heads/topic

    to fork your own 'topic' branch from the corresponding
    branch you track from the 'origin' repository, and set up
    two configuration variables so that 'git pull' without
    parameters does the right thing while you are on your own
    'topic' branch.

    This commit teaches --track option to git-branch, so that
    "git branch --track topic origin/topic" performs the latter
    two actions when creating your 'topic' branch.  By setting
    configuration variable 'branch.trackremotebranches' to true,
    you do not have to pass --track option explicitly (the
    configuration variable is off by default, and there is a
    --no-track option to countermand it even if the variable is
    set).

    Signed-off-by: ...

I do not think a porcelain level command 'branch' should
introduce core.* configuration variables.

I have a feeling that "git checkout -b" and "git checkout -B"
should be taught to explicitly use "git branch --no-track" and
"git branch --track" to create a new branch (currently it does
not even use "git branch" as far as I can tell).  With your
patch, I suspect that you have to say "git branch topic
origin/topic" and then "git checkout topic", which means you
made the three-step process into two steps, but you could have
made it into one step.  I'll send out an untested patch to
git-checkout so that you can try it out in a separate message.

> diff --git a/builtin-branch.c b/builtin-branch.c
> index d0179b0..96658ff 100644
> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -308,15 +308,34 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
>  	free_ref_list(&ref_list);
>  }
>  
> +static void register_pull (const char *name, const char *remote_branch_name)
> +{
> +	char *slash = strchr(remote_branch_name, '/');
> +	char key[1024], value[1024];
> +
> +	if (strlen(remote_branch_name) >= 1024 - 11
> +	    || strlen(name) >= 1024 - 15)
> +		die ("what a long branch name you have!");
> +
> +	snprintf(key, sizeof(key), "branch.%s.remote", name);
> +	snprintf(value, sizeof(value), "%.*s", slash - remote_branch_name,
> +		 remote_branch_name);
> +	git_config_set(key, value);
> +
> +	snprintf(key, sizeof(key), "branch.%s.merge", name);
> +	snprintf(value, sizeof(value), "refs/heads/%s", slash + 1);
> +	git_config_set(key, value);
> +}
> +

 - (minor style) No SP between "register_pull" and "(".  Found
   elsewhere as well.

 - (minor style) I tend to prefer pure declarations before decls
   with initializer.  I.e. "char key[], value[]" first then
   "char *slash".

 - (discipline) Not 1024 in the comparison.  sizeof(key) or
   sizeof(value).

 - (micronit) Is it true that both strlen() tests are about long
   *branch* names?

 - (style and discipline) If you use snprintf(), it is usually
   easier to check its return value to see if you would have
   overflowed, without having the if() statement to check the
   length upfront.  As the code gets updated, you may need to
   change the snprintf() format strings later, and you can
   forget making a matching change to the condition in if()
   statement with the patch above.

 - (moderately serious) The code blindly trusts that
   "refs/remotes/foo/bar" tracks "refs/heads/bar" from remote
   named "foo", which is a bit disturbing.  With the default
   configuration git-clone and git-remote creates, it always is
   the case, but I suspect you might want to at least verify
   that assumption (the user can have different settings in the
   config), if not figuring them out by reading the existing
   configuration yourself.

> @@ -333,7 +354,9 @@ static void create_branch(const char *name, const char *start_name,
>  	if (start_sha1)
>  		/* detached HEAD */
>  		hashcpy(sha1, start_sha1);
> -	else if (get_sha1(start_name, sha1))
> +	else if (dwim_ref(start_name, strlen(start_name), sha1, &real_ref))
> +		remote = !prefixcmp(real_ref, "refs/remotes/");
> +	else
>  		die("Not a valid object name: '%s'.", start_name);
>  
>  	if ((commit = lookup_commit_reference(sha1)) == NULL)

 - (pure question) What happens if dwim_ref() returns more than one?

> diff --git a/config.c b/config.c
> index 0ff413b..49df7bd 100644
> --- a/config.c
> +++ b/config.c
> @@ -294,6 +294,11 @@ int git_default_config(const char *var, const char *value)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "core.trackremotebranches")) {
> +		track_remote_branches = git_config_bool(var, value);
> +		return 0;
> +	}
> +
>  	if (!strcmp(var, "core.legacyheaders")) {
>  		use_legacy_headers = git_config_bool(var, value);
>  		return 0;

 - (mild objection) Does this belong to git_default_config()?  I
   would have expected this to appear in git_branch_config().

> diff --git a/environment.c b/environment.c
> index 570e32a..e440d05 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -17,6 +17,7 @@ int assume_unchanged;
>  int prefer_symlink_refs;
>  int is_bare_repository_cfg = -1; /* unspecified */
>  int log_all_ref_updates = -1; /* unspecified */
> +int track_remote_branches = 0;
>  int warn_ambiguous_refs = 1;
>  int repository_format_version;
>  char *git_commit_encoding;

 - (style and discipline) No need to initialize global int to
   0.  BSS would take care of it.

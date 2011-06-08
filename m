From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCHv8 4/4] Add documentation for ref namespaces
Date: Wed, 08 Jun 2011 11:19:59 -0400
Message-ID: <4DEF931F.70907@xiplink.com>
References: <1307487890-3915-1-git-send-email-jamey@minilop.net> <1307487890-3915-5-git-send-email-jamey@minilop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org,
	Josh Triplett <josh@joshtriplett.org>
To: Jamey Sharp <jamey@minilop.net>
X-From: git-owner@vger.kernel.org Wed Jun 08 17:20:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUKYC-0003ih-Iv
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 17:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756438Ab1FHPUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 11:20:03 -0400
Received: from smtp132.iad.emailsrvr.com ([207.97.245.132]:37007 "EHLO
	smtp132.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756433Ab1FHPUC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 11:20:02 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp43.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id 8DE782D02D0;
	Wed,  8 Jun 2011 11:20:00 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp43.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id CCC412D06C5;
	Wed,  8 Jun 2011 11:19:59 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
In-Reply-To: <1307487890-3915-5-git-send-email-jamey@minilop.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175383>

On 11-06-07 07:04 PM, Jamey Sharp wrote:
> From: Josh Triplett<josh@joshtriplett.org>
>
> Document the namespace mechanism in a new gitnamespaces(7) page.
> Reference it from receive-pack and upload-pack.
>
> Document the new --namespace option and GIT_NAMESPACE environment
> variable in git(1), and reference gitnamespaces(7).
>
> Add a sample Apache configuration to http-backend(1) to support
> namespaced repositories, and reference gitnamespaces(7).
>
> Commit by Josh Triplett and Jamey Sharp.
>
> Signed-off-by: Josh Triplett<josh@joshtriplett.org>
> Signed-off-by: Jamey Sharp<jamey@minilop.net>
> ---
>   Documentation/Makefile                 |    2 +-
>   Documentation/git-http-backend.txt     |    8 +++
>   Documentation/git-receive-pack.txt     |    2 +-
>   Documentation/git-upload-pack.txt      |    4 ++
>   Documentation/git.txt                  |   13 +++++-
>   Documentation/gitnamespaces.txt        |   75 ++++++++++++++++++++++++++++++++
>   contrib/completion/git-completion.bash |    2 +-
>   7 files changed, 101 insertions(+), 5 deletions(-)
>   create mode 100644 Documentation/gitnamespaces.txt
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index 36989b7..2004fbe 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -6,7 +6,7 @@ MAN5_TXT=gitattributes.txt gitignore.txt gitmodules.txt githooks.txt \
>   	gitrepository-layout.txt
>   MAN7_TXT=gitcli.txt gittutorial.txt gittutorial-2.txt \
>   	gitcvs-migration.txt gitcore-tutorial.txt gitglossary.txt \
> -	gitdiffcore.txt gitrevisions.txt gitworkflows.txt
> +	gitdiffcore.txt gitnamespaces.txt gitrevisions.txt gitworkflows.txt
>
>   MAN_TXT = $(MAN1_TXT) $(MAN5_TXT) $(MAN7_TXT)
>   MAN_XML=$(patsubst %.txt,%.xml,$(MAN_TXT))
> diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
> index 277d9e1..f4e0741 100644
> --- a/Documentation/git-http-backend.txt
> +++ b/Documentation/git-http-backend.txt
> @@ -119,6 +119,14 @@ ScriptAliasMatch \
>
>   ScriptAlias /git/ /var/www/cgi-bin/gitweb.cgi/
>   ----------------------------------------------------------------
> ++
> +To serve multiple repositories from different linkgit:gitnamespaces[7] in a
> +single repository:
> ++
> +----------------------------------------------------------------
> +SetEnvIf Request_URI "^/git/([^/]*)" GIT_NAMESPACE=$1
> +ScriptAliasMatch ^/git/[^/]*(.*) /usr/libexec/git-core/git-http-backend/storage.git$1
> +----------------------------------------------------------------
>
>   Accelerated static Apache 2.x::
>   	Similar to the above, but Apache can be used to return static
> diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
> index f34e0ae..3534ba0 100644
> --- a/Documentation/git-receive-pack.txt
> +++ b/Documentation/git-receive-pack.txt
> @@ -149,7 +149,7 @@ if the repository is packed and is served via a dumb transport.
>
>   SEE ALSO
>   --------
> -linkgit:git-send-pack[1]
> +linkgit:git-send-pack[1], linkgit:gitnamespaces[7]
>
>   GIT
>   ---
> diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
> index 4c0ca9d..61a9a04 100644
> --- a/Documentation/git-upload-pack.txt
> +++ b/Documentation/git-upload-pack.txt
> @@ -33,6 +33,10 @@ OPTIONS
>   <directory>::
>   	The repository to sync from.
>
> +SEE ALSO
> +--------
> +linkgit:gitnamespaces[7]
> +
>   GIT
>   ---
>   Part of the linkgit:git[1] suite
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 5c45446..4cbf741 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -10,8 +10,8 @@ SYNOPSIS
>   --------
>   [verse]
>   'git' [--version] [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
> -    [-p|--paginate|--no-pager] [--no-replace-objects]
> -    [--bare] [--git-dir=<path>] [--work-tree=<path>]
> +    [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
> +    [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
>       [-c<name>=<value>]
>       [--help]<command>  [<args>]
>
> @@ -325,6 +325,11 @@ help ...`.
>   	variable (see core.worktree in linkgit:git-config[1] for a
>   	more detailed discussion).
>
> +--namespace=<path>::
> +	Set the git namespace.  See linkgit:gitnamespaces[7] for more
> +	details.  Equivalent to setting the `GIT_NAMESPACE` environment
> +	variable.
> +
>   --bare::
>   	Treat the repository as a bare repository.  If GIT_DIR
>   	environment is not set, it is set to the current working
> @@ -589,6 +594,10 @@ git so take care if using Cogito etc.
>   	This can also be controlled by the '--work-tree' command line
>   	option and the core.worktree configuration variable.
>
> +'GIT_NAMESPACE'::
> +	Set the git namespace; see linkgit:gitnamespaces[7] for details.
> +	The '--namespace' command-line option also sets this value.
> +

Thanks for this work!

Does --namespace override GIT_NAMESPACE or extend it in some way?

I also have a question about how to use this feature.  We currently have 
a central "Main.git" repo where people put their finished work. 
Developers clone this repo with, say, "git clone 
ssh://host/git/Main.git".  Each developer also has a "personal" repo 
where they can publish work-in-progress branches to share without 
creating churn in Main.git.  Folks add personal repos as remotes in 
their Main.git clone, e.g. "git remote add Marc 
git://host/git/personal/marcnarc/Main.git".

This is a fairly clean model:  The personal repos on the central host 
are just local clones of the Main.git repo, and fetching from a personal 
repo only transmits unique refs.  But setting it up was a bit involved, 
and it looks like namespaces would make things even cleaner on the 
central host.

But I think our users will get tripped up by the remote-ext syntax.  The 
above "remote add" command is reasonably straightforward, but with 
namespaces it would be

	git remote add Marc ext::"git --namespace=personal/marcnarc %s 
git://host/git/Main.git"

I can see a lot of opportunity for confusion as users try to type that in.

So my question is, is there any way we could adopt namespaces without 
teaching our users about remote-ext?  Ideally they would just use the 
same URLs they already use, or maybe a slight variation thereof (e.g. 
git://host/git/Main.git/personal/marcnarc).

		M.

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Ask for "git program" when asking for "git-program" over SSH connection
Date: Wed, 25 Jun 2008 00:44:09 -0400
Message-ID: <20080625044409.GE11793@spearce.org>
References: <7vskv2d0lp.fsf@gitster.siamese.dyndns.org> <20080624221049.GE29404@genesis.frugalware.org> <7vk5gea0ff.fsf@gitster.siamese.dyndns.org> <20080624233236.GI29404@genesis.frugalware.org> <7vk5ge8bm5.fsf@gitster.siamese.dyndns.org> <20080625120832.6117@nanako3.lavabit.com> <7v1w2m8ahi.fsf@gitster.siamese.dyndns.org> <7vprq66vqd.fsf_-_@gitster.siamese.dyndns.org> <20080625034538.GW11793@spearce.org> <7vk5ge6soc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@lavabit.com>,
	Miklos Vajna <vmiklos@frugalware.org>, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 06:45:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBMsr-00044k-QF
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 06:45:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759281AbYFYEoe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 00:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759287AbYFYEoe
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 00:44:34 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44043 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759717AbYFYEob (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 00:44:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KBMrb-00075Y-1X; Wed, 25 Jun 2008 00:44:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6EC6320FBAE; Wed, 25 Jun 2008 00:44:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vk5ge6soc.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86224>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Sorry, but I think this change needs to go higher up, to the default
> > values that --upload-pack and remote.$name.uploadpack override,
> > so the user can at least work around it when we break her ability
> > to use github, gitosis, or anything like it.
> 
> Well, the thing is, "higher up" would not have enough clue to see if it
> needs to give dashed form (for git-daemon) or space form (for ssh), so
> that suggestion won't help much.

Actually I'd go the other direction.  Allow the higher up level
to supply "git upload-pack" and convert it to git- for the git://
protocol.  Possible patch below.

> I do not care too much about closed source service, but gitosis should be
> able to update the pattern to allow "git[ -]upload-pack" reasonably
> easily.

Pasky also has to update:

$ git ls-remote --upload-pack='git upload-pack' repo.or.cz:/srv/git/egit.git
fatal: unrecognized command 'git upload-pack '/srv/git/egit.git''
fatal: The remote end hung up unexpectedly

;-)
 
> Any other suggestions that is workable?

diff --git a/builtin-clone.c b/builtin-clone.c
index 5c5acb4..98d0f0f 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -37,7 +37,7 @@ static int option_quiet, option_no_checkout, option_bare;
 static int option_local, option_no_hardlinks, option_shared;
 static char *option_template, *option_reference, *option_depth;
 static char *option_origin = NULL;
-static char *option_upload_pack = "git-upload-pack";
+static char *option_upload_pack = "git upload-pack";
 
 static struct option builtin_clone_options[] = {
 	OPT__QUIET(&option_quiet),
@@ -58,7 +58,7 @@ static struct option builtin_clone_options[] = {
 	OPT_STRING('o', "origin", &option_origin, "branch",
 		   "use <branch> instead or 'origin' to track upstream"),
 	OPT_STRING('u', "upload-pack", &option_upload_pack, "path",
-		   "path to git-upload-pack on the remote"),
+		   "path to git upload-pack on the remote"),
 	OPT_STRING(0, "depth", &option_depth, "depth",
 		    "create a shallow clone of that depth"),
 
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index f4dbcf0..b0efd01 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -14,7 +14,7 @@ static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
 static int unpack_limit = 100;
 static struct fetch_pack_args args = {
-	/* .uploadpack = */ "git-upload-pack",
+	/* .uploadpack = */ "git upload-pack",
 };
 
 static const char fetch_pack_usage[] =
diff --git a/connect.c b/connect.c
index e92af29..dbabd93 100644
--- a/connect.c
+++ b/connect.c
@@ -576,8 +576,8 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		 * from extended components with a NUL byte.
 		 */
 		packet_write(fd[1],
-			     "%s %s%chost=%s%c",
-			     prog, path, 0,
+			     "git-%s %s%chost=%s%c",
+			     prog + 4, path, 0,
 			     target_host, 0);
 		free(target_host);
 		free(url);
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 695a409..0f82a93 100755
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -255,10 +255,10 @@ get_uploadpack () {
 	case "$data_source" in
 	config)
 		uplp=$(git config --get "remote.$1.uploadpack")
-		echo ${uplp:-git-upload-pack}
+		echo ${uplp:-git upload-pack}
 		;;
 	*)
-		echo "git-upload-pack"
+		echo "git upload-pack"
 		;;
 	esac
 }
diff --git a/transport.c b/transport.c
index 3ff8519..351b7f5 100644
--- a/transport.c
+++ b/transport.c
@@ -762,10 +762,10 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 		data->thin = 1;
 		data->conn = NULL;
-		data->uploadpack = "git-upload-pack";
+		data->uploadpack = "git upload-pack";
 		if (remote && remote->uploadpack)
 			data->uploadpack = remote->uploadpack;
-		data->receivepack = "git-receive-pack";
+		data->receivepack = "git receive-pack";
 		if (remote && remote->receivepack)
 			data->receivepack = remote->receivepack;
 	}

-- 
Shawn.

From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] remote add: add a --no-tags (-n) option
Date: Mon, 19 Apr 2010 18:10:27 +0200
Message-ID: <4BCC8073.80109@drmicha.warpmail.net>
References: <20100419135014.1077.28627.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Samuel Tardieu <sam@rfc1149.net>
X-From: git-owner@vger.kernel.org Mon Apr 19 18:13:38 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3tbN-0004oT-Kl
	for gcvg-git-2@lo.gmane.org; Mon, 19 Apr 2010 18:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754847Ab0DSQNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Apr 2010 12:13:32 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34678 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754948Ab0DSQNb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Apr 2010 12:13:31 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id ACED4E9F05;
	Mon, 19 Apr 2010 12:13:30 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 19 Apr 2010 12:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=6jCrrKiCIRzKYiUoglZb8dYPALM=; b=nKFBnKaNed9zuHaHzu1vEFcsqrdhMjk/oQCb7/7QBZdptGXoU+GgWPVoq4Ri+YTLt9h8PCaNk1iLbg0cx6nmfoFBAL/Zvq3Nks/vMOeLcMSS8ptG2eRsi/OYco2pM5/kXVyThTT2BxGfzImbKwOBY4UcTgHHBgNt0okb4HdCqnQ=
X-Sasl-enc: X3vmUnCSDLb0Z1sCoeRR4vM7H7FHXDGt6aozf9D/o40X 1271693610
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C4CBE37DE4;
	Mon, 19 Apr 2010 12:13:29 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100414 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <20100419135014.1077.28627.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145309>

Samuel Tardieu venit, vidit, dixit 19.04.2010 15:50:
> Add a '--no-tags' option to 'git remote add' which adds a
> 'remote.REMOTE.tagopt = --no-tags' to the configuration file.
> 
> 'git add -f -n REMOTE' will create a new remote and fetch from it

I guess you mean 'git remote add' here.

The general directions for this is nice. Just don't expect much response
now in rc-phase.

> without importing the tags. Subsequent 'git fetch REMOTE' will also
> not import the tags.
> 
> Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
> ---
>  Documentation/git-remote.txt |    5 ++++-
>  builtin/remote.c             |   11 ++++++++++-
>  t/t5505-remote.sh            |   36 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index 3fc599c..9db3c35 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git remote' [-v | --verbose]
> -'git remote add' [-t <branch>] [-m <master>] [-f] [--mirror] <name> <url>
> +'git remote add' [-t <branch>] [-m <master>] [-f] [-n] [--mirror] <name> <url>
>  'git remote rename' <old> <new>
>  'git remote rm' <name>
>  'git remote set-head' <name> (-a | -d | <branch>)
> @@ -51,6 +51,9 @@ update remote-tracking branches <name>/<branch>.
>  With `-f` option, `git fetch <name>` is run immediately after
>  the remote information is set up.
>  +
> +With `-n` option, `git fetch <name>` does not import tags from
> +the remote repository.
> ++
>  With `-t <branch>` option, instead of the default glob
>  refspec for the remote to track all branches under
>  `$GIT_DIR/remotes/<name>/`, a refspec to track only `<branch>`
> diff --git a/builtin/remote.c b/builtin/remote.c
> index 277765b..bb5606b 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -106,7 +106,7 @@ static int fetch_remote(const char *name)
>  
>  static int add(int argc, const char **argv)
>  {
> -	int fetch = 0, mirror = 0;
> +	int fetch = 0, mirror = 0, notags = 0;
>  	struct string_list track = { NULL, 0, 0 };
>  	const char *master = NULL;
>  	struct remote *remote;
> @@ -116,6 +116,8 @@ static int add(int argc, const char **argv)
>  
>  	struct option options[] = {
>  		OPT_BOOLEAN('f', "fetch", &fetch, "fetch the remote branches"),
> +		OPT_BOOLEAN('n', "no-tags", &notags,
> +			"do not import remote tags when fetching"),
>  		OPT_CALLBACK('t', "track", &track, "branch",
>  			"branch(es) to track", opt_parse_track),
>  		OPT_STRING('m', "master", &master, "branch", "master branch"),
> @@ -172,6 +174,13 @@ static int add(int argc, const char **argv)
>  			return 1;
>  	}
>  
> +	if (notags) {
> +		strbuf_reset(&buf);
> +		strbuf_addf(&buf, "remote.%s.tagopt", name);
> +		if (git_config_set(buf.buf, "--no-tags"))
> +			return 1;

Is this buf freed again?

> +	}
> +
>  	if (fetch && fetch_remote(name))
>  		return 1;
>  
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 230c0cd..d4ed7ea 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -320,6 +320,42 @@ test_expect_success 'add alt && prune' '
>  	 git rev-parse --verify refs/remotes/origin/side2)
>  '
>  
> +cat > test/expect << EOF
> +some-tag
> +EOF
> +
> +test_expect_success 'add with tags (default)' '
> +	(cd one &&
> +	 git tag -a -m "Some tag" some-tag) &&
> +	(mkdir add-tags &&
> +	 cd add-tags &&
> +	 git init &&
> +	 git remote add -f origin ../one &&
> +	 git tag -l some-tag > ../test/output &&
> +	 test_must_fail git config remote.origin.tagopt) &&
> +	(cd one &&
> +	 git tag -d some-tag) &&
> +	test_cmp test/expect test/output
> +'
> +
> +cat > test/expect << EOF
> +--no-tags
> +EOF
> +
> +test_expect_success 'add --no-tags' '
> +	(cd one &&
> +	 git tag -a -m "Some tag" some-tag) &&
> +	(mkdir add-no-tags &&
> +	 cd add-no-tags &&
> +	 git init &&
> +	 git remote add -f -n origin ../one &&
> +	 git tag -l some-tag > ../test/output &&
> +	 git config remote.origin.tagopt >> ../test/output) &&
> +	(cd one &&
> +	 git tag -d some-tag) &&
> +	test_cmp test/expect test/output
> +'
> +
>  cat > one/expect << EOF
>    apis/master
>    apis/side
> 

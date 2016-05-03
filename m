From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] commit-tree: do not pay attention to commit.gpgsign
Date: Tue, 3 May 2016 00:12:57 -0400
Message-ID: <20160503041256.GA30529@sigill.intra.peff.net>
References: <xmqqlh3sqfze.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 06:13:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axRhx-0007U8-75
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 06:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbcECENB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 00:13:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:60778 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750713AbcECENA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 00:13:00 -0400
Received: (qmail 9107 invoked by uid 102); 3 May 2016 04:12:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 00:12:59 -0400
Received: (qmail 22124 invoked by uid 107); 3 May 2016 04:13:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 00:13:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 00:12:57 -0400
Content-Disposition: inline
In-Reply-To: <xmqqlh3sqfze.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293318>

On Mon, May 02, 2016 at 02:58:45PM -0700, Junio C Hamano wrote:

> ba3c69a9 (commit: teach --gpg-sign option, 2011-10-05) introduced a
> "signed commit" by teaching --[no-gpg-sign option and commit.gpgsign
> configuration variable to various commands that create commits.
> 
> Teaching these to "git commit" and "git merge", both of which are
> end-user facing Porcelain commands, was perfectly fine.  Allowing
> the plumbing "git commit-tree" to suddenly change the behaviour to
> surprise the scripts by paying attention to commit.gpgsign was not.
> 
> Among the in-tree scripts, filter-branch, quiltimport, rebase and
> stash are the commands that run "commit-tree".  If any of these
> wants to allow users to always sign every single commit, they should
> offer their own configuration (e.g. "filterBranch..gpgsign") with an
> option to disable (e.g. "git filter-branch --no-gpgsign").
> 
> Ignoring commit.gpgsign option _obviously_ breaks the backward
> compatibility, but I seriously doubt anybody sane is depending on
> this misfeature that commit-tree blindly follows commit.gpgsign in
> any third-party script that calls it.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>  * This is an simpler alternative that forces commit-tree callers
>    that want to honor commit.gpgsign to do so themselves.

I don't have any such scripts myself (aside from git-stash, whose
signing behavior is moderately annoying), but I think this simpler form
is fine. There is already an escape hatch for scripts, and it is:

  if test "$(git config --bool commit.gpgsign)" = "true"; then
          sign=-S
  else
          sign=
  fi

  git commit-tree $sign ...

That is a few more lines than "--use-commit-gpgsign-config", but it's
simple enough to be acceptable, and matches the same technique that
other config options need when used with plumbing.

So I think the motivation and premise are good, but...

> -static int commit_tree_config(const char *var, const char *value, void *cb)
> -{
> -	int status = git_gpg_config(var, value, NULL);
> -	if (status)
> -		return status;
> -	if (!strcmp(var, "commit.gpgsign")) {
> -		sign_commit = git_config_bool(var, value) ? "" : NULL;
> -		return 0;
> -	}
> -	return git_default_config(var, value, cb);
> -}
> -

I think this may be going too far. If I do "git commit-tree -S", I'd
expect it to use gpg.program, but here you are dropping the call to
git_gpg_config. Likewise for user.signingkey.

So I think you just want to drop the commit.gpgsign block here, and keep
the rest.

-Peff

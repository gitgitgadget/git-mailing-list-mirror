From: Jeff King <peff@peff.net>
Subject: Re: Re* Bug report: reset -p HEAD
Date: Fri, 25 Oct 2013 00:24:21 -0400
Message-ID: <20131025042421.GB11810@sigill.intra.peff.net>
References: <CAPWpf+wi0zH2sOnuqiZuKkf+kC0RMug_ASb-J-TGGLd2RFT1wg@mail.gmail.com>
 <CAPWpf+xqutvhq1jyVkxr6LyKsANTCS6M=vj5XY=EgUfiS3Z8xg@mail.gmail.com>
 <CAPWpf+x5KUjD2K81pJAsV_XuPkd=BT06qPjvr8s7tEe5YqBt=w@mail.gmail.com>
 <CAPWpf+zkA68pzR3qx5xma8BNiONwt5o8iNba0x8fmmiDAWpHuw@mail.gmail.com>
 <xmqqvc0mj9wi.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Maarten de Vries <maarten@de-vri.es>,
	git mailing list <git@vger.kernel.org>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 06:24:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZYwm-00031m-8U
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 06:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab3JYEYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 00:24:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:55232 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750954Ab3JYEYY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 00:24:24 -0400
Received: (qmail 31069 invoked by uid 102); 25 Oct 2013 04:24:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 23:24:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 00:24:21 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvc0mj9wi.fsf_-_@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236656>

On Thu, Oct 24, 2013 at 08:40:13PM -0700, Junio C Hamano wrote:

> Maarten de Vries <maarten@de-vri.es> writes:
> 
> > Some more info: It used to work as intended. Using a bisect shows it
> > has been broken by commit 166ec2e9.
> 
> Thanks.
> 
> A knee-jerk change without thinking what side-effect it has for you
> to try out.
> 
>  builtin/reset.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/reset.c b/builtin/reset.c
> index f2f9d55..a3088d9 100644
> --- a/builtin/reset.c
> +++ b/builtin/reset.c
> @@ -304,7 +304,10 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
>  	if (patch_mode) {
>  		if (reset_type != NONE)
>  			die(_("--patch is incompatible with --{hard,mixed,soft}"));
> -		return run_add_interactive(sha1_to_hex(sha1), "--patch=reset", &pathspec);
> +		return run_add_interactive(
> +			(unborn || strcmp(rev, "HEAD"))
> +			? sha1_to_hex(sha1)
> +			: "HEAD", "--patch=reset", &pathspec);
>  	}

I think that's the correct fix for the regression.  You are restoring
the original, pre-166ec2e9 behavior for just the HEAD case. I do not
think add--interactive does any other magic between a symbolic rev and
its sha1, except for recognizing HEAD specially. However, if you wanted
to minimize the potential impact of 166ec2e9, you could pass the sha1
_only_ in the unborn case, like this:

diff --git a/builtin/reset.c b/builtin/reset.c
index f2f9d55..bfdd8d3 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -283,6 +283,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (unborn) {
 		/* reset on unborn branch: treat as reset to empty tree */
 		hashcpy(sha1, EMPTY_TREE_SHA1_BIN);
+		rev = EMPTY_TREE_SHA1_HEX;
 	} else if (!pathspec.nr) {
 		struct commit *commit;
 		if (get_sha1_committish(rev, sha1))
@@ -304,7 +305,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (patch_mode) {
 		if (reset_type != NONE)
 			die(_("--patch is incompatible with --{hard,mixed,soft}"));
-		return run_add_interactive(sha1_to_hex(sha1), "--patch=reset", &pathspec);
+		return run_add_interactive(rev, "--patch=reset", &pathspec);
 	}
 
 	/* git reset tree [--] paths... can be used to

That fixes any possible regression from add--interactive treating the
two cases differently. On an unborn branch, we will still say "apply
this hunk" rather than "unstage this hunk". That's not a regression,
because it simply didn't work before, but it's not ideal. To fix that,
we need to somehow tell add--interactive "this is HEAD, but use the
empty tree because it's unborn". I can think of a few simple-ish ways:

  1. Pass the head/not-head flag as a separate option.

  2. Pass HEAD even in the unborn case; teach add--interactive to
     convert an unborn HEAD to the empty tree.

  3. Teach add--interactive to recognize the empty tree sha1 as an
     "unstage" path.

I kind of like (3). At first glance, it is wrong; we will also treat
"git reset -p $(git hash-object -t tree /dev/null)" as if "HEAD" had
been passed. But if you are explicitly passing the empty tree like that,
I think saying "unstage" makes a lot of sense.

-Peff

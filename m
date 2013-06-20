From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pull: pull into void by fast-forwarding from empty tree
Date: Thu, 20 Jun 2013 08:47:58 -0400
Message-ID: <20130620124758.GA2376@sigill.intra.peff.net>
References: <45f6841746e5dcea03a97fc3ea24aef274728023.1371731513.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan =?utf-8?B?U2Now7zDn2xlcg==?= <mail@stefanschuessler.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 20 14:48:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpeHb-00059f-Jo
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 14:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965472Ab3FTMsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 08:48:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:56490 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965449Ab3FTMsB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 08:48:01 -0400
Received: (qmail 16870 invoked by uid 102); 20 Jun 2013 12:49:01 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Jun 2013 07:49:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2013 08:47:58 -0400
Content-Disposition: inline
In-Reply-To: <45f6841746e5dcea03a97fc3ea24aef274728023.1371731513.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228490>

On Thu, Jun 20, 2013 at 02:36:03PM +0200, Thomas Rast wrote:

> The logic for pulling into an unborn branch was originally designed to
> be used on a newly-initialized repository (d09e79c, git-pull: allow
> pulling into an empty repository, 2006-11-16).  It thus did not
> initially deal with uncommitted changes in the unborn branch.  The
> case of an _unstaged_ untracked file was fixed by by 4b3ffe5 (pull: do
> not clobber untracked files on initial pull, 2011-03-25).  However, it
> still clobbered existing staged files, both when the file exists in
> the merged commit (it will be overwritten), and when it does not (it
> will be lost!).

Yeah, in 4beffe5 I just assumed that using "read-tree -m" would give us
the protections we need. But obviously I didn't think about the fact
that we are not giving it enough information.

> We fix this by doing a two-way merge, where the "current" side of the
> merge is an empty tree, and the "target" side is HEAD (already updated
> to FETCH_HEAD at this point).  This amounts to claiming that all work
> in the index was done vs. an empty tree, and thus all content of the
> index is precious.

This seems like the correct fix; it is giving read-tree the right
information to make the decision. Thanks for working on this.

> +test_expect_success 'pulling into void does not overwrite staged files' '
> +	git init cloned-staged-colliding &&
> +	(
> +		cd cloned-staged-colliding &&
> +		echo "alternate content" >file &&
> +		git add file &&
> +		test_must_fail git pull .. master &&
> +		echo "alternate content" >expect &&
> +		test_cmp expect file
> +	)
> +'
> +
> +test_expect_success 'pulling into void does not remove new staged files' '
> +	git init cloned-staged-new &&
> +	(
> +		cd cloned-staged-new &&
> +		echo "new tracked file" >newfile &&
> +		git add newfile &&
> +		git pull .. master &&
> +		echo "new tracked file" >expect &&
> +		test_cmp expect newfile
> +	)
> +'

Do we want to also check the index state after each pull? In the former
case, I think it should obviously represent a conflict. In the latter,
we should be retaining the index contents of newfile.

These are basic things that read-tree's two-way merge should get right
(and are presumably tested elsewhere), but it might be worth confirming
the desired behavior here in case somebody later tries to tweak this
code path not to use read-tree.

-Peff

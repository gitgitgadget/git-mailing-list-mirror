From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] builtin-checkout: suggest creating local branch
 when appropriate to do so
Date: Mon, 5 Oct 2009 18:52:40 -0400
Message-ID: <20091005225240.GA29335@coredump.intra.peff.net>
References: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 01:08:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Muwej-0006PR-Bm
	for gcvg-git-2@lo.gmane.org; Tue, 06 Oct 2009 01:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755161AbZJEWzL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2009 18:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755126AbZJEWzH
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Oct 2009 18:55:07 -0400
Received: from peff.net ([208.65.91.99]:39244 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755395AbZJEWx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2009 18:53:26 -0400
Received: (qmail 21027 invoked by uid 107); 5 Oct 2009 22:56:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 05 Oct 2009 18:56:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Oct 2009 18:52:40 -0400
Content-Disposition: inline
In-Reply-To: <1254775583-49452-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129602>

On Mon, Oct 05, 2009 at 04:46:23PM -0400, Jay Soffian wrote:

> +static int suggest_new_branch_name_compare(struct remote *remote, void *priv)
> +{
> +	struct suggest_new_branch_name_data *data = priv;
> +	unsigned char sha1[20];
> +	struct strbuf buf = STRBUF_INIT;
> +	strbuf_addf(&buf, "refs/remotes/%s/%s", remote->name, data->name);
> +	if (resolve_ref(buf.buf, sha1, 1, NULL)) {
> +		data->matches++;
> +		if (data->found)
> +			strbuf_release(&buf);
> +		else
> +			data->found = strbuf_detach(&buf, NULL);
> +	}
> +	return 0;
> +}

This assumes that remote X always has its tracking branches in
refs/remotes/X/*. But that is really dependent on how the fetch refspec
is set up. True, it will be like that for remotes set up by "git remote"
or "git clone", but it isn't universal (and we have tried not to make
that assumption elsewhere, like when finding upstream branches to merge
from).  Doing it right would mean interpreting the refspecs in
remote.*.fetch.

But this is not necessarily about actual remotes, I don't think. It is
really about the names of refs we have, and that you could reference,
but that are not actual tracking branches. It's just that refs/remotes
is the obvious hierarchy there.

But I wonder if what you should do instead is to iterate through each
ref, removing refs/heads/* and refs/tags/* (which are uninteresting, as
they are already part of the normal ref lookup), and then suffix-match.
So looking for "next" would find "refs/remotes/origin/next", or even
"refs/foobar/next" if you had some "foobar" hierarchy.

It would also match "foo" to "refs/remotes/origin/jk/foo". I'm not sure
if that is a feature or a bug, though.


Aside from that, I can't think of anything wrong with the idea.
Personally I find it more chatty than I would want, because I know what
I'm doing. So I would suggest adding an advice.suggestBranchName config
option to voluntarily suppress it.

-Peff

From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] remote: introduce and fill branch->pushremote
Date: Mon, 13 Jan 2014 03:34:21 -0500
Message-ID: <20140113083421.GA18531@sigill.intra.peff.net>
References: <1389546666-17438-1-git-send-email-artagnon@gmail.com>
 <1389546666-17438-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 13 09:34:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2cya-0004Zm-57
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 09:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbaAMIeZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 03:34:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:59722 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751251AbaAMIeX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 03:34:23 -0500
Received: (qmail 18586 invoked by uid 102); 13 Jan 2014 08:34:23 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 13 Jan 2014 02:34:23 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Jan 2014 03:34:21 -0500
Content-Disposition: inline
In-Reply-To: <1389546666-17438-4-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240357>

On Sun, Jan 12, 2014 at 10:41:06PM +0530, Ramkumar Ramachandra wrote:

> When a caller uses branch_get() to retrieve a "struct branch", they get
> the per-branch remote name and a pointer to the remote struct. However,
> they have no way of knowing about the per-branch pushremote from this
> interface. So, let's expose that information via fields similar to
> "remote" and "remote_name"; "pushremote" and "pushremote_name".

Makes sense. This is similar to what I posted before, but stops short of
setting branch->pushremote based on "default.pushremote". I think that's
a good thing. Your patch matches branch->remote better, and the logic
for doing that fallback should probably stay outside of the "struct
branch" construct.

All 3 patches look like sane building blocks to me.

One comment on this hunk, though:

>  		} else if (!strcmp(subkey, ".pushremote")) {
> +			if (git_config_string(&branch->pushremote_name, key, value))
> +				return -1;
>  			if (branch == current_branch)
> -				if (git_config_string(&pushremote_name, key, value))
> -					return -1;
> +				pushremote_name = branch->pushremote_name;

In this code (both before and after your patch), pushremote_name does
double-duty for storing both "remote.pushdefault", and the current
branch's "branch.*.pushremote". I introduced an extra variable in my
version of the patch to store "remote.pushdefault" directly, and turned
pushremote_name into an alias (either to the current branch config, or
to the global config).

I did that for two reasons, one minor and one that I think will come up
further in the topic:

  1. After your patch "pushremote_name" sometimes owns its memory (if
     allocated for remote.pushdefault), and sometimes not (if an alias to
     branch.*.pushremote). This isn't a problem in the current code,
     because we never actually free() the string, meaning that if you
     set push.default twice, we leak. But that probably does not matter
     too much, and we have many such minor leaks of global config.

  2. If the current branch has a branch.*.pushremote set, but we want to
     know where a _different_ branch would be pushed, we have no way to
     access remote.pushdefault (it gets overwritten in the hunk above).

     @{upstream} does not have this problem, because it is _only_
     defined if branch.*.remote is set. There is no such thing as
     defaulting to a "remote.default" (or "origin") there, and we never
     need to look at default_remote_name.

     For @{publish}, though, I think we will want that default. The
     common config will be to simply set "remote.pushdefault", rather
     than setting up "branch.*.pushremote" for each branch, and we would
     want @{publish} to handle that properly.

So I think your patch is OK as-is, as the problem in (2) does not show
up until later in the series. But I suspect you will need to do
something to address it (and I think it is fine as a patch that comes
later to do that refactoring).

-Peff

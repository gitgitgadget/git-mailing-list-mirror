From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] strbuf: add xstrdup_fmt helper
Date: Wed, 18 Jun 2014 15:32:08 -0700
Message-ID: <xmqq7g4dj1cn.fsf@gitster.dls.corp.google.com>
References: <20140618200000.GA22994@sigill.intra.peff.net>
	<20140618200133.GA23057@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 00:32:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxOOx-00012V-KK
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 00:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbaFRWcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 18:32:15 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54267 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753425AbaFRWcP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 18:32:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 36454218FF;
	Wed, 18 Jun 2014 18:32:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5AOciXRGdehMiF+8ks+FVwLcvJ4=; b=D9tZSG
	dbK6WspaxwSY8OVTzWUhbVVUE3OFR6GGmwXcG+8K40Iu99c9LQJ+jOiXRqKqzr0J
	rY400tDvD8oNarSo0v9G2v2ZELWSrfRQR2/H5EKfPP8xcs94keVZwGgQDr33vPgK
	P7KXxaHMBZSUMpaljjDUKkqFeo5EDx5J2fi44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UW9sYVV/W0SPsrvt3DsD8NY9xx1q/3GQ
	zU1GK6EF5Rjr8L55BJbKcb8n8zThalSxxzQ/PIxYT27jujKG9A5HDu5c5uRT3Vpd
	hTk+GfycY9KIoUAGMb42GgGrYm/c8qFdfP42MFExSpGqneak41T9+Omz3K22Ja0g
	Zbi0Yi0cBDE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2C1A1218FE;
	Wed, 18 Jun 2014 18:32:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B1227218FA;
	Wed, 18 Jun 2014 18:32:07 -0400 (EDT)
In-Reply-To: <20140618200133.GA23057@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 18 Jun 2014 16:01:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 61815CCE-F738-11E3-9542-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252078>

Jeff King <peff@peff.net> writes:

> You can use a strbuf to build up a string from parts, and
> then detach it. In the general case, you might use multiple
> strbuf_add* functions to do the building. However, in many
> cases, a single strbuf_addf is sufficient, and we end up
> with:
>
>   struct strbuf buf = STRBUF_INIT;
>   ...
>   strbuf_addf(&buf, fmt, some, args);
>   str = strbuf_detach(&buf, NULL);
>
> We can make this much more readable (and avoid introducing
> an extra variable, which can clutter the code) by
> introducing a convenience function:
>
>   str = xstrdup_fmt(fmt, some, args);
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I'm open to suggestions on the name. This really is the same thing
> conceptually as the GNU asprintf(), but the interface is different (that
> function takes a pointer-to-pointer as an out-parameter, and returns the
> number of characters return).

Naming it with anything "dup" certainly feels wrong.  The returned
string is not a duplicate of anything.

To me, the function feels like an "sprintf done right"; as you said,
the best name for "printf-like format into an allocated piece of
memory" is unfortunately taken as asprintf(3).

I wonder if our callers can instead use asprintf(3) with its
slightly more quirky API (and then we supply compat/asprintf.c for
non-GNU platforms).  Right now we only have three call sites, but if
we anticipate that "printf-like format into an allocated piece of
memory" will prove be generally useful in our code base, following
an API that other people already have established may give our
developers one less thing that they have to learn.

As usual, I would expect we would have xasprintf wrapper around it
to die instead of returning -1 upon allocation failure.

The call sites do not look too bad (see below) if we were to go that
route instead.


 remote.c       |  2 +-
 unpack-trees.c | 10 ++++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/remote.c b/remote.c
index b46f467..87fa7ec 100644
--- a/remote.c
+++ b/remote.c
@@ -185,7 +185,7 @@ static struct branch *make_branch(const char *name, int len)
 		ret->name = xstrndup(name, len);
 	else
 		ret->name = xstrdup(name);
-	ret->refname = xstrdup_fmt("refs/heads/%s", ret->name);
+	asprintf(&ret->refname, "refs/heads/%s", ret->name);
 
 	return ret;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index dd1e06e..d6a07b8 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -63,8 +63,8 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 			"Please, commit your changes or stash them before you can %s.";
 	else
 		msg = "Your local changes to the following files would be overwritten by %s:\n%%s";
-	msgs[ERROR_WOULD_OVERWRITE] = msgs[ERROR_NOT_UPTODATE_FILE] =
-		xstrdup_fmt(msg, cmd, cmd2);
+	xasprintf(&msgs[ERROR_WOULD_OVERWRITE], msg, cmd, cmd2);
+	msgs[ERROR_NOT_UPTODATE_FILE] =	msgs[ERROR_WOULD_OVERWRITE];
 
 	msgs[ERROR_NOT_UPTODATE_DIR] =
 		"Updating the following directories would lose untracked files in it:\n%s";
@@ -75,8 +75,10 @@ void setup_unpack_trees_porcelain(struct unpack_trees_options *opts,
 	else
 		msg = "The following untracked working tree files would be %s by %s:\n%%s";
 
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED] = xstrdup_fmt(msg, "removed", cmd, cmd2);
-	msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN] = xstrdup_fmt(msg, "overwritten", cmd, cmd2);
+	xasprintf(&msgs[ERROR_WOULD_LOSE_UNTRACKED_REMOVED],
+		 msg, "removed", cmd, cmd2);
+	xasprintf(&msgs[ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN],
+		 msg, "overwritten", cmd, cmd2);
 
 	/*
 	 * Special case: ERROR_BIND_OVERLAP refers to a pair of paths, we

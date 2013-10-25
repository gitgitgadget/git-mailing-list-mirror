From: Jeff King <peff@peff.net>
Subject: Re: [BUG] "git --literal-pathspecs blame" broken in master
Date: Fri, 25 Oct 2013 00:04:36 -0400
Message-ID: <20131025040436.GA11810@sigill.intra.peff.net>
References: <20131025034947.GA4959@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 06:04:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZYdf-0003wO-9R
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 06:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545Ab3JYEEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Oct 2013 00:04:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:55216 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751512Ab3JYEEj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Oct 2013 00:04:39 -0400
Received: (qmail 30016 invoked by uid 102); 25 Oct 2013 04:04:39 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 23:04:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Oct 2013 00:04:36 -0400
Content-Disposition: inline
In-Reply-To: <20131025034947.GA4959@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236652>

On Thu, Oct 24, 2013 at 11:49:47PM -0400, Jeff King wrote:

> We get another change with a16bf9d (pathspec: make --literal-pathspecs
> disable pathspec magic, 2013-07-14), which I would think would fix
> things, but doesn't.
> 
>   $ git blame ':(foo)bar'
>   fatal: Invalid pathspec magic 'foo' in ':(foo)bar'
>   $ git --literal-pathspecs blame ':(foo)bar'
>   fatal: :(foo)bar: pathspec magic not supported by this command: 'literal'
> 
> The first one remains good, but the second one is still broken. I
> haven't dug further yet, but I thought it might be a bit more obvious to
> you.

Hmm. Is the fix as simple as:

diff --git a/builtin/blame.c b/builtin/blame.c
index 56e3d6b..1c2b303 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -408,7 +408,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 	paths[0] = origin->path;
 	paths[1] = NULL;
 
-	parse_pathspec(&diff_opts.pathspec, PATHSPEC_ALL_MAGIC, 0, "", paths);
+	parse_pathspec(&diff_opts.pathspec, PATHSPEC_ALL_MAGIC & ~PATHSPEC_LITERAL, 0, "", paths);
 	diff_setup_done(&diff_opts);
 
 	if (is_null_sha1(origin->commit->object.sha1))

All of the GUARD_PATHSPEC calls indicate that everybody understands
PATHSPEC_LITERAL. It is not technically true that git-blame understands
the literal pathspec magic:

  $ git blame -- ':(literal)revision.c'
  fatal: no such path ':(literal)revision.c' in HEAD

but that is a separate bug (that blame considers the argument as a path
first before feeding it to the pathspec machinery). The patch above does
not fix that, but AFAICT it does not make anything worse.

-Peff

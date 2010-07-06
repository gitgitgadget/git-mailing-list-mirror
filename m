From: Jeff King <peff@peff.net>
Subject: Re: 'git commit --short' without touching index?
Date: Tue, 6 Jul 2010 08:10:22 -0400
Message-ID: <20100706121022.GB15413@sigill.intra.peff.net>
References: <loom.20100703T102242-536@post.gmane.org>
 <20100703091748.GA11714@sigill.intra.peff.net>
 <7veifhy9j0.fsf@alter.siamese.dyndns.org>
 <20100705205651.GA32728@sigill.intra.peff.net>
 <7vk4p9wrdb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel <friedan@muon.rutgers.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 14:10:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW6yy-0006xb-94
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 14:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932Ab0GFMK0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 08:10:26 -0400
Received: from peff.net ([208.65.91.99]:49307 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753063Ab0GFMKZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 08:10:25 -0400
Received: (qmail 28446 invoked by uid 107); 6 Jul 2010 12:11:20 -0000
Received: from c-67-172-213-4.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (67.172.213.4)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 06 Jul 2010 08:11:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 06 Jul 2010 08:10:22 -0400
Content-Disposition: inline
In-Reply-To: <7vk4p9wrdb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150344>

On Mon, Jul 05, 2010 at 02:28:16PM -0700, Junio C Hamano wrote:

> > Apparently not:
> >
> >   $ stat .git/index | grep -i modify
> >   Modify: 2010-07-05 16:52:11.000000000 -0400
> >   $ git status
> >   # On branch master
> >   nothing to commit
> >   $ stat .git/index | grep -i modify
> >   Modify: 2010-07-05 16:53:09.000000000 -0400
> >
> > and it is not just updating some stat-dirtiness. Doing it over and over
> > will keep updating the index. It looks like we unconditionally do the
> > lock and write in cmd_status, but I haven't looked further.
> 
> Something like this, plus possibly a similar fix to "git commit $path"
> codepath, perhaps?

Yeah, that looks sane, though the one for "git status" is actually:

diff --git a/builtin/commit.c b/builtin/commit.c
index 8258a16..5e578af 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1090,9 +1090,11 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 
 	fd = hold_locked_index(&index_lock, 0);
 	if (0 <= fd) {
-		if (!write_cache(fd, active_cache, active_nr))
+		if (active_cache_changed &&
+		    !write_cache(fd, active_cache, active_nr))
 			commit_locked_index(&index_lock);
-		rollback_lock_file(&index_lock);
+		else
+			rollback_lock_file(&index_lock);
 	}
 
 	s.is_initial = get_sha1(s.reference, sha1) ? 1 : 0;

and I did confirm that it works (does not touch the index when nothing
changes, and does write out the index even for a stat-dirty entry).

> We may want to audit all uses of write_cache() and write_index() that are
> not protected with active_cache_changed (or istate->cache_changed); I am
> reluctant to suggest placing that logic into write_index() at this point,
> though, as we may be updating the index in bulk, without marking
> active_cache_changed bit, exactly because we know we will unconditionally
> write the result out.

I don't think changing write_index() is a good idea. There are a lot of
calls, and I would rather have each one opt into this optimization than
break them in a mass change.

I was thinking that we might be able to simplify all of these lines into
a "lock, write, and commit" function that would either rollback or die
on failure, depending on a parameter. But there's often more complex
logic going on between those functions, so I don't think it would really
save us much.

-Peff

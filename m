From: Junio C Hamano <gitster@pobox.com>
Subject: Re: *[PATCH] builtin-commit: Refresh cache after adding files.
Date: Fri, 09 Nov 2007 17:40:45 -0800
Message-ID: <7v640ari76.fsf@gitster.siamese.dyndns.org>
References: <1194626427-2419-1-git-send-email-krh@redhat.com>
	<Pine.LNX.4.64.0711091702190.4362@racer.site>
	<7vhcjvtgz5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 10 02:41:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqfLS-0003wr-O8
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 02:41:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312AbXKJBky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 20:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754484AbXKJBky
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 20:40:54 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37698 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312AbXKJBkx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 20:40:53 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DD4342F2;
	Fri,  9 Nov 2007 20:41:13 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 51EC993C55;
	Fri,  9 Nov 2007 20:41:09 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64296>

Junio C Hamano <gitster@pobox.com> writes:

> This discussion exposes a problem with add_files_to_cache()
> function.
> ...
> And add_file_to_cache(), which calls add_file_to_index() on
> the_index, does call the fill_stat_cache_info() to sync the stat
> information by itself, as it should be.  I am still puzzled with
> this.

Blech.  I think it is 0781b8a9b2fe760fc4ed519a3a26e4b9bd6ccffe
(add_file_to_index: skip rehashing if the cached stat already
matches) that broke "git add".  I get the same problem not just
with "git add -u" but also with an explicit "git add Makefile".

In add_file_to_index(), we check if ie_modified() says if the
path is modified, but that is actually a very wrong check in
that function.  ie_modified() knows the racy git condition and
digs deeper to find if the file in the work tree is really
different.  We end up saying "ah, Ok, if that is the same, then
we do not add it to the index again", which is why we do not
update the stat info in this case.

Instead, we should ask ie_match_stat() which answers "does not
match" for a entry that _could_ be racily clean, so that we make
sure we re-add such an entry to clear the stat info.

This applies to maint and all the way up.

I also suspect that run_diff_files() that is called from
builtin-add.c:update() needs to tell ie_match_stat() to assume
that a racily clean path is unclean (that is what bit (1<<1) of
the third parameter to ie_match_stat() is about), so that "add
-u" will call the add_file_to_index() function, but that would
be a bigger patch.

---

 read-cache.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 928e8fa..75e2d46 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -420,7 +420,7 @@ int add_file_to_index(struct index_state *istate, const char *path, int verbose)
 	pos = index_name_pos(istate, ce->name, namelen);
 	if (0 <= pos &&
 	    !ce_stage(istate->cache[pos]) &&
-	    !ie_modified(istate, istate->cache[pos], &st, 1)) {
+	    !ie_match_stat(istate, istate->cache[pos], &st, 3)) {
 		/* Nothing changed, really */
 		free(ce);
 		return 0;

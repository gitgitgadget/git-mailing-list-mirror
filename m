From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] parse_object: clear "parsed" when freeing buffers
Date: Thu, 24 Jan 2013 02:07:15 -0500
Message-ID: <20130124070715.GD610@sigill.intra.peff.net>
References: <8988071A-1DF3-463E-8AF9-AE4EA200D786@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathon Mah <jmah@me.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 08:07:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyGuT-0005oL-7t
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 08:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225Ab3AXHHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 02:07:20 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45803 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751056Ab3AXHHS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 02:07:18 -0500
Received: (qmail 12521 invoked by uid 107); 24 Jan 2013 07:08:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Jan 2013 02:08:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2013 02:07:15 -0500
Content-Disposition: inline
In-Reply-To: <8988071A-1DF3-463E-8AF9-AE4EA200D786@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214400>

On Wed, Jan 23, 2013 at 01:25:04PM -0800, Jonathon Mah wrote:

> Several areas of code would free buffers for object structs that
> contained them ("struct tree" and "struct commit"), but without clearing
> the "parsed" flag. parse_object would clear the flag for "struct tree",
> but commits would remain in an invalid state (marked as parsed but with
> a NULL buffer). Because the objects are uniqued (ccdc6037fee), the
> invalid objects stay around and can lead to bad behavior.
> 
> In particular, running pickaxe on all refs in a repository with a cached
> textconv could segfault. If the textconv cache ref was evaluated first
> by cmd_log_walk, a subsequent notes_cache_match_validity call would
> dereference NULL.

Just to be sure I understand, what is going on is something like this?

  Log reads all refs, including notes. After showing the notes commit,
  log frees the buffer to save memory.  Later, doing the diff on a
  commit causes us to use the notes_cache mechanism. That will look at
  the commit at the tip of the notes ref, which log has already
  processed. It will call parse_commit, but that will do nothing, as the
  parsed flag is already set, but the commit buffer remains NULL.

I wonder if this could be the source of the segfault here, too:

  http://thread.gmane.org/gmane.comp.version-control.git/214322/focus=214355

If you have refs pointing to both a submodule and its superproject, a
"log --all --submodule -p" might process the submodule's commits first,
free their buffers, and then want to show them again as part of the
submodule diff. This code in builtin/log.c:

                if (!rev->reflog_info) {
                        /* we allow cycles in reflog ancestry */
                        free(commit->buffer);
                        commit->buffer = NULL;
                }

assumes we will only ever look at a commit once (except for
reflog-walking), but submodule diff violates that.

-Peff

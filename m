From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 00/28] clean-ups of static functions and returns
Date: Mon, 14 Aug 2006 16:05:18 -0700
Message-ID: <7vlkpqdikx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608141314350.19383@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 01:05:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GClUr-00007u-6p
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 01:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWHNXFV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 19:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWHNXFV
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 19:05:21 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:51631 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S965038AbWHNXFV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 19:05:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814230519.HMIT27846.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 19:05:19 -0400
To: David Rientjes <rientjes@google.com>
In-Reply-To: <Pine.LNX.4.63.0608141314350.19383@chino.corp.google.com> (David
	Rientjes's message of "Mon, 14 Aug 2006 13:17:16 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25421>

David Rientjes <rientjes@google.com> writes:

> This patch series cleans up a number of static function
> returns that are either meaningless or could be more
> efficiently written.

Interesting.  Did you use some automated tool to spot them?

I see two categories of changes in your series.

 * Making stricter error checking in the future harder.  There
   are three classes, but the lines between them are fuzzy.

        [PATCH 04/28] builtin-diff.c cleanup
        [PATCH 06/28] make cmd_log_walk void
        [PATCH 07/28] builtin-mailinfo.c cleanup
        [PATCH 09/28] makes prune_dir void
        [PATCH 11/28] makes append_ref and show_indepedent void
        [PATCH 12/28] makes generate_tar void
        [PATCH 13/28] builtin-unpack-objects.c cleanup
        [PATCH 14/28] make do_reupdate void
        [PATCH 16/28] daemon.c cleanup
        [PATCH 17/28] makes diff_cache void
        [PATCH 19/28] makes finish_pack void
        [PATCH 20/28] makes fetch_pack void
        [PATCH 23/28] makes peek_remote void

   The callers of the first group check their return values, so
   we could make error checking of these functions stricter in
   the future without affecting the rest of the code.  The ones
   that currently die() (or usage()) could be made into more
   libified form to return error codes.

   So I do not think it is worth doing these.
   
        [PATCH 03/28] makes checkout_all void
        [PATCH 15/28] makes sha1flush void
        [PATCH 21/28] makes fsck_dir void
        [PATCH 25/28] makes pack_objects void
        [PATCH 27/28] makes track_tree_refs void
        [PATCH 28/28] makes upload_pack void

   The callers of the second group do not check their return
   values, so making them void for now is fine, but if we wanted
   to make error checking of these functions stricter in the
   future, we would need to change them back and update the
   callers.

        [PATCH 02/28] makes pprint_tag void
	[PATCH 26/28] makes show_entry void

   These, strictly speaking, fall in the second category, but I
   do not think of a reasonable graceful error return case from
   them.  show_entry() dies when it cannot continue upon
   encountering a corrupt tree, which I think is reasonable.  So
   I think the change to make these void makes sense.

   I said the lines between these three categories are fuzzy.
   If we look at the functions more closely, I am reasonably
   sure that we would find some from the first and the second
   categories do not have a reasonable graceful error return
   case from them, in which case making them void would become
   reasonable like you did.

 * Style and readability.

        [PATCH 01/28] blame.c return cleanup
        [PATCH 05/28] builtin-grep.c cleanup
        [PATCH 08/28] remove conditional return
        [PATCH 10/28] builtin-push.c cleanup
        [PATCH 15/28] makes sha1flush void
        [PATCH 18/28] diff.c cleanup
        [PATCH 22/28] http-push.c cleanup
        [PATCH 24/28] read-cache.c cleanup

   Most of them use the well established idiom, "return
   !!(something)", and I think they are fine (15/28 do not even
   need !! -- the function already returns 0 or 1).

   I personally feel the original is more readable for 08/28.

   Of course, this distinction is subjective.

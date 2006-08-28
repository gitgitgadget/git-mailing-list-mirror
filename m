From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Refactor sha1_pack_index_name and sha1_pack_name to use a common backend
Date: Sun, 27 Aug 2006 21:40:36 -0700
Message-ID: <7vlkp9tquz.fsf@assigned-by-dhcp.cox.net>
References: <20060828001610.GC20904@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 28 06:40:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHYuu-00045G-7x
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 06:40:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWH1EkE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Aug 2006 00:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932339AbWH1EkE
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Aug 2006 00:40:04 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:58605 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932335AbWH1EkD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Aug 2006 00:40:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060828044002.UDKQ6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Mon, 28 Aug 2006 00:40:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id FGg01V0054Noztg0000000
	Mon, 28 Aug 2006 00:40:00 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20060828001610.GC20904@diku.dk> (Jonas Fonseca's message of
	"Mon, 28 Aug 2006 02:16:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26140>

Jonas Fonseca <fonseca@diku.dk> writes:

> This adds another pair of static buffers, if that's a problem and the
> cleanup is still wanted I can change it to use malloc.

To be perfectly honest, I would rather get rid of these two
functions, and also sha1[] member from struct packed_git.

The real core git does not impose any limit to the name of the
packfiles, other than that the name of the datafile ends with
".pack" and that its corresponding pack index file has the same
name ending with ".idx".  It is only the packfile support which
was later bolted on to commit walkers by commit bf592c5 that
introduced this silly expectation that they are always of form
"pack-[0-9a-f]{40}.pack" and "pack-[0-9a-f]{40}.idx".

For example, fetch_pack() in local-fetch.c is given an object
name and tries to find the packfile that contains it by looking
at ".idx" files downloaded from the other side.  When it finds
one, it fabricates a name for the pack file by what is in
target->sha1 (where target is of type "struct packed_git").

However, struct packed_git already has perfectly good place that
is meant to store the real name of the packfile, so this is
totally unnecessary.

As a clean-up, I'd rather see a patch that removes the need for
these two functions and one struct member, rather than keeping
these two misguided functions and consolidating their
implementations.

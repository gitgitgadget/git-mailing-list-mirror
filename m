From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: New diff-delta.c implementation
Date: Sat, 22 Apr 2006 10:29:55 -0700
Message-ID: <7vslo5ikmk.fsf@assigned-by-dhcp.cox.net>
References: <602974A9-09A3-46E9-92D6-D30728923C11@adacore.com>
	<Pine.LNX.4.64.0604212308080.2215@localhost.localdomain>
	<A856A2C5-2BD7-4DC5-9CCC-CD53E9A2623C@adacore.com>
	<7v7j5hkglq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604220835190.2215@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 22 19:30:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXLvk-0000kS-F6
	for gcvg-git@gmane.org; Sat, 22 Apr 2006 19:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWDVR36 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 13:29:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbWDVR35
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 13:29:57 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:38863 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750820AbWDVR35 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Apr 2006 13:29:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060422172956.UOVI16517.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Apr 2006 13:29:56 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0604220835190.2215@localhost.localdomain> (Nicolas
	Pitre's message of "Sat, 22 Apr 2006 08:45:07 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19040>

Nicolas Pitre <nico@cam.org> writes:

> Well, actually I was measuring a 10% speed improvement with a quick and 
> naive (not memory efficient) approach for pack-objects with the current 
> algorithm.
>...
> The idea to avoid memory pressure is to reverse the window processing 
> such that the object to delta against is constant for the entire window 
> instead of the current logic where the target object is constant.  This 
> way there would be only one index in memory at all time.

Your are right.  The first led to the latter unexplored idea.

I expect to be offline most of the day today, and have other
things I can work on for the next few days anyway, so if you or
somebody else have an inclination and energy to reverse the
delta window, I would appreciate that.

Maybe the calling convention of diff-delta.c would become
something like this?

struct delta_index; /* opaque to the caller; implementation
		     * defines what's in it.
                     */

/* returns a newly allocated struct delta_index.
 * input "buf" pointer can be stored in the struct, but "buf"
 * does not belong to diff-delta module (i.e. borrowed reference).
 */
struct delta_index *delta_index(
  void *buf,			/* input: from buffer */
  unsigned long size,		/* input: from size */
);

/* ... so free the structure and its internal data, but
 * do not free the borrowed reference!
 */
void free_delta_index(struct delta_index *);

/* Take "from", an already preprocessed delta_index for the
 * traditional from_buffer/from_size, and to_buf/to_size, and
 * produce delta in newly allocated buffer (caller should
 * free() when it is done), and return the result size in
 * *delta_size.  Stop early if the result would exceed max_size.
 */
void *diff_delta(
    struct delta_index *from,	/* input: prepared by delta_index() */
    void *to_buf,		/* input: destination buffer */
    unsigned long to_size,	/* input: destination size */
    unsigned long *delta_size,	/* output: result size */
    unsigned long max_size	/* input: do not waste cycles if
                                   you cannot generate result
                                   smaller than this */
);

and the calling convention would be:

	struct unpacked *s, *d;
	unsigned long max_size;

	/* precompute the index */
	struct delta_index *src = delta_index(s->data, s->entry->size);

	/* do the delta */
        void *delta_buf = diff_delta(src, d->data, d->entry->size,
                                     &sz, max_size);
        /* do useful thing here on delta_buf and sz */
        free(delta_buf);

	/* the caller can reuse *src with other *d,
         * but when it is done...
         */
        free_delta_index(src);

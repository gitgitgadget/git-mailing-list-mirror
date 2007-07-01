From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Non-http dumb protocols
Date: Sat, 30 Jun 2007 19:58:19 -0700
Message-ID: <7vbqewakz8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0706301613410.14638@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Jul 01 04:58:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4pdo-0008Ob-Uw
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 04:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754992AbXGAC6V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 22:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754976AbXGAC6V
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 22:58:21 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:57769 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956AbXGAC6U (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 22:58:20 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070701025820.QTBA1257.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Sat, 30 Jun 2007 22:58:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id J2yK1X0021kojtg0000000; Sat, 30 Jun 2007 22:58:19 -0400
In-Reply-To: <Pine.LNX.4.64.0706301613410.14638@iabervon.org> (Daniel
	Barkalow's message of "Sat, 30 Jun 2007 16:19:00 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51268>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Do we actually support local-fetch and ssh-fetch/ssh-push any more? They 
> seem to me to have been entirely supplanted with respect to functionality 
> for a long time now, but the programs are still there. This complicates 
> http-fetch, because only one -fetch can be linked into a binary as 
> currently designed, and we may want to make http-fetch builtin at some 
> point. Can we remove the other dumb protocols and merge fetch.c into 
> http-fetch.c?

I have a feeling that nobody uses commit walkers other than
http.  I do not see a point in ssh-fetch/push (we said it is
deprecated long time ago, and I was just too lazy to propose and
actually remove it when I did 1.5.2).  local-fetch _might_ be
useful as a debugging tool when you have trouble not related to
libcurl in http-fetch, but other than that I do not see a point
to it either.  

I am personally Ok with removing them on the sole basis of "they
are practically disused"; but there may be people on the list
with different opinions (at least here, they are not stupid nor
ugly).

However, from "technical" point of view, I do not think the
commit walker framework "fetch.c" is beyond salvaging, as you
make it sound, to make it a built-in.  The commit walker
framework was your work IIRC, so this may be preaching to the
choir, but my understanding is that it wants the following
functions defined in the transport backend module:

    extern int fetch(unsigned char *sha1);
    extern void prefetch(unsigned char *sha1);
    extern int fetch_ref(char *ref, unsigned char *sha1);

and exports the following symbols to be set:

    extern int get_tree;
    extern int get_history;
    extern int get_all;
    extern int get_verbosely;
    extern int get_recover;

I think you could define

	struct fetch_backend {
		int (*fetch_fn)(const unsigned char *);
		void (*prefetch_fn)(const unsigned char *);
		int (*fetch_ref_fn)(const char *, const unsigned char *);
		int get_tree;
		int get_history;
		int get_all;
		int get_verbosely;
		int get_recover;
	};

and have the backend "main()" pass a pointer to it to functions
pull(), pull_targets_stdin() and such, that are defined in
fetch.c.  That way, you can have multiple backend linked in.

To be linked with the rest of git, I think the global symbols
fetch.c has are named a little too generically, and they would
need to be fixed first.  It may make sense to do the "backend
descriptor" code restructure first _before_ linking anything
with the rest of git.  We can rename main() in *-fetch.c to
cmd_*_fetch() only for the ones that we choose to make built-in
when the conversion is ready.

Having said that, I have a feeling that many people do not build
any of the commit walkers, and especially the http walker,
because they have no need for dumb protocols, and libcurl-dev is
just another piece of dependency they do not have to have.  If
we were to do a built-in http-fetch, we also need to make sure 
it is done in such a way that people can choose to configure it
out.

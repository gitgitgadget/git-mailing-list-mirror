From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-diff-*: Allow "--name-only -z" as alias for "--name-only-z"
Date: Thu, 14 Jul 2005 16:11:39 -0700
Message-ID: <7vmzop56fo.fsf@assigned-by-dhcp.cox.net>
References: <20050714215126.GY9915@kiste.smurf.noris.de>
	<7vvf3d6nis.fsf@assigned-by-dhcp.cox.net>
	<20050714223622.GZ9915@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 15 01:14:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DtCtd-0000dk-F7
	for gcvg-git@gmane.org; Fri, 15 Jul 2005 01:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbVGNXNN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 19:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262821AbVGNXNA
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 19:13:00 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:6542 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S262639AbVGNXLl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 19:11:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050714231137.MUJL17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 14 Jul 2005 19:11:37 -0400
To: Matthias Urlichs <smurf@smurf.noris.de>
In-Reply-To: <20050714223622.GZ9915@kiste.smurf.noris.de> (Matthias Urlichs's message of "Fri, 15 Jul 2005 00:36:23 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matthias Urlichs <smurf@smurf.noris.de> writes:

> Exactly the same thing as vice versa.
> Or, even more exactly, my patch *makes* that happen. ;-)

Ah, I was not being careful enough.  Sorry.

That said, I have been hating that diff options parsing for
quite a while, and I've been thinking about cleaning it up along
the lines I'll outline here, but have not done anything about
it.  Care to help me out?

 - In diff.h introduce these new stuff:

     struct diff_opts {
     int output_format;
     int detect_rename;
     ...
     };
     void diff_opts_init(struct diff_opts *);
     int diff_opts_parse(const char *, struct diff_opts *);
     int diff_opts_final(struct diff_opts *);

 - In diff-* brothers:

   - replace individual diff option variables with a single
     "static struct diff_opts diff_opts";

   - change the argument parsing code to do the following:

     diff_opts_init(&diff_opts);
     for each arg {
         /* common options to diff brothers are handled by
          * diff_opts_parse()
          */
         switch (diff_opts_parse(arg, &diff_opts)) {
         case 1: /* was a diff option and was parsed successfully */
         	continue;
         case -1: /* error */
                usage(diff_*_usage);
         }
         if (!strcmp())
              ... parsing of other options
     }
     if (diff_opts_final(&diff_opts))
         /* defaulting to HUMAN format when nothing specified,
          * complaining if find-copies-harder is specified but
          * -C was not, etc. is done in diff_opts_final().
          *
          * The complex if() chains that checks if we are in
          * name or in raw mode and switch output_format around
          * properly is what I missed in your patch, but I think
          * you can lose that by recording z-ness of the output
          * independently from the output format in diff_opts_parse()
          * and combining diff-raw vs diff-name and z vs non-z
          * in diff_opts_final().  That would make the code much
          * simpler.
          */
         usage(diff_*_usage);

 - In diff.h and diff.c, replace individual option parameters
   for the following functions to a single pointer to struct
   diff_opts:

     diff_setup(), diffcore_std(), diffcore_std_no_resolve(), diff_flush().  

We probably can make diff_scoreopt_parse() function static to
diff.c once this is done.

We may want to rip out the independeant pickaxe, orderfile and
filter support for diff-helper while we are at it, making it
truly just a "diff-raw to diff-patch" converter.

Hmm?

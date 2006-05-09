From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitopt - command-line parsing enhancements
Date: Tue, 09 May 2006 13:28:23 -0700
Message-ID: <7vr7332ba0.fsf@assigned-by-dhcp.cox.net>
References: <1147151209168-git-send-email-normalperson@yhbt.net>
	<7vzmhr7fys.fsf@assigned-by-dhcp.cox.net>
	<20060509194825.GC3676@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 22:28:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdYom-0007hJ-Nh
	for gcvg-git@gmane.org; Tue, 09 May 2006 22:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWEIU2Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 16:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWEIU2Z
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 16:28:25 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:5063 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751129AbWEIU2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 May 2006 16:28:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060509202824.XIHV17501.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 9 May 2006 16:28:24 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060509194825.GC3676@localdomain> (Eric Wong's message of "Tue,
	9 May 2006 12:48:25 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19848>

Eric Wong <normalperson@yhbt.net> writes:

>> And scary, especially the "eat" macros are very scary.
>
> They look weird at first, but I think they help readability and
> maintainability once you get used to them.  They let you focus on the
> important part of the function while hiding the boring parts from you.
> Quite elegant, imho.

Sorry, there is no elegance to it as far as I can see.  A macro
invocation that creates a private function while it does not
look like a function definition is already bad, you cannot have
a comma in the stmt part, and the bare semicolons in the
parenthesised text look insane.

If your patch were like this, it would have been a bit easier
for me to understand what was going on during my first pass:

    static struct exec_args *ui_optparse
            (struct opt_spec *s, int ac, char **av, int *ac_p, int what)
    {
            struct exec_args *ea = one_arg(s, ac, av, ac_p);
            if (!ea) return NULL;
            switch (what) {
            case IGNORE_MISSING:
                    not_new = 1; break;
            case VERBOSE:
                    verbose = 1; break;
            case HELP:
                    usage(update_index_usage); break;
            }
            return nil_exec_args(ea);
    }

instead of

    gitopt_eat(opt_ignore_missing, not_new = 1;)
    gitopt_eat(opt_verbose, verbose = 1;)
    gitopt_eat(opt_h, usage(update_index_usage);)

Then, you would give an extra element in the table, and your
argument parsing/splitting routine passes that one to the
handler function:

    static const struct opt_spec update_index_ost[] = {
    ...
    { "ignore-missing", 0,	0, 0, ui_optparse, IGNORE_MISSING },
    { "verbose",	    0,	0, 0, ui_optparse, VERBOSE },
    { "help",	   'h',	0, 0, ui_optparse, HELP },
    { 0, 0 }

Another thing is I do not think we would want to make the
argument parsing into callback style interface like you did.  It
actively encourages the option variables to be global (you could
make it file scoped static but they are global nevertheless).
If you can make it an iterator style, it would be a lot easier
to see what is going on, I suspect.  Then you would not even
need the callback function pointers and small functions created
by magic eat() macros.

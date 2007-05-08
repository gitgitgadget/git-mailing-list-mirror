From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --no-reuse-delta, --window, and --depth options to
Date: Tue, 08 May 2007 14:12:56 -0700
Message-ID: <7vwszj10kn.fsf@assigned-by-dhcp.cox.net>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
	<11786309073709-git-send-email-tytso@mit.edu>
	<alpine.LFD.0.99.0705081005400.24220@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Ts'o <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue May 08 23:13:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlX0K-0005yT-Kl
	for gcvg-git@gmane.org; Tue, 08 May 2007 23:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032209AbXEHVNH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 17:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032239AbXEHVNG
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 17:13:06 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:42265 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032209AbXEHVNE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 17:13:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508211302.PFPZ2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 8 May 2007 17:13:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id wlCw1W0061kojtg0000000; Tue, 08 May 2007 17:13:00 -0400
In-Reply-To: <alpine.LFD.0.99.0705081005400.24220@xanadu.home> (Nicolas
	Pitre's message of "Tue, 08 May 2007 11:30:31 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46628>

Nicolas Pitre <nico@cam.org> writes:

> In which case, it is git-gc that needs to get a bit smarter.  Maybe 
> something like this:

I agree git-gc should be tuned to "one size fits all well enough"
default, rather than getting more complicated parameters to fine
tune its behaviour to satisfy power users.

> @@ -65,7 +65,20 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  	if (run_command_v_opt(argv_reflog, RUN_GIT_CMD))
>  		return error(FAILED_RUN, argv_reflog[0]);
>  
> -	if (run_command_v_opt(argv_repack, RUN_GIT_CMD))
> +	if (num_loose_objects() > 0) {
> +		do_repack = 1;
> +	} else {
> +		struct packed_git *p;
> +		unsigned long num_pack = 0;
> +		if (!packed_git)
> +			prepare_packed_git();
> +		for (p = packed_git; p; p = p->next)
> +			if (p->pack_local)
> +				num_pack++;
> +		if (num_pack > 1)
> +			do_repack = 1;
> +	}
> +	if (do_repack && run_command_v_opt(argv_repack, RUN_GIT_CMD))
>  		return error(FAILED_RUN, argv_repack[0]);
>  
>  	if (prune && run_command_v_opt(argv_prune, RUN_GIT_CMD))

Is this even correct?

When your repository is fully packed, if you decided to discard
one of your topic branches with "git branch -D", what does this
code do?  We see no loose objects, we see only one pack, so the
unreachable objects are left in the pack?

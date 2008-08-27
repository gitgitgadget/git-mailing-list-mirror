From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-shortlog hangs on bare repo without --bare option
Date: Wed, 27 Aug 2008 16:16:32 -0700
Message-ID: <7v8wuim4kv.fsf@gitster.siamese.dyndns.org>
References: <20080827195233.GA2477@garry-thinkpad.arpnetworks.com>
 <48B5C9E4.4030807@lsrfire.ath.cx> <7vvdxmm78o.fsf@gitster.siamese.dyndns.org>
 <7vod3em67d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng?= =?utf-8?Q?=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 01:18:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYUGo-0003q6-E4
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 01:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754041AbYH0XQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 19:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753848AbYH0XQm
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 19:16:42 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41119 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753960AbYH0XQl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 19:16:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 63D386A74A;
	Wed, 27 Aug 2008 19:16:40 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 316976A748; Wed, 27 Aug 2008 19:16:34 -0400 (EDT)
In-Reply-To: <7vod3em67d.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 27 Aug 2008 15:41:26 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3461C7DE-748E-11DD-ACBD-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93979>

Junio C Hamano <gitster@pobox.com> writes:

> And I think this is related to the complexity that snuck in when worktree
> feature was added to the setup sequence.
>
> Untested, but I think this would help.

While this might help, I see there are more serious issues here.

If you start "git-shortlog" (or anything that has USE_PAGER but not
RUN_SETUP in git.c) inside your project/.git directory (or a bare one, for
that matter), the call sequence would become like this:

git.c::main()
 -> handle_internal_command()
   -> run_command()
     -> commit_pager_choice()
       -> setup_pager() (this is in pager.c)
         -> git_config(git_default_config, NULL)
           -> git_path("config")
             -> get_git_dir()
               -> setup_git_env()
                 This sets git_dir to ".git"!!!!

And that was part of the reason why "git-shortlog" started from a bare
repository did not even notice that the default "HEAD" that is given
internally by the program is not a valid ref (because it tries to read
from .git/HEAD without the patch I sent earlier).  Oh, of course that
git_config() won't read from the right config file either.

This may be repeating what Jeff said earlier in another thread, but I
think we should rethink the start-up sequence carefully.  Ideally (I am
thinking aloud)...

 * Have a single function "git_setup()" that notices --bare and --git-dir
   from the command line and GIT_DIR environment, and does the discovery
   of git_dir (if not told with the command line or environment
   explicitly); if we do not find it, do *NOT* barf.  Just record the
   facts it finds somewhere (e.g. the location of git_dir, absense of
   git_dir, if the repository is explicitly bare, etc.).

 * As the next step, still in this single function, if we have git_dir,
   find out where the work_tree is, paying attention to --work-tree from
   the command line and GIT_WORK_TREE environment if exists.  If we do not
   have work tree, do *NOT* barf.  Again, just record the facts it finds.
   If we do not have --work-tree from the command line and if we are not
   told that it is --bare from the command line, then we may need to open
   the config to see where core.worktree points at.

 * Before returning from that single setup function, i think it is Ok to
   make it mimick the current git_setup_directory_gently(), cd up to the
   normal work-tree top if needed, and make it return prefix.

 * After all of the above is done, then we can start futzing with other
   things such as pager.  At that point we know we can read from the
   correct configuratoin.

 * Each individual command may decide to refuse to work in the absense of
   git_dir and/or work_tree, by calling require_work_tree(), etc.

Hmm?

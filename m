From: Xavier Maillard <xma@gnu.org>
Subject: Re: [PATCH] help: implement multi-valued "man.viewer" config option
Date: Wed, 12 Mar 2008 02:00:06 +0100
Organization: GNU's Not UNIX!
Message-ID: <200803120100.m2C105YM010496@localhost.localdomain>
References: <20080311085113.176df1af.chriscool@tuxfamily.org>
Reply-To: Xavier Maillard <xma@gnu.org>
Cc: junkio@cox.net, pascal@obry.net, nanako3@bluebottle.com,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Mar 12 02:36:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZFtU-0001ON-5P
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 02:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750985AbYCLBf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 21:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbYCLBf4
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 21:35:56 -0400
Received: from master.uucpssh.org ([193.218.105.66]:49212 "EHLO
	master.uucpssh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbYCLBfz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 21:35:55 -0400
Received: by master.uucpssh.org (Postfix, from userid 10)
	id 904E0C97EA; Wed, 12 Mar 2008 02:34:12 +0100 (CET)
Received: from localhost.localdomain (IDENT:1000@localhost [127.0.0.1])
	by localhost.localdomain (8.14.1/8.13.8) with ESMTP id m2C1071q010499;
	Wed, 12 Mar 2008 02:00:07 +0100
Received: (from xma@localhost)
	by localhost.localdomain (8.14.1/8.13.8/Submit) id m2C105YM010496;
	Wed, 12 Mar 2008 02:00:06 +0100
In-reply-to: <20080311085113.176df1af.chriscool@tuxfamily.org> (message from
	Christian Couder on Tue, 11 Mar 2008 08:51:12 +0100)
User-Agent: Rmail in GNU Emacs 23.0.60.2 on GNU/Linux
Jabber-ID: xma01@jabber.fr
X-uucpssh: Found to be clean
X-uucpssh-SpamCheck: not spam, SpamAssassin (not cached, score=-4.39,
	required 4.6, autolearn=not spam, ALL_TRUSTED -1.80, AWL 0.01,
	BAYES_00 -2.60, SPF_HELO_PASS -0.00)
X-uucpssh-From: xma@gnu.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76903>


   Junio suggested:
   > How about allowing multi-valued man.viewer like this:
   >
   >        [man]
   >                viewer = woman
   >                viewer = konqueror
   >                viewer = man
   >
   > and have:
   >
   >        static struct man_viewer {
   >                char *name;
   >                void (*exec)(const char *);
   >        } viewers[] = {
   >                { "woman", exec_woman },
   >                { "konqueror", exec_konqueror },
   >                { "man", exec_man },
   >                { NULL, },
   >        };
   >
   > Then you can iterate the man.viewer values, ask the viewer's
   > exec() function to show the page (or return when it is not
   > in an environment that it can be useful).
   >
   > show_man_page() would become:
   >
   >        for (each viewer in user's config)
   >                viewer.exec(page); /* will return when unable */
   >        die("no man viewer handled the request");

   This patch implements the above using a list of exec functions that
   is filled when reading the config.

   To do that the exec functions have been moved before reading the
   config. This makes the patch much longer than it would be otherwise.

   Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Tested-by: Xavier Maillard <xma@gnu.org>

Though, I thought that when one entry had failed we would have
switched to the next until none could be found thus 

I (voluntary) made a typo in my .git/config file as reflected by:

[xma@localhost 23:57:18 git]$ git config --get-all man.viewer
woma  <- TYPO HERE
konqueror
man

and I then tried git config --help. I thought it would have tried
all entries and as a last resort would have failed back to man
but it did not act like this:

[xma@localhost 23:57:11 git]$ git config --help
error: 'woma': unsupported man viewer.
fatal: bad config file line 16 in .git/config

Ok, woma in not supported here and it is reported like this but
would it be possible to just throw an error on stdout and try
another viewer ? We could even imagine something even more
general like the possibility for the user to write his own man
viewer (a bash script for example) and set it as a candidate.

By the way, I do not see any reason to put man as a candidate.
"man" should be the default when nothing is specified or when all
candidates have failed.

Anyway, thank you for this implementation.

	Xavier
-- 
http://www.gnu.org
http://www.april.org
http://www.lolica.org

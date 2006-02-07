From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Cogito] Various bugs
Date: Mon, 06 Feb 2006 19:03:00 -0800
Message-ID: <7v8xsn50rf.fsf@assigned-by-dhcp.cox.net>
References: <20060131041318.GC30744@diku.dk>
	<20060207003643.GJ31278@pasky.or.cz>
	<7vfymw3oym.fsf@assigned-by-dhcp.cox.net>
	<20060207021006.GM31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 07 04:03:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6J8J-000429-SN
	for gcvg-git@gmane.org; Tue, 07 Feb 2006 04:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWBGDDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 22:03:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWBGDDE
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 22:03:04 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:48045 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964943AbWBGDDC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2006 22:03:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060207030027.PQME26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Feb 2006 22:00:27 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060207021006.GM31278@pasky.or.cz> (Petr Baudis's message of
	"Tue, 7 Feb 2006 03:10:06 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15678>

Petr Baudis <pasky@suse.cz> writes:

>> > I'm puzzled. GIT should handle this fine.
>> >
>> > 	export GIT_AUTHOR_NAME=''
>> > 	git-commit-tree $(cg-object-id -t)
>> >
>> > works as expected, but for some reason escaping me it does not work
>> > inside of cg-commit. Insights welcomed.
>> ...
> Thanks, I've updated the cg-commit version. Note that the empty
> GIT_AUTHOR_NAME problem seems to exist in git-commit as well.

It depends on what you expect, but it meets _my_ expectation:

    $ GIT_AUTHOR_NAME='' git-commit-tree $(git-write-tree) </dev/null
    Committing initial tree a2b59c3848164a2c9c3c75fbaadccaed9485da92
    ef90563fa278735af367e7606ea7eb2559121ca7
    $ git-cat-file commit ef90563fa278735af367e7606ea7eb2559121ca7
    tree a2b59c3848164a2c9c3c75fbaadccaed9485da92
    author  <junkio@cox.net> 1139281078 -0800
    committer Junio C Hamano <junkio@cox.net> 1139281078 -0800

That is, the user said GIT_AUTHOR_NAME is empty, so he gets a
commit with an empty author name.

get_ident() in ident.c does this. getenv("GIT_AUTHOR_NAME") and
friends are passed to it, and git_default_* are takenfrom gecos.
It might match some peoples' expectation (but not mine) if we
did this instead.


diff --git a/ident.c b/ident.c
index 0461b8b..7ec7516 100644
--- a/ident.c
+++ b/ident.c
@@ -163,9 +163,9 @@ static const char *get_ident(const char 
 	char date[50];
 	int i;
 
-	if (!name)
+	if (!name || !*name)
 		name = git_default_name;
-	if (!email)
+	if (!email || !*email)
 		email = git_default_email;
 	strcpy(date, git_default_date);
 	if (date_str)

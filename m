From: Junio C Hamano <junkio@cox.net>
Subject: minimize_url in git-svn?
Date: Tue, 08 May 2007 02:58:32 -0700
Message-ID: <7v4pmn4oxj.fsf_-_@assigned-by-dhcp.cox.net>
References: <C05C5EF4-EC68-490B-946E-630117393F4E@drhanson.net>
	<463F6A95.30207@midwinter.com>
	<9fb1551c0705072048u3ff85ea7n5166596855b8f322@mail.gmail.com>
	<464023D4.5060101@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 08 11:58:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlMSt-00059J-UG
	for gcvg-git@gmane.org; Tue, 08 May 2007 11:58:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934980AbXEHJ6e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 05:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934981AbXEHJ6e
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 05:58:34 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51671 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934980AbXEHJ6d (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 05:58:33 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070508095832.EUUV6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 8 May 2007 05:58:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id wZyY1W00B1kojtg0000000; Tue, 08 May 2007 05:58:32 -0400
In-Reply-To: <464023D4.5060101@midwinter.com> (Steven Grimm's message of "Tue,
	08 May 2007 00:16:36 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46558>

I was trying to run git-svn against this:

	https://repo.socialtext.net:8999/svn/socialtext/trunk

This is an open source project [*1*] and the trunk is supposed
to be readable by everybody, but it seems that anything outside
that area needs authentication.  If I mimick the example in
git-svn.txt manual page to clone from there, it creates trunk,
trunk/.git, and then asks for password:

	$ URL=https://repo.socialtext.net:8999/svn/socialtext/trunk
	$ git-svn clone $URL
        Authentication realm: <https://repo.socialtext.net:8999> Auth for SVN
	Password for 'junio': ^C

I've narrowed it down to this part of git-svn.  If I tell it not
to bother "minimiz"ing the URL, it seems to import without
stepping outside of the URL it was given.

--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1038,7 +1038,8 @@
 		}
 		$self->{repo_id} = $existing;
 	} else {
-		my $min_url = Git::SVN::Ra->new($url)->minimize_url;
+		my $ra = Git::SVN::Ra->new($url);
+		my $min_url = $url; # $ra->minimize_url;
 		$existing = find_existing_remote($min_url, $r);
 		if ($existing) {
 			unless ($no_write) {

Two and half questions.

 * What does minimize do, and why is it necessary?

 * The resulting git-svn remote tracking branch (and 'master')
   seems to check out fine, but I do not know what damage the
   hack to avoid minimizing is causing.  Are there any?  I see
   many 0{40} lines in trunk/.git/svn/git-svn/.rev_db.* file,
   and also many lines in unhandled.log file (+empty_dir,
   +file_prop, and +dir_prop).  Are these something to worry
   about?

 * Assuming there aren't any damage, or maybe some damage that
   would cause minor decreased functionality/interoperability,
   would it perhaps make sense to optionally allow skipping the
   minimizing to avoid this problem?  Would it make sense, or is
   the setting at socialtext site too esoteric and it isn't
   worth to worry about?


[Footnote]

*1* http://www.socialtext.net/stoss/index.cgi?developing_with_a_dev_env

From: Fredrik Skolmli <fredrik@frsk.net>
Subject: Re: git svn --use-log-author misbehavior?
Date: Fri, 20 Jun 2008 10:56:18 +0200
Message-ID: <20080620085618.GA27940@frsk.net>
References: <485AF10B.7060202@mircea.bardac.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mircea Bardac <dev@mircea.bardac.net>
X-From: git-owner@vger.kernel.org Fri Jun 20 11:30:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9cwm-0003Vp-Qi
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 11:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbYFTJ3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 05:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbYFTJ3S
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 05:29:18 -0400
Received: from cassarossa.samfundet.no ([129.241.93.19]:51152 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751641AbYFTJ3R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 05:29:17 -0400
X-Greylist: delayed 1976 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Jun 2008 05:29:17 EDT
Received: from asterix.samfundet.no ([2001:700:300:1800::f] ident=postfix)
	by cassarossa.samfundet.no with esmtp (Exim 4.63)
	(envelope-from <fredrik@frsk.net>)
	id 1K9cPq-0008EA-Rb; Fri, 20 Jun 2008 10:56:19 +0200
Received: by asterix.samfundet.no (Postfix, from userid 1000)
	id 97A4DA6039D; Fri, 20 Jun 2008 10:56:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <485AF10B.7060202@mircea.bardac.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85610>

On Fri, Jun 20, 2008 at 12:51:39AM +0100, Mircea Bardac wrote:
> Hi,
> 
> According to the documentation, this parameter (--use-log-author) should 
>  use the author from the From/Signed-off-by line. Unfortunately, I 
> found this to be working only on the first git svn clone. Later rebasing 
> made the commits use the old username@uuid format.
> 
> I am assuming the option is not being preserved in the Git repository 
> metadata and it is only used on cloning/init. Is this the intended 
> behavior?

Doesn't look like it. When you're using --add-author-from on dcommit, git-svn
doesn't seem to know that it should look after "From:" in the commit, thus
not setting the author correctly. The following oneliner should solve the
case. Please let me know if it works as well for you as it did for me.
 
Signed-off-by: Fredrik Skolmli <fredrik@frsk.net>
---
 git-svn.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index a54979d..8f77b91 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -432,6 +432,9 @@ sub cmd_dcommit {
 		     "without --no-rebase may be required."
 	}
 	while (1) {
+		if ($Git::SVN::_add_author_from) {
+			$Git::SVN::_use_log_author = 1;
+		}
 		my $d = shift @$linear_refs or last;
 		unless (defined $last_rev) {
 			(undef, $last_rev, undef) = cmt_metadata("$d~1");
-- 
1.5.6.6.gd3e97

-- 
Regards,
Fredrik Skolmli

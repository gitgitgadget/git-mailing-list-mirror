From: Igor Mironov <igor.a.mironov@gmail.com>
Subject: [PATCH 1/4] git-svn: fix the trivial case of 'src and dst not in
 the same repo' during branch/tag
Date: Tue, 12 Jan 2010 03:20:43 +1100
Message-ID: <4B4B4FDB.4000602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 17:20:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUN0k-0005oj-75
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 17:20:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083Ab0AKQUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 11:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890Ab0AKQUy
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 11:20:54 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:61007 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab0AKQUx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 11:20:53 -0500
Received: by bwz27 with SMTP id 27so391793bwz.21
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 08:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=kIEsUPqkcZEaSA7v33viD+LxvtJ9mXUmxMpME1C5shk=;
        b=bOxWEsXVhuz6mjhi3WCiIgM/Ix6IXClKwVe1bWcQeMv2eFT5oyo7wSkU6Fv+/KNWFq
         pS9iIDj3jk1eW3xuFBRNEiSTR6IJ5JLg2s7HYNufkd1BKqsoCnkjmR60vv13iSxh25vy
         JrILV+/VeeUXLxVj68kE4Q35i1C+17dpbGk8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=OEjEy3eULmpTDQunh5aMQAtHKAsZ2dETDCcPeOeQekCFj7i05gTUrmTzv5YItXDYCD
         tVF8PwOGaj8XOj5vEUL9YpDrhdhlYaa3YB/uZMhjTBriIqtXMkU2F7me+lBWyJ9ZgkQ8
         wVQIZiVxSmGK+O8Kz+gk6tVjZy23G+BHpTCqs=
Received: by 10.204.155.82 with SMTP id r18mr2200212bkw.180.1263226851710;
        Mon, 11 Jan 2010 08:20:51 -0800 (PST)
Received: from ?10.54.5.111? (ppp121-45-186-233.lns20.syd7.internode.on.net [121.45.186.233])
        by mx.google.com with ESMTPS id 15sm8910582bwz.0.2010.01.11.08.20.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Jan 2010 08:20:50 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136635>

This fixes the following issue:
$ git svn branch -t --username=svnuser --commit-url=https://myproj.domain.com/svn mytag
Copying http://myproj.domain.com/svn/trunk at r26 to https://myproj.domain.com/svn/tags/mytag...
Trying to use an unsupported feature: Source and dest appear not to be in the same repository (src: 'http://myproj.domain.com/svn/trunk'; dst: 'https://myproj.domain.com/svn/tags/mytag') at /usr/lib/git-core/git-svn line 623
Signed-off-by: Igor Mironov <igor.a.mironov@gmail.com>
---
 git-svn.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 650c9e5..3f7ccc1 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -710,6 +710,10 @@ sub cmd_branch {
 	my ($lft, $rgt) = @{ $glob->{path} }{qw/left right/};
 	my $dst = join '/', $remote->{url}, $lft, $branch_name, ($rgt || ());
 
+	if ($dst=~"^https:" && $src=~"^http:") {
+		$src=~s/^http:/https:/;
+	}
+
 	my $ctx = SVN::Client->new(
 		auth    => Git::SVN::Ra::_auth_providers(),
 		log_msg => sub {
-- 
1.6.6.106.ge2de8

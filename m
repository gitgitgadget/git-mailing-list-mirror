From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix handling of $file_name in feed generation
Date: Fri, 3 Aug 2007 19:50:42 +0200
Message-ID: <200708031950.43126.jnareb@gmail.com>
References: <20070803020555.GB8593@dervierte> <200708031110.55969.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Robert Fitzsimons <robfitz@273k.net>,
	Junio Hamano <gitster@pobox.com>
To: Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 04 01:28:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH6Zc-00024B-1y
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 01:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757315AbXHCX2p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 19:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755805AbXHCX2p
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 19:28:45 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:54638 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401AbXHCX2o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Aug 2007 19:28:44 -0400
Received: by nf-out-0910.google.com with SMTP id g13so254160nfb
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 16:28:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MrIgY8lZ9HHpgoev6BVrv1OzZgJp7Bzmpxc6zAPoArUlzv5/XnWM7ev4981L3fBluZXd4l33AR90SogPGC5zpdf9WVAhwVhm7cmHlGIABPgarEeU//xB0y7gd3noqQ0csCpPRwnXYc/6CdYavY+/Lno4rhDI32DHCurenjd+Qbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=eqOwRH8A9ntDYcLfD1fQRzHHWyNFXmwHQN5hbeOWU3xaJHcnvITq2aJ49ptJ0aCAnRQLHBAnh4MXwrrm+rcRch+FMTE15qBE02sqH5Q7ICLvMeQhSJuLV1HUoBghLfTMVD+kXbHAFgsk+1V1PVnATg+gwcbaemN1gO8Y5K3ElNs=
Received: by 10.86.89.4 with SMTP id m4mr2624866fgb.1186183722862;
        Fri, 03 Aug 2007 16:28:42 -0700 (PDT)
Received: from host-89-229-8-65.torun.mm.pl ( [89.229.8.65])
        by mx.google.com with ESMTPS id a37sm7349329fkc.2007.08.03.16.28.36
        (version=SSLv3 cipher=OTHER);
        Fri, 03 Aug 2007 16:28:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200708031110.55969.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54769>

>From 6ef05672bb1dd1fe1ded15707164eaac36772c21 Mon Sep 17 00:00:00 2001
From: Steven Walter <stevenrwalter@gmail.com>
From: Jakub Narebski <jnareb@gmail.com>
Date: Fri, 3 Aug 2007 19:35:00 +0200
Subject: [PATCH] gitweb: Fix handling of $file_name in feed generation

The commit b6093a5c, by Robert Fitzsimons:
  "gitweb: Change atom, rss actions to use parse_commits."
forgot to pass $file_name parameter to parse_commits subroutine.

If git_feed is provided a file name, it ought to show only the history
affecting that file or a directory.  The title was being set
correctly, but all commits from history were being shown.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Three comments. First, authorship. Steven Walter didn't signoff his patch,
and the contents differs a bit from second chunk of his patch (see
comment below) and I have added infor about which commit introduced this
bug to the commit message. I have added my signoff, you can take this
patch as either mine or Steven authorship.


Second, I have discarded first chunk in Steven patch because it was too
intrusive. As I have said, it makes 'file_name' default argument,
unless overriden. While it made sense for 'project' parameter to be made
default parameter in href(), as almost all URLs in gitweb needed it,
more than half URLs does not need 'file_name' parameter. And some of
those URLs are present in a views which do use 'file_name'.

So if we want alternative URLs for a feed preserve 'file_name' parameter,
or we want RSS/Atom links for "file_name" kind of views, like 'tree',
'blob' or 'history' views, we should add 'file_name' parameter
explicitely, and not change href() to do it implicitely.

But as we are in stabilization (freeze) stage, I'd rather not add any new
features. This one just fixes a bug in gitweb.


Third, I'd rather not use "--full-history" for feeds. We use it in the
'history' view for backward compatibility reasons; I'd rather leave it
for extra options in the feed. But this is also for after the release.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 498b936..4733728 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5365,7 +5365,7 @@ sub git_feed {
 
 	# log/feed of current (HEAD) branch, log of given branch, history of file/directory
 	my $head = $hash || 'HEAD';
-	my @commitlist = parse_commits($head, 150);
+	my @commitlist = parse_commits($head, 150, 0, undef, $file_name);
 
 	my %latest_commit;
 	my %latest_date;
-- 
1.5.2.4

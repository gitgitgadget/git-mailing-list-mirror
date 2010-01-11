From: Igor Mironov <igor.a.mironov@gmail.com>
Subject: [PATCH 2/4] git-svn: use commiturl in preference to url when constructing
 dst for branch/tag
Date: Tue, 12 Jan 2010 03:21:23 +1100
Message-ID: <4B4B5003.6070003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 17:21:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUN1N-000684-0B
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 17:21:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482Ab0AKQVd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2010 11:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751264Ab0AKQVc
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 11:21:32 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:42534 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab0AKQVc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2010 11:21:32 -0500
Received: by bwz27 with SMTP id 27so392511bwz.21
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 08:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=dHo7EcqzP8v3MpSZMBqL19z0yBBQpZ6/HBADMlkaEng=;
        b=RdE7d5Ne302Q+J9y+SHiUX2q8GmsAoYPhEhpBlD85mtRyNZlUrzBEzZdU0Z9bMoM6H
         BWRXqPYPGov61R4qtmoMuyRkEaklloMGqutlrCJ5BNklkRRJbMZVwdLH/vj34DS8Gaar
         3blypZQmbYGCU/Z2f0dYMXHa8ojTdyQ4aqfEM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=JHPgkW5GIKrs+bQKmZVRCyQ4db7/bZuMk9RRhWy9BtVf2PmSnaVdY+JYvCEy/SdRgU
         zAvo7SLmb1qw1hgG3hNxuLJcfY44HktR71jvga2Ci5VDt0G8jiI2714xg/faUPAvS10W
         pFA0pEvGk/oFkDhz6uKz3OKyHuz3fUwuXKzkc=
Received: by 10.204.131.91 with SMTP id w27mr2093606bks.193.1263226890085;
        Mon, 11 Jan 2010 08:21:30 -0800 (PST)
Received: from ?10.54.5.111? (ppp121-45-186-233.lns20.syd7.internode.on.net [121.45.186.233])
        by mx.google.com with ESMTPS id 16sm8925303bwz.11.2010.01.11.08.21.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 11 Jan 2010 08:21:29 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136636>

When constructing a destination URL, use the property 'commiturl' if it is specified in the configuration file; otherwise take 'url' as usual.  This accommodates the scenario where a user only wants to involve the writable repository in operations performing a commit and defaults everything else to a read-only URL.
Signed-off-by: Igor Mironov <igor.a.mironov@gmail.com>
---
 git-svn.perl |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index 3f7ccc1..3bdd8d3 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -708,7 +708,17 @@ sub cmd_branch {
 		}
 	}
 	my ($lft, $rgt) = @{ $glob->{path} }{qw/left right/};
-	my $dst = join '/', $remote->{url}, $lft, $branch_name, ($rgt || ());
+	my $url;
+	if (defined $_commit_url) {
+		$url = $_commit_url;
+	} else {
+		$url = eval { command_oneline('config', '--get',
+			"svn-remote.$gs->{repo_id}.commiturl") };
+		if (!$url) {
+			$url = $remote->{url};
+		}
+	}
+	my $dst = join '/', $url, $lft, $branch_name, ($rgt || ());
 
 	if ($dst=~"^https:" && $src=~"^http:") {
 		$src=~s/^http:/https:/;
-- 
1.6.6.106.ge2de8

From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: remove leading slashes from fetch lines in the generate config
Date: Sat, 14 Jul 2007 12:40:32 -0700
Message-ID: <20070714194031.GA5160@soma>
References: <f158199e0707131024o5eb27b72v900f0d0613bc834b@mail.gmail.com> <f158199e0707131205w358676e5j88f8e4c63b1be1f5@mail.gmail.com> <f158199e0707141159t290d3aa9g90c6799e98520f56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Bradford Smith <bradford.carl.smith@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 21:40:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9nTr-0006mu-Ii
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 21:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762402AbXGNTkf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 15:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762127AbXGNTkf
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 15:40:35 -0400
Received: from hand.yhbt.net ([66.150.188.102]:41828 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760924AbXGNTke (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 15:40:34 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 671602DC032;
	Sat, 14 Jul 2007 12:40:32 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 14 Jul 2007 12:40:32 -0700
Content-Disposition: inline
In-Reply-To: <f158199e0707141159t290d3aa9g90c6799e98520f56@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52500>

We were previously sensitive to leading slashes in the fetch
lines and incorrectly writing them to the config if the user
used them (needlessly) in the command-line.

This fixes the issue and allows us to play nicely with legacy
configs that have leading slashes in fetch lines.

Thanks to Bradford Smith for figuring this out for me:
>
> This works:
>
> git-svn clone https://my.server.net/repos/path/ -Ttrunk/testing
>   -ttags/testing -bbranches/testing testing
>
> This doesn't:
>
> git-svn clone https://my.server.net/repos/path -T/trunk/testing
>   -t/tags/testing -b/branches/testing testing

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 git-svn.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index b3dffcc..299b40f 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1026,7 +1026,9 @@ sub read_all_remotes {
 	my $r = {};
 	foreach (grep { s/^svn-remote\.// } command(qw/config -l/)) {
 		if (m!^(.+)\.fetch=\s*(.*)\s*:\s*refs/remotes/(.+)\s*$!) {
-			$r->{$1}->{fetch}->{$2} = $3;
+			my ($remote, $local_ref, $remote_ref) = ($1, $2, $3);
+			$local_ref =~ s{^/}{};
+			$r->{$remote}->{fetch}->{$local_ref} = $remote_ref;
 		} elsif (m!^(.+)\.url=\s*(.*)\s*$!) {
 			$r->{$1}->{url} = $2;
 		} elsif (m!^(.+)\.(branches|tags)=
@@ -1146,6 +1148,7 @@ sub init_remote_config {
 	unless ($no_write) {
 		command_noisy('config',
 			      "svn-remote.$self->{repo_id}.url", $url);
+		$self->{path} =~ s{^/}{};
 		command_noisy('config', '--add',
 			      "svn-remote.$self->{repo_id}.fetch",
 			      "$self->{path}:".$self->refname);
-- 
Eric Wong

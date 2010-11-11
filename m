From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv7 02/11] gitweb: introduce remote_heads feature
Date: Thu, 11 Nov 2010 13:26:09 +0100
Message-ID: <1289478378-15604-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 13:26:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGWEh-0000Gr-42
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 13:26:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756469Ab0KKM0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 07:26:30 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64924 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756444Ab0KKM03 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 07:26:29 -0500
Received: by eye27 with SMTP id 27so1036109eye.19
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 04:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=elAYp2ZePbwHOLk0TlxoDzV7C0uEnnKpnU3FvYHhqLA=;
        b=VpFtEpjDwJTEiMqc4cr8hDmDwLJdbid2owOhvKjHroQo+0H0ZwDbvKWjXJoYMdiy3R
         yQ5MvFu4HabeT8P2dmX5e6/jMpy/zEqUmhiJwffVPVE1N8MKBKEEoewyUjzVMuEFremw
         Lwevs+N6BZUxJFlRU4ixA4cjEsdL4myF1u2Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=U6YLes4nvOY/mFbfjn1Jxt12ZUrBnCHBwQzp/psapUyFC+yejQlHcp0UB2hUrWysxx
         +apspvl34iyMZuQgZgmJGYSbRhZPqFVKndIagwHtIAb+V5e0YbNhICpkjtKlR1TmCBmY
         W4pDDg9xNvgK9bx3lNBL020dbT6mnkhXP5I3Q=
Received: by 10.216.49.145 with SMTP id x17mr640006web.55.1289478387922;
        Thu, 11 Nov 2010 04:26:27 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id x3sm1243069wes.22.2010.11.11.04.26.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Nov 2010 04:26:26 -0800 (PST)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1289478378-15604-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161235>

With this feature enabled, remote heads are retrieved (and displayed)
when getting (and displaying) the heads list. Typical usage would be for
local repository browsing, e.g. by using git-instaweb (or even a more
permanent gitweb setup), to check the repository status and the relation
between tracking branches and the originating remotes.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 77693ab..e1787c2 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -493,6 +493,18 @@ our %feature = (
 		'sub' => sub { feature_bool('highlight', @_) },
 		'override' => 0,
 		'default' => [0]},
+
+	# Enable displaying of remote heads in the heads list
+
+	# To enable system wide have in $GITWEB_CONFIG
+	# $feature{'remote_heads'}{'default'} = [1];
+	# To have project specific config enable override in $GITWEB_CONFIG
+	# $feature{'remote_heads'}{'override'} = 1;
+	# and in project config gitweb.remote_heads = 0|1;
+	'remote_heads' => {
+		'sub' => sub { feature_bool('remote_heads', @_) },
+		'override' => 0,
+		'default' => [0]},
 );
 
 sub gitweb_get_feature {
@@ -3160,10 +3172,12 @@ sub git_get_heads_list {
 	my $limit = shift;
 	my @headslist;
 
+	my $remote_heads = gitweb_check_feature('remote_heads');
+
 	open my $fd, '-|', git_cmd(), 'for-each-ref',
 		($limit ? '--count='.($limit+1) : ()), '--sort=-committerdate',
 		'--format=%(objectname) %(refname) %(subject)%00%(committer)',
-		'refs/heads'
+		'refs/heads', ($remote_heads ? 'refs/remotes' : ())
 		or return;
 	while (my $line = <$fd>) {
 		my %ref_item;
@@ -3174,7 +3188,7 @@ sub git_get_heads_list {
 		my ($committer, $epoch, $tz) =
 			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
 		$ref_item{'fullname'}  = $name;
-		$name =~ s!^refs/heads/!!;
+		$name =~ s!^refs/(?:head|remote)s/!!;
 
 		$ref_item{'name'}  = $name;
 		$ref_item{'id'}    = $hash;
-- 
1.7.3.68.g6ec8

From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 01/12] gitweb: introduce remote_heads feature
Date: Fri, 24 Sep 2010 18:02:36 +0200
Message-ID: <1285344167-8518-2-git-send-email-giuseppe.bilotta@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 18:03:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzAkG-0005n3-0W
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 18:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966Ab0IXQDM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 12:03:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:36921 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab0IXQDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 12:03:08 -0400
Received: by wyb28 with SMTP id 28so2050871wyb.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 09:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=/DyQIpjMMahalOogruf5xoeIrtMQM8oxYvGlLxe2FcA=;
        b=eOWsaCHjpJhLbnbQIs+9NPeQOKga2eodMauhMvqRrxiZ/w1frN8tVnW7w6YjHlz6ol
         Qrgz7MT1aA3bAvTf9TGHJMGH6csRBw4MfsBR4Zg+CSSEph8mbJ3Z4IWeLkS5EBKkHfuq
         EvB1vKJ7aa+y2ihYDb1ejw++VbuzploigG2c4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=x299lL+e6kIo1630EAnnl02kEU5VMyr7lOS/65LJ4dSU4myjRDo6hAyl5AX3ExC+45
         PB+r7wmGxDPbT3oQ73AL5ngbmCtHLgIZWM10zI/2+GmBwq54TbHaQX+6nZr2BWJckH23
         t2qHrsLlsCX/uR4IQw4Wdj3wLqAnYDZiCF3WQ=
Received: by 10.216.165.16 with SMTP id d16mr2949155wel.0.1285344186785;
        Fri, 24 Sep 2010 09:03:06 -0700 (PDT)
Received: from localhost ([151.60.177.109])
        by mx.google.com with ESMTPS id x33sm1429737weq.47.2010.09.24.09.03.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 09:03:04 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.68.g6ec8
In-Reply-To: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157002>

With this feature enabled, remotes are retrieved (and displayed)
when getting (and displaying) the heads list. Typical usage would be for
local repository browsing, e.g. by using git-instaweb (or even a more
permanent gitweb setup), to check the repository status and the relation
between tracking branches and the originating remotes.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a85e2f6..f09fcee 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -486,6 +486,18 @@ our %feature = (
 		'sub' => sub { feature_bool('highlight', @_) },
 		'override' => 0,
 		'default' => [0]},
+
+	# Make gitweb show remotes too in the heads list
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
@@ -3146,10 +3158,12 @@ sub git_get_heads_list {
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
@@ -3160,7 +3174,7 @@ sub git_get_heads_list {
 		my ($committer, $epoch, $tz) =
 			($committerinfo =~ /^(.*) ([0-9]+) (.*)$/);
 		$ref_item{'fullname'}  = $name;
-		$name =~ s!^refs/heads/!!;
+		$name =~ s!^refs/(?:head|remote)s/!!;
 
 		$ref_item{'name'}  = $name;
 		$ref_item{'id'}    = $hash;
-- 
1.7.3.68.g6ec8

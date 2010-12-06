From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 18/24] gitweb/lib - Configure running 'generating_info' when generating data
Date: Tue,  7 Dec 2010 00:11:03 +0100
Message-ID: <1291677069-6559-19-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:20:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkMV-0003wg-F4
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:20:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754243Ab0LFXUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:20:46 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:46905 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151Ab0LFXUp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:20:45 -0500
Received: by eyg5 with SMTP id 5so8020468eyg.2
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:20:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ji0TKQMa81qHlm94srrVLat4+N+Ph6BpdZ2GRTH33X8=;
        b=olFlibp3TaAAyVciwNxVy6uoKihhkznmxZKzn9YI7SAZ9Vv/avkb02YechbeZaA6X1
         SRoDE253P65LPkhpfRoRD0aS6WkveoT1exIB9Ol9fTtO3dcNSW/qMBc2qMW0ZerBzUDS
         O/4RERYVYtv1HJJWIKEc1AysfpwxqEi8du4GQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=pD0yL3Sp26t0GVN0XK+Pll8EBwPF4qaIp8v2ro2OsbEj/4cjdKqNrWv/CtEn8VANsZ
         mmm/WMOWBvdJ06xlxg2vst3noQnI2bFrcrbrU2HJf5xv4USLAdXVX+rJ3qNL1YRYCQ3S
         qe8uhbDmsQBuOc75Biid2S4FEy8Z8Hd6/4UA8=
Received: by 10.14.37.10 with SMTP id x10mr5019201eea.31.1291677145381;
        Mon, 06 Dec 2010 15:12:25 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.23
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:24 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163060>

Add a new 'generating_info_is_safe' cache option; if true, then
process generating data (one that acquired exclusive writer's lock)
would run 'generating_info' if there is no stale data and background
cache generation is enabled.

If function generating (or printing) exits, which leads to cache entry
not being generated (for gitweb this means that there are pages which
are not cached, i.e. error pages), and 'generating_info' also exits,
this could result in bad behavior.  Therefore this new option is false
by default.


Updates t9503 test appropriately.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch was not present in previous version of this series.

This is one solution to the problem mentioned in commit message;
another is to use initial delay in "Generating..." page, as it is done
in next patch, and as it was done in previous version of this series.

 gitweb/lib/GitwebCache/FileCacheWithLocking.pm |   17 ++++++++++++++---
 t/t9503/test_cache_interface.pl                |    1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
index 694c318..0823c55 100644
--- a/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
+++ b/gitweb/lib/GitwebCache/FileCacheWithLocking.pm
@@ -80,26 +80,35 @@ use POSIX qw(setsid);
 #    instead), for other process (or bacground process).  It is passed
 #    $cache instance, $key, and opened $lock_fh filehandle to lockfile.
 #    Unset by default (which means no activity indicator).
+#  * 'generating_info_is_safe' (boolean)
+#    If true, run 'generating_info' subroutine also in the project that
+#    is generating data.  This has effect only when 'background_cache'
+#    is true (both 'background_cache' and 'generating_info_is_safe' must
+#    be true for project generating data to run 'generating_info').
+#    Defaults to false for safety.
 sub new {
 	my $class = shift;
 	my %opts = ref $_[0] ? %{ $_[0] } : @_;
 
 	my $self = $class->SUPER::new(\%opts);
 
-	my ($max_lifetime, $background_cache, $generating_info);
+	my ($max_lifetime, $background_cache, $generating_info, $gen_info_is_safe);
 	if (%opts) {
 		$max_lifetime =
 			$opts{'max_lifetime'} ||
 			$opts{'max_cache_lifetime'};
 		$background_cache = $opts{'background_cache'};
 		$generating_info  = $opts{'generating_info'};
+		$gen_info_is_safe = $opts{'generating_info_is_safe'};
 	}
 	$max_lifetime = -1 unless defined($max_lifetime);
 	$background_cache = 1 unless defined($background_cache);
+	$gen_info_is_safe = 0 unless defined($gen_info_is_safe);
 
 	$self->set_max_lifetime($max_lifetime);
 	$self->set_background_cache($background_cache);
 	$self->set_generating_info($generating_info);
+	$self->set_generating_info_is_safe($gen_info_is_safe);
 
 	return $self;
 }
@@ -110,7 +119,8 @@ sub new {
 # http://perldesignpatterns.com/perldesignpatterns.html#AccessorPattern
 
 # creates get_depth() and set_depth($depth) etc. methods
-foreach my $i (qw(max_lifetime background_cache generating_info)) {
+foreach my $i (qw(max_lifetime background_cache
+                  generating_info generating_info_is_safe)) {
 	my $field = $i;
 	no strict 'refs';
 	*{"get_$field"} = sub {
@@ -214,7 +224,8 @@ sub _set_maybe_background {
 		# to regenerate/refresh the cache (generate data),
 		# or if main process would show progress indicator
 		$pid = fork()
-			if (@stale_result || $self->{'generating_info'});
+			if (@stale_result ||
+			    ($self->{'generating_info'} && $self->{'generating_info_is_safe'}));
 	}
 
 	if ($pid) {
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 81f0b76..480cfbc 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -333,6 +333,7 @@ subtest 'serving stale data when (re)generating' => sub {
 
 	# with background generation
 	$cache->set_background_cache(1);
+	$cache->set_generating_info_is_safe(1);
 
 	$cache->set($key, $stale_value);
 	$cache->set_expires_in(0);    # set value is now expired
-- 
1.7.3

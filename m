From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 09/10] gitweb/cache.pm - Serve stale data when waiting for filling cache (WIP)
Date: Sat, 23 Jan 2010 01:27:32 +0100
Message-ID: <dba7265713bde1e403c3cbab6de81345b20f8ab8.1264198194.git.jnareb@gmail.com>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:28:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTrk-0002dP-SL
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756489Ab0AWA2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756459Ab0AWA16
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:27:58 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:44611 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756467Ab0AWA1y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:27:54 -0500
Received: by fg-out-1718.google.com with SMTP id 16so165872fgg.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=RT7lUYp9EuErdFMQZQhHjOY7EJpysZu1Wfe6KX4jIaE=;
        b=eCd2+DtTXlMrF8ZdzxjILxXpxy1AyOx/IUEKGmYIAczyyaKkv1DPiQq5akoWdNgaWv
         2QjEJakXYpLyNNIeuNqWnwpsseuE6+zb+IxS83Lx6K1CGixzSFUVbnJgMgx67uy6vOPe
         mfQ5Je+qYkDiqpCRrRjSsqVqOcpu9/9oa83m8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OBQjyxlLaCnicdhuHcSfybCyBb8m/7Wb5805OczA9Qqpx9sTB/8b171gLNe9uyOwP6
         eirjkWmJnl3D21lwJrxw7ic2SgLfndsUlHpjCVs/CESC7Q3T0FJdjvDO9AqlfBnTx1nQ
         tHALnLCZ0CfXvafB8hPLuPJKLBJp/5+sWXrWw=
Received: by 10.103.84.30 with SMTP id m30mr1934514mul.22.1264206473526;
        Fri, 22 Jan 2010 16:27:53 -0800 (PST)
Received: from localhost.localdomain (abvr137.neoplus.adsl.tpnet.pl [83.8.215.137])
        by mx.google.com with ESMTPS id s11sm11094697mue.19.2010.01.22.16.27.52
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 16:27:52 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
In-Reply-To: <cover.1264198194.git.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137800>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch, as you can see, lack proper commit message: it is work in
progress.

Note that contrary to original patch by J.H. we fork unconditionally;
otherwise the process which do recalculate cache entry would be at
disadvantage compared to processes which failed race to acquire
writers lock.  Perhaps this should be made configurable, though.

Also note that currently there is no limit on how stale the data which
is being served while regenerating data can be, i.e. there is no
equivalent for $maxCacheLife.  Simplest solution (I guess) would be to
just delete cache entry if it is too stale upfront.

 gitweb/cache.pm                 |   32 +++++++++++++++++++++++++++-----
 t/t9503/test_cache_interface.pl |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index f514ee9..1adf467 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -426,14 +426,36 @@ sub compute {
 	_Make_Path($lockfile);
 	open my $lock_fh, '+>', $lockfile;
 	#	or die "Can't open lockfile '$lockfile': $!";
+
+	# try to retrieve stale data
+	$data = $self->restore($self->get_namespace(), $p_key);
+
 	if (my $lock_state = flock($lock_fh, LOCK_EX | LOCK_NB)) {
 		# acquired writers lock
-		$data = $p_coderef->($self, $p_key);
-		$self->set($p_key, $data);
+		my $pid = fork() if $data;
+		if (!defined $pid || $pid) {
+			# parent, or didn't fork
+			$data = $p_coderef->($self, $p_key);
+			$self->set($p_key, $data);
+
+			if ($pid) {
+				# wait for child (which would print) and exit
+				waitpid $pid, 0;
+				exit 0;
+			} else {
+				# there is no child, or was no $data to serve in background
+				;
+			}
+		} else {
+			# child to serve $data
+			;
+		}
 	} else {
-		# get readers lock
-		flock($lock_fh, LOCK_SH);
-		$data = $self->restore($self->get_namespace(), $p_key);
+		if (!defined $data) {
+			# get readers lock if there is no stale data to serve
+			flock($lock_fh, LOCK_SH);
+			$data = $self->restore($self->get_namespace(), $p_key);
+		}
 	}
 	close $lock_fh;
 	return $data;
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 43b806d..788e8f2 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -154,5 +154,42 @@ is($cache->get_expires_in(), 0,        '"expires in" is set to now (0)');
 $cache->set($key, $value);
 ok(!defined($cache->get($key)),        'cache is expired');
 
+# Test that cache returns stale data in existing but expired cache situation
+# (probably should be run only if GIT_TEST_LONG)
+$cache->set_expires_min(0);
+$cache->set_expires_max(0);
+my $stale_value = 'Stale Value';
+my $child_data = '';
+$cache->set($key, $stale_value);
+$call_count = 0;
+$pid = open $kid_fh, '-|';
+SKIP: {
+	skip "cannot fork: $!", 4
+		unless defined $pid;
+
+	my $data = $cache->compute($key, \&get_value_slow);
+
+	if ($pid) {
+		$child_data = <$kid_fh>;
+		chomp $child_data;
+
+		waitpid $pid, 0;
+		close $kid_fh;
+	} else {
+		print "$data\n";
+		exit 0;
+	}
+
+	is($data,       $stale_value, 'stale data in parent when expired');
+	is($child_data, $stale_value, 'stale data in child  when expired');
+
+	# never expire
+	$cache->set_expires_min(-1);
+	$cache->set_expires_max(-1);
+	is($cache->get($key), $value, 'value got set correctly');
+}
+$cache->set_expires_min(0);
+$cache->set_expires_max(0);
+
 
 done_testing();
-- 
1.6.6.1

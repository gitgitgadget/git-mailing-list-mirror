From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 06/10] gitweb/cache.pm - Adaptive cache expiration time (WIP)
Date: Sat, 23 Jan 2010 01:27:29 +0100
Message-ID: <1021d8b597baf908f9770e36dddde87e9fbf1a0c.1264198194.git.jnareb@gmail.com>
References: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
Cc: John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 01:28:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYTrl-0002dP-EN
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 01:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429Ab0AWA2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 19:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756469Ab0AWA1z
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 19:27:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:44611 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884Ab0AWA1v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 19:27:51 -0500
Received: by fg-out-1718.google.com with SMTP id 16so165872fgg.1
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 16:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:in-reply-to:references;
        bh=lz7fPnwrY0PSW/xqyB0cCpMQO8RRsCUJHyJJgSz4HaI=;
        b=YhUNMeLZDTZsrkVE3RvjbQXZB3dwJNcJjyFduaus6Oza8Ov6q0N/Rfs+FdQkyShed7
         G4lnBSSM1hgIxJ1f3TvpthvmqbueT7CBtYwQ/BomjN8oJgs7Xqxu5Td3vD2fYpCYhmpJ
         f9cowajQQlvXTQ29N8Vjf/RLwe/g3BrNgGh3A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=voe4CPiFvHZnikMijc2ZNgtMQEYpkt1CYK2RM/1jopdZd3f/YgJ7xf3PfOxvAEy/rN
         G7aiRQzoerQe0zjturKkyq/IVd9NWhbQjkZV0Am7b5vxmtniYzbYY8sLxPCPlEbRBdHE
         QVcGeNSLkiZLInQENz6umYaVcAxWqQN1pTdpM=
Received: by 10.103.78.22 with SMTP id f22mr1889820mul.91.1264206468993;
        Fri, 22 Jan 2010 16:27:48 -0800 (PST)
Received: from localhost.localdomain (abvr137.neoplus.adsl.tpnet.pl [83.8.215.137])
        by mx.google.com with ESMTPS id s11sm11094697mue.19.2010.01.22.16.27.47
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 16:27:48 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1
In-Reply-To: <1263432185-21334-10-git-send-email-warthog9@eaglescrag.net>
In-Reply-To: <cover.1264198194.git.jnareb@gmail.com>
References: <cover.1264198194.git.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137801>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch, as you can see, lack proper commit message: it is work in
progress.

As it is quick'n'dirty proof of concept patch, it lacks variables in
gitweb.perl that can be used to control cache behaviour.  In original
patch in J.H. those were the following variables: $minCacheTime,
$maxCacheTime.

In the final version we should probably leave $check_load undefined,
or set it to 'sub { return 0; }' instead of requiring that there is
get_loadavg() subroutine in main namespace (see t9503 test change).
It would be alos good idea to leave ->set_expires_in() subroutine
which would set min and max range so that adaptive cache lifetime is
effectively disabled.

 gitweb/cache.pm                 |   82 ++++++++++++++++++++++++++++++++++----
 t/t9503/test_cache_interface.pl |    8 +++-
 2 files changed, 80 insertions(+), 10 deletions(-)

diff --git a/gitweb/cache.pm b/gitweb/cache.pm
index 3a33158..9692e8d 100644
--- a/gitweb/cache.pm
+++ b/gitweb/cache.pm
@@ -61,24 +61,36 @@ sub new {
 	my $self  = {};
 	$self = bless($self, $class);
 
-	my ($root, $depth, $ns, $expires_in);
+	my ($root, $depth, $ns);
+	my ($expires_min, $expires_max, $increase_factor, $check_load);
 	if (defined $p_options_hash_ref) {
 		$root  = $p_options_hash_ref->{'cache_root'};
 		$depth = $p_options_hash_ref->{'cache_depth'};
 		$ns    = $p_options_hash_ref->{'namespace'};
-		$expires_in =
+		$expires_min =
+			$p_options_hash_ref->{'expires_min'} ||
 			$p_options_hash_ref->{'default_expires_in'} ||
 			$p_options_hash_ref->{'expires_in'};
+		$expires_max =
+			$p_options_hash_ref->{'expires_max'};
+		$increase_factor = $p_options_hash_ref->{'expires_factor'};
+		$check_load      = $p_options_hash_ref->{'check_load'};
 	}
 	$root  = $DEFAULT_CACHE_ROOT  unless defined($root);
 	$depth = $DEFAULT_CACHE_DEPTH unless defined($depth);
 	$ns    = '' unless defined($ns);
-	$expires_in = -1 unless defined($expires_in); # <0 means never
+	$expires_min =   20 unless defined($expires_min);
+	$expires_max = 1200 unless defined($expires_max);
+	$increase_factor = 60 unless defined($increase_factor);
+	$check_load = \&main::get_loadavg unless defined($check_load);
 
 	$self->set_root($root);
 	$self->set_depth($depth);
 	$self->set_namespace($ns);
-	$self->set_expires_in($expires_in);
+	$self->set_expires_min($expires_min);
+	$self->set_expires_max($expires_max);
+	$self->set_increase_factor($increase_factor);
+	$self->set_check_load($check_load);
 
 	return $self;
 }
@@ -124,19 +136,71 @@ sub set_namespace {
 	$self->{'_Namespace'} = $namespace;
 }
 
-sub get_expires_in {
+
+sub get_expires_min {
 	my ($self) = @_;
 
-	return $self->{'_Expires_In'};
+	return $self->{'_Expires_Min'};
+}
+
+sub set_expires_min {
+	my ($self, $expires_min) = @_;
+
+	$self->{'_Expires_Min'} = $expires_min;
 }
 
+sub get_expires_max {
+	my ($self) = @_;
+
+	return $self->{'_Expires_Max'};
+}
+
+sub set_expires_max {
+	my ($self, $expires_max) = @_;
+
+	$self->{'_Expires_Max'} = $expires_max;
+}
+
+sub get_increase_factor {
+	my ($self) = @_;
+
+	return $self->{'_Increase_Factor'};
+}
 
-sub set_expires_in {
-	my ($self, $expires_in) = @_;
+sub set_increase_factor {
+	my ($self, $increase_factor) = @_;
 
-	$self->{'_Expires_In'} = $expires_in;
+	$self->{'_Increase_Factor'} = $increase_factor;
 }
 
+sub get_check_load {
+	my ($self) = @_;
+
+	return $self->{'_Check_Load'};
+}
+
+sub set_check_load {
+	my ($self, $sub) = @_;
+
+	$self->{'_Check_Load'} = $sub;
+}
+
+# ......................................................................
+
+sub get_expires_in {
+	my ($self) = @_;
+	my $expires_in =
+		#$self->get_expires_min() +
+		$self->get_increase_factor() * $self->get_check_load()->();
+
+	if ($expires_in < $self->get_expires_min()) {
+		return $self->get_expires_min();
+	} elsif ($expires_in > $self->get_expires_max()) {
+		return $self->get_expires_max();
+	}
+
+	return $expires_in;
+}
 
 # ----------------------------------------------------------------------
 # (private) utility functions and methods
diff --git a/t/t9503/test_cache_interface.pl b/t/t9503/test_cache_interface.pl
index 3644ca8..0870b87 100755
--- a/t/t9503/test_cache_interface.pl
+++ b/t/t9503/test_cache_interface.pl
@@ -6,6 +6,11 @@ use strict;
 
 use Test::More;
 
+# mockup
+sub get_loadavg {
+	return 0.0;
+}
+
 # test source version; there is no installation target for gitweb
 my $cache_pm = "$ENV{TEST_DIRECTORY}/../gitweb/cache.pm";
 
@@ -77,7 +82,8 @@ cmp_ok($call_count, '==', 1, 'get_value() is called once');
 
 # Test cache expiration for 'expire now'
 #
-$cache->set_expires_in(0);
+$cache->set_expires_min(0);
+$cache->set_expires_max(0);
 is($cache->get_expires_in(), 0,        '"expires in" is set to now (0)');
 $cache->set($key, $value);
 ok(!defined($cache->get($key)),        'cache is expired');
-- 
1.6.6.1

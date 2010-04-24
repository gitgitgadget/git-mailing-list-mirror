From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/5] gitweb: href(..., -path_info => 0|1)
Date: Sat, 24 Apr 2010 15:53:19 +0200
Message-ID: <20100424135024.30511.78790.stgit@localhost.localdomain>
References: <20100424132255.30511.98829.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 15:53:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5fnz-0008ID-4J
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 15:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753166Ab0DXNxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Apr 2010 09:53:52 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:41226 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab0DXNxw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Apr 2010 09:53:52 -0400
Received: by bwz19 with SMTP id 19so257035bwz.21
        for <git@vger.kernel.org>; Sat, 24 Apr 2010 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=nU2lz0PWHD70yWHxOSJo03G5j1INCzFwhBpwfEDK9tE=;
        b=eiD8I5Lb7YhF9BXKd3C33bCgTNBGiRsvCtl5S1WenFkXLoyW7xBrwFy/UvQjWn2kwE
         gGiEGZMCj3QPziEH6ZSB/Guw2HdRugxqJmE6BqdKoy0qqhmGW7m2khyQhFKM7Q6ug1DQ
         Anbxi+LudXO37rvo2KGIwiODx4mPJK/t4UZek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=N8YMvpEpmtPePWhqC/NhdFe30GnyPjuT8wAoMHY65zMrfXBmdgK0xACHfZKiFkviyn
         kqBmCl27Vn8EIyTi5QhloHGsnAEHRlGZAfWJQ7u38nyVXaX5v6B++gh2UtfS4eHHr379
         4cCAqY1fXEwhlQ+eD4DzVq8KIBBY6QtLNTyYc=
Received: by 10.204.156.204 with SMTP id y12mr914114bkw.82.1272117230663;
        Sat, 24 Apr 2010 06:53:50 -0700 (PDT)
Received: from localhost.localdomain (abvk50.neoplus.adsl.tpnet.pl [83.8.208.50])
        by mx.google.com with ESMTPS id 16sm838228bwz.1.2010.04.24.06.53.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 24 Apr 2010 06:53:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3ODrJiY030976;
	Sat, 24 Apr 2010 15:53:29 +0200
In-Reply-To: <20100424132255.30511.98829.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145677>

If named boolean option -path_info is passed to href() subroutine, it
would use its value to decide whether to generate path_info URL form.
If this option is not passed, href() queries 'pathinfo' feature to
check whether to generate path_info URL (if generating path_info link
is possible at all).

href(-replay=>1, -path_info=>0) is meant to be used to generate a key
for caching gitweb output; alternate solution would be to use freeze()
from Storable (core module) on %input_params hash (or its reference),
e.g.:
  $key = freeze \%input_params;
or other serialization of %input_params.

While at it document extra options/flags to href().

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
The commit message explicitly mentions caching support, but in fast
this feature is just about having a way to request *canonical* URL
(canonical link).

 gitweb/gitweb.perl |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index c356e95..6cefb09 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -977,6 +977,10 @@ exit;
 ## ======================================================================
 ## action links
 
+# possible values of extra options
+# -full => 0|1      - use absolute/full URL ($my_uri/$my_url as base)
+# -replay => 1      - start from a current view (replay with modifications)
+# -path_info => 0|1 - don't use/use path_info URL (if possible)
 sub href {
 	my %params = @_;
 	# default is to use -absolute url() i.e. $my_uri
@@ -993,7 +997,8 @@ sub href {
 	}
 
 	my $use_pathinfo = gitweb_check_feature('pathinfo');
-	if ($use_pathinfo and defined $params{'project'}) {
+	if (defined $params{'project'} &&
+	    (exists $params{-path_info} ? $params{-path_info} : $use_pathinfo)) {
 		# try to put as many parameters as possible in PATH_INFO:
 		#   - project name
 		#   - action

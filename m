From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCHv4 17/17] gitweb: Add startup delay to activity indicator for cache
Date: Mon, 14 Jun 2010 18:08:30 +0200
Message-ID: <1276531710-22945-19-git-send-email-jnareb@gmail.com>
References: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 14 18:10:45 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOCEu-0002Dq-EI
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 18:10:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563Ab0FNQJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 12:09:13 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55154 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755556Ab0FNQJH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 12:09:07 -0400
Received: by mail-fx0-f46.google.com with SMTP id 8so2649718fxm.19
        for <git@vger.kernel.org>; Mon, 14 Jun 2010 09:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Y/YWh77S5gCfW92qCNMgZEaFMMIgG7KcPJzgzBkvtXE=;
        b=k9Po34mS8k2z+/xoN4Gb5KCm3f4wx6IaMdiJbvhzSE26SlM4PsWxenhDcVKCr82qUc
         sfmHBxgEwQass7PhN5dUXYrOCV17EbliyRcAgRflC9X0c14TMnA6rxo4lWCW9g7DN9nK
         2/Os7Q9otkwMRMtf4YuhPL/X47rQkkcVBK7aQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=LXPNXlVaF+eoyPqB/v+Fqg7nbntJGQxpzTT2qIEl3GkS2LHO9Dadj5mPaNyr7yFJOz
         T1FN8t68P25yW1SCuCdtSEZyqDVXkg+/8HaaL22OtAQ7Kr1DETPCukaJHbiVWoypTXn5
         JVFWFrMZjLBLVST9W/mnuTJUscPwBFfSV2vhY=
Received: by 10.223.22.145 with SMTP id n17mr5716683fab.23.1276531747124;
        Mon, 14 Jun 2010 09:09:07 -0700 (PDT)
Received: from localhost.localdomain (abuz111.neoplus.adsl.tpnet.pl [83.8.197.111])
        by mx.google.com with ESMTPS id u12sm7476715fah.28.2010.06.14.09.09.05
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 14 Jun 2010 09:09:06 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.1
In-Reply-To: <1276531710-22945-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149117>

This adds support for [optional] startup delay to git_generating_data_html()
subroutine, which is used to provide "Generating..." page as activity
indicator when waiting for page to be generated if caching.  If the data
(page contents) gets generated within $generating_options{'staryp_delay'}
seconds, the "Generating..." page won't get displayed.

This feature was created in response to complaint by Petr 'Pasky' Baudis'
about "Generating..." feature.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8d7540e..313114c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -326,6 +326,9 @@ our %cache_options = (
 # (which means that $cache_options{'generating_info'} is set to coderef);
 # override them with $GITWEB_CONFIG as necessary.
 our %generating_options = (
+	# The delay before displaying "Generating..." page, in seconds.  It is
+	# intended for "Generating..." page to be shown only when really needed.
+	'startup_delay' => 1,
 	# The time between generating new piece of output to prevent from
 	# redirection before data is ready, i.e. time between printing each
 	# dot in activity indicator / progress info, in seconds.
@@ -3368,6 +3371,23 @@ sub git_generating_data_html {
 	#	return;
 	#}
 
+	# Initial delay
+	if ($generating_options{'startup_delay'} > 0) {
+		eval {
+			local $SIG{ALRM} = sub { die "alarm clock restart\n" }; # NB: \n required
+			alarm $generating_options{'startup_delay'};
+			flock($lock_fh, LOCK_SH); # blocking readers lock
+			alarm 0;
+		};
+		if ($@) {
+			# propagate unexpected errors
+			die $@ if $@ !~ /alarm clock restart/;
+		} else {
+			# we got response within 'startup_delay' timeout
+			return;
+		}
+	}
+
 	# Stop capturing response, just in case (we should be not generating response)
 	#
 	capture_stop(); # or gitweb could use 'print $STDOUT' in place of 'print STDOUT'
-- 
1.7.0.1

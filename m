From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 19/24] gitweb: Add startup delay to activity indicator for cache
Date: Tue,  7 Dec 2010 00:11:04 +0100
Message-ID: <1291677069-6559-20-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:20:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkLr-0003e6-Fp
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150Ab0LFXUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:20:04 -0500
Received: from mail-ey0-f171.google.com ([209.85.215.171]:50690 "EHLO
	mail-ey0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab0LFXUD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:20:03 -0500
Received: by eyg5 with SMTP id 5so8020007eyg.2
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:20:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8NRmUapQW75e9UGxNCc5nGve/aXK8Fes0z9oA//dy/U=;
        b=QNAPsrWJFH7M/oDDpllgpl07CHe5uvmUWIhyp5VZg+vAvbTL4LQ83ErQa6K4RXjV63
         ERZ7oVvjqRYcVw1LhOOw5AvGnjCcYMlkhvvEIx18XJEKTkFQ9FpQg3y7qWb4VhOkztrV
         R/HfTlPRpRBIZGyDw7crzEPzfKqKaKGcTA6wg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=XSd3b9lwGA6JPU61dci09mEAw6tTRIxQviMkKPbVn9DAd0UzYushxr0VzeagIOK5eU
         DG6NiV+JCejGSNa7oW9/cqU6l5i3pHs3n7IbIFVwcLODsEvDCgeDX0FJI+ToJB/0jCq4
         d41wEpCDYG+ULID1mTk0FlbagPeoG9q+NPAoE=
Received: by 10.14.37.10 with SMTP id x10mr5355471eea.32.1291677147425;
        Mon, 06 Dec 2010 15:12:27 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.25
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:26 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163056>

This adds support for [optional] startup delay to git_generating_data_html()
subroutine, which is used to provide "Generating..." page as activity
indicator when waiting for page to be generated if caching.  If the data
(page contents) gets generated within $generating_options{'staryp_delay'}
seconds, the "Generating..." page won't get displayed.

This feature was created in response to complaint by Petr 'Pasky' Baudis'
about "Generating..." feature.


NOTE: This startup delay allows to use git_generating_data_html() also
for process generating data, assuming that die_error(), which turns of
capturing and which output (error page) is not cache, finishes within
startup delay.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch doesn't have equivalent in J.H. series, and is rather
extension of idea of progress indicator for (re)generating [cache]
data.  It was inspired by comment by Petr 'Pasky' Baudis on #git IRC
channel that one doesn't want to have "Generating..." page to be shown
only to immediately vanish.

The additional advantage is that it solves problem with link that
leads to error page: die_error exits / ends request without generating
cache entry, so if "Generating..." is done also for process generating
data in background (perhaps it isn't true in J.H. series; I am not
sure about code flow there), then gitweb would endlessly show
"Generating..." page if it didn't wait and exited / ended request also
for die_error case.

The only difference compared to previous version of this series is that
git_generating_data_html is now marked as 'generating_info_is_safe'.

 gitweb/gitweb.perl |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 181b85d..c974e79 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -357,11 +357,22 @@ our %cache_options = (
 	# is passed the following parameters: $cache instance, human-readable
 	# $key to current page, and filehandle $lock_fh to lockfile.
 	'generating_info' => \&git_generating_data_html,
+
+	# This enables/disables using 'generating_info' subroutine by process
+	# generating data, when not too stale data is not available (data is then
+	# generated in background).  Because git_generating_data_html() includes
+	# initial delay (of 1 second by default), and we can assume that die_error
+	# finishes within this time, then generating error pages should be safe
+	# from infinite "Generating page..." loop.
+	'generating_info_is_safe' => 1,
 );
 # You define site-wide options for "Generating..." page (if enabled) here
 # (which means that $cache_options{'generating_info'} is set to coderef);
 # override them with $GITWEB_CONFIG as necessary.
 our %generating_options = (
+	# The delay before displaying "Generating..." page, in seconds.  It is
+	# intended for "Generating..." page to be shown only when really needed.
+	'startup_delay' => 1,
 	# The time between generating new piece of output to prevent from
 	# redirection before data is ready, i.e. time between printing each
 	# dot in activity indicator / progress info, in seconds.
@@ -3607,6 +3618,23 @@ sub git_generating_data_html {
 		return;
 	}
 
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
 	my $title = "[Generating...] " . get_page_title();
 	# TODO: the following line of code duplicates the one
 	# in git_header_html, and it should probably be refactored.
-- 
1.7.3

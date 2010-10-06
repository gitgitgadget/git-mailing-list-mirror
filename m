From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv5 15/17] gitweb: Introduce %actions_info, gathering information about actions
Date: Thu,  7 Oct 2010 00:02:00 +0200
Message-ID: <1286402526-13143-16-git-send-email-jnareb@gmail.com>
References: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 07 00:04:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3c5p-0002Gb-KT
	for gcvg-git-2@lo.gmane.org; Thu, 07 Oct 2010 00:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933238Ab0JFWDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 18:03:08 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:35042 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933219Ab0JFWDA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 18:03:00 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so49424bwz.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 15:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=yP5lNiKKfBZknWSh9/9Ct77m3lxhLZpc57yapWvHdtQ=;
        b=M301t+tUk1girM1WwPBBm7+ZukQ+8TIIje8jzspmPKBRh3Ej7IYJoBpRH2wckstRpl
         7uJTAtXLH40v1Mw0kMPWxd+im+WygMew5y+s3jm5epgOiN1PYqTXPd8A4IH9lUiE5TgQ
         T/rCFK17SqczQ9E/AlGUCPxcWDnLT+s0JGpkI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Qzjffc/qvc1sOczhTX60k+jbdgXxOvmI3P1gjuOixL4BrJrmhdA6w/x8wSylbI38sr
         jXeTKLUmANrL1itAo1Olbq6AXR3x6ywAjtX4e05etdfyNu/gthuyPhYOjLmQSz+ElY8R
         +Im7UKOd3Yv7NOENXgXpmqnquGtkOyQ3hefZc=
Received: by 10.204.79.199 with SMTP id q7mr10306358bkk.76.1286402580065;
        Wed, 06 Oct 2010 15:03:00 -0700 (PDT)
Received: from localhost.localdomain (abwe253.neoplus.adsl.tpnet.pl [83.8.228.253])
        by mx.google.com with ESMTPS id 24sm1044480bkr.19.2010.10.06.15.02.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 15:02:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1286402526-13143-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158316>

Currently it only contains information about output format, and is not
used anywhere.  It will be used to check whether current action
produces HTML output, and therefore is displaying HTML-based progress
info about (re)generating cache makes sense.

It can contain information about allowed extra options, whether to
display link to feed (Atom or RSS), etc. in easier and faster way than
listing all matching or all non-matching actions at appropriate site.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This is new patch, which didn't exist in v4 (previous version) of
gitweb caching series, and doesn't have equivalent in J.H. patch.

While it is patch preparing infrastructure to be used by progress
indicator (generating info), it is IMHO a good idea in itself, and
that is why it is not marked as RFC.

 gitweb/gitweb.perl |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index d9ac063..26d5619 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -807,6 +807,25 @@ our %allowed_options = (
 	"--no-merges" => [ qw(rss atom log shortlog history) ],
 );
 
+our %actions_info = ();
+sub evaluate_actions_info {
+	our %actions_info;
+	our (%actions);
+
+	# unless explicitely stated otherwise, default output format is html
+	foreach my $action (keys %actions) {
+		$actions_info{$action}{'output_format'} = 'html';
+	}
+	# list all exceptions; undef means variable (no definite format)
+	map { $actions_info{$_}{'output_format'} = 'text' }
+		qw(commitdiff_plain patch patches project_index blame_data);
+	map { $actions_info{$_}{'output_format'} = 'xml' }
+		qw(rss atom opml); # there are different types (document formats) of XML
+	map { $actions_info{$_}{'output_format'} = undef }
+		qw(blob_plain object);
+	$actions_info{'snapshot'}{'output_format'} = 'binary';
+}
+
 # fill %input_params with the CGI parameters. All values except for 'opt'
 # should be single values, but opt can be an array. We should probably
 # build an array of parameters that can be multi-valued, but since for the time
@@ -1153,6 +1172,7 @@ sub run_request {
 
 	evaluate_uri();
 	evaluate_gitweb_config();
+	evaluate_actions_info();
 	evaluate_git_version();
 	check_loadavg();
 	configure_caching()
-- 
1.7.3

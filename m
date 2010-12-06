From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 16/24] gitweb: Introduce %actions_info, gathering information about actions
Date: Tue,  7 Dec 2010 00:11:01 +0100
Message-ID: <1291677069-6559-17-git-send-email-jnareb@gmail.com>
References: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Cc: John 'Warthog9' Hawley <warthog9@kernel.org>,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>,
	Junio C Hamano <gitster@pobox.com>,
	demerphq <demerphq@gmail.com>,
	Aevar Arnfjord Bjarmason <avarab@gmail.com>,
	Thomas Adam <thomas@xteddy.org>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 00:12:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPkER-0008RS-0G
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 00:12:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145Ab0LFXMY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 18:12:24 -0500
Received: from mail-ew0-f45.google.com ([209.85.215.45]:50271 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917Ab0LFXMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 18:12:21 -0500
Received: by mail-ew0-f45.google.com with SMTP id 10so7581892ewy.4
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 15:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=4KSkT5UVLVXWHbfc3W923W+JZmVw7DZeu/iaRoXkiNc=;
        b=DrUqD/J83ROD0X9f3J08QPbHWtQL+PP/JrsZ8HcGlcF4Vks2GdkNW7TAgV/Poc04Dv
         uH0vpB/mkCVl9n35fMcaz+IBLAodi2ZIJub/ZsaNGsNs8PHzw3sVleoiZxt26jLL41t5
         03EORQRExv2A0OcjnR5jifc9CPjkIgEMGhYBk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dXR1KW6aks7q9wBynDxkFOxKt4QAkfKet1L4dXOsqqvu120C1TGT2nk3GHAOhRP61F
         u+DF/MFrGgy6mzgedkqqH/W1auBeM44dMR9Q8pcSG6K3ytmwENkt/uOSxjqRzKp/FZ9Z
         Qg9gXrJTZzcM56Y5UTi+E3rrhfUfxN2+uWD0E=
Received: by 10.14.11.226 with SMTP id 74mr5153612eex.5.1291677140532;
        Mon, 06 Dec 2010 15:12:20 -0800 (PST)
Received: from localhost.localdomain (abwg200.neoplus.adsl.tpnet.pl [83.8.230.200])
        by mx.google.com with ESMTPS id y5sm5190626eeh.22.2010.12.06.15.12.18
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 06 Dec 2010 15:12:19 -0800 (PST)
X-Mailer: git-send-email 1.7.3
In-Reply-To: <1291677069-6559-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163038>

Currently it only contains information about output format, and is not
used anywhere.  It will be used to check whether current action
produces HTML output, and therefore is displaying HTML-based progress
info about (re)generating cache makes sense.

It can contain information about allowed extra options, whether to
display link to feed (Atom or RSS), etc. in easier and faster way than
listing all matching or all non-matching actions at appropriate place.


Currently not used; will be used in next commit, to check if action
produces HTML output and therefore we can use HTML-specific progress
indicator.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
While it is patch preparing infrastructure to be used by progress
indicator (generating info), it is IMHO a good idea in itself, and
that is why it is not marked as RFC.

This patch is the same as in the previous version.

It has no equivalent in "Gitweb cachning v7" series by J.H.

 gitweb/gitweb.perl |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index f202d6b..da95388 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -818,6 +818,25 @@ our %allowed_options = (
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
@@ -1226,6 +1245,7 @@ sub evaluate_argv {
 
 sub run {
 	evaluate_argv();
+	evaluate_actions_info();
 
 	$pre_listen_hook->()
 		if $pre_listen_hook;
-- 
1.7.3

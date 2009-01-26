From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv2] gitweb: make static files accessible with PATH_INFO
Date: Mon, 26 Jan 2009 13:45:37 +0100
Message-ID: <1232973937-23875-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 26 13:46:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRQrX-0000q2-22
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 13:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbZAZMpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 07:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbZAZMpW
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 07:45:22 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:43790 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbZAZMpV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 07:45:21 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3504418fgg.17
        for <git@vger.kernel.org>; Mon, 26 Jan 2009 04:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=V9F0O8ft+IPU2YVFlbC0rb1KFp9sLHJjR346US/v2QQ=;
        b=l7812sfJM+M3IZO8vvcriDHEwJWFLRsHTSYJr+2gpiVthd7odzBLOp7PPxycSEfM3E
         i9k6iO3Ney1o77JIJBIkrJkJCMDAYhGJnvRZrECY6TpTlAjniWRTm8MX1LpESmzmATNH
         zSTkIIpfiVSKOdL2JiiJpkYkRy891jo9NKPZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=QUHPOXvFItKbG8W2TLQJI9Jtylv+BmS5MRp01kwODIn4sltM61FT9UoqZX4yBmpXVU
         ixxHuxDBy8GKnM8sRIEMQFrsiqmLNUHaVGS/KZy9n9kZpByF3wy3h+JCl0Tzwg1SO3os
         3DFsw2Gml1a5QcRysvSbgVjjoEcKUQVjLoJ7A=
Received: by 10.223.108.211 with SMTP id g19mr224531fap.39.1232973919479;
        Mon, 26 Jan 2009 04:45:19 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id d13sm22969586fka.0.2009.01.26.04.45.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jan 2009 04:45:18 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107208>

When PATH_INFO is defined, static files such as the defalt CSS or the
shortcut icon are not accessible beyond the summary page (e.g. in
shortlog or commit view).

Fix this by adding a <base> tag pointing to the script base URL.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
It's sick that $cgi->url() has no way to print the script base url
without path_info information (or that, if it has, it's very well
hidden).

 gitweb/gitweb.perl |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 931db4f..910da35 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2901,6 +2901,14 @@ sub git_header_html {
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
 EOF
+# the stylesheet, favicon etc urls won't work correctly with path_info unless we set the appropriate base URL
+	if ($ENV{'PATH_INFO'}) {
+		my $base = $my_uri;
+		my $sname = $ENV{'SCRIPT_NAME'};
+		$base =~ s,\Q$sname\E$,,;
+		$base .= "/";
+		print "<base href=\"$base\"/>\n";
+	}
 # print out each stylesheet that exist
 	if (defined $stylesheet) {
 #provides backwards capability for those people who define style sheet in a config file
-- 
1.5.6.5

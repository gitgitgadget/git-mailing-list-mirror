From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: pull ref markes pull out of subject <a> tag
Date: Sun, 23 Aug 2009 10:28:09 +0200
Message-ID: <1251016089-10548-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 23 10:29:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mf8SD-0007B8-31
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 10:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932685AbZHWI2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Aug 2009 04:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755878AbZHWI2Q
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 04:28:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:43886 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755876AbZHWI2P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Aug 2009 04:28:15 -0400
Received: by fg-out-1718.google.com with SMTP id e21so368040fga.17
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Do9Tnd7y5/vizH+eZO2RAipEXJffKhEMXa62u5vjOno=;
        b=eAK0JiHXL7TZ4/rGHuYwj+HshcHpw8I/JrcCaE0TtksCxAK+wkf6bOC0HDfwUo+a0H
         P19GT7UK7bzEzas+Zfig11ywozusM+FP+rjnIbmyxDpwObVyvCvFJ7nuYMlXevRlULoY
         gaABRRCPwreclYjpof8g0NaXaMgMm/QU6O2V4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hPbaJzYf9XNrHWqLKFBddnBvrIbs38UXIIHNfiepmFPweWEKxpSPUrtU1JwC/dPyHa
         tSq6TC61Gf4xFmhDozUe2r55zqqm+5up+x6/ycwLf0Lr7iTQg1t3bfMB4fE33xMxGZ1b
         5IyLKue+YYoFkekmwMI7zZL359jD/0gouaFqw=
Received: by 10.86.208.2 with SMTP id f2mr2328117fgg.16.1251016094847;
        Sun, 23 Aug 2009 01:28:14 -0700 (PDT)
Received: from localhost (host-78-15-4-214.cust-adsl.tiscali.it [78.15.4.214])
        by mx.google.com with ESMTPS id 4sm415713fge.17.2009.08.23.01.28.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 23 Aug 2009 01:28:14 -0700 (PDT)
X-Mailer: git-send-email 1.6.3.rc1.192.gdbfcb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126849>

Since 4afbaefffa9095fe1391b4b61289a7dc954e9f7b ref markers that
accompain the subject in views such as shortlog and history point to
something different from the subject itself. Therefore, they should not
be included in the same <a> tag.

Benefits of the change are:
* better compliance to the XHTML standards, that forbid links within
  links even though the restriction cannot be imposed via DTD; this also
  benefits visualization in some older browsers;
* when hovering the subject, only the subject itself is underlined; when
  hovering the ref markers, only the text in the hovered ref marker is
  underlined; previously, hovering any written part of the subject
  column led to complete underlying of everything at the same time,
  with unpleasing effects.
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

The next step would be to find a way to layout decently the case when
some shortlog entries have a _humongous_ amount of ref markers. See
for example http://git.oblomov.eu/acecad/shortlog

I honestly doubt these cases happen in normal git repositories, but it
might still be worth taking them into consideration. Possibilities
include hard-limiting the title column maximum width (in browsers for
which the corresponding attributes and rules work), manual insertion of
hard line breaks <br/> every n-th ref marker, or something more dynamic
such as hiding most of the ref markers when they are more than, say, 5,
and showing them on hover.

Suggestions? Comments?

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ce6e8f6..bb9648b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1524,10 +1524,10 @@ sub format_subject_html {
 		$long =~ s/[[:cntrl:]]/?/g;
 		return $cgi->a({-href => $href, -class => "list subject",
 		                -title => to_utf8($long)},
-		       esc_html($short) . $extra);
+		       esc_html($short)) . $extra;
 	} else {
 		return $cgi->a({-href => $href, -class => "list subject"},
-		       esc_html($long)  . $extra);
+		       esc_html($long)) . $extra;
 	}
 }
 
-- 
1.6.3.rc1.192.gdbfcb

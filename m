From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb.js: Workaround for IE8 bug
Date: Sun, 24 Jan 2010 19:05:23 +0100
Organization: 
Message-ID: <20100124180226.14562.87666.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 24 19:06:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ6qV-0000RF-Da
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 19:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258Ab0AXSFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 13:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147Ab0AXSFz
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 13:05:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:63518 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab0AXSFx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 13:05:53 -0500
Received: by fg-out-1718.google.com with SMTP id l26so743454fgb.1
        for <git@vger.kernel.org>; Sun, 24 Jan 2010 10:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:date
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=2eocsm07Qv/jMffGD7ruKLtEBa8jApx09w8VbS8kr+A=;
        b=wVGNXQTES6A4nZvyYecU4e3IXqeEfw6JhkNxKSCmVoz1N4L9auQFJkHWPOTia0KXUm
         MDl4hdvBiVB69xFxwYvHAiz3nOv+BVe6iEamHuSAUpE1M3Q1DUeyUiiEYcRQFdU1LiPV
         QEBZvr0eFjYpUKRBvum3Tnenp9Aefw2RDky8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:date:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        b=A0eGfC4yowray0VEeVnEJzO3X01/3Fp2KdlRxgeABkubKvF6qYFomJIXIIEiWOSYJd
         sgkC3B6qMPqRvJ69TXR/osio6C8cNUdeau5lvzHjbro6KMxywRtdRndsSF2v7O6WHcBX
         Ug0fm1xIB3H9p4Ys7DO9w2zIcLBPY63IXy3YM=
Received: by 10.87.54.5 with SMTP id g5mr3265307fgk.78.1264356351161;
        Sun, 24 Jan 2010 10:05:51 -0800 (PST)
Received: from localhost.localdomain (abvk247.neoplus.adsl.tpnet.pl [83.8.208.247])
        by mx.google.com with ESMTPS id l19sm3669597fgb.5.2010.01.24.10.05.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Jan 2010 10:05:50 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0OI5N90014630
	for <git@vger.kernel.org>; Sun, 24 Jan 2010 19:05:34 +0100
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137906>

In Internet Explorer 8 (IE8) the 'blame_incremental' view, which uses
JavaScript to generate blame info using AJAX, sometimes hang at the
beginning (at 0%) of blaming, e.g. for larger files with long history
like git's own gitweb/gitweb.perl.

The error shown by JavaScript console is "Unspecified error" at char:2
of the following line in gitweb/gitweb.js:

  if (xhr.readyState === 3 && xhr.status !== 200) {

Debugging it using IE8 JScript debuger shown that the error occurs
when trying to access xhr.status (xhr is XMLHttpRequest object).
Watch for xhr object shows 'Unspecified error.' as "value" of
xhr.status, and trying to access xhr.status from console throws error.

This bug is some intermittent bug, depending on XMLHttpRequest timing,
as it doesn't occur in all cases.  It is probably caused by the fact
that handleResponse is called from timer (pollTimer), to work around
the fact that some browsers call onreadystatechange handler only once
for each state change, and not like required for 'blame_incremental'
as soon as new data is available from server.  It looks like xhr
object is not properly initialized; still it is a bug to throw an
error when accessing xhr.status (and not use 'null' or 'undefined' as
value).

Work around this bug in IE8 by using try-catch block when accessing
xhr.status.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It is, if I remember correctly, resend.

I don't have IE6 nor IE7 to check whether this bug is present also in
older versions of Internet Explorer...

 gitweb/gitweb.js |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.js b/gitweb/gitweb.js
index 2a25b7c..9c66928 100644
--- a/gitweb/gitweb.js
+++ b/gitweb/gitweb.js
@@ -779,7 +779,12 @@ function handleResponse() {
 	}
 
 	// the server returned error
-	if (xhr.readyState === 3 && xhr.status !== 200) {
+	// try ... catch block is to work around bug in IE8
+	try {
+		if (xhr.readyState === 3 && xhr.status !== 200) {
+			return;
+		}
+	} catch (e) {
 		return;
 	}
 	if (xhr.readyState === 4 && xhr.status !== 200) {

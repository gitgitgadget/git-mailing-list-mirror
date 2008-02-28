From: "Angus Salkeld" <ahsalkeld@gmail.com>
Subject: [PATCH] stg mail crashes when there is no patch description
Date: Fri, 29 Feb 2008 12:14:36 +1300
Message-ID: <8daa1da0802281514wcaaafc0m436311f0046ba0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 29 00:15:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUryD-0008Hf-3u
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 00:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758709AbYB1XOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 18:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758109AbYB1XOn
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 18:14:43 -0500
Received: from ti-out-0910.google.com ([209.85.142.186]:26310 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756912AbYB1XOm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 18:14:42 -0500
Received: by ti-out-0910.google.com with SMTP id 28so3295701tif.23
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 15:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=MFUu2WGEcPcdbU0RhGr9RkCNF/EgNcCAJJGMMERACEw=;
        b=wE0ZeyufsarJeNNakJkPt4rDQMMLTyUGXr7TiWHU/sz+DOfvxrr5Ll/myfki1qa06MInn9rJlBv6fFJeZy9rnA+zVr1BC6Je8yvQ6Ldq25RdDz3f16bmKecUqvqWRYr0DSELI21MiUFQTR4O9v0f7B5QycmFnKFrKQWDchBVNao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=CBS5P/FRlqMuAMrU/RXZk2huEsUEcOPHdrAFpr4UbjsKyXg8F1lu/bDfw/YanAsK/D0hy32dbb4IsNDGxqdezvBnBUlGlIKVfAjA0CCnxrtLcV/t81UL8cUDUZMk+RX/uQL/U5oiQRXheziYCTzwP7mMSrKfc5KCy6sp1hqOaLM=
Received: by 10.150.139.15 with SMTP id m15mr3075713ybd.30.1204240476386;
        Thu, 28 Feb 2008 15:14:36 -0800 (PST)
Received: by 10.150.95.18 with HTTP; Thu, 28 Feb 2008 15:14:36 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75475>

stg mail crashes when there is no patch description

The error is:
File "/usr/lib/python2.4/site-packages/stgit/commands/mail.py", line
397, in __build_message
descr = p.get_description().strip()
AttributeError: 'NoneType' object has no attribute 'strip'

This patch tries to handle this a bit better by setting the description
to "<empty message>" and forcing the edit_patches option on.
---

 stgit/commands/mail.py |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)


diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index f12d694..63c4b39 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -393,7 +393,13 @@ def __build_message(tmpl, patch, patch_nr,
total_nr, msg_id, ref_id, options):
     """
     p = crt_series.get_patch(patch)

-    descr = p.get_description().strip()
+    if p.get_description():
+        descr = p.get_description().strip()
+    else:
+        # provide a place holder and force the edit message option on
+        descr = '<empty message>'
+        options.edit_patches = True
+
     descr_lines = descr.split('\n')

     short_descr = descr_lines[0].rstrip()

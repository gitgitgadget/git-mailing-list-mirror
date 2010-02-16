From: Evan Powers <evan.powers@gmail.com>
Subject: [PATCH] git-p4: fix bug in symlink handling
Date: Tue, 16 Feb 2010 00:44:08 -0800
Message-ID: <6682cfcf1002160044i7aacd1b0t7bb351380b1bd27c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: gitster@pobox.com, Simon Hausmann <simon@lst.de>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 09:44:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhJ2W-0005PB-AM
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 09:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022Ab0BPIoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 03:44:10 -0500
Received: from mail-pz0-f187.google.com ([209.85.222.187]:33984 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759Ab0BPIoI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 03:44:08 -0500
Received: by pzk17 with SMTP id 17so4828585pzk.4
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 00:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=uwtkvQwOwenalHQjOUlbF81uWwO77FWOgZMTKGOs4s8=;
        b=aqNjqpsiNLP0xg2prKjW95ZRyRogoP5Q6eJR6LFoNpzpXo0ZlhjeRfVZ6lur/vBXXz
         fHd6HAKlB2s/HoUAT1W9w7F6wb4RCVo/LDqjqlv0ni0Dc9QopwWRhY2uJ7O/y/03EHn+
         OBZ+bmTbB64F9l9dNSLfc7S3lYbMrseTFVfow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=gWwz00lGWmXFrXcu3Rrsty2tqKvpK6LwNRXa3YDk6R1avHb8SwHGiQeGDsYbXiqzC0
         wOP9TAVYsmDmVQ3arEAB96RAZoagd5MRJjmQ7Q988ywmp6XtSbdXq9ZyCld2SoVt4LP6
         fTU5xZTJBBK9yGZ8KKTnb6Se80Mk9r2rsOy84=
Received: by 10.143.21.9 with SMTP id y9mr4143790wfi.229.1266309848069; Tue, 
	16 Feb 2010 00:44:08 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140086>

Fix inadvertent breakage from b932705 in the code that strips the
trailing '\n' from p4 print on a symlink. (In practice, contents is of
the form ['target\n', ''].)

Signed-off-by: Evan Powers <evan.powers@gmail.com>
---
This patch Works For Me, but I didn't take the time to understand the
entire code path so it might be equally valid to replace contents.pop()
with contents.pop(0) and call it a day.

 contrib/fast-import/git-p4 |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index e7c4814..cd96c6f 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -967,9 +967,8 @@ class P4Sync(Command):
         elif file["type"] == "symlink":
             mode = "120000"
             # p4 print on a symlink contains "target\n", so strip it off
-            last = contents.pop()
-            last = last[:-1]
-            contents.append(last)
+            data = ''.join(contents)
+            contents = [data[:-1]]

         if self.isWindows and file["type"].endswith("text"):
             mangled = []
-- 
1.6.6

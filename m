From: Ilyas -- <umask00@gmail.com>
Subject: Versioning configuration files on a server: fatal: Unable to create
 '//etc/.git/index.lock': No such file or directory
Date: Wed, 24 Nov 2010 11:01:21 +0300
Message-ID: <AANLkTikfg9fLtqC6V3hQkiSZ+RfWqViJsHPxrt6ycoRR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 24 09:01:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLAIC-0002sO-ED
	for gcvg-git-2@lo.gmane.org; Wed, 24 Nov 2010 09:01:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071Ab0KXIBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Nov 2010 03:01:23 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:37105 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744Ab0KXIBX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Nov 2010 03:01:23 -0500
Received: by wyb28 with SMTP id 28so9202682wyb.19
        for <git@vger.kernel.org>; Wed, 24 Nov 2010 00:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=fJeJJ6+3uf61s3akeVCVndWnTF60+EBQjjcUIOWU9SU=;
        b=a4/1ujN3OJ65RkpIMfOrHQuvh2uAC7KslJGAlwTfQibIactjr6dVRUAa2D6ElJEjYy
         BnqizUaEm5oPYmTZHeXCPLjxeRF2gn0FT90+SG87IRA2b4FPIXsISZ2GmC6YF8XkGGGN
         Py7xnyeR3YAERlPuT4DIW85SLjIh2CrGZoMH8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=MX71nXr0KYZhvcfD/ivFi+nsi5iUdkhHtwKdahmWrcFbtHWFHjOgYpksN5RIo5RKsA
         iZtUK2akdj6AdXpIC1jwAHocqHxX37H13cDxJ2m7frHa5JQF20h2UzGYzFCqlrkvR/8l
         lT1QtvbjEti6J/fFbbVFZ0leab7yDVNBLulVU=
Received: by 10.216.35.133 with SMTP id u5mr7200913wea.72.1290585681183; Wed,
 24 Nov 2010 00:01:21 -0800 (PST)
Received: by 10.216.234.216 with HTTP; Wed, 24 Nov 2010 00:01:21 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162051>

Hi!

The patch bellow for problem 'Versioning configuration files on a
server: fatal: Unable to create '//etc/.git/index.lock': No such file
or directory' works fine on FreeBSD/Linux.
Please fix this problem in upstream.

Thank you.


diff --git a/dir.c b/dir.c
index d1e5e5e..5408db9 100644
--- a/dir.c
+++ b/dir.c
@@ -943,6 +943,7 @@ int file_exists(const char *f)


 char *get_relative_cwd(char *buffer, int size, const char *dir)

 {
        char *cwd = buffer;
+       size_t len, root_len;

        if (!dir)
                return NULL;
@@ -952,6 +953,15 @@ char *get_relative_cwd(char *buffer, int size,
const char *dir)

        if (!is_absolute_path(dir))


                dir = make_absolute_path(dir);

+       len = strlen(dir);
+       root_len = offset_1st_component(dir);
+
+       if (root_len >= len) {

+           /* dir is the filesystem root, so the cwd is always inside */


+           root_len = offset_1st_component(cwd);
+           return cwd + root_len;
+       }
+
        while (*dir && *dir == *cwd) {

                dir++;
                cwd++;

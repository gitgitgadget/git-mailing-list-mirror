From: Aleksander Boruch-Gruszecki <aleksander.boruchgruszecki@gmail.com>
Subject: [PATCH] merge-file: correctly open files when in a subdir
Date: Sun, 8 Feb 2015 17:53:53 +0100
Message-ID: <CAPHKiG7yP=QZBVdDbyQp=uyMX0EsmUqgO-LO8pscn7hcbP0RCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: stefanbeller@googlemail.com, pclouds@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 17:54:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YKV7Q-0002nD-Ab
	for gcvg-git-2@plane.gmane.org; Sun, 08 Feb 2015 17:54:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758276AbbBHQxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2015 11:53:55 -0500
Received: from mail-qg0-f65.google.com ([209.85.192.65]:61082 "EHLO
	mail-qg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757658AbbBHQxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2015 11:53:54 -0500
Received: by mail-qg0-f65.google.com with SMTP id h3so4559637qgf.0
        for <git@vger.kernel.org>; Sun, 08 Feb 2015 08:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=3hlNsaFCRhYZaFDVyDldbyDZ4K7qQCSwY1vkv6rthqs=;
        b=czI3zPBjXyppnhRj/hAJc95rig+PvlvJGQYziclwiab19PdYrpi3nDwU/7C/u6HrQT
         xn/+eIQRAos/9YMtvfhXJHu+wp2IPzEJhv5YSyA28GAW1WSsrP26CWZzXQ8SziUfyed3
         j3teh/tLV+P8lp1Gj3lcEoJ3QVha2kKL+IVBXJ5rgyl4fapRsHFFFdJsiK3VOKIKbfWs
         AjNJpO2c0nTj1j6xO4wX35t1QN7fyhLRAm/LhONBItkIt2U23hjZFgdiT9PmEI++huhc
         m13pyFtfBjCV3ZllStOL+dCR/KroIPGocBlQRxeB+1/E8IXeJMfIwd65rMhLLPECEC36
         gEdQ==
X-Received: by 10.224.68.8 with SMTP id t8mr1300958qai.72.1423414433666; Sun,
 08 Feb 2015 08:53:53 -0800 (PST)
Received: by 10.140.36.201 with HTTP; Sun, 8 Feb 2015 08:53:53 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263527>

run_setup_gently() is called before merge-file. This may result in changing
current working directory, which wasn't taken into account when opening a file
for writing.

Fix by prepending the passed prefix. Previous var is left so that error
messages keep referring to the file from the user's working directory
perspective.

Signed-off-by: Aleksander Boruch-Gruszecki
    <aleksander.boruchgruszecki@gmail.com>
---
I'm sorry if I'm sending the copies to wrong people, but I had no idea
who to send them to since there were barely any changes to the file.
Since the fix is so trivial I didn't add any tests, but I can create
some if they're needed.

 builtin/merge-file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 844f84f..232b768 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -90,7 +90,8 @@ int cmd_merge_file(int argc, const char **argv,
const char *prefix)

     if (ret >= 0) {
         const char *filename = argv[0];
-        FILE *f = to_stdout ? stdout : fopen(filename, "wb");
+        const char *fpath = prefix_filename(prefix, prefixlen, argv[0]);
+        FILE *f = to_stdout ? stdout : fopen(fpath, "wb");

         if (!f)
             ret = error("Could not open %s for writing", filename);
-- 
1.9.1

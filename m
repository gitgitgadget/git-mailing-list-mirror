From: Petr Stodulka <pstodulk@redhat.com>
Subject: [BUG] [PATCH] infinite loop due to broken symlink
Date: Mon, 23 Mar 2015 17:04:45 +0100
Message-ID: <5510399D.4020007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 17:04:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya4qS-0006xx-UA
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 17:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbbCWQEs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 12:04:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38296 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288AbbCWQEr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 12:04:47 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2NG4l9A029188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <git@vger.kernel.org>; Mon, 23 Mar 2015 12:04:47 -0400
Received: from [10.34.4.110] (unused-4-110.brq.redhat.com [10.34.4.110])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t2NG4j6V030434
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 23 Mar 2015 12:04:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266145>

Hi guys,
git goes into an infinite loop due to broken symlink (minimal reproducer 
[0]).  Affected code is in function
"resolve_ref_unsafe" in file refs.c - notice 'stat_ref'. There is comment
about problem with race condition, hovewer in that case it's regular broken
symlink which cause infinite loop. Possible patch could be something 
like this:

-------------------------------------------------------
diff --git a/refs.c b/refs.c
index e23542b..9efe8d2 100644
--- a/refs.c
+++ b/refs.c
@@ -1356,6 +1356,7 @@ static struct ref_dir *get_loose_refs(struct 
ref_cache *refs)
  /* We allow "recursive" symbolic refs. Only within reason, though */
  #define MAXDEPTH 5
  #define MAXREFLEN (1024)
+#define MAXLOOP 1024

  /*
   * Called by resolve_gitlink_ref_recursive() after it failed to read
@@ -1482,6 +1483,7 @@ const char *resolve_ref_unsafe(const char 
*refname, int resolve_flags, unsigned
         char buffer[256];
         static char refname_buffer[256];
         int bad_name = 0;
+    int loop_counter = 0;

         if (flags)
                 *flags = 0;
@@ -1546,7 +1548,8 @@ const char *resolve_ref_unsafe(const char 
*refname, int resolve_flags, unsigned
                 if (S_ISLNK(st.st_mode)) {
                         len = readlink(path, buffer, sizeof(buffer)-1);
                         if (len < 0) {
-                               if (errno == ENOENT || errno == EINVAL)
+                               if (loop_counter++ < MAXLOOP &&
+                    (errno == ENOENT || errno == EINVAL))
                                         /* inconsistent with lstat; 
retry */
                                         goto stat_ref;
                                 else
@@ -1579,7 +1582,7 @@ const char *resolve_ref_unsafe(const char 
*refname, int resolve_flags, unsigned
                  */
                 fd = open(path, O_RDONLY);
                 if (fd < 0) {
-                       if (errno == ENOENT)
+                       if (loop_counter++ < MAXLOOP && errno == ENOENT)
                                 /* inconsistent with lstat; retry */
                                 goto stat_ref;
                         else
-------------------------------------------------------

If I understand well that simple check of broken symlink is not possible
due to race conditions.

Regards,
Petr

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1204193

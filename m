From: Karsten Blees <karsten.blees@gmail.com>
Subject: [PATCH] Documentation/i18n.txt: clarify character encoding support
Date: Sat, 13 Jun 2015 22:24:01 +0200
Message-ID: <557C9161.6020703@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 13 22:24:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3ryH-0005ds-Le
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 22:24:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbbFMUYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 16:24:00 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33399 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbbFMUX6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 16:23:58 -0400
Received: by wiwd19 with SMTP id d19so43562316wiw.0
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 13:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=9DTn8Ph0xn91krNfYPOg/+RBXGCwlbfvq+nFcdIEtuU=;
        b=sTHVpSAikTkrjSs6R93yOPgBgxIiNNG0XelRd8DOHM53GUs1u1Y7RvFIWyN5ulX404
         qRBwZkwXIqHpDomS2ctO7XzsvU+PsyJ4CHqFdGhhun6WkBhzfStpo+7KMfgOWQD9PjPV
         W0u75oLWWQKKj4XkSMQbdeuANrQU3yLzCAsE+nb6pdBGIONh2gHmH2C/zIbJDAVLin51
         ofep/sh2p5GRYRs9xoSc/+wdD6SjqK1PhX1STrv9IyYrc4mUSPuBBi74JdglFJMc3bP8
         Xpquo5UFKcILb9TH5FjHs9u8rqvQOj3Zjj8SWRGWxJAuhOgLBRTqIQe6XC9HUHQaGO/8
         u42g==
X-Received: by 10.194.63.228 with SMTP id j4mr38196083wjs.38.1434227037461;
        Sat, 13 Jun 2015 13:23:57 -0700 (PDT)
Received: from [10.1.116.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id u7sm8635959wif.3.2015.06.13.13.23.56
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jun 2015 13:23:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271588>

As a "distributed" VCS, git should better define the encodings of its core
textual data structures, in particular those that are part of the network
protocol.

That git is encoding agnostic is only really true for blob objects. E.g.
the 'non-NUL bytes' requirement of tree and commit objects excludes
UTF-16/32, and the special meaning of '/' in the index file as well as
space and linefeed in commit objects eliminates EBCDIC and other non-ASCII
encodings.

Git expects bytes < 0x80 to be pure ASCII, thus CJK encodings that partly
overlap with the ASCII range are problematic as well. E.g. fmt_ident()
removes trailing 0x5C from user names on the assumption that it is ASCII
'\'. However, there are over 200 GBK double byte codes that end in 0x5C.

UTF-8 as default encoding on Linux and respective path translations in the
Mac and Windows versions have established UTF-8 NFC as de-facto standard
for path names.

Update the documentation in i18n.txt to reflect the current status-quo.

Signed-off-by: Karsten Blees <blees@dcon.de>
---
 Documentation/i18n.txt | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index e9a1d5d..e5f6233 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -1,18 +1,28 @@
-At the core level, Git is character encoding agnostic.
-
- - The pathnames recorded in the index and in the tree objects
-   are treated as uninterpreted sequences of non-NUL bytes.
-   What readdir(2) returns are what are recorded and compared
-   with the data Git keeps track of, which in turn are expected
-   to be what lstat(2) and creat(2) accepts.  There is no such
-   thing as pathname encoding translation.
+Git is to some extent character encoding agnostic.
 
  - The contents of the blob objects are uninterpreted sequences
    of bytes.  There is no encoding translation at the core
    level.
 
- - The commit log messages are uninterpreted sequences of non-NUL
-   bytes.
+ - Pathnames are encoded in UTF-8 normalization form C. This
+   applies to tree objects, the index file, ref names and
+   config files (`.git/config` (see linkgit:git-config[1]),
+   linkgit:gitignore[5], linkgit:gitattributes[5] and
+   linkgit:gitmodules[5]).
+   The Mac and Windows versions automatically translate pathnames
+   to and from UTF-8 NFC in their readdir(2), lstat(2), creat(2)
+   etc. APIs. However, there is no such translation on other
+   platforms. If file system APIs don't use UTF-8 (which may be
+   file system specific), it is recommended to stick to pure
+   ASCII file names. While Git technically supports other
+   extended ASCII encodings at the core level, such repositories
+   will not be portable.
+
+ - Commit log messages are typically encoded in UTF-8, but other
+   extended ASCII encodings are also supported. This includes
+   ISO-8859-x, CP125x and many others, but _not_ UTF-16/32,
+   EBCDIC and CJK multi-byte encodings (GBK, Shift-JIS, Big5,
+   EUC-x, CP9xx etc.).
 
 Although we encourage that the commit log messages are encoded
 in UTF-8, both the core and Git Porcelain are designed not to
-- 
2.4.1.windows.1

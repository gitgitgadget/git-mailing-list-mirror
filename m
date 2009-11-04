From: Abdelrazak Younes <younes@lyx.org>
Subject: [QGIT PATCH/RFC]
Date: Wed, 04 Nov 2009 15:56:48 +0100
Organization: LyX
Message-ID: <4AF19630.2070402@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 15:57:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5hIG-0004pt-G3
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 15:57:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756374AbZKDO4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 09:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756161AbZKDO4x
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 09:56:53 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:8080 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756133AbZKDO4x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 09:56:53 -0500
Received: by ey-out-2122.google.com with SMTP id d26so907469eyd.19
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 06:56:57 -0800 (PST)
Received: by 10.213.100.167 with SMTP id y39mr189040ebn.51.1257346617343;
        Wed, 04 Nov 2009 06:56:57 -0800 (PST)
Received: from ?192.168.4.216? ([62.161.104.182])
        by mx.google.com with ESMTPS id 5sm976070eyf.39.2009.11.04.06.56.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Nov 2009 06:56:55 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132091>

Hello Marco,

While recompiling latest qgit4, I stumbled accross this. I am not quite 
sure you used a QLatin1String instead of a QByteArray but the attached 
seems to work fine...

Anyway, I'll let you decide what do to with it.

Thanks for QGit,
Abdel.


diff --git a/src/cache.cpp b/src/cache.cpp 
 

index af18fbf..2d9f415 100644 
 

--- a/src/cache.cpp 
 

+++ b/src/cache.cpp 
 

@@ -70,11 +70,11 @@ bool Cache::save(const QString& gitDir, const 
RevFileMap& rf, 

                 const ShaString& sha = it.key(); 
 

                 if (   sha == ZERO_SHA_RAW 
 

                     || sha == CUSTOM_SHA_RAW 
 

-                   || sha.latin1()[0] == 'A') // ALL_MERGE_FILES + rev 
sha 

+                   || sha.at(0) == 'A') // ALL_MERGE_FILES + rev sha 
 

                         continue; 
 


                 v.append(it.value());
-               buf.append(sha.latin1()).append('\0');
+               buf.append(sha);
                 newSize += 41;
                 if (newSize > bufSize) {
                         dbs("ASSERT in Cache::save, out of allocated 
space");
diff --git a/src/common.h b/src/common.h
index ceb62fb..0d65980 100644
--- a/src/common.h
+++ b/src/common.h
@@ -7,6 +7,7 @@
  #ifndef COMMON_H
  #define COMMON_H

+#include <QByteArray>
  #include <QColor>
  #include <QEvent>
  #include <QFont>
@@ -49,7 +50,7 @@ class QDataStream;
  class QProcess;
  class QSplitter;
  class QWidget;
-class ShaString;
+typedef QByteArray ShaString;

  // type shortcuts
  typedef const QString&              SCRef;
@@ -274,18 +275,6 @@ namespace QGit {
         extern const QString SCRIPT_EXT;
  }

-class ShaString : public QLatin1String {
-public:
-       inline ShaString() : QLatin1String(NULL) {}
-       inline ShaString(const ShaString& sha) : 
QLatin1String(sha.latin1()) {}
-       inline explicit ShaString(const char* sha) : QLatin1String(sha) {}
-
-       inline bool operator!=(const ShaString& o) const { return 
!operator==(o); }
-       inline bool operator==(const ShaString& o) const {
-
-               return (latin1() == o.latin1()) || !qstrcmp(latin1(), 
o.latin1());
-       }
-};

  class Rev {
         // prevent implicit C++ compiler defaults
diff --git a/src/git.cpp b/src/git.cpp
index 177b24a..afa5234 100644
--- a/src/git.cpp
+++ b/src/git.cpp
@@ -725,7 +725,7 @@ const Rev* Git::revLookup(SCRef sha, const 
FileHistory* fh) const {
  const Rev* Git::revLookup(const ShaString& sha, const FileHistory* fh) 
const {

         const RevMap& r = (fh ? fh->revs : revData->revs);
-       return (sha.latin1() ? r.value(sha) : NULL);
+       return (sha.isEmpty() ? NULL : r.value(sha));
  }

  bool Git::run(SCRef runCmd, QString* runOutput, QObject* receiver, 
SCRef buf) {
diff --git a/src/namespace_def.cpp b/src/namespace_def.cpp
index 80c2551..2960c36 100644
--- a/src/namespace_def.cpp
+++ b/src/namespace_def.cpp
@@ -95,7 +95,7 @@ static inline uint hexVal(const uchar* ch) {

  uint qHash(const ShaString& s) { // fast path, called 6-7 times per 
revision

-       const uchar* ch = reinterpret_cast<const uchar*>(s.latin1());
+       const uchar* ch = reinterpret_cast<const uchar*>(s.data());
         return (hexVal(ch     ) << 24)
              + (hexVal(ch +  2) << 20)
              + (hexVal(ch +  4) << 16)

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [GUILT] [PATCH 5/7] Fix fatal "guilt graph" error in sha1sum
 invocation.
Date: Tue, 15 Jan 2013 18:29:13 -0800
Message-ID: <20130116022913.GN12524@google.com>
References: <20130116022606.GI12524@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>,
	Theodore Ts'o <tytso@mit.edu>, Iulian Udrea <iulian@linux.com>,
	Axel Beckert <abe@deuxchevaux.org>
To: Josef 'Jeff' Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:29:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvIl2-0002fH-4b
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 03:29:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758070Ab3APC3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 21:29:19 -0500
Received: from mail-da0-f46.google.com ([209.85.210.46]:51329 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758050Ab3APC3R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 21:29:17 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so329462dak.19
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 18:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=+lSeHeZ7avLgb1QliCzRVVamN8fYxetVxnVXWwxqBFc=;
        b=NAe5U+0nY52kgcnJveZPsIMpUQ8Gt4knOE5ZssFTyROFrBbU3J27RwqU8tnXnzlv7p
         LokTxkJLY4N1vJ/YOKB1cshyzsbv1uq+OY0s374yHaCmXnLUWOgHVjFNVRAOwJ9/pOKv
         EKctGxUoSHTivW2cQzHNa41qhTfoz+CJS5X+v3d8/415A2SzegsMnhI6c55ywxGGLxHq
         /N+CEJWa0JoCzlWp6W26/WZDUbivIgd/tTVw2i3JQlEatFpr0Xwi/nfiyKMajSy7csmE
         hTvKw1LosWjLw3SnI/Atzo4A0KaTiFaf5VTAl26c863UwJwCoAjdRJXbniy0KkTXuGLk
         Y+Dg==
X-Received: by 10.68.192.97 with SMTP id hf1mr269558559pbc.106.1358303357318;
        Tue, 15 Jan 2013 18:29:17 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id z10sm11944530pax.38.2013.01.15.18.29.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 15 Jan 2013 18:29:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20130116022606.GI12524@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213713>

From: Per Cederqvist <cederp@opera.com>
Date: Wed, 14 Mar 2012 14:34:38 +0100

Fix the compatibility function sha1 so that it reads from
stdin (and not a file with a zero-length file name) when
no argument is supplied.

[jn: adapted to also handle newer versions of OpenSSL,
 based on reports from Andreas Schwab and John Szakmeister.

 $ openssl dgst -sha1</dev/null
 da39a3ee5e6b4b0d3255bfef95601890afd80709
 $ openssl version
 OpenSSL 0.9.8o 01 Jun 2010

 $ openssl dgst -sha1 </dev/null
 (stdin)= da39a3ee5e6b4b0d3255bfef95601890afd80709
 $ openssl version
 OpenSSL 1.0.0d 8 Feb 2011
]

Signed-off-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 os.Darwin | 7 ++++++-
 os.Linux  | 7 ++++++-
 os.SunOS  | 7 ++++++-
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/os.Darwin b/os.Darwin
index 470f5fb..3f23121 100644
--- a/os.Darwin
+++ b/os.Darwin
@@ -27,7 +27,12 @@ head_n()
 # usage: sha1 [file]
 sha1()
 {
-	openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).= \(.*\),\2  \1,"
+	if [ $# = 1 ]
+	then
+		openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).= \(.*\),\2  \1,"
+	else
+		openssl dgst -sha1 | sed 's,\(.*= \)*\(.*\),\2  -,'
+	fi
 }
 
 # usage: cp_a <src> <dst>
diff --git a/os.Linux b/os.Linux
index 30b9cb0..aaebf88 100644
--- a/os.Linux
+++ b/os.Linux
@@ -30,7 +30,12 @@ head_n()
 # usage: sha1 [file]
 sha1()
 {
-	sha1sum "$1"
+	if [ $# = 1 ]
+	then
+		sha1sum "$1"
+	else
+		sha1sum
+	fi
 }
 
 # usage: cp_a <src> <dst>
diff --git a/os.SunOS b/os.SunOS
index 30b9cb0..aaebf88 100644
--- a/os.SunOS
+++ b/os.SunOS
@@ -30,7 +30,12 @@ head_n()
 # usage: sha1 [file]
 sha1()
 {
-	sha1sum "$1"
+	if [ $# = 1 ]
+	then
+		sha1sum "$1"
+	else
+		sha1sum
+	fi
 }
 
 # usage: cp_a <src> <dst>
-- 
1.8.1

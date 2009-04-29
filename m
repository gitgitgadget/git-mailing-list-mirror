From: Samuel Tardieu <sam@rfc1149.net>
Subject: Re: [StGit PATCH 9/9] Use the default git colouring scheme rather than specific scripts
Date: Wed, 29 Apr 2009 13:48:29 +0200
Organization: RFC 1149 (see http://www.rfc1149.net/)
Message-ID: <2009-04-29-13-48-29+trackit+sam@rfc1149.net>
References: <20090428150742.27261.19620.stgit@pc1117.cambridge.arm.com>
	<20090428151025.27261.15964.stgit@pc1117.cambridge.arm.com>
	<20090429064331.GI18483@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 13:48:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz8HM-0000fr-BP
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 13:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbZD2Lsi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Apr 2009 07:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbZD2Lsh
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 07:48:37 -0400
Received: from zoidberg.rfc1149.net ([91.121.19.179]:39060 "EHLO
	zoidberg.rfc1149.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbZD2Lsg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Apr 2009 07:48:36 -0400
Received: from localhost (localhost [127.0.0.1])
	by zoidberg.rfc1149.net (Postfix) with ESMTP id A865F11022E;
	Wed, 29 Apr 2009 13:48:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rfc1149.net
Received: from zoidberg.rfc1149.net ([127.0.0.1])
	by localhost (zoidberg.rfc1149.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RORTgVPrJU1a; Wed, 29 Apr 2009 13:48:30 +0200 (CEST)
Received: from mail2.rfc1149.net (willow.rfc1149.net [IPv6:2001:6f8:37a:2::2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail2.rfc1149.net", Issuer "CAcert Class 3 Root" (verified OK))
	by zoidberg.rfc1149.net (Postfix) with ESMTPS id 99E4B10FAF0;
	Wed, 29 Apr 2009 13:48:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mail2.rfc1149.net (Postfix) with ESMTP id 9F467C40C5;
	Wed, 29 Apr 2009 13:48:29 +0200 (CEST)
Received: from mail2.rfc1149.net ([127.0.0.1])
	by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pPbzeDHT24Pb; Wed, 29 Apr 2009 13:48:29 +0200 (CEST)
Received: by mail2.rfc1149.net (Postfix, from userid 1000)
	id 6D3F5C40C6; Wed, 29 Apr 2009 13:48:29 +0200 (CEST)
In-Reply-To: <20090429064331.GI18483@diana.vm.bytemark.co.uk> ("Karl
 =?iso-8859-1?Q?Hasselstr=F6m=22's?= message of "Wed\, 29 Apr 2009
 08\:43\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117875>

Author: Samuel Tardieu <sam@rfc1149.net>
Date:   Wed Apr 29 13:45:06 2009 +0200

Load the whole config at once and cache it for future use

The whole configuration files are read using

  git config --list --null

and cached for future lookups.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
>>>>> "Karl" =3D=3D Karl Hasselstr=F6m <kha@treskal.com> writes:

Karl> But config.get() should be dirt cheap, because we should be
Karl> reading in all the config values at once the first time we need
Karl> one of them. But as I recall we don't currently do that, so my
Karl> one-liner might not be so clever after all ...

Something like this may be useful then.

  Sam

diff --git a/stgit/config.py b/stgit/config.py
index dbca5fb..c40756c 100644
--- a/stgit/config.py
+++ b/stgit/config.py
@@ -40,25 +40,31 @@ class GitConfig:
         'stgit.shortnr':	 '5'
         }
=20
-    __cache=3D{}
+    __cache =3D None
+
+    def load(self):
+        """Load the whole configuration in __cache unless it has been
+        done already."""
+        if self.__cache is not None:
+            return
+        self.__cache =3D {}
+        lines =3D Run('git', 'config', '--list', '--null').raw_output(=
)
+        for line in filter(None, lines.split('\0')):
+            key, value =3D line.split('\n', 1)
+            self.__cache.setdefault(key, []).append(value)
=20
     def get(self, name):
-        if self.__cache.has_key(name):
-            return self.__cache[name]
-        try:
-            value =3D Run('git', 'config', '--get', name).output_one_l=
ine()
-        except RunException:
-            value =3D self.__defaults.get(name, None)
-        self.__cache[name] =3D value
-        return value
+        self.load()
+        if name not in self.__cache:
+            self.__cache[name] =3D [self.__defaults.get(name, None)]
+        return self.__cache[name][0]
=20
     def getall(self, name):
-        if self.__cache.has_key(name):
+        self.load()
+        try:
             return self.__cache[name]
-        values =3D Run('git', 'config', '--get-all', name
-                     ).returns([0, 1]).output_lines()
-        self.__cache[name] =3D values
-        return values
+        except KeyError:
+            return []
=20
     def getint(self, name):
         value =3D self.get(name)

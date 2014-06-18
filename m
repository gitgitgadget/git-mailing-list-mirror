From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 0/5] cleanup duplicate name_compare() functions
Date: Wed, 18 Jun 2014 11:45:12 -0700
Message-ID: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 18 20:45:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxKru-0006wh-7f
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 20:45:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbaFRSpx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jun 2014 14:45:53 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:57541 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaFRSpw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 14:45:52 -0400
Received: by mail-pa0-f43.google.com with SMTP id lf10so1022432pab.30
        for <git@vger.kernel.org>; Wed, 18 Jun 2014 11:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=9NuLkqA34yoVg5MVclhUelN4Wx5bbc7WVsEIs5ZHXbU=;
        b=L9n+h9kYAMTep3HLugD9akrymzsFY68ISYTqMuHyTbalX3cgt89N6y6LSBgh7H5gfN
         zdmNGpf8pBseAcnUq00kKZ4C+w27GBjeQPKgPiPT+TjE4JfcsIfsdtK7DWxoHduLKqHf
         G1C38STlcBvLXj7veOdwwwx1+7cYRlfrrM83mHUZIzt8JGjCTRmzAe0vEHYguFpIY3uH
         9IpPrlOagejzIQEivYNFaKUn4CIBgSdyYDCQOAdcWtyFziPTDkmsQ4zTxADt1OZYauJ4
         rCmSLdoerFZak2bkbyVR4Yi9a0HvO0LyDnfoczLf7HkmeidIThNIUpqZf6q9LuPfbhs3
         SKBA==
X-Received: by 10.66.65.225 with SMTP id a1mr4674190pat.139.1403117152216;
        Wed, 18 Jun 2014 11:45:52 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id fd5sm14271505pad.12.2014.06.18.11.45.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jun 2014 11:45:51 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.697.g57b47e0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252020>

Version 3 of the patch series to cleanup duplicate name_compare()
functions (previously was 'add strnncmp() function' [1]). =20

This version goes in a slightly different direction than the previous
version.  Before I was trying to add a strnncmp() function so I could
remove duplicate copies of the name_compare() function in tree-walk.c
and unpack-trees.c.  But then Torsten B=C3=B6gershausen pointed out tha=
t
there is a cache_name_compare() function which is nearly identical to
name_compare() [2]*.

* cache_name_compare() is not identical to name_compare().  The former
  returns +1, -1, whereas the latter returns +N, -N.  But there is no
  place where name_compare() was used that needed the magnitude so this
  change would not alter its behavior.

So I decided why not generalize the name of cache_name_compare() by
renaming it to  name_compare(), since it doesn't do anything with
caches, other than being part of cache.h and read-cache.c.  Then the
duplicate name_compare() functions can be removed and the few places
that used cache_name_compare() can be renamed to name_compare().

It cleans up the code with a minimal number of changes.  It keeps
existing functions instead of creating new ones.  And there are several
other functions in cache.h that are similarly named '*name_compare' so
it follows the already established style.

Also, the name_compare() now uses memcmp() as it did originally instead
of using strncmp() as it did in the last version.

[1]: http://marc.info/?l=3Dgit&m=3D140299051431479&w=3D2

[2]: http://marc.info/?l=3Dgit&m=3D140300329403706&w=3D2

Jeremiah Mahler (5):
  cache: rename cache_name_compare() to name_compare()
  tree-walk.c: remove name_compare() function
  unpack-trees.c: remove name_compare() function
  dir.c: rename to name_compare()
  name-hash.c: rename to name_compare()

 cache.h        |  2 +-
 dir.c          |  3 +--
 name-hash.c    |  2 +-
 read-cache.c   | 23 +++++++++++++----------
 tree-walk.c    | 10 ----------
 unpack-trees.c | 11 -----------
 6 files changed, 16 insertions(+), 35 deletions(-)

--=20
2.0.0

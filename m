From: Clemens Buchacher <clemens.buchacher@intel.com>
Subject: [PATCH] git_open_noatime: return with errno=0 on success
Date: Wed, 8 Jul 2015 14:38:20 +0200
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany - Tel: +49 89 99 8853-0, www.intel.de - Managing Directors: Prof. Dr. Hermann Eul, Christin Eisenschmid - Chairperson of the Supervisory Board: Tiffany Doon Silva - Registered Office: Munich - Commercial Register: Amtsgericht Mnchen HRB 186928
Message-ID: <20150708123820.GA25269@musxeris015.imu.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Martin =?iso-8859-1?Q?Schr=F6der?= <martin.h.schroeder@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 14:38:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCocP-0005UL-1Z
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 14:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758349AbbGHMiY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jul 2015 08:38:24 -0400
Received: from mga01.intel.com ([192.55.52.88]:26481 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758287AbbGHMiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2015 08:38:23 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP; 08 Jul 2015 05:38:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,431,1432623600"; 
   d="scan'208";a="758318262"
Received: from musxeris015.imu.intel.com (HELO localhost) ([10.216.40.13])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jul 2015 05:38:22 -0700
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273678>

In read_sha1_file_extended we die if read_object fails with a fatal
error. We detect a fatal error if errno is non-zero and is not
ENOENT. If the object could not be read because it does not exist,
this is not considered a fatal error and we want to return NULL.

Somewhere down the line, read_object calls git_open_noatime to open
a pack index file, for example. We first try open with O_NOATIME.
If O_NOATIME fails with EPERM, we retry without O_NOATIME. When the
second open succeeds, errno is however still set to EPERM from the
first attemt. When we finally determine that the object does not
exist, read_object returns NULL and read_sha1_file_extended dies
with a fatal error:

    fatal: failed to read object <sha1>: Operation not permitted

=46ix this by resetting errno to zero before we call open again.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Clemens Buchacher <clemens.buchacher@intel.com>
Helped-by: Martin Schr=F6der <martin.h.schroeder@intel.com>
---
 sha1_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sha1_file.c b/sha1_file.c
index 77cd81d..62b7ad6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1453,6 +1453,7 @@ int git_open_noatime(const char *name)
 	static int sha1_file_open_flag =3D O_NOATIME;
=20
 	for (;;) {
+		errno =3D 0;
 		int fd =3D open(name, O_RDONLY | sha1_file_open_flag);
 		if (fd >=3D 0)
 			return fd;
--=20
1.9.4

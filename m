From: Clemens Buchacher <clemens.buchacher@intel.com>
Subject: [PATCH] git_open_noatime: return with errno=0 on success
Date: Tue, 4 Aug 2015 10:24:29 +0200
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany - Tel: +49 89 99 8853-0, www.intel.de - Managing Directors: Prof. Dr. Hermann Eul, Christin Eisenschmid - Chairperson of the Supervisory Board: Tiffany Doon Silva - Registered Office: Munich - Commercial Register: Amtsgericht Mnchen HRB 186928
Message-ID: <20150804082429.GA22271@musxeris015.imu.intel.com>
References: <20150708123820.GA25269@musxeris015.imu.intel.com> <CAPig+cSacM_JwZzagOVZpMJF=oE7m3rMnq1eKr=aNsGY0vvmfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Martin =?iso-8859-1?Q?Schr=F6der?= <martin.h.schroeder@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 04 10:24:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMXWZ-0006Pe-5T
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 10:24:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754922AbbHDIYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 04:24:34 -0400
Received: from mga03.intel.com ([134.134.136.65]:1313 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752679AbbHDIYb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 04:24:31 -0400
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP; 04 Aug 2015 01:24:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,607,1432623600"; 
   d="scan'208";a="776359508"
Received: from musxeris015.imu.intel.com (HELO localhost) ([10.216.40.13])
  by fmsmga002.fm.intel.com with ESMTP; 04 Aug 2015 01:24:29 -0700
Content-Disposition: inline
In-Reply-To: <CAPig+cSacM_JwZzagOVZpMJF=oE7m3rMnq1eKr=aNsGY0vvmfQ@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275242>

In read_sha1_file_extended we die if read_object fails with a fatal
error. We detect a fatal error if errno is non-zero and is not
ENOENT. If the object could not be read because it does not exist,
this is not considered a fatal error and we want to return NULL.

Somewhere down the line, read_object calls git_open_noatime to open
a pack index file, for example. We first try open with O_NOATIME.
If O_NOATIME fails with EPERM, we retry without O_NOATIME. When the
second open succeeds, errno is however still set to EPERM from the
first attempt. When we finally determine that the object does not
exist, read_object returns NULL and read_sha1_file_extended dies
with a fatal error:

    fatal: failed to read object <sha1>: Operation not permitted

Fix this by resetting errno to zero before we call open again.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Clemens Buchacher <clemens.buchacher@intel.com>
---

This is a re-submission without changes except for a typo fix in the
comments (thanks Eric). The original submission received no other
comments, but I think it is a clear improvement and I hope it was just
missed the first time.

Best regards,
Clemens

 sha1_file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sha1_file.c b/sha1_file.c
index 77cd81d..62b7ad6 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -1453,6 +1453,7 @@ int git_open_noatime(const char *name)
 	static int sha1_file_open_flag = O_NOATIME;
 
 	for (;;) {
+		errno = 0;
 		int fd = open(name, O_RDONLY | sha1_file_open_flag);
 		if (fd >= 0)
 			return fd;
-- 
1.9.4

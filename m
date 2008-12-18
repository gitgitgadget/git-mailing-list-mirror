From: "Pickens, James E" <james.e.pickens@intel.com>
Subject: [RFC PATCH 0/2] Add support for multi threaded checkout
Date: Thu, 18 Dec 2008 13:51:57 -0700
Message-ID: <3BA20DF9B35F384F8B7395B001EC3FB3265B2A01@azsmsx507.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 18 21:53:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDPs6-0000R4-9b
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 21:53:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbYLRUwI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Dec 2008 15:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbYLRUwH
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 15:52:07 -0500
Received: from mga01.intel.com ([192.55.52.88]:43322 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750915AbYLRUwE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 15:52:04 -0500
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 18 Dec 2008 12:43:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.36,245,1228118400"; 
   d="scan'208";a="650961641"
Received: from unknown (HELO azsmsx601.amr.corp.intel.com) ([10.2.121.193])
  by fmsmga001.fm.intel.com with ESMTP; 18 Dec 2008 12:52:32 -0800
Received: from azsmsx507.amr.corp.intel.com ([10.2.121.87]) by
 azsmsx601.amr.corp.intel.com ([10.2.121.193]) with mapi; Thu, 18 Dec 2008
 13:51:58 -0700
Thread-Topic: [RFC PATCH 0/2] Add support for multi threaded checkout
Thread-Index: AclhUndRFOK7yuM8TN2LtoebHpxfhg==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103489>


There was some discussion a while back about improving git performance =
on
NFS (http://article.gmane.org/gmane.comp.version-control.git/100950).
This led to Linus adding the 'preload_index' function, which improves
performance of several commands using multi threading.  He also briefly
described how to do the same for 'git checkout'.  Well, I finally found
some time to work on it, and will post patches shortly.  This is my fir=
st
patch; apologies if I screwed something up.

Patch 1 adds the functionality, and 2 adds a config option to
enable/disable it.

Much of the patch is literally copy/paste from preload-index.c into
unpack-trees.c.  Many of the functions called during checkout are not
thread safe, so I added a mutex in entry.c to serialize basically
everything except writing the files to disk.  I also added a mutex in
unpack-trees.c for the progress meter.

It passes the test suite, and seems fairly safe to my na=EFve eyes.

Here are some benchmarks, cloning a linux kernel repo I had on an NFS
drive:

                   NFS->NFS    NFS->Local
master (53682f0c)    2:46.1          13.3
with threads           36.6          18.2

So it improved performance on NFS significantly.  Unfortunately it also
degraded performance on the local disk significantly.  I'm hoping someo=
ne
will suggest a way to mitigate that... I think it would be reasonable t=
o
disable the threading except when the work dir is on NFS, but I don't
know how to detect that.  Even in that case it will have *some* impact
from locking/unlocking the mutex, but I think it would be in the noise.

James

From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/6] Improve tag checking in fsck and with
 transfer.fsckobjects
Date: Wed, 10 Sep 2014 15:52:33 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.1409101552250.990@s15462909.onlinehome-server.info>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Sep 10 15:52:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRiKC-0008BM-LY
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 15:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbaIJNwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 09:52:40 -0400
Received: from mout.gmx.net ([212.227.17.21]:60280 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944AbaIJNwj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 09:52:39 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0Lp3Qu-1Xxj9y1Zrw-00ewJL;
 Wed, 10 Sep 2014 15:52:34 +0200
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:5ZVmxC49HjDIDKo5Kzq9LdDbo5rspqZTgWshGqPj7qidDueSw+m
 Bqf/usWhGgWk8VReKjP5pkHBMMTLtS9lrAddhJMdhgv2ICKZx2X+A/3VGISjvsxjjt9fAbQ
 pAdIVcMM7qjNQ2RyLcdzPevYmS01y25Sp5cjXDmQt8DAWuCh26U/TJmzwlp4ZUFMhAhV9d6
 /dbdhLmBYO2sR0gMgjF4A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256739>

This patch series introduces detailed checking of tag objects when calling
git fsck, and also when transfer.fsckobjects is set to true.

To this end, the fsck machinery is reworked to accept the buffer and size
of the object to check, and for commit and tag objects, we verify that the
buffers contain an end of header (i.e. an empty line) to guarantee that our
checks do not run beyond the buffer.

This work was sponsored by GitHub.

Changes since v1:

- Let type_from_string_gently() accept an optional string length

- Renamed 'tmp' to 'to_free'

- Renamed must_have_empty_line() to require_end_of_header()

- Renamed 'commit_sha1' in fsck_tag_buffer to 'sha1'

- Avoided temporarily inserting NUL characters into the buffer

- Demoted problematic 'tag' value to a mere warning

- Mentioned GitHub only in the cover letter, i.e. keeping it out of the git log

Still unaddressed:

- getting rid of struct object altogether in fsck (I felt this was quite a big
  task, getting much more familiar with the non-tag code paths, and I did not
  want to delay this patch series up any further)

- ensuring that index-pack passes only NUL-terminated buffers to fsck (again,
  I am not familiar enough with the code, and IIRC the problematic unit test
  that revealed that these buffers are not always NUL-terminated exercised the
  unpack-objects code path, not index-pack, again nothing I wanted to let
  delay this patch series any further).

Johannes Schindelin (6):
  Refactor type_from_string() to avoid die()ing in case of errors
  Accept object data in the fsck_object() function
  Make sure fsck_commit_buffer() does not run out of the buffer
  fsck: check tag objects' headers
  Add regression tests for stricter tag fsck'ing
  Make sure that index-pack --strict fails upon invalid tag objects

 builtin/fsck.c           |   2 +-
 builtin/index-pack.c     |   3 +-
 builtin/unpack-objects.c |  14 +++--
 fsck.c                   | 132 +++++++++++++++++++++++++++++++++++++++++++----
 fsck.h                   |   4 +-
 object.c                 |  11 +++-
 object.h                 |   3 +-
 t/t1450-fsck.sh          |  39 ++++++++++++++
 t/t5302-pack-index.sh    |  19 +++++++
 9 files changed, 207 insertions(+), 20 deletions(-)

-- 
2.0.0.rc3.9669.g840d1f9

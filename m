From: Elijah Newren <newren@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=200/7=5D=20Minor=20bug=20fix=20and=20optimizations=20for=20revision/tree=20walking?=
Date: Tue, 24 Aug 2010 20:53:08 -0600
Message-ID: <1282704795-29661-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 04:52:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo65p-0007sX-IJ
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 04:52:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756045Ab0HYCvr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 22:51:47 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33622 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab0HYCvp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 22:51:45 -0400
Received: by vws3 with SMTP id 3so180848vws.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 19:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=fKGTVDvguub58L1PzXr0ZwuCE9pICBsxs+yWq7PryuQ=;
        b=Rvl3gL3xENxyEaSCY7B4YsT3Hox/pCkiFJ0affIrYXfLr2VdKWx7I3N8h8p720xYfY
         fuyqos7eSDghodAonTXLkLpbYxuCJnCT9igZOBBb98k1PaMCd6JnTYnkq0H8yVP9xtON
         JZM0XOHA1SZ3VPKMGDwSIGS+29GsjJvzpWc/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=eAo1NcZowybkcSelMPhhcvy9brZmp8QnolR524ZhECQkBu/4/DTHKZc1MaQtm7ZQ+c
         WIJdWZVnxjNd6Bi3SGybGuB5G+OD+RxWRdEbSPfnIEedbM2hNJQhIDH7QRo4KsBzIpWU
         75ALq3s0TX4CXyihAapqu1KLVEgR0m/Wj8POM=
Received: by 10.220.157.139 with SMTP id b11mr4939526vcx.11.1282704704182;
        Tue, 24 Aug 2010 19:51:44 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id v11sm577473vbb.3.2010.08.24.19.51.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 19:51:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.2.39.gf7e23
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154396>

While working on sparse clones[1], I discovered a minor bug in the
tree-walking machinery for rev-list when both --objects and paths are
specified.  In particular, such a combination of options would
(correctly) result in the paths being used to select relevant commits,
but (incorrectly) being ignored when walking the subtrees of those
commits.  While I was at it, I also cleaned a few things up and
provided some small optimizations.  Passes all the tests for me.

NOTE: The last two patches are here mostly to see if anyone knows of
any real uses of git with ginormous trees that are really deep and
have few entries per tree.  These two patches might help with such a
case, but otherwise they seem to make the code a bit uglier and don't
really help performance-wise (and I think may even hurt a little bit).

Performance-wise, ignoring the last two patches, I get the following
approximate speedups:
  (A -  0%) git rev-list --quiet HEAD
  (B -  4%) git rev-list --quiet HEAD -- Documentation/
  (C -  3%) git rev-list --quiet HEAD -- t/
  (D -  1%) git rev-list --objects HEAD > /dev/null
  (E - 66%) git rev-list --objects HEAD -- Documentation/ > /dev/null

Complete timings (in seconds) on my laptop (core 2 duo?):
               A      B      C      D      E
  maint       0.35   0.69   1.35   1.92   1.40
  Patch-1     0.35   0.70   1.35   1.92   1.40
  Patch-2     0.34   0.69   1.35   1.90   0.85
  Patch-3     0.35   0.69   1.35   1.90   0.84
  Patch-4     0.34   0.70   1.35   1.90   0.85
  Patch-5     0.35   0.66   1.31   1.90   0.84
  Patch-6     0.35   0.66   1.31   1.92   0.82
  Patch-7     0.35   0.66   1.31   1.91   0.81

Note that for each case, I ran 6 times and averaged the last 5 runs.
I've rerun the cases a few times to regenerate the above table; the
numbers seem to vary about +/- 0.01 seconds between runs so the
speedups are slightly noisy given the small values, but they are
consistently positive for me.  I sometimes see the last two patches
have a little more negative impact, though it's pretty close to noise.


Elijah Newren (7):
  Add testcase showing how pathspecs are ignored with rev-list
    --objects
  Fix ignoring of pathspecs with rev-list --objects
  tree-walk: Correct bitrotted comment about tree_entry()
  tree_entry_interesting(): Make return value more specific
  diff_tree(): Skip skip_uninteresting() when all remaining paths
    interesting
  list-objects.c: Avoid recomputing interesting-ness for subtrees when
    possible
  tree-diff.c: Avoid recomputing interesting-ness for subtrees when
    possible

 diff.h                   |    1 +
 list-objects.c           |   27 ++++++++++++++++++---
 t/t6000-rev-list-misc.sh |   23 ++++++++++++++++++
 tree-diff.c              |   58 +++++++++++++++++++++++---------------=
--------
 tree-walk.h              |    4 ++-
 5 files changed, 79 insertions(+), 34 deletions(-)
 create mode 100755 t/t6000-rev-list-misc.sh

[1] It looks like Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy is much fur=
ther along than I am
on such work.  Perhaps the only point in the work I was doing was to
enable me to help review a few of his patches (which I will try to
find some time to do), though perhaps the different route I have taken
will end up helping some.  It's fun and educational either way.

--=20
1.7.2.2.39.gf7e23

From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 0/5] multithread traverse_commit_list (aka rev-list)
Date: Tue, 10 Apr 2012 21:39:26 +0700
Message-ID: <1334068771-32725-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 10 16:42:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHcHH-0006xS-9M
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 16:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758920Ab2DJOme convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Apr 2012 10:42:34 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:52722 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758824Ab2DJOmd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 10:42:33 -0400
Received: by pbcun15 with SMTP id un15so45834pbc.19
        for <git@vger.kernel.org>; Tue, 10 Apr 2012 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=AT+CB4R1ccD09azE0dK20kziue9kVz1c7G19Q1McPKM=;
        b=TJG5DKpwDSqwo5ovIIB9lDCaT/z82es5AomaVGujTDAosfS9MEGP8F+tSA8j7YsZw3
         DGHSFW9TwAFID7FXzBGkNaBeEI6yZL+vpu+lrf2V71OhwIVgl0CwcfX3AoB7SIz4GUWW
         kMzoguKRW3US1s6CG6Z+1rotIC94+ExL2+OJgajzVNNEBYllEQOrUWMQVHXIEKcG8Uz9
         d4WNviqZ0KF8A3RrK0qaNCpwJtdMOGnyBQOSwR75lPCXc7lx+42HY1QSqhbaGbjSp04+
         xjC6amrlOpfjboJoTpKogNThIBw6Eg65GR+I4DBuFnzbthdfL54sOowTJvv+Q+KU75C9
         EYuA==
Received: by 10.68.200.162 with SMTP id jt2mr8249585pbc.54.1334068953417;
        Tue, 10 Apr 2012 07:42:33 -0700 (PDT)
Received: from pclouds@gmail.com ([115.74.33.136])
        by mx.google.com with ESMTPS id i8sm49825pbi.47.2012.04.10.07.42.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 10 Apr 2012 07:42:31 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Tue, 10 Apr 2012 21:39:32 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195085>

rev-list is quite cpu extensive. While there's better approach to
tackle this (e.g. Shawn's bitmap cache idea), I was curious if
making it parellel could give us anything. So this is a naive (and
failed) attempt at that. I post it anyway, so people, especially gsoc
students if the related proposal is chosen, might learn from it, or
learn to avoid it, or just laugh at my attempt to relieve stress.

While this series does not break rev-list (but breaks all external
commands, I don't care anyway), and it proves lock-free pack access
works, it does not improve rev-list performance. I suspect extensive
locking around "struct object *" may be the culprit.  Or maybe it's
just my dumb partition method. A better partition method that avoids
locking might improve it. We may split the object hash table into 4,
one for each object type and assign one thread for tree, one for blob.
Or something else..

Anyway I'll stop here to finish my ongoing topics for 1.7.11 and maybe
implement Shawn's idea if I still have more time. Effectively generatin=
g
the cache from index-pack could be challenging.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (5):
  Remove global pointer "packed_git" in favor or set/get function pair
  sha1_file: stuff various pack reading variables into a struct
  Make lookup_*() functions thread-safe
  Teach traverse_commit_list callsites about new parameter, nr_threads
  Support multithread in traverse_commit_list and rev-list

 blob.c                   |   11 ++-
 builtin/count-objects.c  |    4 +-
 builtin/fsck.c           |    4 +-
 builtin/gc.c             |    2 +-
 builtin/pack-objects.c   |   12 +-
 builtin/pack-redundant.c |    4 +-
 builtin/rev-list.c       |    5 +-
 cache.h                  |    8 +-
 commit.c                 |   12 ++-
 git.c                    |    1 +
 list-objects.c           |  157 +++++++++++++++++++++++++-
 list-objects.h           |    2 +-
 object.c                 |    9 ++-
 object.h                 |    6 +
 pack-revindex.c          |    4 +-
 revision.c               |   16 +++
 revision.h               |    2 +
 server-info.c            |    4 +-
 sha1_file.c              |  276 ++++++++++++++++++++++++++++----------=
--------
 sha1_name.c              |    2 +-
 tag.c                    |    9 +-
 tree.c                   |   18 +++-
 upload-pack.c            |    2 +-
 23 files changed, 419 insertions(+), 151 deletions(-)

--=20
1.7.8.36.g69ee2

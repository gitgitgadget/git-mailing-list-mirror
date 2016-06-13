From: Christian Couder <christian.couder@gmail.com>
Subject: [RFC/PATCH 0/8] Add initial experimental external ODB support
Date: Mon, 13 Jun 2016 10:55:38 +0200
Message-ID: <20160613085546.11784-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 10:56:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCNfJ-00073d-0q
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 10:56:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161215AbcFMI4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 04:56:07 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37552 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161007AbcFMI4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 04:56:05 -0400
Received: by mail-wm0-f42.google.com with SMTP id k204so69356946wmk.0
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 01:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=aU4hzLlO7PAVFu9J+IZZnTCJfNk7u9+bS4RWOVZzmEU=;
        b=eqslRvA2JdF+JKqc3zS2fZDR5Js+OzXwcGFc/vm3dKAc5XLiYo1sLpD7vUXsBo/F1X
         FcjfydisPlZXv/QGM6X+NRMxqy2m+fNv2D6RCDzcvNR/Z388kVjpl7MpcOl6maO1/2CC
         AsTrKxxU0CCZr2toFmtkOww4gLxVFu+85Ng0XgG60yQJjRuE94crt1AD0KQXKpyxRunX
         hL321H4A+UbVISvlM9KXVnQjL8nYlDGOjrdKPQwHgv1RuAbdPxyvYuJmSzXkLvTri6Cc
         Z+BT6Hrhrp3MW4dmAqyxTEcgZ3MFV3wzC95FyC+EpBqWys73v081XnsDwV37DcqkiGAJ
         QwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aU4hzLlO7PAVFu9J+IZZnTCJfNk7u9+bS4RWOVZzmEU=;
        b=XUZqs+att9TbOE31aYgl990kb30dEXeKHu7QlUiuqSfc53XIY1wsqRieOfApAB0bee
         thuNvv1nuLSgcR4LZp/BH4iyNoV6eIRm2Hnn0XJ5Vb55+DxYVWH7WJB3bOS4jGwF4dhS
         h8xYoJ1R8qD+FhoTr9KYINgc5mToi5eindynRNuRTjF4Ylma7zD+sV+mZTieasWQksCZ
         u03L1TPV8Xv2gQE6oqKYAIpOlpGpfwvNpDyJEd/gwVZAt466gIIwh6Z5+tZ8dK7iIAfq
         kbCCvxiibyI+uHyD7/8AyuAal/9WYwUsy7QDeSWF4njwUvQgdnnXnsjF3W73KerZ1jJe
         3HAg==
X-Gm-Message-State: ALyK8tIWiemK+TJWF1G5M64zRYaq/831M3cPGFN7tRQc78kEVMAshtTMl7y+mDe66pgKUg==
X-Received: by 10.194.48.7 with SMTP id h7mr13102150wjn.9.1465808162914;
        Mon, 13 Jun 2016 01:56:02 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id z6sm26342384wjv.41.2016.06.13.01.56.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 01:56:02 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.8.ga2c5126
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297164>

Goal
~~~~

Git can store its objects only in the form of loose objects in
separate files or packed objects in a pack file.
To be able to better handle some kind of objects, for example big
blobs, it would be nice if Git could store its objects in other object
databases (ODB).
To do that, this patch series makes it possible to register commands,
using "odb.<odbname>.command" config variables, to access external
ODBs where objects can be stored and retrieved.

Design
~~~~~~

Each registered command manages access to one external ODB and will be
called the following ways:

  - "<command> have": the command should output the sha1, size and
type of all the objects the external ODB contains, one object per
line.

  - "<command> get <sha1>": the command should then read from the
external ODB the content of the object corresponding to <sha1> and
output it on stdout.

  - "<command> put <sha1> <size> <type>": the command should then read
from stdin an object and store it in the external ODB.

This RFC patch series for now does not address the following important
parts of a complete solution:

  - There is no way to transfer external ODB content using Git.

  - No real external ODB has been interfaced with Git. The tests use
another git repo in a separate directory for this purpose which is
probably useless in the real world.

Design discussion about performance
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Yeah, it is not efficient to fork/exec a command to just read or write
one object to or from the external ODB. Batch calls and/or using a
daemon and/or RPC should be used instead to be able to store regular
objects in an external ODB. But for now the external ODB would be all
about really big files, where the cost of a fork+exec should not
matter much. If we later want to extend usage of external ODBs, yeah
we will probably need to design other mechanisms.

Here are some related explanations from Peff:

{{{
Because this "external odb" essentially acts as a git alternate, we
would hit it only when we couldn't find an object through regular means.
Git would then make the object available in the usual on-disk format
(probably as a loose object).

So in most processes, we would not need to consult the odb command at
all. And when we do, the first thing would be to get its "have" list,
which would at most run once per process.

So the per-object cost is really calling "get", and my assumption there
was that the cost of actually retrieving the object over the network
would dwarf the fork/exec cost.

I also waffled on having git cache the output of "<command> have" in
some fast-lookup format to save even the single fork/exec. But I figured
that was something that could be added later if needed.

You'll note that this is sort of a "fault-in" model. Another model would
be to treat external odb updates similar to fetches. I.e., we touch the
network only during a special update operation, and then try to work
locally with whatever the external odb has. IMHO this policy could
actually be up to the external odb itself (i.e., its "have" command
could serve from a local cache if it likes).
}}}

Implementation
~~~~~~~~~~~~~~

This series adds a set of function in external-odb.{c,h} that are
called by the rest of Git to manage all the external ODBs.

These functions use 'struct odb_helper' and its associated functions
defined in odb-helper.{c,h} to talk to the different external ODBs by
launching the configured "odb.<odbname>.command" commands and writing
to or reading from them.

The tests in this series creates an odb-helper script that is
registered using the "odb.magic.command" config variable, and then
called to read from and write to the external ODB.

Highlevel view of the patches in the series
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    - Patches 01/08 and 02/08 are Peff's initial work fixed a little
      bit so that it compiles and pass tests.

    - Patches 03/08 is an optimization in the odb-helper script that
      is used for testing. I will probably squash it into 01/08.

    - Patches 04/08 and 05/08 are adding "put" support in the
      odb-helper script and testing that.

    - Patches 06/08 and 08/08 are enhancing external-odb.{c,h} and
      odb-helper.{c,h}, so that Git can write into an external ODB.

    - Patches 07/08 limits write support to "blobs" for now to
      simplify things.

Future work
~~~~~~~~~~~

>From the discussions it appear that using the bundle v3 mechanism to
tranfer external ODB data could work, but only if the server has access
to its own external ODB.

Another possible mechanism to transfer external ODB data would be some
kind of replace refs. This would be slower but the mechanism for the
transfer already fully exists.

So I think I am going to experiment with some kind of replace refs.

One interesting thing also would be to use the streaming api when
reading from or writing to the external ODB.

Previous work and discussions
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Peff started to work on this and discuss this some years ago:

http://thread.gmane.org/gmane.comp.version-control.git/206886/focus=207040
http://thread.gmane.org/gmane.comp.version-control.git/247171
http://thread.gmane.org/gmane.comp.version-control.git/202902/focus=203020

His work, which is not compile-tested any more, is still there:

https://github.com/peff/git/commits/jk/external-odb-wip

Initial discussions about this new series are there:

http://thread.gmane.org/gmane.comp.version-control.git/288151/focus=295160

Links
~~~~~

This patch series is available here:

https://github.com/chriscool/git/commits/external-odb


Christian Couder (6):
  t0400: use --batch-all-objects to get all objects
  t0400: add 'put' command to odb-helper script
  t0400: add test for 'put' command
  external odb: add write support
  external-odb: accept only blobs for now
  t0400: add test for external odb write support

Jeff King (2):
  Add initial external odb support
  external odb foreach

 Makefile                |   2 +
 cache.h                 |   9 ++
 external-odb.c          | 148 +++++++++++++++++++++++++
 external-odb.h          |  16 +++
 odb-helper.c            | 287 ++++++++++++++++++++++++++++++++++++++++++++++++
 odb-helper.h            |  32 ++++++
 sha1_file.c             |  66 ++++++++---
 t/t0400-external-odb.sh |  77 +++++++++++++
 8 files changed, 622 insertions(+), 15 deletions(-)
 create mode 100644 external-odb.c
 create mode 100644 external-odb.h
 create mode 100644 odb-helper.c
 create mode 100644 odb-helper.h
 create mode 100755 t/t0400-external-odb.sh

-- 
2.9.0.rc2.362.g3cd93d0

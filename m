From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/32] Split index mode for very large indexes
Date: Mon, 28 Apr 2014 17:55:21 +0700
Message-ID: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 12:54:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WejCv-0000aD-3D
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755123AbaD1Kyf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 06:54:35 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:54449 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbaD1Kyd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:54:33 -0400
Received: by mail-pb0-f52.google.com with SMTP id rp16so1859254pbb.39
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=6zb+MXSmTTEbDeIQW9pYk0hRi/FhL5WEabAbnG5sJoM=;
        b=Kj5SU2lPkF/RzG51jTfnDwfRG3dOwDDPDRbCyPp+bpSvnnLS4uDsXIAe3P8IfQMk0Y
         GFSS0fRBk8jnE2hqwP+L1/MLbic5tt4RcujEKUrFzRHUxlJogGi6It21RVrgeH3mP+Pz
         jrP41eF9TTXS45sLo86meDyhh49UYRnuCFIez2WURL1eSXcFG3j1D2HCyPxDBDFECYnb
         Xe9t3xUtK8exDVxLHcPegyp+NeOjSs8p3r6mESU7YzplruXSPf/1GGxQuG8W7xARszgr
         O5coYe/Ow0nQhGf+uBBvcXVXomJG6Rgs+1H/ypL0qLy3P7qRVidf6LMFrCq/9JRFMGF2
         7MNg==
X-Received: by 10.68.227.4 with SMTP id rw4mr28396447pbc.3.1398682472953;
        Mon, 28 Apr 2014 03:54:32 -0700 (PDT)
Received: from lanh ([115.73.231.31])
        by mx.google.com with ESMTPSA id ky8sm34166739pbc.64.2014.04.28.03.54.30
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:54:32 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Apr 2014 17:56:00 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247268>

I hinted about it earlier [1]. It now passes the test suite and with a
design that I'm happy with (thanks to Junio for a suggestion about the
rename problem).

=46rom the user point of view, this reduces the writable size of index
down to the number of updated files. For example my webkit index v4 is
14MB. With a fresh split, I only have to update an index of 200KB.
Every file I touch will add about 80 bytes to that. As long as I don't
touch every single tracked file in my worktree, I should not pay
penalty for writing 14MB index file on every operation.

The read penalty is not addressed here, so I still pay 14MB hashing
cost. But that's an easy problem. We could cache the validated index
in a daemon. Whenever git needs to load an index, it pokes the daemon.
The daemon verifies that the on-disk index still has the same
signature, then sends the in-mem index to git. When git updates the
index, it pokes the daemon again to update in-mem index. Next time git
reads the index, it does not have to pay I/O cost any more (actually
it does but the cost is hidden away when you do not have to read it
yet).

The forth patch is not really necessary. I started out with a
different approach that needed that abstraction. But I think it's
still a nice thing to keep. The real meat starts from 0017 to 0025. In
essence, the new index is more like a journal, where the real index is
put away unchanged.

Doing this in other implementations should be easy (at least the
reading part) and with small code change. The whole index format is
retained. All you need is to read a new extension that contains two
ewah-bitmaps and apply the changes to create the final index.

This is a preparation step for my untracked file cache. With writing
(and later on reading) index becoming cheap, I can start to put more
things in there.

[1] http://thread.gmane.org/gmane.comp.version-control.git/246471/focus=
=3D247031

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (32):
  ewah: fix constness of ewah_read_mmap
  ewah: delete unused ewah_read_mmap_native declaration
  sequencer: do not update/refresh index if the lock cannot be held
  read-cache: new API write_locked_index instead of write_index/write_c=
ache
  read-cache: relocate and unexport commit_locked_index()
  read-cache: store in-memory flags in the first 12 bits of ce_flags
  read-cache: be strict about "changed" in remove_marked_cache_entries(=
)
  read-cache: be specific what part of the index has changed
  update-index: be specific what part of the index has changed
  resolve-undo: be specific what part of the index has changed
  unpack-trees: be specific what part of the index has changed
  cache-tree: mark istate->cache_changed on cache tree invalidation
  cache-tree: mark istate->cache_changed on cache tree update
  cache-tree: mark istate->cache_changed on prime_cache_tree()
  entry.c: update cache_changed if refresh_cache is set in checkout_ent=
ry()
  read-cache: save index SHA-1 after reading
  read-cache: split-index mode
  read-cache: mark new entries for split index
  read-cache: save deleted entries in split index
  read-cache: mark updated entries for split index
  split-index: the writing part
  split-index: the reading part
  split-index: do not invalidate cache-tree at read time
  split-index: strip pathname of on-disk replaced entries
  update-index: new options to enable/disable split index mode
  update-index --split-index: do not split if $GIT_DIR is read only
  rev-parse: add --shared-index-path to get shared index path
  read-tree: force split-index mode off on --index-output
  read-tree: note about dropping split-index mode or index version
  read-cache: force split index mode with GIT_TEST_SPLIT_INDEX
  t2104: make sure split index mode is off for the version test
  t1700: new tests for split-index mode
--=20
1.9.1.346.ga2b5940

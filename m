From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 00/11] Large blob fixes
Date: Mon, 27 Feb 2012 14:55:04 +0700
Message-ID: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 08:55:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1vQw-0006la-K6
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 08:55:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516Ab2B0Hzm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Feb 2012 02:55:42 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:33496 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750918Ab2B0Hzl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2012 02:55:41 -0500
Received: by pbcup15 with SMTP id up15so1787730pbc.19
        for <git@vger.kernel.org>; Sun, 26 Feb 2012 23:55:41 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.216.4 as permitted sender) client-ip=10.68.216.4;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.216.4 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.216.4])
        by 10.68.216.4 with SMTP id om4mr37418593pbc.19.1330329341088 (num_hops = 1);
        Sun, 26 Feb 2012 23:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=TAr8s5Jtqq6KCFtPRrRhsNVs+R25WVPltmCxyzkA+aU=;
        b=NhXjfrPmOsy/EpcBWjd+/UpWdKzOk+ReQnV/rv188gcAMZVTj92OUYhVJ96QcE103L
         1IMgwsamXa5yrJvNpHOz5ZS2OSWbb4iEp/gywIPpQUrCNY1KEXxSOB+YFcBxpMmWDoh4
         H50Ex33Rf8u/k428HkI3i7vxgUf4v/oO7d2Hs=
Received: by 10.68.216.4 with SMTP id om4mr31775137pbc.19.1330329341048;
        Sun, 26 Feb 2012 23:55:41 -0800 (PST)
Received: from pclouds@gmail.com ([113.161.77.29])
        by mx.google.com with ESMTPS id 3sm12027827pbx.66.2012.02.26.23.55.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 26 Feb 2012 23:55:40 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Mon, 27 Feb 2012 14:55:15 +0700
X-Mailer: git-send-email 1.7.3.1.256.g2539c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191605>

These patches make sure we avoid keeping whole blob in memory, at
least in common cases. Blob-only streaming code paths are opened to
accomplish that.

I don't quite like having three different implementations for
checking sha-1 signature (one on git_istream, one on packed_git and
the other one in index-pack) but I failed to see how to unify them.

Making archive-zip work with stream can be difficult. But at least tar
format works. Good enough for me.

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (11):
  Add more large blob test cases
  Factor out and export large blob writing code to arbitrary file
    handle
  cat-file: use streaming interface to print blobs
  parse_object: special code path for blobs to avoid putting whole
    object in memory
  show: use streaming interface for showing blobs
  index-pack --verify: skip sha-1 collision test
  index-pack: split second pass obj handling into own function
  index-pack: reduce memory usage when the pack has large blobs
  pack-check: do not unpack blobs
  archive: support streaming large files to a tar archive
  fsck: use streaming interface for writing lost-found blobs

 archive-tar.c        |   35 +++++++++++++---
 archive-zip.c        |    9 ++--
 archive.c            |   51 ++++++++++++++++--------
 archive.h            |   11 ++++-
 builtin/cat-file.c   |   22 ++++++++++
 builtin/fsck.c       |    8 +---
 builtin/index-pack.c |  108 +++++++++++++++++++++++++++++++++++++-----=
-------
 builtin/log.c        |    9 ++++-
 cache.h              |    5 ++-
 entry.c              |   39 ++++++++++++------
 fast-import.c        |    2 +-
 object.c             |   11 +++++
 pack-check.c         |   21 +++++++++-
 sha1_file.c          |   78 +++++++++++++++++++++++++++++++-----
 t/t1050-large.sh     |   59 +++++++++++++++++++++++++++-
 wrapper.c            |   27 +++++++++++-
 16 files changed, 400 insertions(+), 95 deletions(-)

--=20
1.7.3.1.256.g2539c.dirty

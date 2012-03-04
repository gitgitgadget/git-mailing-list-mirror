From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 00/10] Large blob fixes
Date: Sun,  4 Mar 2012 19:59:46 +0700
Message-ID: <1330865996-2069-1-git-send-email-pclouds@gmail.com>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 04 14:02:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4B5D-0003Pa-S6
	for gcvg-git-2@plane.gmane.org; Sun, 04 Mar 2012 14:02:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838Ab2CDNCH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 08:02:07 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:47290 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab2CDNCF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2012 08:02:05 -0500
Received: by pbcun15 with SMTP id un15so1801180pbc.19
        for <git@vger.kernel.org>; Sun, 04 Mar 2012 05:02:05 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.68.204.106 as permitted sender) client-ip=10.68.204.106;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.68.204.106 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.68.204.106])
        by 10.68.204.106 with SMTP id kx10mr38441286pbc.150.1330866125099 (num_hops = 1);
        Sun, 04 Mar 2012 05:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dw/xTH88wwu86xVXNKErAvrKIAMjA66KYE8+CYalmsw=;
        b=MNTmI3fY6TNICb0SY3lrAagnfKnGCGMgRGRA7Omd/2mFTh8EHLY9TgTqlirxo31Yeu
         0y9AH2rTNPLupR5B4X1PKuTZGW8YHLVlT4dN8ZxCkyOmoMk4/tsZ/4CO21ebcmjfvBzh
         AugvqxbbAChELSp3JMAFMIKCS99B2HQWCzDflYDJpU8qqTKMhrjmoClPy1RCuj5G2rE5
         x/4Lppd6ksegKUtEcX2CDNyeU6irbEB1h2E1n1R61KJ9Hcc4fpPyW4UoY7oi94MrtvuU
         7RmfJMPejM2kt6SVjv7zRPnmkAx9hQ3j1bviOQ31RtyZfk4v02n3oONm2RlqR6JgCRz2
         G8Jg==
Received: by 10.68.204.106 with SMTP id kx10mr32792581pbc.150.1330866125028;
        Sun, 04 Mar 2012 05:02:05 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.34.94])
        by mx.google.com with ESMTPS id a1sm10419249pbj.72.2012.03.04.05.02.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 04 Mar 2012 05:02:03 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Sun, 04 Mar 2012 19:59:57 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
In-Reply-To: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192151>

These patches make sure we avoid keeping whole blob in memory, at
least in common cases. Blob-only streaming code paths are opened to
accomplish that.

There are a few things I'd like to see addressed, perhaps as part of
GSoC if any student steps up.

 - somehow avoid unpack-objects and keep the pack if it contains large
   blobs. I guess we could just save the pack, then decide to
   unpack-objects later. I've updated GSoC ideas page about this.
=20
 - pack-objects still puts large blobs in memory if they are in loose
   format. This should not happen if we fix the above. But if anyone
   has spare energy, (s)he can try to stream large loose blobs in the
   pack too. Not sure how ugly the end result could be.

 - archive-zip with large blobs. I think two phases are required
   because we need to calculate crc32 in advance. I have a feeling
   that we could just stream compressed blobs (either in loose or
   packed format) to the zip file, i.e. no decompressing then
   compresssing, which makes two phases nearly as good as one.

 - not really large blob related, but it'd be great to see
   pack-check.c and index-pack.c share as much pack reading code as
   possible, even bettere if sha1_file.c could join the party.

 - I've been thinking whether we could just drop pack-check.c, which
   is only used by fsck, and make fsck run index-pack instead. The
   pros is we can run index-pack in parallel. The cons is, how to
   return marked object list to fsck efficiently.

Anyway changes from v1:

 - use stream_blob_to_fd() patch from Junio (better factoring)
 - split show_object() in "git show" in two separate functions, one
   for tag and one for blob, as they do not share much in the end
 - get rid of "index-pack --verify" patch. It'll come back separately

Junio C Hamano (1):
  streaming: make streaming-write-entry to be more reusable

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (9):
  Add more large blob test cases
  cat-file: use streaming interface to print blobs
  parse_object: special code path for blobs to avoid putting whole
    object in memory
  show: use streaming interface for showing blobs
  index-pack: split second pass obj handling into own function
  index-pack: reduce memory usage when the pack has large blobs
  pack-check: do not unpack blobs
  archive: support streaming large files to a tar archive
  fsck: use streaming interface for writing lost-found blobs

 archive-tar.c        |   35 +++++++++++++++----
 archive-zip.c        |    9 +++--
 archive.c            |   51 ++++++++++++++++++---------
 archive.h            |   11 +++++-
 builtin/cat-file.c   |   23 ++++++++++++
 builtin/fsck.c       |    8 +---
 builtin/index-pack.c |   95 ++++++++++++++++++++++++++++++++++++------=
--------
 builtin/log.c        |   34 ++++++++++-------
 cache.h              |    2 +-
 entry.c              |   53 +++-------------------------
 fast-import.c        |    2 +-
 object.c             |   11 ++++++
 pack-check.c         |   21 ++++++++++-
 sha1_file.c          |   78 +++++++++++++++++++++++++++++++++++------
 streaming.c          |   55 +++++++++++++++++++++++++++++
 streaming.h          |    2 +
 t/t1050-large.sh     |   59 ++++++++++++++++++++++++++++++-
 wrapper.c            |   27 ++++++++++++--
 18 files changed, 434 insertions(+), 142 deletions(-)

--=20
1.7.8.36.g69ee2

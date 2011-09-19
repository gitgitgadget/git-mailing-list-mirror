From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 0/8] fast-import: cache oe more often
Date: Mon, 19 Sep 2011 07:27:29 +0600
Message-ID: <1316395657-6991-1-git-send-email-divanorama@gmail.com>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 03:21:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5SYD-0007cL-05
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 03:21:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178Ab1ISBVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 21:21:18 -0400
Received: from mail-wy0-f170.google.com ([74.125.82.170]:46718 "EHLO
	mail-wy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1ISBVS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 21:21:18 -0400
Received: by wyg8 with SMTP id 8so8452393wyg.1
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 18:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Q2pVp88H7Z1DYJaMpF6Gtiw0cQOqBqYEHqRl7Ju1ADw=;
        b=Q+3zEU6AkKTpsIJCXQUgUKI2G5AWUsEXCK1n+N9qy6QxbaInIjnIh2zKrwYx9CNdby
         t2/HhrVMBLQc8e9108T0BthyHM5XXMtmQjf4Fkr52T875b9SCwMITwOXT00H7uXhBpxm
         98UWbwbNHCJWafFYlyhRoyVg+H17P85M+nMWg=
Received: by 10.227.204.198 with SMTP id fn6mr2060635wbb.96.1316395277139;
        Sun, 18 Sep 2011 18:21:17 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru. [79.172.62.237])
        by mx.google.com with ESMTPS id fa3sm23640766wbb.3.2011.09.18.18.21.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 18:21:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181656>

fast-import keeps a struct object_entry for each object written to
it's pack. This is to keep type, pack-coordinates and delta_depth.
struct object_entry is also used to cache this metadata for objects
that exist outside fast-import's pack ('old' objects).
struct object_entry has a small fixed size and thus it should be
reasonable to cache any 'old' object metadata retrieval to save the
disk i/o.

Also it is a step toward making fast-import identify objects via
struct object_entry rather than sha1. One pointer takes less than
20 bytes, it'll be later possible to have references to objects
that don't yet have sha1 computed (fast-import with threads future).

Dmitry Ivankov (8):
  fast-import: cache oe in file_change_m
  fast-import: cache oe in parse_new_tag
  fast-import: cache oe in note_change_n
  fast-import: extract common sha1_file access functions
  fast-import: tiny optimization in read_marks
  fast-import: cache oe in load_tree
  fast-import: cache oe in cat_blob
  fast-import: cache objects while dereferencing

 fast-import.c |  177 +++++++++++++++++++++++++++++++--------------------------
 1 files changed, 96 insertions(+), 81 deletions(-)

-- 
1.7.3.4

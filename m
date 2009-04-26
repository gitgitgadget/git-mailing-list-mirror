From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add core.trustlowlevelstat for diffs in dev,ino,uid and
 gid
Date: Sun, 26 Apr 2009 11:38:08 -0700
Message-ID: <7vocujjm5r.fsf@gitster.siamese.dyndns.org>
References: <1240743317-10117-1-git-send-email-robin.rosenberg@dewire.com>
 <200904261306.15448.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, spearce@spearce.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:26:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly9Gd-0002mn-D0
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 20:39:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193AbZDZSiV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 26 Apr 2009 14:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbZDZSiU
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 14:38:20 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520AbZDZSiU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Apr 2009 14:38:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 33C4DADB1F;
	Sun, 26 Apr 2009 14:38:15 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id DBDEBADB1E; Sun,
 26 Apr 2009 14:38:10 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 67449624-3291-11DE-AEDB-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117625>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> s=C3=B6ndag 26 april 2009 12:55:17 skrev Robin Rosenberg:
>> This reason we may want to ignore these fields is that the Java impl=
ementation=20
>> of Git cannot set these fields properly. To mark this JGit sets thes=
e fields
>> to to UINT_MAX (all bits set).
>
> Oopps, you won't be able to apply this one,...

Yeah, I noticed your ~0u hack, but it is clear what is going on in the
patch.

I had a similar patch that disables inum checking in my private tree fo=
r
different reasons of my own; the set of fields your patch ignores is a
compatible superset of, and I think makes more sense than, what I was
planning to do, so no objections from me on this _optional_ feature.

It might be easier (with proper re-indentation, which I omitted from th=
is
patch with "diff -w") and more efficient to do this, though...

diff --git a/read-cache.c b/read-cache.c
index 3f58711..03ecd11 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -210,6 +210,8 @@ static int ce_match_stat_basic(struct cache_entry *=
ce, struct stat *st)
 		changed |=3D CTIME_CHANGED;
 #endif
=20
+	if (trust_lowlevel_stat) {
+
 	if (ce->ce_uid !=3D (unsigned int) st->st_uid ||
 	    ce->ce_gid !=3D (unsigned int) st->st_gid)
 		changed |=3D OWNER_CHANGED;
@@ -226,6 +228,7 @@ static int ce_match_stat_basic(struct cache_entry *=
ce, struct stat *st)
 		changed |=3D INODE_CHANGED;
 #endif
=20
+	}
 	if (ce->ce_size !=3D (unsigned int) st->st_size)
 		changed |=3D DATA_CHANGED;
=20

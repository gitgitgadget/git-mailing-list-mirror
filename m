From: Bill Zaumen <bill.zaumen+git@gmail.com>
Subject: Patches for message-digest support.
Date: Tue, 20 Dec 2011 23:51:52 -0800
Message-ID: <1324453912.1684.62.camel@yos>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 21 08:51:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdGxt-00026s-B0
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 08:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752655Ab1LUHvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 02:51:49 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:53549 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab1LUHvr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 02:51:47 -0500
Received: by iaeh11 with SMTP id h11so11508963iae.19
        for <git@vger.kernel.org>; Tue, 20 Dec 2011 23:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:subject:from:to:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=/lkSVRvvMOUg2uEabRoCWTgmd4AUQUA6p+XRhTawaLI=;
        b=bLF9mHK9Z6p1Q60qFlJxeLH8reExRChOPKckOojrjW1EG+7rhWXaAmgDJ/AaCnx3RL
         gNzhsopmWgP32ei8MDeV2BnRpYQFU1neYOsAg3EWZTeNDpryfhx1s/iVv7yAh3C5wmxU
         GW8r7kDo8rSJXoxH/BMII8jL0mceMnRC8QT/Q=
Received: by 10.50.51.168 with SMTP id l8mr1725359igo.5.1324453907218;
        Tue, 20 Dec 2011 23:51:47 -0800 (PST)
Received: from [192.168.1.20] (adsl-209-233-20-69.dsl.snfc21.pacbell.net. [209.233.20.69])
        by mx.google.com with ESMTPS id cv10sm23163833igc.0.2011.12.20.23.51.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 20 Dec 2011 23:51:46 -0800 (PST)
X-Mailer: Evolution 2.30.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187557>


I just sent a series of 6 patches, roughly similar to the ones I sent a
few weeks ago, but allowing a choice of message digests in addition to
a CRC (kept for testing purposes) - SHA-1, SHA-256, and SHA-512 with
more added easily.  The current default is SHA-256.  The use of SHA-1
for git object IDs is unchanged. Unlike the object-ID digest, the
additional digests do not include the Git object-header.  I also changed
a number of function names, using "digest" or "mdigest" in them.
Searching for the string "digest" is a good way of finding things.
Finally, I added a header to commit messages (conditionally compiled so
this can be turned off) that contains a digest of digests plus some
other fields.  I also broke it up into a series of smaller patches.

Just as a summary:

The first patch contains several new files.  It uses a data structure
for message digests that keeps the bytes of a digest aligned on
32 or 64 bit boundaries to allow fast comparisons. The digests are
stored long with a one-byte code indicating the digest type. The code
handles storing and looking up the digests, including support for
alternate object databases.

The second patch modifies some of the existing git files (the major
changes are in sha1_file.c and pack-write.c) for storing message digests
when an object or a pack index file is created.

The third patch modifies the files in the builtin directory that contain
the implementation of git commands for packing and pruning objects, and
for verifying pack files and counting objects.  The code does some
checks for hash collisions by comparing the digests.  At this point,
each git object will have a digest that can be looked up given the
object's ID.  This mapping is maintained as pack files are
created.

The fourth patch adds a digest header to commit messages.  This header
contains a digest of the digests for the commit's parents and for each
object in the commit's tree, and of the other fields in the commit.
The digest header, like the rest of the commit, is used in computing the
commit's object ID and matching digest.  A function verify_commit
checks the digest header by recomputing it and can be used as desired
for authentication or other purposes.

The fifth patch transfers the message digest corresponding to a SHA-1
ID during fetch or push operations to allow early detection of
collisions.  This is a fast test - a simple lookup - and can be turned
off by removing the "mds-check" capability.

The sixth patch contains documentation.

Bill

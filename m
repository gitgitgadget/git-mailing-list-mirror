From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH] hash-object doc: "git hash-object -w" can write invalid
 objects
Date: Fri, 22 Feb 2013 15:01:32 -0800
Message-ID: <20130222230132.GB4514@google.com>
References: <kg8ri2$vjb$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 00:02:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U91d1-0004H8-ON
	for gcvg-git-2@plane.gmane.org; Sat, 23 Feb 2013 00:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754051Ab3BVXBm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 Feb 2013 18:01:42 -0500
Received: from mail-da0-f42.google.com ([209.85.210.42]:56501 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044Ab3BVXBm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 18:01:42 -0500
Received: by mail-da0-f42.google.com with SMTP id z17so575416dal.1
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 15:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=J/ryrjAEF0um2rUkIiVgQh/6fnBJNK5Hpobl1IzDPCA=;
        b=yTZDVeUso9iiOgrVYdQkRGr52PV3ST1xRg/MxAGCDXHZDzgBpw00JyWoc+SBrc5Ycl
         EPLdFobZg7BxZt2FO7vR0W3AlXvmKAgVvw+oywp4NUZN7G5maBANAxBHhblS8Gv/knML
         jDyG467SoJDdG4Ato4/4UQqRWyF7fsOCFOgoGh+keEHhDMLdCu4evi9/1HQOwZ8a7Pja
         oIybpzT978PyVk8Udidc/qJwLLEmHhzp+CNEdLrbRd8FOPReJSNqwoZm8maV55kKyS/o
         c5bR28aYwZ9WAmgO4b1V3dVidn+cy/ux916CnxqrhgA1DRuwIJ8iarvxfPjjkPFxUCY+
         aGIA==
X-Received: by 10.66.162.196 with SMTP id yc4mr6672756pab.137.1361574101542;
        Fri, 22 Feb 2013 15:01:41 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id d8sm4367562pax.23.2013.02.22.15.01.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Feb 2013 15:01:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <kg8ri2$vjb$1@ger.gmane.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216875>

When using "hash-object -w" to create non-blob objects, it is
generally a good policy to run "git fsck" afterward to make sure the
resulting object is valid.  Add a warning to the manpage.

While it at, gently nudge the user of "hash-object -w" toward
higher-level interfaces for creating or modifying trees, commits, and
tags.

Reported-by: Mantas Mikul=C4=97nas <grawity@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi Mantas,

Mantas Mikul=C4=97nas wrote:

> When messing around with various repositories, I noticed that git 1.8
> (currently using 1.8.2.rc0.22.gb3600c3) has problems parsing tag obje=
cts
> that have invalid timestamps.
[...]
> Git doesn't handle the resulting tag objects nicely at all. For examp=
le,
> running `git cat-file -p` on the new object outputs a really odd
> timestamp "Thu Jun Thu Jan 1 00:16:09 1970 +0016" (I'm guessing it
> parses the year as Unix time),

The usual rule is that with invalid objects (e.g. as detected by "git
fsck"), any non-crash result is acceptable.  Garbage in, garbage out.

>                                and `git show` outright crashes
> (backtrace included below.)

Probably worth fixing.

I notice that git-hash-object(1) doesn't contain any reference to
git-fsck(1).  How about something like this, to start?

Perhaps by default hash-object should automatically fsck the objects
it is asked to create.

Thanks,
Jonathan

 Documentation/git-hash-object.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash=
-object.txt
index 02c1f12..8ed8c6e 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -30,6 +30,8 @@ OPTIONS
=20
 -w::
 	Actually write the object into the object database.
+	This does not check that the resulting object is valid;
+	for that, see linkgit:git-fsck[1].
=20
 --stdin::
 	Read the object from standard input instead of from a file.
@@ -53,6 +55,14 @@ OPTIONS
 	conversion. If the file is read from standard input then this
 	is always implied, unless the --path option is given.
=20
+SEE ALSO
+--------
+linkgit:git-mktree[1],
+linkgit:git-commit-tree[1],
+linkgit:git-tag[1],
+linkgit:git-filter-branch[1],
+sha1sum(1)
+
 GIT
 ---
 Part of the linkgit:git[1] suite
--=20
1.8.1.4

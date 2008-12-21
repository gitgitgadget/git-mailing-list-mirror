From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Memory issue with fast-import, why track branches?
Date: Sun, 21 Dec 2008 07:54:57 +0200
Message-ID: <94a0d4530812202154l26dfe0dfm49397c63dbfdfdf9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Dec 21 06:58:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEHKG-0002OH-VE
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 06:58:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbYLUFzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 00:55:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbYLUFzD
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 00:55:03 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:33623 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbYLUFzA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 00:55:00 -0500
Received: by fg-out-1718.google.com with SMTP id 19so617954fgg.17
        for <git@vger.kernel.org>; Sat, 20 Dec 2008 21:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=TmeS6OzQSrt4uFwXlVH7Y4x0qx4uW9Dm0pakOLIi+AQ=;
        b=MrfNZ68CmK0ZsVXLJ3waxZXvEME4BLw0sZr/f2uZ/sZRvJh0yOfYYFMhGzIG2aTe/D
         XUvJiyVGOO753K5/skE8QEnS0qdfhZuUj+tA0tg48mQaXZH4sBoIZbM255C6T8hnxi+T
         mTooUTB48uhaB86aUryB6Hsp3+E1sP3Rrdp38=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=D3XgFzQ7r7RcytrZy4Edo5G2jr+7pK4bnTKuZehi1nHErl52/SNIn3SuoqcNZy8Hcy
         F0/oKCNM7qKyePvSRXPViV1fNIRDVZ6FJgL033Hqi1rikxJ5CCL6R6CTifZ2+UgeFLxY
         LuBbh0DLcyGJeT2t+9pFdtb9sdMjq5Ib/C0Ag=
Received: by 10.86.76.20 with SMTP id y20mr2847306fga.37.1229838897976;
        Sat, 20 Dec 2008 21:54:57 -0800 (PST)
Received: by 10.86.77.17 with HTTP; Sat, 20 Dec 2008 21:54:57 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103688>

Hi,

I tracked down an issue I have when importing a big repository. For
some reason memory usage keeps increasing until there is no more
memory.

Here is what valgrind shows:
==21034== 471,080,280 bytes in 114,517 blocks are still reachable in
loss record 8 of 8
==21034==    at 0x4004BA2: calloc (vg_replace_malloc.c:397)
==21034==    by 0x806A340: xcalloc (wrapper.c:75)
==21034==    by 0x8063BC1: use_pack (sha1_file.c:808)
==21034==    by 0x8063DA9: unpack_object_header (sha1_file.c:1443)
==21034==    by 0x8064F4F: unpack_entry (sha1_file.c:1736)
==21034==    by 0x8065393: cache_or_unpack_entry (sha1_file.c:1606)
==21034==    by 0x8065464: read_packed_sha1 (sha1_file.c:2000)
==21034==    by 0x80655E5: read_object (sha1_file.c:2090)
==21034==    by 0x8065677: read_sha1_file (sha1_file.c:2106)
==21034==    by 0x8056AE9: parse_object (object.c:190)
==21034==    by 0x805E90A: write_ref_sha1 (refs.c:1214)
==21034==    by 0x804CC4F: update_branch (fast-import.c:1558)

After looking at the code my guess is that I have a humongous amount
of branches.

Actually they are not really branches, but refs. For each git commit
there's an original mtn ref that I store in 'refs/mtn/sha1', but since
I'm using 'commit refs/mtn/sha1' to store it, a branch is created for
every commit.

I guess there are many ways to fix the issue, but for starters I
wonder why is fast-import keeping track of all the branches? In my
case I would like fast-import to work exactly the same if I specify
branches or not (I'll update them later).

Cheers.

-- 
Felipe Contreras

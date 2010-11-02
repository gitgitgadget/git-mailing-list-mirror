From: Shawn Pearce <spearce@spearce.org>
Subject: bug in git notes fanout
Date: Tue, 2 Nov 2010 15:06:56 -0700
Message-ID: <AANLkTi=JfwJq8wq_1an014WO+A_Dwp5cDKa+xHi10awr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>, Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Nov 02 23:10:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDP47-0007Xd-DH
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 23:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753060Ab0KBWHS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 18:07:18 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56320 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab0KBWHR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 18:07:17 -0400
Received: by gyg4 with SMTP id 4so4466138gyg.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 15:07:16 -0700 (PDT)
Received: by 10.42.166.8 with SMTP id m8mr948063icy.120.1288735636461; Tue, 02
 Nov 2010 15:07:16 -0700 (PDT)
Received: by 10.231.140.97 with HTTP; Tue, 2 Nov 2010 15:06:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160560>

Why doesn't the fan-out work for this case?

  git notes --ref buggy.fanout add -m test HEAD
  perl -e 'for($i=0;$i<1024;$i++){printf "%s %s%4.4x\n", $ARGV[0],
"0"x36, $i}' $(git rev-parse HEAD) | git notes --ref buggy.fanout copy
--stdin
  git ls-tree refs/notes/buggy.fanout
100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4	0000000000000000000000000000000000000000
100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4	0000000000000000000000000000000000000001
100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4	0000000000000000000000000000000000000002
100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4	0000000000000000000000000000000000000003
...
100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4	000000000000000000000000000000000000018c
...
100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4	00000000000000000000000000000000000003e1
...
100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4	00000000000000000000000000000000000003e2
...
100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4	00000000000000000000000000000000000003fd
100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4	00000000000000000000000000000000000003fe
100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4	00000000000000000000000000000000000003ff
100644 blob 9daeafb9864cf43055ae93beb0afd6c7d144bfa4	638d3d9244720e0f07f22a953d25db878e9ad3f5


I thought the entire points of the notes fanout being 0/40, 2/38,
2/2/36, 2/2/2/34 was to prevent git from having a big linear search
within any single tree when a large number of notes are added to a
note branch.

IIRC when the notes stuff was being debated on this list we insisted
that the fan-out algorithm had to be consistent, ensuring that if I
create a note for 638d3d92 and Junio creates a note on the same
object, they will wind up at the same path in the notes, and we won't
have doppleganger notes (two different notes in the same tree with the
same object).

Basically this issue arises because we are adding node support to
JGit.  Our planned implementation would have inserted
00000000000000000000000000000000000003ff into
00/00/00/00/00/00/00/00/00/00/00/00/00/00/00/00/00/00/03/ff because
there are so many notes that at each depth we wind up with >255
entries, and split the tree again.  But that results in a very
different structure from what the C implementation is doing today.

As far as I can tell from the C code, it won't split unless every hex
digit in the 0..f range is used.  That is just a weird heuristic, and
actual paths used depend on the actual SHA-1s that we add to the tree.
 If I get "unlucky" and add 5 commits that start with "f" and never
add one that starts with "0", I won't get fan-out, even though my
notes tree has more than 256 items in it.

*sigh*

This is almost as bad as the "lets sort names in trees by name *and* type!".

-- 
Shawn.

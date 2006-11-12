X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Shallow clone
Date: Sun, 12 Nov 2006 00:16:40 -0800
Message-ID: <7vu015f5av.fsf@assigned-by-dhcp.cox.net>
References: <7v8ximwrm3.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611072009220.2601@qynat.qvtvafvgr.pbz>
	<45520872.3090506@gmail.com> <45521AE9.7050902@gmail.com>
	<7vac31p8om.fsf@assigned-by-dhcp.cox.net>
	<87zmaynl18.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 12 Nov 2006 08:16:57 +0000 (UTC)
Cc: "Aneesh Kumar K.V" <aneesh.kumar@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31258>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GjAWM-0002Qn-Kb for gcvg-git@gmane.org; Sun, 12 Nov
 2006 09:16:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754087AbWKLIQm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 12 Nov 2006
 03:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754102AbWKLIQm
 (ORCPT <rfc822;git-outgoing>); Sun, 12 Nov 2006 03:16:42 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:31434 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1754087AbWKLIQl
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 12 Nov 2006 03:16:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061112081641.KEWE5575.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Sun, 12
 Nov 2006 03:16:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id lkGF1V00C1kojtg0000000; Sun, 12 Nov 2006
 03:16:16 -0500
To: Alexandre Julliard <julliard@winehq.org>
Sender: git-owner@vger.kernel.org

Alexandre Julliard <julliard@winehq.org> writes:

> There's also a problem with the packing, a clone --depth 1 currently
> results in a pack that's about 3 times as large as it should be.

That's interesting.

  : gitster; git clone -n --depth 1 git://127.0.0.1/git.git victim-001
  remote: Generating pack...
  remote: Done counting 6246 objects.
  remote: Deltifying 6246 objects.
  remote:  100% (6246/6246) done
  Indexing 6246 objects.
  remote: Total 6246, written 6246 (delta 3106), reused 4313 (delta 3106)
   100% (6246/6246) done
  Resolving 3106 deltas.
   100% (3106/3106) done
  : gitster; cd victim-001
  : gitster; ls -lh .git/objects/pack/
  total 9.6M
  drwxrwsr-x 2 junio src 4.0K 2006-11-11 23:52 ./
  drwxrwsr-x 4 junio src 4.0K 2006-11-11 23:52 ../
  -r--r--r-- 1 junio src 148K 2006-11-11 23:52 pack-f5f88d83....idx
  -r--r--r-- 1 junio src 9.5M 2006-11-11 23:52 pack-f5f88d83....pack

Repacking immediately after cloning brings it down to what is
expected.

  : gitster; git repack -a -d -f
  Generating pack...
  Done counting 6246 objects.
  Deltifying 6246 objects.
   100% (6246/6246) done
  Writing 6246 objects.
   100% (6246/6246) done
  Total 6246, written 6246 (delta 4815), reused 1407 (delta 0)
  Pack pack-f5f88d83524213e3ab05697ff75f245b1ef9081a created.
  : gitster; ls -lh .git/objects/pack/
  total 2.8M
  drwxrwsr-x 2 junio src 4.0K 2006-11-11 23:53 ./
  drwxrwsr-x 4 junio src 4.0K 2006-11-11 23:52 ../
  -rw-rw-r-- 1 junio src 148K 2006-11-11 23:53 pack-f5f88d83....idx
  -rw-rw-r-- 1 junio src 2.6M 2006-11-11 23:53 pack-f5f88d83....pack

In any case, after this "shallow" stuff, repeated "fetch --depth
99" seems to fetch 0 object and 3400 objects alternately, and
the shallow file alternates between 900 bytes and 11000 bytes.

We would need to take a deeper look into what this series does,
before moving it to 'next'.




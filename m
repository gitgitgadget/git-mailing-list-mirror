Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07143C433EF
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 14:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbhLDPCo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 10:02:44 -0500
Received: from avasout-ptp-004.plus.net ([84.93.230.250]:51135 "EHLO
        avasout-ptp-004.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhLDPCo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Dec 2021 10:02:44 -0500
Received: from [10.0.2.15] ([147.147.167.109])
        by smtp with ESMTPA
        id tWVPm0eKMjMoZtWVQmv4EP; Sat, 04 Dec 2021 14:59:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1638629957; bh=ePJDYK7q833rDOFnGHjJ0oOAI4jXV3UsyxXnwaFq9Z4=;
        h=To:Cc:From:Subject:Date;
        b=R2KkQ4N7FMVUIYO7gSQq6wKbgKH5E47NYyytZNn1Z4ZbuI9X0XsSInNFeY9EcfzLk
         VjtwrWCfsDhfszSise+7FlVDVkogf0sM4qmmexWG2zegSCPi1N03ukVOzaIeiBmrF1
         zsQQbotzN9AL7ngzMrdjg0p8hfSgRuyoBhof5rSh9O4x1KJ4FujW+d1ifuL94wD+VQ
         Qv/elz+8of0Vc3wT5rloRjrWiJKyoIi6K8Ks7m4mHfV8yaiGAnk2xGC9m0JZqH3Yi2
         K6CnhjpUHhExNWVrIe4Cz2PgD+QRd4rc167i+I0JlpySPKm6Y8UD5ewjAdo4gwRIdX
         zYFaYmwsXHvNw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=D7Qkltdj c=1 sm=1 tr=0 ts=61ab8245
 a=QdS5mZX/VJYKMdXaSBaSIA==:117 a=QdS5mZX/VJYKMdXaSBaSIA==:17
 a=IkcTkHD0fZMA:10 a=XUWtvKednLWLcuv_2nAA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
To:     Taylor Blau <me@ttaylorr.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: static-check hits
Message-ID: <ec008905-5e04-944d-f164-d52a622f0531@ramsayjones.plus.com>
Date:   Sat, 4 Dec 2021 14:59:15 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfK7m+yy4Bm004hWDMZsx5FlnWkZn7iclw/gGqakqur/eZpPiIrGpFFfj1pR1Kg0WJnfChL1FCdcxrm0JS/mO087Jp/L8CnftUKLJdLKJpi223E0Q/Xh7
 lUDi4cqdbj9p9NkUqC4buMdncVFaYaQ+Hf7ibbnRYUvo2TNBruvmp2TKGs/wqLzQZ6ey0QmRb//QKWBwPWZYahJzVF/OQw7XF7k=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

Just a quick note about new hits from my 'static-check.pl' script
caused by the 'tb/cruft-packs' branch. This script notes any symbols
that are not referenced outside the defining compilation unit.
(So they could be declared static in that compilation unit).
Comparing the current 'next' and 'seen' branches:

  $ diff nsc ssc
  ...
  62a63,64
  > pack-mtimes.o	- pack_has_mtimes
  > packfile.o	- close_pack_mtimes
  ...
  $ 

This is not necessarily a problem, of course, if you have patches/plans
to add callers in the future (or that they simply 'round out' an API).
I haven't looked (so can't comment), beyond:

  $ git grep -n pack_has_mtimes
  pack-mtimes.c:14:int pack_has_mtimes(struct packed_git *p)
  pack-mtimes.h:11:int pack_has_mtimes(struct packed_git *p);
  $ git grep -n close_pack_mtimes
  packfile.c:336:void close_pack_mtimes(struct packed_git *p) {
  packfile.c:350: close_pack_mtimes(p);
  packfile.h:94:void close_pack_mtimes(struct packed_git *p);
  $ 

Note that 'pack_has_mtimes()' has no callers at all. Also, the function
definition of 'close_pack_mtimes()' has the opening { of the body
on the function header line, rather than by itself on the following line.

Just an FYI.

ATB,
Ramsay Jones



From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: valgrind hits in t9400 and t9401 (git cvsserver)
Date: Fri, 02 Jul 2010 21:06:27 +0200
Message-ID: <4C2E38B3.2020900@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: jaysoffian@gmail.com, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 02 21:06:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUlZQ-0008Mb-8v
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 21:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752715Ab0GBTGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jul 2010 15:06:34 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:42072 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728Ab0GBTGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 15:06:33 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate01.web.de (Postfix) with ESMTP id 36CE11629EAA0;
	Fri,  2 Jul 2010 21:06:32 +0200 (CEST)
Received: from [80.128.51.157] (helo=[192.168.178.29])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OUlZH-0005nw-00; Fri, 02 Jul 2010 21:06:32 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/jcBcJbWhAlvdZOTRauBNq1zWu7XQUc5eB1b9J
	M5jywtiSq7Hzsk0CXEI0QMwWCJuvcvtkoS6MiWGy71YZmr2jcy
	QVFHYqyMZCmnjkuw4kmQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150148>

While working on a new configuration option for submodules i came
across a strange test failure today. My changes broke 19 different
tests in t9400 and t9401.

I found out that the failures were triggered by adding a function
call in cmd_diff_tree() right before the git_config() call. As I
had no idea how this change could possibly break those tests, I
decided to ask valgrind for its opinion. Using the --valgrind
option on t9400-git-cvsserver-server.sh I saw three hits. Unable
to imagine how my changes could provoke them, I tried plain next
et voila, the same hits showed up (as for master and pu).

I bisected the failure of t9400 to the commit ca8a36e "Merge branch
'js/remote-improvements'" (I CCed Jay because of that). I checked
this both on my desktop sytem (Fedora 12, Athlon 64 X2, gcc 4.4.3,
valgrind 3.5.0) and my Laptop (Fedora 13, Intel Core2 Duo T550,
gcc 4.4.4, valgrind 3.5.0) with the same result.

I searched the web but didn't find anything. As I am not at all
familiar with remote.c and cmd_fetch(), I'll now pass this to the
list.

Ideas?


valgrind says at ca8a36e for t9400-git-cvsserver-server.sh:

==3407== Invalid read of size 4
==3407==    at 0x80D0254: copy_ref (remote.c:786)
==3407==    by 0x80D0F01: get_fetch_map (remote.c:1242)
==3407==    by 0x8069CC5: cmd_fetch (builtin-fetch.c:123)
==3407==    by 0x804B0B4: handle_internal_command (git.c:244)
==3407==    by 0x804B26D: main (git.c:434)
==3407==  Address 0x4035fd0 is 80 bytes inside a block of size 82 alloc'd
==3407==    at 0x4004F1B: calloc (vg_replace_malloc.c:418)
==3407==    by 0x80E9790: xcalloc (wrapper.c:75)
==3407==    by 0x80D0483: alloc_ref_with_prefix (remote.c:769)
==3407==    by 0x80A6D92: get_remote_heads (connect.c:96)
==3407==    by 0x80E2BF2: get_refs_via_connect (transport.c:618)
==3407==    by 0x80E247D: transport_get_remote_refs (transport.c:791)
==3407==    by 0x8069C88: cmd_fetch (builtin-fetch.c:119)
==3407==    by 0x804B0B4: handle_internal_command (git.c:244)
==3407==    by 0x804B26D: main (git.c:434)
==3407==


==3407== Invalid read of size 4
==3407==    at 0x80D0240: copy_ref (remote.c:786)
==3407==    by 0x80D0406: copy_ref_list (remote.c:801)
==3407==    by 0x8067C1A: fetch_pack (builtin-fetch-pack.c:579)
==3407==    by 0x80E2A52: fetch_refs_via_pack (transport.c:654)
==3407==    by 0x80E25B3: transport_fetch_refs (transport.c:810)
==3407==    by 0x8069806: fetch_refs (builtin-fetch.c:456)
==3407==    by 0x8069D6E: cmd_fetch (builtin-fetch.c:584)
==3407==    by 0x804B0B4: handle_internal_command (git.c:244)
==3407==    by 0x804B26D: main (git.c:434)
==3407==  Address 0x4035f4c is 68 bytes inside a block of size 69 alloc'd
==3407==    at 0x4004F1B: calloc (vg_replace_malloc.c:418)
==3407==    by 0x80E9790: xcalloc (wrapper.c:75)
==3407==    by 0x80D0483: alloc_ref_with_prefix (remote.c:769)
==3407==    by 0x80A6D92: get_remote_heads (connect.c:96)
==3407==    by 0x80E2BF2: get_refs_via_connect (transport.c:618)
==3407==    by 0x80E247D: transport_get_remote_refs (transport.c:791)
==3407==    by 0x8069C88: cmd_fetch (builtin-fetch.c:119)
==3407==    by 0x804B0B4: handle_internal_command (git.c:244)
==3407==    by 0x804B26D: main (git.c:434)
==3407==

==3407== Invalid read of size 4
==3407==    at 0x80D0254: copy_ref (remote.c:786)
==3407==    by 0x80D0406: copy_ref_list (remote.c:801)
==3407==    by 0x8067C1A: fetch_pack (builtin-fetch-pack.c:579)
==3407==    by 0x80E2A52: fetch_refs_via_pack (transport.c:654)
==3407==    by 0x80E25B3: transport_fetch_refs (transport.c:810)
==3407==    by 0x8069806: fetch_refs (builtin-fetch.c:456)
==3407==    by 0x8069D6E: cmd_fetch (builtin-fetch.c:584)
==3407==    by 0x804B0B4: handle_internal_command (git.c:244)
==3407==    by 0x804B26D: main (git.c:434)
==3407==  Address 0x4035fd0 is 80 bytes inside a block of size 82 alloc'd
==3407==    at 0x4004F1B: calloc (vg_replace_malloc.c:418)
==3407==    by 0x80E9790: xcalloc (wrapper.c:75)
==3407==    by 0x80D0483: alloc_ref_with_prefix (remote.c:769)
==3407==    by 0x80A6D92: get_remote_heads (connect.c:96)
==3407==    by 0x80E2BF2: get_refs_via_connect (transport.c:618)
==3407==    by 0x80E247D: transport_get_remote_refs (transport.c:791)
==3407==    by 0x8069C88: cmd_fetch (builtin-fetch.c:119)
==3407==    by 0x804B0B4: handle_internal_command (git.c:244)
==3407==    by 0x804B26D: main (git.c:434)
==3407==

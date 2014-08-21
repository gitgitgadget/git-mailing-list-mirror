From: Petr Stodulka <pstodulk@redhat.com>
Subject: [BUG] resolved deltas
Date: Thu, 21 Aug 2014 13:35:43 +0200
Message-ID: <53F5D98F.4040700@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 21 13:35:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKQem-00068y-9y
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 13:35:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755076AbaHULfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 07:35:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41233 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755070AbaHULfq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 07:35:46 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7LBZk9q030288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <git@vger.kernel.org>; Thu, 21 Aug 2014 07:35:46 -0400
Received: from [10.34.4.169] (unused-4-169.brq.redhat.com [10.34.4.169])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s7LBZiqK003368
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 21 Aug 2014 07:35:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.7.0
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255606>

Hi guys,
I wanted post you patch here for this bug, but I can't find primary 
source of this problem [0], because I don't understand some ideas in the 
code. So what I investigate:

Bug is reprodusible since git version 1.8.3.1 (may earlier 1.8.xx, but I 
don't test it) to actual upstream version.
This problem "doesn't exists" in version 1.7.xx - or more precisely is 
not reproducible. "May" this is reproducible
since commit "7218a215" - in this commit was added assert in file 
"builtin/index-pack.c" (actual line is 918), but I didn't test this.

This assert tests if object's (child) real type == OBJ_REF_DELTA. This 
will failure for object with real_type == OBJ_TREE (set as parent's 
type) and type == OBJ_REF_DELTA. Here some prints of important variables 
before failure assert() (from older version but I think that values are 
still actual in this case):
------------------------------
(gdb) p base->ref_first
$9 = 3223

(gdb) p deltas[3223]
$10 = {
   base = {
     sha1 = "\274\070k\343K\324x\037q\273h\327*n\n\356\061$ \036",
     offset = 2267795834784135356
   },
   obj_no = 11152
}

(gdb) p *child
$11 = {
   idx = {
     sha1 = "J\242i\251\261\273\305\067\236%CE\022\257\252\342[;\tD",
     crc32 = 2811659028,
     offset = 10392153
   },
   size = 30,
   hdr_size = 22,
   type = OBJ_REF_DELTA,
   real_type = OBJ_TREE,
   delta_depth = 0,
   base_object_no = 5458
}

(gdb) p objects[5458]
$13 = {
   idx = {
     sha1 = "\274\070k\343K\324x\037q\273h\327*n\n\356\061$ \036",
     crc32 = 3724458534,
     offset = 6879168
   },
   size = 236,
   hdr_size = 2,
   type = OBJ_TREE,
   real_type = OBJ_TREE,
   delta_depth = 0,
   base_object_no = 0
}
---------------------------------------

"base_object_no" is static 5458. "base->ref_first" child's object are 
dynamic. If you want stop process in same position my recommendation for 
gdb (if you use gdb) when you will be in file index-pack.c:
br 1093
cont
set variable nr_threads = 1
br 1111
cond 2 i == 6300
cont
br 916
cont
-----------
compilated without any optimisation, line numbers modified for commit 
"6c4ab27f2378ce67940b4496365043119d7ffff2"
Condition i == 6300 ---> last iteration before failure has dynamic rank 
in range 6304 to 6309 in the most cases (that's weird for me, when count 
of downloaded objects is statically 12806, may wrong search of children?)
-----------------------------------

Here I am lost. I don't know really what I can do next here, because I 
don't understand some ideas in code. e.g. searching of child - functions 
find_delta(), find_delta_children(). Calculation on line 618:
----
     int next = (first+last) / 2;
----
I still don't understand. I didn't find description of this searching 
algorithm in tech. documentation but I didn't read all yet. However I 
think that source of problems could be somewhere in these two functions. 
When child is found, its real_type is set to parent's type in function 
resolve_delta() on the line 865 and then lasts wait for failure. I don't 
think that problem is in repository itself [1], but it is possible.

Any next ideas/hints or explanation of these functions? I began study 
source code and mechanisms of the git this week, so don't beat me yet 
please :-)

Regards,
Petr

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1099919
[1] git clone https://code.google.com/p/mapsforge/ mapsforge.git

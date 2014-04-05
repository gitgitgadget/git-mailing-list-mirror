From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: What's cooking in git.git (Apr 2014, #01; Fri, 4)
Date: Sat, 05 Apr 2014 13:56:21 +0200
Message-ID: <533FEF65.8010108@web.de>
References: <xmqq4n28q0ad.fsf@gitster.dls.corp.google.com> <533FCA92.8060006@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Stefan Zager <szager@chromium.org>
To: Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 05 13:56:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWPD7-0003ig-Kz
	for gcvg-git-2@plane.gmane.org; Sat, 05 Apr 2014 13:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbaDEL43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2014 07:56:29 -0400
Received: from mout.web.de ([212.227.15.14]:58076 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642AbaDEL42 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2014 07:56:28 -0400
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb004)
 with ESMTPSA (Nemesis) id 0LseoD-1XBg5D1BJh-012Dv6; Sat, 05 Apr 2014 13:56:26
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <533FCA92.8060006@kdbg.org>
X-Provags-ID: V03:K0:80+2BZUxxeZQrEWMmpHN/LCIO1VrMRsKuaZavgGR3v9cMB2zgAy
 gQ9pRK2JJD1eyJBHqvRK3W09PqLbw8IL7MGjnuxGJ8OUHpNqAH12mwx4Z67ZDyzEiqlPWNo
 rEo3rh8GNwGdpBlKvkYUbF/xrjzKB6c7Gvn+uiOJ7zeuqrX+IzSw9C6poTpT+FAhCoag9hm
 cnwRS57waQJFE7BJwdBTA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245780>

On 2014-04-05 11.19, Johannes Sixt wrote:
> Am 04.04.2014 22:58, schrieb Junio C Hamano:
>> * sz/mingw-index-pack-threaded (2014-03-19) 1 commit
>>  - Enable index-pack threading in msysgit.
>>
>>  What is the status of this topic?  A failure report exists
>>  ($gmane/245170), and I am aware of Duy's $gmane/245034 but that was
>>  where the discussion stalled.  Is everybody waiting for everybody
>>  else to get the discussion unstuck?
> 
> I still have to cross-check Duy's patch. I'll hopefully get to it in the
> next days and report back.
> 
> -- Hannes
If this helps the discussion:
----------------------------
commit 03d9d2990b718ef6d859405af399f549c186b4df
Merge: 1b8b51b d84a3da
Author: Junio C Hamano <gitster@pobox.com>
Date:   Fri Apr 4 13:34:56 2014 -0700
----------------------------
looks like this:
grep "not ok" 5302.txt:
not ok 19 - [index v1] 1) stream pack to repository
not ok 21 - [index v1] 3) corrupted delta happily returned wrong data
not ok 24 - [index v1] 6) newly created pack is BAD !
not ok 25 - [index v2] 1) stream pack to repository
not ok 27 - [index v2] 3) corrupted delta happily returned wrong data
not ok 29 - [index v2] 5) pack-objects refuses to reuse corrupted data
not ok 30 - [index v2] 6) verify-pack detects CRC mismatch
-------------------------------------
After reverting 9d66f2d97a97e08ae8d7c86
t5302 passed 3 times of 4 runs.

In the first run a crashing "dd" was reported, but that
was not reproducable.

(And the test log looked like this:)
--------------------
not ok 20 - [index v1] 2) create a stealth corruption in a delta base reference
#       # This test assumes file_101 is a delta smaller than 16 bytes.
#            # It should be against file_100 but we substitute its base for file_099
#            sha1_101=`git hash-object file_101` &&
#            sha1_099=`git hash-object file_099` &&
#            offs_101=`index_obj_offset 1.idx $sha1_101` &&
#            nr_099=`index_obj_nr 1.idx $sha1_099` &&
#            chmod +w ".git/objects/pack/pack-${pack1}.pack" &&
#            dd of=".git/objects/pack/pack-${pack1}.pack" seek=$(($offs_101 + 1)) \
#               if=".git/objects/pack/pack-${pack1}.idx" \
#               skip=$((4 + 256 * 4 + $nr_099 * 24)) \
#               bs=1 count=20 conv=notrunc &&
#            git cat-file blob $sha1_101 > file_101_foo1
not ok 21 - [index v1] 3) corrupted delta happily returned wrong data
#       test -f file_101_foo1 && ! cmp file_101 file_101_foo1

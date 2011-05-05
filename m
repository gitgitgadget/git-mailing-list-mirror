From: "Kibler, Bill" <bill.kibler@hp.com>
Subject: git failure on HP-UX
Date: Thu, 5 May 2011 18:04:38 +0000
Message-ID: <88C5107F36BD7E4BBFDFDB140E3D81077FA78CF12C@GVW1362EXC.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "Kibler, Bill" <bill.kibler@hp.com>,
	Richard Lloyd <richard.lloyd@connectinternetsolutions.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 05 20:06:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI2wR-0004WM-6i
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:06:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755569Ab1EESGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 14:06:18 -0400
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:22836 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521Ab1EESGR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 14:06:17 -0400
Received: from G3W0631.americas.hpqcorp.net (g3w0631.americas.hpqcorp.net [16.233.59.15])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by g5t0008.atlanta.hp.com (Postfix) with ESMTPS id F204B244BC;
	Thu,  5 May 2011 18:06:16 +0000 (UTC)
Received: from G5W0324.americas.hpqcorp.net (16.228.8.69) by
 G3W0631.americas.hpqcorp.net (16.233.59.15) with Microsoft SMTP Server (TLS)
 id 8.2.176.0; Thu, 5 May 2011 18:04:43 +0000
Received: from GVW1362EXC.americas.hpqcorp.net ([16.230.34.143]) by
 G5W0324.americas.hpqcorp.net ([16.228.8.69]) with mapi; Thu, 5 May 2011
 18:04:44 +0000
Thread-Topic: git failure on HP-UX
Thread-Index: AcwLTuYdFJKvu+hXR2qtX0/WIZVM4w==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: BsPL DaIg GkrY I3um KhCR Lt9u MmzN NL8+ Nq0Z OdsB Or2n
 POY7 QGn5 QKmm QXpX
 Tcn3;2;ZwBpAHQAQAB2AGcAZQByAC4AawBlAHIAbgBlAGwALgBvAHIAZwA7AHIAaQBjAGgAYQByAGQALgBsAGwAbwB5AGQAQABjAG8AbgBuAGUAYwB0AGkAbgB0AGUAcgBuAGUAdABzAG8AbAB1AHQAaQBvAG4AcwAuAGMAbwBtAA==;Sosha1_v1;7;{56C007A8-B777-455F-A39F-B80FC9AA4363};YgBpAGwAbAAuAGsAaQBiAGwAZQByAEAAaABwAC4AYwBvAG0A;Thu,
 05 May 2011 18:04:38
 GMT;ZwBpAHQAIABmAGEAaQBsAHUAcgBlACAAbwBuACAASABQAC0AVQBYAA==
x-cr-puzzleid: {56C007A8-B777-455F-A39F-B80FC9AA4363}
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172863>

An outside HP service provides open source packages compiled to run on HP-UX systems. Our group within HP is currently moving to git with the majority of the git usage on linux systems. However, some older work still needs to be done on HP-UX systems and will require a working git set of tools. The current set of git tools works properly except for accessing gitolite, where ssh access and support is used. When trying to "clone" a gitolite hosted repo over ssh, the HP-UX git session fails with a core dump and "SIGBUS" error.

I went through updating the HP-UX system with all the latest patches and was unable to alter the response in any way. After trying many options it became clear that the problem was inside git. I used wdb/gdb and tusc, where I tracked the failure down to a call to "recv_sideband" in sideband.c. It cores when the call is made. The calling process is "sideband_demux" in builtin/fetch-pack.c. "tusc" output showed a "pipe" of size 8192 being used prior to the core. I believe that git "forks" off a "ssh user@hostanme upload-pack 'repo_name'" that is "piped" back to the git stream process.

In looking at the code, "sideband.h" defines "LARGE_PACKET_MAX 65520" and is related to the passed flag "side-band-64k" as discussed in git document pack-protocol.txt. The current default usage seems to be 64K transfers, yet if we check the "include/limits.h" of HP-UX we see a "PIPE_BUF" set to 8192. Along with the tusc indication of 8K pipe size, I suspect that HP-UX is coring due to git trying to use a 64K pipe when 8K is max.

I solved the probem for now, by changing the file sideband.h to use "LARGE_PACKET_MAX 8208". If you use 8192 or less, you get a failure of too small size in "packet_read_line". So I added 16 bytes to 8192 to get the 8208 value. I noticed the previous value and some comments indicating an 8 to 10 byte overhead was needed and thus a few bytes more is needed in this define.

I suspect the correct process would be making the HP-UX git use/send "side-band" and not "side-band-64k" in the get packet protocol, but I was unable to find out how to do that. The pack-protocol.txt discussion completely ignores this topic and how to handle clients with smaller abilities than servers. It appeared to me that the server set the transfer size and the client is just suppose to accept it. Under HPUX as a client, that is not an option, as it has a 8K max limit.

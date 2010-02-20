From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH/RFC 7/7] t7006-pager: if stdout is not a terminal, make
 a new one
Date: Fri, 19 Feb 2010 18:29:21 -0600
Message-ID: <setkR9a6yaRMOU11ekUmlY6ty8nNSPCcidBKotdDxpQsZLCxc54hKw@cipher.nrlssc.navy.mil>
References: <20100219065010.GA22258@progeny.tock> <20100219072331.GG29916@progeny.tock> <20100219080819.GA13691@coredump.intra.peff.net> <20100219081947.GA12975@progeny.tock> <20100219083440.GC13691@coredump.intra.peff.net> <28d--OB9y5MtIy1nJel2Km6d5sqJ3yX6fVUhecDU5ehJUYJmZlE0-A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org,
	Sebastian Celis <sebastian@sebastiancelis.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 20 01:29:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NidE9-0002Bm-I5
	for gcvg-git-2@lo.gmane.org; Sat, 20 Feb 2010 01:29:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755563Ab0BTA3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 19:29:32 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48186 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab0BTA3b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 19:29:31 -0500
Received: by mail.nrlssc.navy.mil id o1K0TLlp032467; Fri, 19 Feb 2010 18:29:21 -0600
In-Reply-To: <28d--OB9y5MtIy1nJel2Km6d5sqJ3yX6fVUhecDU5ehJUYJmZlE0-A@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 20 Feb 2010 00:29:22.0103 (UTC) FILETIME=[BF611470:01CAB1C3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140508>

>> On Fri, Feb 19, 2010 at 02:19:47AM -0600, Jonathan Nieder wrote:
>>
>>> Jeff King wrote:
>>>
>>>> Solaris 8 and 9 seem to be lacking it. Solaris 10 does have it. AIX 5.2
>>>> and 6.1 both have it.
>>>>
>>>> So it would mean some platforms couldn't run all tests. That is probably
>>>> good enough, given that most of our terminal-related bugs have not been
>>>> platform-specific problems.
>>> Hmm, how about /dev/ptmx?  (One can check by replacing posix_openpt(...)
>>> with open("/dev/ptmx", ...) in the test-terminal.c I sent.)

Didn't work on Solaris 7.  I applied your series on top of master with the
change you described.  Here's the diff:

diff --git a/test-terminal.c b/test-terminal.c
index f4d6a71..6408a7d 100644
--- a/test-terminal.c
+++ b/test-terminal.c
@@ -6,7 +6,7 @@ static void newtty(int *master, int *slave)
        int fd;
        const char *term;
 
-       fd = posix_openpt(O_RDWR|O_NOCTTY);
+       fd = open("/dev/ptmx", O_RDWR|O_NOCTTY);
        if (fd == -1 || grantpt(fd) || unlockpt(fd) || !(term = ptsname(fd)))
                die_errno("Could not allocate a new pseudo-terminal");
        *master = fd;


Here's the result of the terminal test:

  # ./test-terminal sh -c "test -t 1"
  # echo $?
  1


And here's the output of t7006-pager:
*** t7006-pager.sh ***
*   ok 1: set up terminal for tests
* no usable terminal, so skipping some tests
*   ok 2: setup
* skip 3: some commands use a pager
* skip 4: some commands do not use a pager
*   ok 5: no pager when stdout is a pipe
*   ok 6: no pager when stdout is a regular file
* skip 7: git --paginate rev-list uses a pager
*   ok 8: no pager even with --paginate when stdout is a pipe
* skip 9: no pager with --no-pager
*   ok 10: tests can detect color
*   ok 11: no color when stdout is a regular file
* skip 12: color when writing to a pager
*   ok 13: color when writing to a file intended for a pager
*   ok 14: determine default pager
* skip 15: default pager is used by default
* skip 16: PAGER overrides default pager
* skip 17: core.pager overrides PAGER
* skip 18: GIT_PAGER overrides core.pager
* passed all 18 test(s)

hth,
-brandon

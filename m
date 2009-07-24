From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH/RFC] SunOS grep does not understand -C<n>
Date: Fri, 24 Jul 2009 10:43:22 -0500
Message-ID: <bkmAA5IX0ZzfCv66mQCX1GFfM5XwTCDPMQk5LjxMd37QH7PwYK29XA@cipher.nrlssc.navy.mil>
References: <7vr5w6tzq8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 17:44:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUMwY-0001eM-3P
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 17:44:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbZGXPnu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 11:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753212AbZGXPnu
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 11:43:50 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49003 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbZGXPnu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 11:43:50 -0400
Received: by mail.nrlssc.navy.mil id n6OFhNsg021201; Fri, 24 Jul 2009 10:43:25 -0500
In-Reply-To: <7vr5w6tzq8.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 24 Jul 2009 15:43:23.0616 (UTC) FILETIME=[7A4E9E00:01CA0C75]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123922>

Junio C Hamano wrote:
> I noticed that the first "grep -C1" test in t7002 does not pass on my 
> SunOS-5.11-i86pc, and that is not because our way to spawn external
> grep is broken, but because the native grep does not understand -C<n>.
> 
> Is it just me and my installation (i.e. I might have failed to install
> saner grep from the distribution that everybody uses), or everybody on
> SunOS is using this option himself because our Makefile doesn't do that
> automatically for them?

Hmm.  I have _not_ been setting NO_EXTERNAL_GREP and the tests have _not_
been failing.

The system grep does not seem to have the -C option:

   # /usr/xpg4/bin/grep -C1 include ws.c
   /usr/xpg4/bin/grep: illegal option -- C
   Usage:  grep [-E|-F] [-c|-l|-q] [-bhinsvwx] [file ...]
   grep [-E|-F] [-c|-l|-q] [-bhinsvwx] -e pattern... [-f pattern_file]...[file...]
   grep [-E|-F] [-c|-l|-q] [-bhinsvwx] [-e pattern]... -f pattern_file [file...]

but git grep -C1 works fine

   # git grep -C1 include ws.c
   ws.c-
   ws.c:#include "cache.h"
   ws.c:#include "attr.h"
   ws.c-

I have been compiling with the SUNWspro compiler suite though, and I see these
statements in builtin-grep.c:

   #ifndef NO_EXTERNAL_GREP
   #ifdef __unix__
   #define NO_EXTERNAL_GREP 0
   #else
   #define NO_EXTERNAL_GREP 1
   #endif
   #endif

So possibly, the SUNWspro compiler does not set the __unix__ macro.  A quick
compile of a test program confirms it.

   #include <stdio.h>

   int main (int argc, char* argv[])
   {
   #ifdef __unix__
   	puts("__unix__ is set");
   #else
   	puts("__unix__ is not set");
   #endif
   	return 0;
   }

   # /opt/SUNWspro/bin/cc -o test.out test.c
   ./test.out
   __unix__ is not set

   # gcc -o test.out test.c
   __unix__ is set

So, I have been getting NO_EXTERNAL_GREP all along without knowing it.

-brandon

From: dev <dev@cor0.com>
Subject: problem with def of inet_ntop() in git-compat-util.h as well as
 other places
Date: Wed, 27 Aug 2014 15:15:05 -0400 (EDT)
Message-ID: <1024776344.30870.1409166905539.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
Reply-To: dev <dev@cor0.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 27 21:15:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMign-0006P8-MV
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 21:15:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935511AbaH0TPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 15:15:20 -0400
Received: from atl4mhfb02.myregisteredsite.com ([209.17.115.56]:42870 "EHLO
	atl4mhfb02.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935490AbaH0TPS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Aug 2014 15:15:18 -0400
Received: from atl4mhob10.myregisteredsite.com (atl4mhob10.myregisteredsite.com [209.17.115.48])
	by atl4mhfb02.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s7RJFHKg020496
	for <git@vger.kernel.org>; Wed, 27 Aug 2014 15:15:17 -0400
Received: from atl4oxapp02pod2.mgt.hosting.qts.netsol.com ([10.30.77.38])
	by atl4mhob10.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s7RJF5Mh006686
	for <git@vger.kernel.org>; Wed, 27 Aug 2014 15:15:05 -0400
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v-
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256024>



per :


  http://pubs.opengroup.org/onlinepubs/009695399/functions/inet_ntop.html


The last parameter is not unsigned long but socklen_t size.

This causes a problem on things like Solaris :

 * new build flags
    CC credential-store.o
"git-compat-util.h", line 516: error: identifier redeclared: inet_ntop
        current : function(int, pointer to const void, pointer to char,
unsigned long) returning pointer to const char
        previous: function(int, pointer to const void, pointer to char,
unsigned int) returning pointer to const char :
"/usr/include/arpa/inet.h", line 68
cc: acomp failed for credential-store.c
gmake: *** [credential-store.o] Error 2



Therefore I hacked around it with a #ifdef __SunOS_5_10 for the sake of
getting the build done.


However ran into a problem, again, with compat/inet_ntop.c which seems
to be not needed at all since inet_ntop() handles both IPv6 and IPv4
just fine.   Really I don't see why this file gets carted around so much
as it is even in the Apache svn codebase as well.

Not needed.

Therefore I commented out the inet_ntop() function entirely therein.

Also the Makefile's generated are all borked full of GCCism "CFLAGS = -g
-O2 -Wall"  which means very little on some OS wherein the gcc compiler
is not the default.  Love GCC. I bootstrap it all the time. However this
is Solaris and am using ORacle Studio 12.3 compilers and therefore the
CFLAGS in the Makefiles are just silly.  Lastly, the linkage to libintl
should look in /usr/local/lib if the LD_LIBRARY_PATH and other env vars
are setup correctly. However the Makefile's seem to miss this fact and
-lintl needs to be manually hacked into place.

Still doesn't "just build" yet.  Getting there :-\

dev

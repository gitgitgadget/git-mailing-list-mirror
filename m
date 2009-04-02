From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Header includes cleanup
Date: Wed, 01 Apr 2009 22:25:09 -0700
Message-ID: <7v8wmjk4p6.fsf@gitster.siamese.dyndns.org>
References: <1238406925-15907-1-git-send-email-nathaniel.dawson@gmail.com>
 <200903310859.36035.chriscool@tuxfamily.org>
 <7vk56565m1.fsf@gitster.siamese.dyndns.org>
 <200904020557.25058.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nathaniel P Dawson <nathaniel.dawson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Apr 02 07:27:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpFSH-00044C-L9
	for gcvg-git-2@gmane.org; Thu, 02 Apr 2009 07:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbZDBFZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 01:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752508AbZDBFZW
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 01:25:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbZDBFZU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 01:25:20 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 78369A67C6;
	Thu,  2 Apr 2009 01:25:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C0B5DA67C1; Thu,
  2 Apr 2009 01:25:12 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A76B4BA2-1F46-11DE-AC67-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115443>

Christian Couder <chriscool@tuxfamily.org> writes:

> Ok, so I suggest the following simple guiding principles:
>
> - git-compat-util.h or cache.h or builtin.h should always be the first 
> #include in C files,
>
> - header files should include other incude files if and only if the other 
> includes are needed to compile them,

This is unclear.

Long before I started touching git, I used to be religious about making
header files self contained.  For a header file frotz.h in the project, I
used to insist that

	$ cat >1.c <<\EOF
	#include "frotz.h"
        EOF
        $ cc -Wall -c 1.c

did not fail.  

Are you talking about that by "to compile them"?

I stopped doing that long time ago, partly because the rule was cumbersome
to enforce, but primarily because it was not helping much in the larger
picture.

Such a rule, together with strict rules such as the order of including
other header files in the header files themselves, may make life easier
for programmers who touch .c files but never .h files, because they can
include only the necessary .h files and in any order.  But in practice,
people need to touch both .h and .c files and when they need to include
new system header files, they need to follow the inclusion order rule
somewhere anyway---at that point, it does not matter much if the rule
applies to only .h files or both .h and .c files.

So for example, you cannot compile

	$ cat >1.c <<\EOF
        #include "revision.h"
        EOF
        $ cc -Wll -c 1.c

in git.git project, but I do not think it is a problem.

> - a header file should be included in a C file only if it is needed to 
> compile the C file (it is not ok to include it only because it includes 
> many other headers that are needed)

If that is the rule, perhaps the problem lies not in a .c program that
includes such a .h header, but in the .h itself that includes many other
header files.

> - other than the above rules, it is ok to reduce the number of includes as 
> much as possible
>
> What do you think?

What you did not write and I forgot to mention, which is a logical
conclusion of the first rule, is that C files should not directly include
common system header files such as unistd, sys/stat, etc.

There are exceptions to any rule.  For example, inclusion of syslog.h in
daemon.c is OK because most of the rest of the system does not even use
syslog.  If we later find a platform whose syslog.h has some funny
inter-header dependencies, however, we will need to include it in the
git-compat-util.h and resolve the dependencies there, like we do for other
system header files.

> Or perhaps Junio would prefer that you work on a C file by C file basis? 
> Like for example:
>
> "delete useless includes in 'builtin-diff-files.c'"
> "delete useless includes in 'builtin-diff-index.c'"

If the series does not involve .h file clean-up, then a series that
consists of one patch per .c file would be easier to handle, I think.

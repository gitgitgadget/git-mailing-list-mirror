From: linux@horizon.com
Subject: Re: [PATCH] Clean up file descriptors when calling hooks.
Date: 7 Dec 2005 22:24:28 -0500
Message-ID: <20051208032428.8591.qmail@science.horizon.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 04:25:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkCOm-0002Qk-Ty
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 04:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030435AbVLHDYq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 22:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030437AbVLHDYq
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 22:24:46 -0500
Received: from science.horizon.com ([192.35.100.1]:26172 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1030435AbVLHDYp
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 7 Dec 2005 22:24:45 -0500
Received: (qmail 8592 invoked by uid 1000); 7 Dec 2005 22:24:28 -0500
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13355>

> A quick question.  I understand "not connected to the pushing
> connection" is desirable, but is there a reason you chose to
> leave them open to /dev/null, not close()d?

Because then the first open() in the hook will assign those fds,
confusing programs that try to use them for their traditional
purposes.  fd 2 (stderr) is of particular concern.

E.g. imagine if I ran gcc -c file.c, and it assigned file.c to fd 0,
file.h to fd1, and file.o to fd 2.   Then wants to print a warning
message... right into the middle of the binary.  (Oversimplified
example, because gcc is actually several separate programs, but
hopefully you get the idea.)

It's just safer to leave those fds open to a null device.

From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Solaris 8
Date: Mon, 26 Jun 2006 10:09:12 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060626080912.GA3646@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Jun 26 10:09:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fum9o-0001qn-Fc
	for gcvg-git@gmane.org; Mon, 26 Jun 2006 10:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964862AbWFZIJQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 04:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWFZIJQ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 04:09:16 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:8920 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S964862AbWFZIJO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 04:09:14 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1Fum9h-00068j-0Q
	for git@vger.kernel.org; Mon, 26 Jun 2006 10:09:13 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k5Q89CD10215
	for git@vger.kernel.org; Mon, 26 Jun 2006 10:09:12 +0200 (MEST)
To: git@vger.kernel.org
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

when trying to get git running on Solaris 8 (gcc 2.95), there are
several pit-falls:

1) for me, install and tar are GNUish, ginstall and gtar don't exist.
   (INSTALL = ginstall, TAR = gtar for SunOS in Makefile)

2) connect.c and merge-index.c use signal() without including signal.h

3) Solaris ships zlib 1.1.3.  That version doesn't define
   ZLIB_VERNUM.  But no, that's not my problem, ... I have it: There is
   another zlib version in /usr/local.  That's 1.2.3, defining
   ZLIB_VERNUM as 0x1230.  The compiler uses include files from
   /usr/local, but lib from /usr/lib.  Aargh, I have to dig the admins
   here...

4) libc don't know printf z and t modifier:

	alloc.c: In function `alloc_report':
	alloc.c:47: warning: unknown conversion type character `z' in format
	alloc.c:47: warning: too many arguments for format
	alloc.c:48: warning: unknown conversion type character `z' in format
	alloc.c:48: warning: too many arguments for format
	alloc.c:49: warning: unknown conversion type character `z' in format
	alloc.c:49: warning: too many arguments for format
	alloc.c:50: warning: unknown conversion type character `z' in format
	alloc.c:50: warning: too many arguments for format
	mktag.c: In function `verify_tag':
	mktag.c:69: warning: unknown conversion type character `t' in format
	mktag.c:69: warning: too many arguments for format
	mktag.c:72: warning: unknown conversion type character `t' in format
	mktag.c:72: warning: too many arguments for format
	mktag.c:77: warning: unknown conversion type character `t' in format
	mktag.c:77: warning: too many arguments for format
	mktag.c:97: warning: unknown conversion type character `t' in format
	mktag.c:97: warning: too many arguments for format
	mktag.c:104: warning: unknown conversion type character `t' in format
	mktag.c:104: warning: too many arguments for format

5) I don't understand why I get this warning for EMIT(c), but not for
   EMIT('\\'):

	quote.c:34: warning: value computed is not used
	quote.c:37: warning: value computed is not used

6) typedef long pid_t
	upload-pack.c: In function `create_pack_file':
	upload-pack.c:277: warning: int format, pid_t arg (arg 2)
	daemon.c: In function `remove_child':
	daemon.c:371: warning: int format, pid_t arg (arg 2)
	daemon.c: In function `child_handler':
	daemon.c:481: warning: int format, pid_t arg (arg 3)

7) I think these can safely be ignored:
	builtin-help.c: In function `cmd_help':
	builtin-help.c:234: warning: null format string
	builtin-help.c:236: warning: null format string
	git.c: In function `main':
	git.c:280: warning: null format string

I'll send out patches in reply to this mail for 2) and 6)

-- 
Uwe Zeisberger

main(){char*a="main(){char*a=%c%s%c;printf(a,34,a,34%c";printf(a,34,a,34
,10);a=",10);a=%c%s%c;printf(a,34,a,34,10);}%c";printf(a,34,a,34,10);}

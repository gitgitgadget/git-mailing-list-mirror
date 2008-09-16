From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [RFC/PATCH] Use compatibility regex library for OSX/Darwin
Date: Tue, 16 Sep 2008 12:49:20 -0500
Message-ID: <W_emvcr7ijntBMNCDV17_XHXotGkm1Bn-9Bw-ZixcXmFyBWlDj5vYg@cipher.nrlssc.navy.mil>
References: <20080907184537.GA4148@regex.yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Tue Sep 16 19:51:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfei6-0001tD-DJ
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 19:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbYIPRuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 13:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753551AbYIPRuY
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 13:50:24 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:46557 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbYIPRuX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 13:50:23 -0400
Received: by mail.nrlssc.navy.mil id m8GHnKDN029721; Tue, 16 Sep 2008 12:49:21 -0500
In-Reply-To: <20080907184537.GA4148@regex.yaph.org>
X-OriginalArrivalTime: 16 Sep 2008 17:49:20.0581 (UTC) FILETIME=[8C23B750:01C91824]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96022>

Arjen Laarhoven wrote:
> The standard libc regex library on OSX does not support alternation
> in POSIX Basic Regular Expression mode.  This breaks the diff.funcname
> functionality on OSX.
> 
> To fix this, we use the GNU regex library which is already present in
> the compat/ diretory for the MinGW port.  However, simply adding compat/
> to the COMPAT_CFLAGS variable causes a conflict between the system
> fnmatch.h and the one present in compat/.  To remedy this, move the
> regex and fnmatch functionality to their own subdirectories in compat/
> so they can be included seperately.


I wonder if this is the right fix? Right now the GNU regex library is
necessary for Darwin, FreeBSD and AIX. I can add IRIX6.5 and Solaris 7
to that list. Have newer Solaris's been tested yet? (Jeff?) I wonder if
the new test which triggers this flaw has been tested on the other
non-GNU platforms in the Makefile which have not been updated. Boyd
Lynn Gerber and his 12 platforms comes to mind.

It seems POSIX only mentions alternation under Extended Regular Expressions.
Likewise for the vertical-line character '|'.

http://www.opengroup.org/onlinepubs/009695399/basedefs/xbd_chap09.html#tag_09_04_07

A look at compat/regex/regex.c: line 4723 shows that the default mode is
RE_SYNTAX_POSIX_BASIC.

>From the description in regex.h this mode includes "...bits common to both
basic and extended POSIX regex syntax". It seems this mode allows backslashed
versions of the extended regular expression operators ?, +, and |.

Other platforms which adhere more strictly to the POSIX spec do not interpret
the backslashed Ext-RE operators in Basic Regular Expression mode. Similar
to GNU RE_SYNTAX_POSIX_MINIMAL_BASIC.

If I'm interpreting things correctly, then all non-GNU platforms may need the
compat regex library.

On a related note: Is there any reason why extended regular expressions
were not used by default? Wouldn't they have looked prettier (fewer backslashes)?

It's too late to change diff.*.funcname now, but an alternative fix which would
probably not require every other platform to use GNU regex, is to introduce a
new funcname option which would allow extended regular expression syntax and to
convert the internal regular expressions to that format.

-brandon

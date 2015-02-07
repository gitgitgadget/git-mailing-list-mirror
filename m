From: Joachim Schmitz <jojo@schmitz-digital.de>
Subject: read()  =?utf-8?b?TUFYX0lPX1NJWkU=?= bytes, more than =?utf-8?b?U1NJWkVfTUFYPw==?=
Date: Sat, 7 Feb 2015 16:45:39 +0000 (UTC)
Message-ID: <loom.20150207T174514-727@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 07 17:45:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YK8W0-000678-5P
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 17:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756882AbbBGQps (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 11:45:48 -0500
Received: from plane.gmane.org ([80.91.229.3]:51329 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755768AbbBGQpr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 11:45:47 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1YK8Vu-00063B-9F
	for git@vger.kernel.org; Sat, 07 Feb 2015 17:45:46 +0100
Received: from dslb-188-109-251-074.188.109.pools.vodafone-ip.de ([188.109.251.74])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2015 17:45:46 +0100
Received: from jojo by dslb-188-109-251-074.188.109.pools.vodafone-ip.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 07 Feb 2015 17:45:46 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 188.109.251.74 (Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263443>

Hi there

While investigating the problem with hung git-upload-pack we think to have 
found a bug in wrapper.c:

#define MAX_IO_SIZE (8*1024*1024)

This is then used in xread() to split read()s into suitable chunks.
So far so good, but read() is only guaranteed to read as much as SSIZE_MAX 
bytes at a time. And on our platform that is way lower than those 8MB (only 
52kB, POSIX allows it to be as small as 32k), and as a (rather strange) 
consequence mmap() (from compat/mmap.c) fails with EACCESS (why EACCESS?), 
because xpread() returns something > 0.

How large is SSIZE_MAX on other platforms? What happens there if you try to 
read() more? Should't we rather use SSIZE_MAX on all platforms? If I'm 
reading the header files right, on Linux it is LONG_MAX (2TB?), so I guess 
we should really go for MIN(8*1024*1024,SSIZE_MAX)?


bye, Jojo

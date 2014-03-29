From: Charles Bailey <cbailey32@bloomberg.net>
Subject: AIX fixes
Date: Sat, 29 Mar 2014 15:38:59 +0000
Message-ID: <1396107541-22974-1-git-send-email-cbailey32@bloomberg.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 29 16:39:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTvLs-0001iw-1K
	for gcvg-git-2@plane.gmane.org; Sat, 29 Mar 2014 16:39:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbaC2PjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2014 11:39:16 -0400
Received: from avasout05.plus.net ([84.93.230.250]:54322 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbaC2PjN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2014 11:39:13 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id jTfA1n0052iA9hg01TfBor; Sat, 29 Mar 2014 15:39:12 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=SYp5d5hu c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=N2sEI2mohSIA:10 a=BHUvooL90DcA:10 a=BNFp--SqAAAA:8
 a=Ew9TdX-QAAAA:8 a=K8bVcilmhTe1kJ7BVYIA:9
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1WTvLi-00060K-Mz
	for git@vger.kernel.org; Sat, 29 Mar 2014 15:39:10 +0000
X-Mailer: git-send-email 1.8.5.1.2.ge5d1dab
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245433>

[PATCH 1/2] Remove inline from git_fnmatch in dir.c

There are currently a few issues with building on AIX. These two patches
address two of them. The first removes 'inline' from a function in
dir.c. The function has grown such that I don't really see a benefit in
explicitly encouraging the compiler to inline. (As it is in a .c file, it's
only going to be inlined for sophisticated toolchains doing LTO or
similar for other translation units and with this sophistication the
inline hinting behaviour is probably not so important.)

The problem with having this function declared inline is a compliance
issue.

6.7.4 of C99 says:
> An inline definition of a function with external linkage shall not
> contain a definition of a modifiable object with static storage
> duration, and shall not contain a reference to an identifier with
> internal linkage.

git_fnmatch contains calls to ps_strncmp and ps_strcmp which are all
declared static so violate this and xlC complains about this.

[PATCH 2/2] Don't rely on strerror text when testing rmdir failure

The second issue is that AIX doesn't distinguish between EEXIST and
WNOTEMPTY so two tests that rely on the exact text of strerror for
rmdir's failure to remove a non-empty directory fail. My personal take
was that the exact text of strerror was not too important but we can
test the leading portion of the error message which is under the control
of Git and verifies that the readdir function reported a failure.

I also have an issue where two low level tests (t0020-crlf and
t0022-crlf-rename) fail (and perhaps later tests, too) unless I
de-inline ce_path_match and dir_path_match from dir.h but as I cannot
yet explain what the issue is or why this is a fix, I'm holding onto
this one for now.

Charles.

From: Ian Hinder <hinder@Gravity.PSU.Edu>
Subject: Problems building git with custom curl installation
Date: Thu, 06 Mar 2008 19:39:03 -0500
Message-ID: <47D08EA7.8000607@gravity.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 07 02:25:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXRL7-00031q-Fp
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 02:25:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398AbYCGBYu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 20:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756292AbYCGBYu
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 20:24:50 -0500
Received: from f05s05.cac.psu.edu ([128.118.141.48]:37821 "EHLO
	f05n05.cac.psu.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754665AbYCGBYt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 20:24:49 -0500
X-Greylist: delayed 2743 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Mar 2008 20:24:49 EST
Received: from [146.186.121.44] (grav10.gravity.psu.edu [146.186.121.44])
	(authenticated bits=0)
	by f05n05.cac.psu.edu (8.13.2/8.13.2) with ESMTP id m270d3cv065230
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Thu, 6 Mar 2008 19:39:03 -0500
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76443>

Hi,

I have had some problems building git on a machine which does not have
the distro development packages for Curl installed.  I have installed it
from source, but there are some issues.

>From a clean download of git-1.5.4, I do:

./configure --prefix=/home/ian/software/git-1.5.4
--with-curl=/home/ian/software/curl-7.18.0

I get

  checking for curl_global_init in -lcurl... no

even though curl has been installed in /home/ian/software/curl-7.18.0

I do "make", and get

  /bin/sh: curl-config: command not found

but the make proceeds anyway. When linking, I get warnings

  cc: unrecognized option
'-R/usr/center/atlas1/numrel/software/curl-7.18.0/lib'
and "ldd git" gives

        libcurl.so.4 => not found

If I do

  NO_R_TO_GCC_LINKER=yes make

then things seem to work perfectly, and the rpath to curl is set in
the git executable.  In the course of debugging this problem, I also
found that LDFLAGS were not being passed from the configure command
line to the makefile.

I suggest that the following are bugs:

1. Configure: Specifying the curl location leads to output that
indicates that curl was not correctly located, even though a
subsequent make finds it successfully and includes it in the build.

2. Make: an error appears indicating that curl-config is not found,
which suggests that curl will not be used successfully, even though it
works fine.  It must not be looking for curl-config in the right
place, and it doesn't even seem to be necessary.

3. The use of the makefile option NO_R_TO_GCC_LINKER is not
automatically determined - perhaps an autoconf test could be written
for it?  All the machines I have tried give an error if you try to
give gcc a -R option, and gcc is being used as the linker.

4. LDFLAGS is not passed from the configure command line to the
makefile.  Modifying config.mak.in to contain the line LDFLAGS =
@LDFLAGS@ might be the appropriate fix.

-- 
Ian Hinder
hinder@gravity.psu.edu
http://www.gravity.psu.edu/~hinder

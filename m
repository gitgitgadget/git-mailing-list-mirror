From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: hang in git-upload-pack
Date: Sat, 7 Feb 2015 11:48:50 -0500
Message-ID: <01dd01d042f5$f3a03d10$dae0b730$@nexbridge.com>
References: <loom.20150207T171056-519@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Joachim Schmitz'" <jojo@schmitz-digital.de>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 07 18:15:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YK8yi-0002vm-BL
	for gcvg-git-2@plane.gmane.org; Sat, 07 Feb 2015 18:15:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758469AbbBGRP2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2015 12:15:28 -0500
Received: from elephants.elehost.com ([216.66.27.132]:55455 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887AbbBGRP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2015 12:15:27 -0500
X-Greylist: delayed 1591 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Feb 2015 12:15:27 EST
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t17GmpK9094969
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 7 Feb 2015 11:48:52 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <loom.20150207T171056-519@post.gmane.org>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJDfamoLIQdaLdh4v9OrkZBkSaz8pv+8C0g
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263445>

> -----Original Message-----
>Sent: February 7, 2015 11:26 AM
>In HP-Nonstop we're experiencing hangs in git-upload-pack, which seems to
be the result
>of reads from / writes to pipes don't ever finish or don't get interrupted
properly (SIGPIPE, SIGCHLD?)
>Any idea why that might be and how to fix it?

More context on this issue:
This is a new port of Git 2.3 to HP NonStop OSS (POSIX-ish). With very
minimal changes in git_compat-util.h to include floss and wrapper.c (below),
we are able to clone remote repositories and work on local repositories
without issue. However, when attempting to fetch from a local bare
repository (set up as a remote but on the same server) into a working
repository, or when a remote client attempts to clone from any repository on
the server over any protocol, we end up with git-upload-pack hanging as the
common point of failure. Note that this function has not worked in prior
version of git, so we have no working reference to compare. The team is
suspecting differences in how the OS deals with pipes but our primary need
from the community is some guidance on continuing our investigation in
resolving this.

Most git tests succeed except for: t0025(test 2), t0301(test
12-expected),t5507(test 4 - suspicious of this),t9001(expected).

A sample trace showing the issue is below. There are no external clients
involved in this sample. This is git to git locally. The condition appears
to be representative of all of the hangs.

GIT_TRACE=1 /usr/local/bin/git --exec-path=/usr/local/bin fetch
old_floss_tail
09:52:01.198401 trace: built-in: git 'fetch' 'old_floss_tail'
09:52:01.226684 trace: run_command: 'git-upload-pack
'\''/home/git/floss.git/.git'\'''
09:52:01.229229 trace: exec: '/usr/local/bin/bash' '-c' 'git-upload-pack
'\''/home/git/floss.git/.git'\''' 'git-upload-pack
'\''/home/git/floss.git/.git'\'''
09:52:01.303638 trace: run_command: 'rev-list' '--objects' '--stdin' '--not'
'--all' '--quiet'
warning: no common commits
09:52:01.438320 trace: run_command: 'pack-objects' '--revs' '--thin'
'--stdout' '--progress' '--delta-base-offset' '--include-tag'
remote: 09:52:01.445274 trace: exec: 'git' 'pack-objects' '--revs' '--thin'
'--stdout' '--progress' '--delta-base-offset' '--include-tag'
remote: 09:52:01.463846 trace: built-in: git 'pack-objects' '--revs'
'--thin' '--stdout' '--progress' '--delta-base-offset' '--include-tag'
remote: Counting objects: 485, done.
remote: Compressing objects: 100% (472/472), done.
<<<< Hangs forever at this point. >>>> 

The git-unpack-load is stopped at (not that the addresses might mean much):
  xread + 0x130 (UCr)
  create_pack_file + 0x18F0 (UCr)
  upload_pack + 0x450 (UCr)
  .

There are two git processes at:
  xread + 0x130 (UCr)
  read_in_full + 0x130 (UCr)
  get_packet_data + 0x4A0 (UCr)
  .

And one git is at:
  xwrite + 0x130 (UCr)
  flush + 0x530 (UCr)
  sha1write + 0x600 (UCr)
  write_no_reuse_object + 0x1390 (UCr)
  .

Wrapper.c change:
@@ -173,7 +173,12 @@ void *xcalloc(size_t nmemb, size_t size)
  * the absence of bugs, large chunks can result in bad latencies when
  * you decide to kill the process.
  */
-#define MAX_IO_SIZE (8*1024*1024)
+#ifdef __TANDEM
+# include <limits.h> /* SSIZE_MAX == 52k */
+# define MAX_IO_SIZE SSIZE_MAX
+#else
+# define MAX_IO_SIZE (8*1024*1024)
+#endif

Best Regards,
Randall
-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)

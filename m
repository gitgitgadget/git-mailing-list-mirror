From: Tait <git.git@t41t.com>
Subject: Re: [PATCH maint 0/3] do not write files outside of work-dir
Date: Tue, 31 May 2011 21:14:39 -0700
Message-ID: <20110601041439.GH29958@ece.pdx.edu>
References: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, johannes.schindelin@gmx.de,
	j.sixt@viscovery.net, Theo Niessink <theo@taletn.com>
To: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 06:28:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRd37-0006ne-UD
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 06:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab1FAE2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 00:28:48 -0400
Received: from ehlo.cat.pdx.edu ([131.252.208.106]:35850 "EHLO
	ehlo.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075Ab1FAE2r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 00:28:47 -0400
X-Greylist: delayed 831 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Jun 2011 00:28:47 EDT
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by ehlo.cat.pdx.edu (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id p514Eg8P020590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 31 May 2011 21:14:42 -0700
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id p514EgCa017694;
	Tue, 31 May 2011 21:14:42 -0700 (PDT)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id p514EdOC017693;
	Tue, 31 May 2011 21:14:39 -0700 (PDT)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <1306512040-1468-1-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.4 (ehlo.cat.pdx.edu [131.252.208.106]); Tue, 31 May 2011 21:14:42 -0700 (PDT)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=unavailable
	version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on ehlo.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.96.5 at ehlo
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174847>

> Theo Niessink has uncovered a serious sercurity issue in Git for Windows,
> where cloning an evil repository can arbitrarily overwrite files outside
> the repository...

Filenames starting with C: are not necessarily absolute. Consider
"c:foo.txt" where c: is the current directory on drive C, or
"c:stream1" where c is a single-letter filename in the current directory
with an alternate data stream such as would be shown by dir /r. The
has_dos_drive_prefix check is overly broad. Maybe this is intentional and
just needs to be documented. Absolute paths like \\localhost\C$\file.txt
and \\?\C:\file.txt do seem to be caught, because they start with '\'.

Microsoft says[1] a path is relative unless:
  - it begins with "\\"
  - it begins with a disk designator followed by a directory separator
  - it begins with a single "\"

On that basis, has_dos_drive_prefix(path) should be:
  isalpha(*(path)) && (path)[1] == ':' && is_dir_sep((path)[2])

However, there are also paths within the NT namespace (as opposed to the
Win32 namespace, [1] again) that might be considered absolute, or at least
to which git should not try to write. Examples would be PRN, CONOUT$, AUX,
etc. These will not be caught by the current form of has_dos_drive_prefix,
if that is even the right place to catch them. I think the QueryDosDevice
function (given the part of the path up to the first directory separator,
if one is present [2]) would detect them, and logical drive mappings as
well. However, QueryDosDevice seems to also include many things that are
not worthy of concern, like (on my computer) "DISPLAY5". Does anyone know
the correct approach here?

I gather that other programs can create names like these (with
DefineDosDevice), so a hard-coded exception list from [1] (that being: CON,
PRN, AUX, NUL, COM1, COM2, COM3, COM4, COM5, COM6, COM7, COM8, COM9, LPT1,
LPT2, LPT3, LPT4, LPT5, LPT6, LPT7, LPT8, and LPT9) might not be adequate?

[1] http://msdn.microsoft.com/en-us/library/aa365247(v=vs.85).aspx
[2] http://msdn.microsoft.com/en-us/library/aa365461(v=vs.85).aspx

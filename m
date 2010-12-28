From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [RFC/PATCH 0/4] improving svn-fe error handling
Date: Tue, 28 Dec 2010 04:45:03 -0600
Message-ID: <20101228104503.GA5422@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 11:45:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXX3e-0001MZ-TF
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 11:45:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab0L1Kp3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 05:45:29 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65047 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab0L1Kp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 05:45:28 -0500
Received: by ywl5 with SMTP id 5so3827699ywl.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 02:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=K4KPANpszciqba8IrN5iin5DA/rItp2MWh+AGzKtkTU=;
        b=ZWTa2NSltB4MA6XWyg3ZpoMtsDFZmroSRqo+YV9Mw8Ovq87GBngCOkkJ1Gmw8GwPbs
         5m+92vaHe6JRQw5+KMtIgRR32PlSucyw/VGsUYznJal3X3PVnj9iCpnu4l4o8ZNHTdWY
         GO22hdwWiLYZlFzsHMNU5nz9EggDbmnDgvb4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=sMnR8TCAaNc7eVGaEXhkc0HjmtPwkcKSqKbKmPEEAEpa3lvCM5yPs91hhI24lHibjn
         BOtdzEJ+ZEJDswb9//Gah/IifKeI8oiFj9aQM/2MoXMo1OEw1gvZkLy+1JcJp83pYLbo
         W5dJtpjdxz+WzhNl2gWDPaNWX2TFM1Q1TRKH4=
Received: by 10.150.227.13 with SMTP id z13mr17870032ybg.60.1293533128343;
        Tue, 28 Dec 2010 02:45:28 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id q4sm12528979ybe.12.2010.12.28.02.45.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 02:45:27 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164234>

Hi,

Currently malformed streams (e.g., ending early) and input errors when
reading a dump file can cause svn-fe to dereference a NULL pointer or
otherwise act in a confusing way.  Especially since incremental
imports work now, I think a saner behavior is to error out with a
clear error message; the operator can then fix the problem and resume.
This series is an attempt in that direction.

Still to do:
 - add tests (reading /dev/full?  how else to provoke an input error?)
 - change buffer_read_string to disallow short reads, to simplify

I am sending it out now because patches 1, 2, and 3 make API changes
that I find convenient, so I'd be interested in your thoughts before
I commit too heavily to a bad idea.

Patch 1 introduces buffer_ferror, to check if errors were encountered
reading from the line_buffer.  Unlike buffer_deinit, this can be used
after any operation so it can be used early, when errno is still valid.

Patches 2 and 3 make operations that can be partially completed
still return some indication of success or failure.

Patch 4 is an example application, using the new API to make svn-fe
a little better at detecting malformed dump files.

Thoughts?
Jonathan Nieder (4):
  vcs-svn: allow input errors to be detected promptly
  vcs-svn: make buffer_skip_bytes return length read
  vcs-svn: make buffer_copy_bytes return length read
  vcs-svn: improve reporting of input errors

 vcs-svn/fast_export.c   |   13 +++++++++-
 vcs-svn/line_buffer.c   |   36 ++++++++++++++++++-------------
 vcs-svn/line_buffer.h   |    6 +++-
 vcs-svn/line_buffer.txt |    3 +-
 vcs-svn/svndump.c       |   53 +++++++++++++++++++++++++++++++++++++---------
 5 files changed, 80 insertions(+), 31 deletions(-)

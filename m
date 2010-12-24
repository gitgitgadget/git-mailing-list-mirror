From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/4] teach vcs-svn/line_buffer to handle multiple input files
Date: Fri, 24 Dec 2010 02:05:05 -0600
Message-ID: <20101224080505.GA29681@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 24 09:08:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PW2hm-0007V4-Vh
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 09:08:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907Ab0LXIFY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Dec 2010 03:05:24 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45654 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610Ab0LXIFX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 03:05:23 -0500
Received: by gxk9 with SMTP id 9so249180gxk.19
        for <git@vger.kernel.org>; Fri, 24 Dec 2010 00:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=V5ZfOenzprCpUSpM6C0VVKVKr/M9jw0oiXPKQTpHAPM=;
        b=Ky5jVQu1YOi776sI2nxOUqjzeW4euvUpRIWnp1DU/UvL+NScJ1Nz1SDv5RQGghIXcw
         wQ4jdOEBC3brSqfLe4PILGWE66uKtpJ/8K/8hcp0NNuKYigNGhpDUqkJhaWclIefjs1Z
         +bCcpQNvRN89p1AL5dVLlcFiRTj7Kuc7buh3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=NtT87eAmJ5y+unnnJ4DZFeXqW5aaGqwrPH3rWjF+y98RrDmg6OfPQp2ZT2NF359f6E
         JxArnWBjjOoA7n8+NYCHPBoSJl4EypQeNCxVjMtT/eWld4/IrARU/F5QvoqIZGHDgUkL
         Ru4+7leRwxrJDJ7wuEkOD8315B6H1X92Y9vt8=
Received: by 10.150.195.12 with SMTP id s12mr13588982ybf.8.1293177920571;
        Fri, 24 Dec 2010 00:05:20 -0800 (PST)
Received: from burratino (c-76-126-174-171.hsd1.ca.comcast.net [76.126.174.171])
        by mx.google.com with ESMTPS id c4sm8603593ybn.15.2010.12.24.00.05.17
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Dec 2010 00:05:19 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164146>

Hi David et al,

This collection of patches comes from the svndiff0 series[1].  They
are not urgent --- the motivation is for svn-fe to be able to keep
separate track of input from stdin (svnrdump) and the report-fd (blobs
from fast-import) for the coming Text-delta support --- but ideally I
would like to see them applied at the start of the next merge window,
since they change API that other patches use.  See [*] below for the
open question.

The idea: instead of keeping the input file handle and input buffer as
global variables, pack them in a struct and let the calling program
keep track of them.

Patch 1 makes a previously global buffer local to the two functions
that use it.  Performance impact should be negligibile.  Ideally the
buffer would not be needed at all --- there is enough buffering at
lower layers already --- but stdio does not provide the calls that
would be needed to eliminate it (in particular a wrapper for
sendfile(2)).

Patch 2 replaces a use of the obj_pool library with a strbuf.  The
main immediate effect is to improve error handling behavior (more
importantly, this is needed for patches 3 and 4 since obj_pool is
defined to be global).

Patches 3 and 4 are the main patches, collecting input state in a
struct and moving resposibility for that struct to the calling
program, respectively.

The patches have already received a lot of testing.

[*]
I am not sure whether this is the right approach for reading from the
report-fd.  To avoid deadlock, we cannot issue a blocking read(2)
after the trailing newline has been read from an expected line or the
nth byte has been read in fixed-length input.  This would rule out
fread/fgets if implemented as follows with too large an internal
buffer:

 1. fill internal buffer completely (or stop when an error or
    end of file is encountered)
 2. fill caller's buffer from internal buffer

glibc fread/fgets do not work that way (and in fact will never
deadlock for us).  What about other platforms?  The standards (C,
POSIX) do not make it obvious.

 - maybe setvbuf(f, NULL, _IOLBF, 0) would make fgets safe to use
 - maybe setvbuf(f, NULL, _IONBF, 0) would make fread safe to use.
   On the other hand, it is not clear to me what unbuffered input
   means in this context.  That flag does not do anything meaningful
   on glibc, for example, for input streams.

If all else fails, setting the O_NONBLOCK flag with fcntl (this
could presumably be implemented as SetNamedPipeHandleState(...,
PIPE_NOWAIT) on Windows) would avoid trouble.  After any failing
operation we would have to check that the error is EAGAIN and
clear the error indicator.  Simple.  But it would be even better
to learn that that is not needed.

So far I have been playing it safe with the read(fd, buf, 1) trick
but that does not have great performance, as David noticed[2].

Thoughts?

Jonathan Nieder (4):
  vcs-svn: Eliminate global byte_buffer[] array
  vcs-svn: Replace buffer_read_string memory pool with a strbuf
  vcs-svn: Collect line_buffer data in a struct
  vcs-svn: Teach line_buffer to handle multiple input files

 test-line-buffer.c      |   17 ++++++-----
 vcs-svn/fast_export.c   |    6 ++--
 vcs-svn/fast_export.h   |    5 +++-
 vcs-svn/line_buffer.c   |   66 ++++++++++++++++++++--------------------------
 vcs-svn/line_buffer.h   |   25 +++++++++++++-----
 vcs-svn/line_buffer.txt |    5 ++-
 vcs-svn/svndump.c       |   29 +++++++++++---------
 7 files changed, 82 insertions(+), 71 deletions(-)

[1] http://thread.gmane.org/gmane.comp.version-control.git/158731
[2] http://colabti.org/irclogger/irclogger_log/git-devel?date=2010-12-18

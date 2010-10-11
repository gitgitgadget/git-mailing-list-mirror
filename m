From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/WIP 00/16] svn delta applier
Date: Sun, 10 Oct 2010 21:34:36 -0500
Message-ID: <20101011023435.GA706@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 11 04:38:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P58H5-00069i-AW
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 04:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab0JKCh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 22:37:57 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51310 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab0JKCh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 22:37:56 -0400
Received: by gyg13 with SMTP id 13so605905gyg.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 19:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nWJqVsJaeBZOekxc8j5s/0FXi1mNG4h1zkQNFxLN5Eo=;
        b=EnNF94PyOV/c0Q0yBCrUBFbXiJT31dBGr//b9z1d/PxB2mwR15W/c/SV7pdoYDP7TS
         dliaPLRRtoTDPVkuQgdSN5N/fGL9I+i19cPYUF2AoJsrU2G/NLsxRUNY8uq/ijUWqeRf
         1rWISM56pPxRrWwVpq6l3+QaNEnklh0c8mJNg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=n6XgNmabmZtaH4KL86R8PX8y28LcQbB60RmEPb1SDYlFMA5O8IQrogo8vp3H4HqmJf
         Yj+gNKl5OIOSGBzFKKYGOb5Wklu04GKt9ZRkbskhS7P9HtP2ujEg7VNOuzmLjOKR/kSg
         IkiH3m3kLpHqdS4cQC6rSq/4WYyjDjVpRQojw=
Received: by 10.151.40.6 with SMTP id s6mr6043948ybj.445.1286764675542;
        Sun, 10 Oct 2010 19:37:55 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v38sm2295784yba.11.2010.10.10.19.37.54
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 19:37:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100810125317.GB3921@kytes>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158731>

Hi,

The svndiff format has proved more difficult to parse than expected.
This series documents the current state of things, and though it is
not complete, it should be ready for nitpicking by the masses.

Patches 1-4 modify the line_buffer API by introducing a struct
line_buffer to collect state that was previously held in global
variables.  Callers can use multiple line_buffers to manage input from
multiple files at a time.

Patches 5-10 add various utility functions to the line_buffer API
(wrapping strbuf_fread(), fgetc(), etc).  Putting the helpers there
instead of having callers work with the FILE* directly means one
could easily

 - tweak the input stream (to insert "link: " at the beginning
   for symlinks?);
 - trace reads, for debugging; or
 - use read() directly in place of stdio and limit the number of bytes
   buffered

if one wants to.

Patch 11 adds a data structure and function to manage a "sliding
window" without using mmap() or fseek().  See the svndiff0 spec[1] for
how this would be used.

Patches 12 and 13 are some basic components for reading an svndiff0
file: reading variable-length integers and the opening magic bytes.

Patch 15 makes the svn-fe test usable on systems (like Ram's) without
libsvn-perl installed.  It also should make the test easier to read
for people unfamiliar with lib-git-svn.sh.

Patch 16 is the delta parser/applier.  This patch does _not_ add it to
contrib/svn-fe, even though that would be useful, since the
command-line interface is not set in stone yet.  If you want to try it
out, use the test-svn-fe command:

	test-svn-fe -d <preimage> <delta> <delta length>

The preimage or delta arg can be /dev/stdin for use in a pipeline.
Both are only read sequentially; they do not need to be regular files.

One of the test cases is enormous.  The svn delta lib doesn't use
multiple windows except when dealing with relatively big files, but
probably the test case should be replaced with a smaller, artificial
example.

One of the test cases does not pass.  I also don't know how to apply
the delta by hand --- it seems to have some extra bytes at the end. :(
Unfortunately the svndiff0 spec is not as clear about when to stop
reading as one might like

The code separately maintains nominal and actual lengths for a few
buffers, since truncated input is permitted (and even required) in the
deltas svn produces, though the svndiff0 spec does not document the
semantics of that.

For svn-fe changes to take advantage of this code to handle the
dumpfilev3 format, see <git://github.com/barrbrain/git.git>[2].  So
now the full svnrdump | svn-fe | fast-import pipeline can be
experienced.  It still chokes on some deltas in the wild.

Thoughts, cleanups, test cases, bug reports, improvements welcome. :)

Enjoy,
Jonathan Nieder (15):
  vcs-svn: Eliminate global byte_buffer[] array
  vcs-svn: Replace buffer_read_string()'s memory pool with a strbuf
  vcs-svn: Collect line_buffer data in a struct
  vcs-svn: Teach line_buffer to handle multiple input files
  vcs-svn: Make buffer_skip_bytes() report partial reads
  vcs-svn: Better support for reading large files
  vcs-svn: Add binary-safe read() function
  vcs-svn: Let callers peek ahead to find stream end
  vcs-svn: Allow input errors to be detected early
  vcs-svn: Allow character-oriented input
  vcs-svn: Add code to maintain a sliding view of a file
  vcs-svn: Learn to parse variable-length integers
  vcs-svn: Learn to check for SVN\0 magic
  compat: helper for detecting unsigned overflow
  vcs-svn: Add svn delta parser

Ramkumar Ramachandra (1):
  t9010 (svn-fe): Eliminate dependency on svn perl bindings

 Makefile                 |    5 +-
 vcs-svn/line_buffer.txt  |    8 +-
 vcs-svn/fast_export.c    |    6 +-
 vcs-svn/fast_export.h    |    5 +-
 vcs-svn/line_buffer.c    |   99 +-
 vcs-svn/line_buffer.h    |   29 +-
 vcs-svn/sliding_window.c |   65 +
 vcs-svn/sliding_window.h |   14 +
 vcs-svn/svndiff.c        |  344 +
 vcs-svn/svndiff.h        |    9 +
 vcs-svn/svndump.c        |   29 +-
 vcs-svn/LICENSE          |    2 +
 git-compat-util.h        |    6 +
 test-line-buffer.c       |   17 +-
 test-svn-fe.c            |   37 +-
 t/t9010-svn-fe.sh        |   29 +-
 t/t9010/Xerces.cpp.diff0 |  Bin 0 -> 12185 bytes
 t/t9010/Xerces.cpp.done  |54963 +++++++++++++++++++++++++++++++++++++++++++++
 t/t9010/Xerces.cpp.src   |55052 ++++++++++++++++++++++++++++++++++++++++++++++
 t/t9010/newdata.diff0    |  Bin 0 -> 19392 bytes
 t/t9010/newdata.done     |  522 +
 t/t9010/src.diff0        |  Bin 0 -> 74 bytes
 t/t9010/src.done         |  522 +
 23 files changed, 111677 insertions(+), 86 deletions(-)
 create mode 100644 vcs-svn/sliding_window.c
 create mode 100644 vcs-svn/sliding_window.h
 create mode 100644 vcs-svn/svndiff.c
 create mode 100644 vcs-svn/svndiff.h
 create mode 100644 t/t9010/Xerces.cpp.diff0
 create mode 100644 t/t9010/Xerces.cpp.done
 create mode 100644 t/t9010/Xerces.cpp.src
 create mode 100644 t/t9010/blank.done
 create mode 100644 t/t9010/newdata.diff0
 create mode 100644 t/t9010/newdata.done
 create mode 100644 t/t9010/src.diff0
 create mode 100644 t/t9010/src.done

[1] http://svn.apache.org/repos/asf/subversion/trunk/notes/svndiff
[2] And some design notes:
http://thread.gmane.org/gmane.comp.version-control.git/150005/focus=157119

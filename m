From: Raja R Harinath <harinath@hurrynot.org>
Subject: Re: [msysGit] Re: Git for Windows and line endings
Date: Sun, 04 Nov 2012 18:07:53 +0530
Message-ID: <878vahee72.fsf@hariville.hurrynot.org>
References: <CADKp0pyy=Nnv29LyhzAOX4B5wJNYnZ0h5d7zxNRyZxV2OGUSjg@mail.gmail.com>
	<CABPQNSZE7TP0G-uW1b1nbsNgpxYCEiD5KefS62GB5gZbWyZXDQ@mail.gmail.com>
	<alpine.DEB.1.00.1210190801490.2695@bonsai2>
	<CADKp0pxuFsSEeZoeemyaqhSJEcsjj1arEOsF4Ub8=76y7tkwHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 13:39:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUzUM-00067G-2I
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 13:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300Ab2KDMic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 07:38:32 -0500
Received: from plane.gmane.org ([80.91.229.3]:35057 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877Ab2KDMib (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 07:38:31 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TUzTJ-0005W6-Nb
	for git@vger.kernel.org; Sun, 04 Nov 2012 13:38:37 +0100
Received: from 122.172.0.47 ([122.172.0.47])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Nov 2012 13:38:37 +0100
Received: from harinath by 122.172.0.47 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 04 Nov 2012 13:38:37 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 122.172.0.47
User-Agent: Gnus/5.130006 (Ma Gnus v0.6) Emacs/24.2.50 (gnu/linux)
Cancel-Lock: sha1:5VuBRCAiGzuMiRvKKQwEdD2Rlmc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209026>

Hi,

Chris B <chris.blaszczynski@gmail.com> writes:
[snip]
> - Windows has been able to cope with UNIX line endings a long time; no
> developer is using a default Notepad to open files with high
> expectations. Any Windows development tool and editor worth anything
> I've used is able to handle both just fine.
> - VIM also handles Windows line endings just fine as well. I just
> tested it on a Linux machine. Maybe old version? (pure VI is not even
> on this machine but hard to press these days it can't handle it.)
> - The files in .git folder are in UNIX format anyway, so why are those
> not also included in line ending changes? Isn't is because there is a
> Windows app (msysgit) running on Windows that expects the UNIX line
> ending? So in the same manor, someone might have a Windows system
> using some Cygwin components perhaps, or a Windows C program possibly
> poorly written or just old, that demand some text files to be left
> alone in the format we saved it.

There are several subtleties in LF handling with mixed systems.  Here's
my write-up in:

  https://github.com/mono/mono/blob/master/.gitattributes

for an example set of trade-offs.  Quoting in full since it's fairly short.

- Hari

# CRLF Handling
# -------------
#
# The ideal situation would be to do no EOL normalization.  Each file
# would have a default EOL, and tools on Windows and Linux would handle
# both EOL formats.
#
# We're not in the ideal world.  A popular editor on Windows (possibly
# Visual Studio) silently introduces EOL corruption -- it displays an
# LF-file normally, but any newly added lines have CRLF.  On Linux,
# Emacs and versions of VI handle LF-files and CRLF-files properly.
# However, emacs doesn't like files with both LF and CRLF EOLs.  Editing
# the file without additional action will increase the EOL corruption
# in the file.
#
# Another vector for mixed EOLs is scripts.  We mostly don't have scripts
# that add new lines -- so we rarely see this.  However, one major event
# in the tree was the addition of copyright headers using a script.  That
# script introduced EOL corruption.
#
# Any automated EOL normalization of files already in the repository will
# cause difficulties in traversing histories, assigning blame, etc.  So, we
# don't want to change what's in the repository significantly, even if it
# causes trouble.
#
# What we do now:
#
# a) we ensure that there's no further corruption of LF-files.  So, we use
#    git's 'crlf' attribute on those files to ensure that things are fine
#    when we work on Windows.  We could use 'crlf=input', but it doesn't buy
#    us much -- we might as well be working with consistent EOLs for files in
#    working directories as well as in the repository
#
# b) if the file already of CRLFs, we don't do any normalization.  We use '-crlf'
#    so that git doesn't do any EOL-conversion of the file.  As I said, this
#    is mostly harmless on Linux.  We can't mark these files as 'crlf' or use
#    the new (git 1.7.2) 'eol=crlf' attribute, since it changes the contents
#    _inside_ the repository [1], and hence makes history traversal annoying.
#    So, we live with occasional EOL corruption.
#
# c) We can handle mixed-EOL files on a case-by-case basis, converting them to
#    LF- or CRLF-files based on which causes fewer lines to change
#
# d) We try to ensure no further headaches, by declaring EOL normalization on
#    code files, and Unix-flavoured files, like shell-scripts, makefiles, etc.
#
# [1] GIT use LFs as the normalized internal representation.

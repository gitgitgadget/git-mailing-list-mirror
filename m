From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 1 Dec 2009 08:26:27 -0800
Message-ID: <20091201162627.GE21299@spearce.org>
References: <4B1168D4.5010902@syntevo.com> <200911282100.23000.j6t@kdbg.org> <4B14DA78.70906@syntevo.com> <4B14DC20.6040808@syntevo.com> <4B14EB2E.9020906@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Singer <thomas.singer@syntevo.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Dec 01 17:27:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFVYo-0004bw-IB
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 17:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbZLAQ0a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 11:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbZLAQ0a
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 11:26:30 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:33606 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815AbZLAQ03 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 11:26:29 -0500
Received: by yxe17 with SMTP id 17so4704835yxe.33
        for <git@vger.kernel.org>; Tue, 01 Dec 2009 08:26:36 -0800 (PST)
Received: by 10.101.34.13 with SMTP id m13mr2342649anj.179.1259684791229;
        Tue, 01 Dec 2009 08:26:31 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 39sm108006yxd.45.2009.12.01.08.26.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Dec 2009 08:26:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B14EB2E.9020906@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134223>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Thomas Singer schrieb:
> > To be more precise: Who is interpreting the bytes in the file names as
> > characters? Windows, Git or Java?
> 
> In the case of git: Windows does it, using the console's codepage to
> convert between bytes and Unicode.
> 
> I don't know about Java, but I guess that no conversion is necessary
> because Java is Unicode-aware.

Actually, conversion is necessary, and its something that is proving
to be really painful within JGit.

The Java IO APIs use UTF-16 for file names.  However we are reading
a stream of unknown bytes from the index file and tree objects.
Thus JGit must convert a stream of bytes into UTF-16 just to get
to the OS.

The JVM then turns around and converts from UTF-16 to some other
encoding for the filesystem.

On Win32 I suspect the JVM uses the native UTF-16 file APIs, so
this translation is lossless.

On POSIX, I suspect the JVM uses $LANG or some other related
environment variable to guess the user's preferred encoding, and
then converts from UTF-16 to bytes in that encoding.  And I have
no idea how they handle normalization of composed code points.

All of these layers make for a *very* confusing situation for us
within JGit:

  git tree
  +---------+
  | bytes   | -+
  +---------+   \
                 \             +--------+            +---------+
                  +-- JGit --> | UTF-16 | -- JVM --> | OS call |
  .git/index     /             +--------+            +---------+
  +---------+   /
  | bytes   | -+
  +---------+

Its impossible for us to do what C git does, which is just use the
bytes used by the OS call within the git datastructure.  Which of
course also isn't always portable, e.g. the Mac OS X HFS+ mess.

:-)

-- 
Shawn.

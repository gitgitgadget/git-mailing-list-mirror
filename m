From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: non-US-ASCII file names (e.g. Hiragana) on Windows
Date: Tue, 1 Dec 2009 23:11:13 +0100
Message-ID: <200912012311.14321.robin.rosenberg@dewire.com>
References: <4B1168D4.5010902@syntevo.com> <4B14EB2E.9020906@viscovery.net> <20091201162627.GE21299@spearce.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Thomas Singer <thomas.singer@syntevo.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 23:11:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFawN-00068v-0B
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 23:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503AbZLAWLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 17:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753406AbZLAWLL
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 17:11:11 -0500
Received: from mail.dewire.com ([83.140.172.130]:25949 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753389AbZLAWLK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 17:11:10 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id EDDF28003A9;
	Tue,  1 Dec 2009 23:11:15 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PsCWpp0-kzx6; Tue,  1 Dec 2009 23:11:15 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 5360580034F;
	Tue,  1 Dec 2009 23:11:15 +0100 (CET)
User-Agent: KMail/1.11.4 (Linux/2.6.28-11-generic; KDE/4.2.4; i686; ; )
In-Reply-To: <20091201162627.GE21299@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134260>

tisdag 01 december 2009 17:26:27 skrev du:
> Johannes Sixt <j.sixt@viscovery.net> wrote:
> > Thomas Singer schrieb:
> > > To be more precise: Who is interpreting the bytes in the file names as
> > > characters? Windows, Git or Java?
> >
> > In the case of git: Windows does it, using the console's codepage to
> > convert between bytes and Unicode.
> >
> > I don't know about Java, but I guess that no conversion is necessary
> > because Java is Unicode-aware.
>
> Actually, conversion is necessary, and its something that is proving
> to be really painful within JGit.
>
> The Java IO APIs use UTF-16 for file names.  However we are reading
> a stream of unknown bytes from the index file and tree objects.
> Thus JGit must convert a stream of bytes into UTF-16 just to get
> to the OS.
>
> The JVM then turns around and converts from UTF-16 to some other
> encoding for the filesystem.
>
> On Win32 I suspect the JVM uses the native UTF-16 file APIs, so
> this translation is lossless.
>
> On POSIX, I suspect the JVM uses $LANG or some other related
> environment variable to guess the user's preferred encoding, and
> then converts from UTF-16 to bytes in that encoding.  And I have
> no idea how they handle normalization of composed code points.
>
> All of these layers make for a *very* confusing situation for us
> within JGit:
>
>   git tree
>   +---------+
>
>   | bytes   | -+
>
>   +---------+   \
>                  \             +--------+            +---------+
>                   +-- JGit --> | UTF-16 | -- JVM --> | OS call |
>   .git/index     /             +--------+            +---------+
>   +---------+   /
>
>   | bytes   | -+
>
>   +---------+
>
> Its impossible for us to do what C git does, which is just use the
> bytes used by the OS call within the git datastructure.  Which of
> course also isn't always portable, e.g. the Mac OS X HFS+ mess.

We can decode the index anyway we like but not file names coming from
the file system. On Windows, any sane name (it does allow invalid UTF-16 too, 
but...) will be readable by JGit, but on a UTF-8 posix that may not be so, if 
the filename is actually Latin.-1 encoded. In that case the Java runtime will 
return a decoded filename containing an "invalid" code point and any attempt to 
access the file from java will fail. I can see some horribly expensive ways to 
work around that but...

As for the more sane cases I have a compare routine that works on mixed 
encodings that may help to solve some of the problems. Ideally it would not
only be able to compare filenames with unknown encodings to handling case 
folding and composing characters in one go too. I guess one could make it
fall back to another encoding than Latin-1, but with lesser certainty, but
it will not (for sure) work with any arbitrary set of encodings. You'll have 
to choose, so it's only a legacy workaround, as opposed to a solution. 

-- robin

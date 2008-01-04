From: Sean <seanlkml@sympatico.ca>
Subject: Re: Trouble importing from public CVS repo
Date: Fri, 4 Jan 2008 18:17:59 -0500
Message-ID: <BAYC1-PASMTP15EA2E9A1145CD66AF7C4DAE4C0@CEZ.ICE>
References: <477EA7F6.1010608@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>
To: Jeff Garzik <jeff@garzik.org>
X-From: git-owner@vger.kernel.org Sat Jan 05 00:18:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAvoK-0002Us-GI
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 00:18:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434AbYADXSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 18:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753746AbYADXSE
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 18:18:04 -0500
Received: from bay0-omc2-s25.bay0.hotmail.com ([65.54.246.161]:50966 "EHLO
	bay0-omc2-s25.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753438AbYADXSD (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Jan 2008 18:18:03 -0500
Received: from BAYC1-PASMTP15 ([65.54.191.189]) by bay0-omc2-s25.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 4 Jan 2008 15:18:02 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP15.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Fri, 4 Jan 2008 15:18:01 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1JAvnU-0004gQ-HR; Fri, 04 Jan 2008 18:17:52 -0500
In-Reply-To: <477EA7F6.1010608@garzik.org>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.1; i686-pc-linux-gnu)
X-OriginalArrivalTime: 04 Jan 2008 23:18:01.0608 (UTC) FILETIME=[0D09A080:01C84F28]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69614>

On Fri, 04 Jan 2008 16:41:10 -0500
Jeff Garzik <jeff@garzik.org> wrote:

> $ git-cvsimport -v -d:pserver:anonymous@cvs.lysator.liu.se:/cvsroot/unfs3 unfs3
> 
> produces
> 
> Initialized empty Git repository in /spare/repo/unfs3/.git/
> Running cvsps...
> connect error: Network is unreachable
> cvs rlog: Logging unfs3
> cvs rlog: Logging unfs3/Config
> cvs rlog: Logging unfs3/Extras
> cvs rlog: Logging unfs3/contrib
> cvs rlog: Logging unfs3/contrib/nfsotpclient
> cvs rlog: Logging unfs3/contrib/nfsotpclient/mountclient
> cvs rlog: Logging unfs3/contrib/rpcproxy
> cvs rlog: Logging unfs3/doc
> Fetching LICENSE   v 1.1
> New LICENSE: 1416 bytes
> Fetching Makefile.in   v 1.1
> Unknown: error
> 

Hi Jeff,

See the same problem here and it has something to do with how files are being fetched
from the cvs server.  I'm not much inclined to research it further, however the ugly hack
below appears to allow the repo to be imported.  At least importing the first 10 commits
(-L 10) looked okay...  Perhaps it's a clue to how the issue could be resolved properly.

HTH,
Sean

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 6d8ff93..357665d 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -421,7 +421,7 @@ sub _line {
 			$res += $self->_fetchfile($fh, $cnt);
 		} else {
 			chomp $line;
-			if ($line eq "ok") {
+			if ($line eq "ok" or $line =~ /^error/i) {
 				# print STDERR "S: ok (".length($res).")\n";
 				return $res;
 			} elsif ($line =~ s/^E //) {
-- 
1.5.4.rc2.17.g257f

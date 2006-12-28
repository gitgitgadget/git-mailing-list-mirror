From: Steven Grimm <koreth@midwinter.com>
Subject: How to build manpages on OS X
Date: Thu, 28 Dec 2006 15:32:08 -0800
Message-ID: <459453F8.1010200@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 29 00:32:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H04jS-0007tu-Fc
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 00:32:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbWL1Xbz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 18:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbWL1Xbz
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 18:31:55 -0500
Received: from tater.midwinter.com ([216.32.86.90]:37036 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753849AbWL1Xbs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 18:31:48 -0500
Received: (qmail 20731 invoked from network); 28 Dec 2006 23:31:47 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=r5C1Nk05BMhNNg/UrOSoOf0HO4u/bfLJlOSiY7bkjMl7BVJtvQhZZha2jSaPJawu  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 28 Dec 2006 23:31:47 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35565>

Didn't see this documented anywhere, so...

If you want to do a full build of git on OS X including the manpages, 
you need the asciidoc and xmlto packages. Both of them are available 
from macports.org (formerly known as DarwinPorts) but out of the box, 
they don't work quite right. If you try doing a "make doc", you get the 
following error from xmlto:

I/O error : Attempt to load network entity 
http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl

The superficial reason for that error is that xmlto is calling the 
xsltproc utility with a command-line option that tells it to not fetch 
documents from the network. If you edit xmlto and remove that option, 
the doc build will work, but it will have to fetch a bunch of files from 
SourceForge for every manpage, which is dog slow.

The real solution is to use local copies of the files it's trying to 
fetch. These files are installed as part of one of the dependencies when 
you install xmlto, but the install process doesn't tell the system where 
to look for them! To use these local copies, you need to do two things.

First, create an XML catalog file. Typically it's called catalog.xml. 
The contents should be:

<?xml version='1.0'?>
<catalog xmlns="urn:oasis:names:tc:entity:xmlns:xml:catalog">
<rewriteURI 
uriStartString="http://docbook.sourceforge.net/release/xsl/current/"
        rewritePrefix="file:///opt/local/share/xsl/docbook-xsl/" />
<rewriteURI uriStartString="http://www.oasis-open.org/docbook/xml/4.2/"
        rewritePrefix="file:///opt/local/share/xml/docbook-xml/4.3/" />
</catalog>

Yes, that second rewriteURI maps the 4.2 docbook URI to the 4.3 version 
-- blame the MacPorts packages, because that's what gets installed. The 
mismatch doesn't appear to hurt anything. (If you're reading this from 
the mailing list archive, MacPorts might have updated the packages since 
I wrote this, so adjust the paths accordingly.)

Now you need to tell the system to use the file. You do that using the 
XML_CATALOG_FILES environment variable, like so:

$ export XML_CATALOG_FILES=`pwd`/catalog.xml
$ make prefix=/opt/local doc
$ sudo make prefix=/opt/local install-doc

Annoying that it doesn't just work, but hopefully this will save someone 
some Googling around.

-Steve

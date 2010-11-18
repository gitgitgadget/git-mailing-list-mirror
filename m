From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/2] svn-fe: recognize v3 dumps
Date: Wed, 17 Nov 2010 23:00:23 -0600
Message-ID: <20101118050023.GA14861@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 18 06:01:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIwcb-0002Ju-DM
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 06:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867Ab0KRFBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 00:01:10 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56397 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab0KRFBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 00:01:09 -0500
Received: by yxf34 with SMTP id 34so1630143yxf.19
        for <git@vger.kernel.org>; Wed, 17 Nov 2010 21:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=bOnLshKCqaCyxXYV13IVYM5VPfonNQB6oIfenJuyAHs=;
        b=OMfhNuBKpdPtUAhbVMAUUuQ2r1FV9mr8CrOcMFst1Xq/2aR+UtD+GdCKW39LntMswx
         hTJjkhwiXp4IZzD8VKMZLN6LVIVcmFIfcOd8HuieC57oyyS3GylJVuV8dBI3FQLh1WbO
         QT1wjx6TDYvAzUrLuBzPnRK8bEBQ9mUiE1Qog=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=td0aLrexhGPIhdmzJ4loLWZDSHJDo2I40G0ojZOO9UtdK/VZQprWkJ4i9mhn8NMu9e
         3tbUOrXlvqY49AcMwgBPBHJ595RdIJZUVFqsmTEdIpfK5ekUnNg+0QT1g1AtFJPHMwuE
         ZEScyfnGlx5CLFhuiS0mgpCI81i5qhT4c2i0Y=
Received: by 10.151.10.12 with SMTP id n12mr345946ybi.367.1290056468452;
        Wed, 17 Nov 2010 21:01:08 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id v9sm1289638ybe.9.2010.11.17.21.01.06
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 17 Nov 2010 21:01:07 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161647>

This mini-series is part of an effort to get David and Ram's svn
import work integrated into mainline git[1].  It fixes a longstanding
svn-fe bug that bit me a few times: when fed v3 (= --deltas) dumps,
current svn-fe produces nonsense --- a directory full of svn-format
deltas --- rather than erroring out.  For example:

	; git init
	; svnrdump dump -r1:10 http://cvs2svn.tigris.org/svn/cvs2svn |
		svn-fe |
		git fast-import
	; git show HEAD:trunk/README
	SVN^@^@^@M-^N^D^CM-^N^DM-^@M-^N^DThis is a program to convert a CVS repository to Subversion.

After this series, svn-fe would instead die with the message "fatal:
text and property deltas not supported".

Ram and David: this code will probably look familiar.  It is roughly
based on David's "vcs-svn: Extend svndump to parse version 3 format"
from about a month ago[2].  I would be particularly interested in
hearing whether this still seems sensible in design and execution,
so it can be deployed to a wider audience with your blessing if
appropriate.

Thoughts?  Improvements?

David Barr (1):
  vcs-svn: Allow simple v3 dumps (no deltas yet)

Jonathan Nieder (1):
  vcs-svn: Error out for v3 dumps

 t/t9010-svn-fe.sh |  403 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 vcs-svn/svndump.c |   28 ++++-
 2 files changed, 406 insertions(+), 25 deletions(-)

[1] http://thread.gmane.org/gmane.comp.version-control.git/160875

The dumpfile v3 code proper has been proving more trouble to review
than anticipated.  Mostly because it involves tracking down details of
the svn repository model that aren't clearly documented in any obvious
place:

 * What do the five node actions (replace, delete, add, modify,
   unknown) represent?  How can we deal with them without repeating
   the same code four times?

 * Which actions preserve properties?  Which preserve text?

[2] http://thread.gmane.org/gmane.comp.version-control.git/159117/focus=159114

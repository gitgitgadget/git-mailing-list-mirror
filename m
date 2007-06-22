From: Roman Kagan <rkagan@sw.ru>
Subject: parsecvs fails even on simple input
Date: Fri, 22 Jun 2007 15:36:25 +0400
Message-ID: <20070622113625.GD12473@rkagan.sw.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="kXdP64Ggrk/fb43R"
Cc: git@vger.kernel.org
To: Keith Packard <keithp@keithp.com>,
	Al Viro <viro@zeniv.linux.org.uk>
X-From: git-owner@vger.kernel.org Fri Jun 22 13:37:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1hSA-0006Vi-3P
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 13:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbXFVLhX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 07:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752367AbXFVLhW
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 07:37:22 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:14779 "EHLO relay.sw.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752592AbXFVLhV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 07:37:21 -0400
Received: from rkagan.sw.ru ([192.168.3.19])
	by relay.sw.ru (8.13.4/8.13.4) with ESMTP id l5MBaPM8014048
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 22 Jun 2007 15:36:35 +0400 (MSD)
Mail-Followup-To: Roman Kagan <rkagan@sw.ru>,
	Keith Packard <keithp@keithp.com>,
	Al Viro <viro@zeniv.linux.org.uk>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50690>


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

One of the patches recently merged into parsecvs master, namely

commit f5b3cb849517adfd7790c1bfa84bbb84220e3e7b
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Tue Jan 16 04:15:35 2007 -0500

    [PATCH] generate tree objects just as we calculate changesets
    
    ... and don't store the fsckloads of rev_file in ExportGit mode; they
    are only needed (for now) in ExportGraph one.
    
    Tree generation is done directly, without hitting on-disk index.  Very fast
    now.

broke parsecvs entirely.  The reproducer (attached) is very simple:
initial commit of a just added file.  parsecvs now barfs on it:

# parsecvs a,v
Initialized empty shared Git repository in .git/
Load:                                 a,v ....................*     1 of     1
Pack pack-6b955e2d966143fc957ccd272e9dd822ceaccf25 created
Removing unused objects 81%...
Removing unused objects 100%...
Done.

error: invalid object d0141680ee5324d51a558a0a48c8a867cbc6a47c
error: writing tree
Authors: No such file or directory
Save:                              master ....................*     1 of     1


The problem is the following: after that commit parsecvs tries to add
objects to the git tree on its own via calls to libgit; however, in
between it runs git-pack-objects.  Thus objects move to pack files
without libgit being aware of it; this results in 'ivalid object'
errors.

However, the object with that hash exists but is stored on the pack
file; if parsecvs is run in the same directory for the second time it
finds it there and happily completes.

I haven't yet had the time to dig deeper into this problem and code a
patch; however, the whole idea of doing part of the job through the
(unpublished) libgit API and the rest via callouts to git utilities
looks like calling for trouble.  Wouldn't it be better to teach parsecvs
to speak git-fast-import language instead?

Roman.

--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="a,v"

head	1.1;
access;
symbols;
locks; strict;
comment	@# @;


1.1
date	2007.06.21.12.11.32;	author tstuser;	state Exp;
branches;
next	;


desc
@@


1.1
log
@test commit
@
text
@this is test
@

--kXdP64Ggrk/fb43R--

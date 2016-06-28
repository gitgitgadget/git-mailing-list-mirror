Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_NUMERIC_HELO,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890FF2018A
	for <e@80x24.org>; Tue, 28 Jun 2016 16:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbcF1QPJ (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 12:15:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:45702 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbcF1QPI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 12:15:08 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bHvfD-0004XY-Dj
	for git@vger.kernel.org; Tue, 28 Jun 2016 18:15:03 +0200
Received: from 147.114.44.200 ([147.114.44.200])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 18:15:03 +0200
Received: from ioannis.kappas by 147.114.44.200 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 18:15:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Ioannis Kappas <ioannis.kappas@rbs.com>
Subject: Re: git svn clone segmentation faul issue
Date:	Tue, 28 Jun 2016 16:13:37 +0000 (UTC)
Message-ID: <loom.20160628T175016-898@post.gmane.org>
References: <0BCA1E695085C645B9CD4A27DD59F6FA39AAD5CF@GBWGCEUHUBD0101.rbsres07.net> <alpine.DEB.2.20.1606281334450.12947@virtualbox> <alpine.DEB.2.20.1606281530420.12947@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 147.114.44.200 (Mozilla/5.0 (Windows NT 6.1; Win64; x64; Trident/7.0; rv:11.0) like Gecko)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Johanes,

Johannes Schindelin <Johannes.Schindelin <at> gmx.de> writes:

> 
> Hi Ioannis,
> 
> On Tue, 28 Jun 2016, Johannes Schindelin wrote:
> 
> > On Tue, 28 Jun 2016, Ioannis.Kappas <at> rbs.com wrote:
> > 
> > > Git can fail with a "malformed index nnn" error or cause a 
segmentation
> > > fault when executing the "git svn clone" command. 
> > >
> > > [...]
> > >
> > > Fortunately, a patch has already been submitted to subversion with
> > > (github) revision a074af86c8764404b28ce99d0bedcb668a321408 (at
> > > https://github.com/apache/subversion/commit/a074af86c8) on the trunk 
to
> > > handle this and a couple of other similar cases. But by the looks of 
it
> > > has not been picked up yet in the latest subversion 1.9.4 release or 
the
> > > 1.9.x branch, perhaps because this patch was identified in sanity 
checks
> > > rather than coming out from a perceivable production issue?
> > 
> > This is an excellent analysis and a silver lining on the horizon to
> > resolve those vexing git svn issues we keep having in Git for Windows.
> > 
> > Do you have a test case that is reliably reproducing the issue?
> 
> I hope you do! 

Yes, my codebase always fails on git svn clone with something like:

fatal: malformed index info 100644 a6d6543f625fb4a7200e
error: git-svn died of signal 11


> I patched the MSYS2 build script to apply a074af86c8 before
> compiling, and uploaded the resulting packages for i686 and x86_64
> architectures to
> 
> 	https://github.com/dscho/MSYS2-
packages/releases/tag/subversion-1.9.4-2
> 
> Would you mind giving them a whirl?

The patch in "source code (zip)" seems to be missing the line in the prepare
() section of PKGBUILD to actually apply the fix:

diff --git a/subversion/PKGBUILD b/subversion/PKGBUILD
--- a/subversion/PKGBUILD
+++ b/subversion/PKGBUILD

@@ -101,6 +103,7 @@ prepare() {
   patch -p1 -i ${srcdir}/17-fix-test-link.patch
   patch -p1 -i ${srcdir}/18-fix-serf-config.patch
   patch -p1 -i ${srcdir}/19-remove-contrib-from-configure.patch
+  patch -p1 -i ${srcdir}/20-fix-stack-corruption-in-swig-wrappers.patch
   patch -p1 -i ${srcdir}/subversion-1.9.1-msys2.patch
   patch -p1 -i ${srcdir}/remove-checking-symlink.patch
   patch -p1 -i ${srcdir}/90-use-copy-instead-symlink.patch


Would you be so kind to add the above and rebuild. 

I have just tested it locally to work successfully, but I do not mind 
retesting if you wish to provide another build :)

Thanks,
Yannis

> 
> Thanks,
> Johannes
> 





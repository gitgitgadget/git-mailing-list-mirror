From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Tue, 22 May 2007 13:38:03 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705221329420.3366@xanadu.home>
References: <46528A48.9050903@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 19:38:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqYJe-0001w0-N9
	for gcvg-git@gmane.org; Tue, 22 May 2007 19:38:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757965AbXEVRi2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 13:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758139AbXEVRi2
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 13:38:28 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38240 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757965AbXEVRi1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 13:38:27 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JIG00E1BEBFBLG0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 22 May 2007 13:38:04 -0400 (EDT)
In-reply-to: <46528A48.9050903@gmail.com>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48111>

On Mon, 21 May 2007, Dana How wrote:

> 
> Using fast-import and repack with the max-pack-size patch,
> 3628 commits were imported from Perforce comprising
> 100.35GB (uncompressed) in 38829 blobs,  and saved in
> 7 packfiles of 12.5GB total (--window=0 and --depth=0 were
> used due to runtime limits).  When using these packfiles,
> several git commands showed very large process sizes,
> and some slowdowns (compared to comparable operations
> on the linux kernel repo) were also apparent.
> 
> git stores data in loose blobs or in packfiles.  The former
> has essentially now become an exception mechanism,  to store
> exceptionally *young* blobs.  Why not use this to store
> exceptionally *large* blobs as well?  This allows us to
> re-use all the "exception" machinery with only a small change.
> 
> Repacking the entire repository with a max-blob-size of 256KB
> resulted in a single 13.1MB packfile,  as well as 2853 loose
> objects totaling 15.4GB compressed and 100.08GB uncompressed,
> 11 files per objects/xx directory on average.  All was created
> in half the runtime of the previous yet with standard
> --window=10 and --depth=50 parameters.  The data in the
> packfile was 270MB uncompressed in 35976 blobs.  Operations
> such as "git-log --pretty=oneline" were about 30X faster
> on a cold cache and 2 to 3X faster otherwise.  Process sizes
> remained reasonable.
> 
> This patch implements the following:
> 1. git pack-objects takes a new --max-blob-size=N flag,
>    with the effect that only blobs less than N KB are written
>    to the packfiles(s).  If a blob was in a pack but violates
>    this limit (perhaps the packs were created by fast-import
>    or max-blob-size was reduced),  then a new loose object
>    is written out if needed so the data is not lost.
> 2. git repack inspects repack.maxblobsize .  If set,  its
>    value is passed to git pack-objects on the command line.
>    The user should change repack.maxblobsize ,  NOT specify
>    --max-blob-size=N .
> 3. No other caller of git pack-objects supplies this new flag,
>    so other callers see no change.
> 
> This patch is on top of the earlier max-pack-size patch,
> because I thought I needed some behavior it supplied,
> but could be rebased on master if desired.

I think what this patch is missing is a test after all options have been 
parsed to prevent --stdout and --max-blob-size to be used together.


Nicolas

From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: two questions about the format of loose object
Date: Mon, 1 Dec 2008 07:32:11 -0800
Message-ID: <20081201153211.GH23984@spearce.org>
References: <493399B7.5000505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Liu Yubao <yubao.liu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 16:33:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7Am8-0003tJ-K7
	for gcvg-git-2@gmane.org; Mon, 01 Dec 2008 16:33:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751609AbYLAPcM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Dec 2008 10:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbYLAPcM
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Dec 2008 10:32:12 -0500
Received: from george.spearce.org ([209.20.77.23]:40970 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbYLAPcL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Dec 2008 10:32:11 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2F9EC38200; Mon,  1 Dec 2008 15:32:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <493399B7.5000505@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102051>

Liu Yubao <yubao.liu@gmail.com> wrote:
> 
> In current implementation the loose objects are compressed:
> 
>      loose object = deflate(typename + <space> + size + '\0' + data)
...
> * Question 1:
> 
> Why not use the format below for loose object?
>     loose object = typename + <space> + size + '\0' + deflate(data)

Historical accident.  We really should have used a format more
like what you are asking here, because it makes inflation easier.
The pack file format uses a header structure sort of like this,
for exactly that reason.  IOW we did learn our mistakes and fix them.

If you look up the new style loose object code you'll see that it
has a format like this (sort of), the header is actually the same
format that is used in the pack files, making it smaller than what
you propose but also easier to unpack as the code can be reused
with the pack reading code.

Unfortunately the new style loose object was phased out; it never
really took off and it made the code much more complex.  So it was
pulled in commit 726f852b0ed7e03e88c419a9996c3815911c9db1:

 Author: Nicolas Pitre <nico@cam.org>:
 >  deprecate the new loose object header format
 >
 >  Now that we encourage and actively preserve objects in a packed form
 >  more agressively than we did at the time the new loose object format and
 >  core.legacyheaders were introduced, that extra loose object format
 >  doesn't appear to be worth it anymore.
 >
 >  Because the packing of loose objects has to go through the delta match
 >  loop anyway, and since most of them should end up being deltified in
 >  most cases, there is really little advantage to have this parallel loose
 >  object format as the CPU savings it might provide is rather lost in the
 >  noise in the end.
 >
 >  This patch gets rid of core.legacyheaders, preserve the legacy format as
 >  the only writable loose object format and deprecate the other one to
 >  keep things simpler.

-- 
Shawn.

From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Make zlib compression level configurable, and change
 default.
Date: Mon, 3 Jul 2006 12:33:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0607031226370.12404@g5.osdl.org>
References: <loom.20060703T124601-969@post.gmane.org>
 <81b0412b0607030503p63b4ee31v7776bd155d3dab29@mail.gmail.com>
 <44A91C7A.6090902@fys.uio.no> <Pine.LNX.4.64.0607031030150.1213@localhost.localdomain>
 <Pine.LNX.4.64.0607030929490.12404@g5.osdl.org> <85d5cm8qfn.fsf_-_@lupus.ig3.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 03 21:38:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxUFZ-0004AL-71
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 21:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWGCTi0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 15:38:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbWGCTiZ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 15:38:25 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23948 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751250AbWGCTiZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 15:38:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k63JX4nW022021
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 3 Jul 2006 12:33:04 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k63JX3m6030104;
	Mon, 3 Jul 2006 12:33:03 -0700
To: Joachim B Haga <cjhaga@fys.uio.no>
In-Reply-To: <85d5cm8qfn.fsf_-_@lupus.ig3.net>
X-Spam-Status: No, hits=-3 required=5 tests=PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23193>



On Mon, 3 Jul 2006, Joachim B Haga wrote:
> 
> The configurability is through setting core.compression = [-1..9]
> which maps to the zlib constants; -1 is the default, 0 is no
> compression, and 1..9 are various speed/size tradeoffs, 9
> being slowest.

My only worry is that this encodes "Z_DEFAULT_COMPRESSION" as being -1, 
which happens to be /true/, but I don't think that's a documented 
interface (you're supposed to use the Z_DEFAULT_COMPRESSION macro, which 
could have any value, and just _happens_ to be -1).

Is it likely to ever change from that -1? Probably not. So I think your 
patch is technically correct, but it might just be nicer if it did 
something like

	..
	if (!strcmp(var, "core.compression")) {
		int level = git_config_int(var, value);
		if (level == -1)
			level = Z_DEFAULT_COMPRESSION;
		else if (level < 0 || level > Z_BEST_COMPRESSION)
			die("bad zlib compression level %d", level);
		zlib_compression_level = level;
		return 0;
	}
	..

which would be safer, and a smart compiler might notice that the -1 case 
ends up being a no-op, and then just generate code AS IF we just had a

	if (level < -1 || level > Z_BEST_COMPRESSION)
		die(...

there.

Oh, and for all the same reasons, we should use

	int zlib_compression_level = Z_BEST_COMPRESSION;

for the default initializer.

Hmm?

		Linus

From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use configurable zlib compression level everywhere.
Date: Mon, 03 Jul 2006 12:43:10 -0700
Message-ID: <7v4pxyscdt.fsf@assigned-by-dhcp.cox.net>
References: <loom.20060703T124601-969@post.gmane.org>
	<81b0412b0607030503p63b4ee31v7776bd155d3dab29@mail.gmail.com>
	<44A91C7A.6090902@fys.uio.no>
	<Pine.LNX.4.64.0607031030150.1213@localhost.localdomain>
	<Pine.LNX.4.64.0607030929490.12404@g5.osdl.org>
	<8564ie8qbe.fsf_-_@lupus.ig3.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 21:43:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxUKP-0004uB-MC
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 21:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751259AbWGCTnO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 15:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWGCTnN
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 15:43:13 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:2761 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751259AbWGCTnM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 15:43:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703194311.EITQ19057.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Jul 2006 15:43:11 -0400
To: Joachim B Haga <cjhaga@fys.uio.no>
In-Reply-To: <8564ie8qbe.fsf_-_@lupus.ig3.net> (Joachim B. Haga's message of
	"03 Jul 2006 21:02:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23194>

Joachim B Haga <cjhaga@fys.uio.no> writes:

> This one I'm not so sure about, it's for completeness. But I don't actually use
> git and haven't tested beyond the git add / git commit stage. Still...
>
> Signed-off-by: Joachim B Haga (cjhaga@fys.uio.no)

You made a good judgement to notice that these three are
different.

 * sha1write_compressed() in csum-file.c is for producing packs
   and most of the things we compress there are deltas and less
   compressible, so even when core.compression is set to high we
   might be better off using faster compression.

 * diff's deflate_it() is about producing binary diffs (later
   encoded in base85) for textual transfer.  Again it is almost
   always used to compress deltas so the same comment as above
   apply to this.

 * http-push uses it to send compressed whole object, and this
   is only used over the network, so it is plausible that the
   user would want to use different compression level than the
   usual core.compression.

It is fine by me to use the same core.compression to these
three.  If somebody comes up with a workload that benefits from
having different settings for them, we can add separate
variables, falling back on the default core.compression if there
isn't one, as needed.

Thanks for the patches.

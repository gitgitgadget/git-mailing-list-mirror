From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: squelch progress indicator if client does not request sideband
Date: Mon, 15 Jun 2009 14:53:36 -0700
Message-ID: <7vski1i2ov.fsf@alter.siamese.dyndns.org>
References: <200906142238.51725.j6t@kdbg.org>
	<20090615145716.GW16497@spearce.org> <200906152324.43435.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jun 15 23:53:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGK7Z-0002wI-L8
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 23:53:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762779AbZFOVxg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2009 17:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754850AbZFOVxg
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 17:53:36 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43973 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754645AbZFOVxe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2009 17:53:34 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090615215336.DGOX25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Mon, 15 Jun 2009 17:53:36 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4Mtc1c00N4aMwMQ04Mtcv8; Mon, 15 Jun 2009 17:53:37 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=GCefh4Sw5xkA:10 a=X0kwczFtQecA:10
 a=A9qS8gIqAAAA:8 a=f0JYj0Ioyq9Z7WCIb7oA:9 a=zTkaLrVV8lHXgCzg5vsPr4D098wA:4
 a=Kj4G0JfAssAA:10
X-CM-Score: 0.00
In-Reply-To: <200906152324.43435.j6t@kdbg.org> (Johannes Sixt's message of "Mon\, 15 Jun 2009 23\:24\:43 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121634>

Johannes Sixt <j6t@kdbg.org> writes:

> Since the previous patch git-daemon monitors stderr of the service program,
> such as upload-pack, and copies it to the syslog. This would now also copy
> the progress indicator to the syslog. We avoid this by calling pack-objects
> without --progress if there is no sideband channel to the client.
> ...
> +
> +	/*
> +	 * If upload-pack is run from the daemon and the client did not
> +	 * request a sideband, the progress output produced by pack-objects
> +	 * would go to the syslog. Squelch it.
> +	 */
> +	if (!use_sideband)
> +		no_progress = 1;
> +

I think it is a very good idea to squelch progress output that will never
go to the client (it will be wasted traffic, regardless of the "syslog"
thing), but

 (1) Is "not using sideband" the same as "client won't see the progress
     output" for all vintages of clients that work with the current
     server?

     How did we drive upload-pack over native or ssh connection before we
     introduced sideband?  I vaguely recall that we relied on stderr going
     to the invoking terminal in the local case.  With this change, does
     the user suddenly stop seeing progress if the client is older than
     583b7ea (upload-pack/fetch-pack: support side-band communication,
     2006-06-21)?  If so, that would be a regression.

 (2) The change in _this_ patch may be a good thing independent from the
     change to the daemon, and I would hate to see it justified in terms
     of that other change.  This comment applies to the proposed commit
     log message as well.

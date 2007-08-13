From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH 1/2] attr: fix attribute handling if .gitattributes is involved
Date: Sun, 12 Aug 2007 20:51:15 -0500
Message-ID: <20070813015115.GI21692@lavos.net>
References: <11869508753328-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, dmitry.kakurin@gmail.com, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 13 03:51:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKP5e-0004cc-BS
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 03:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763949AbXHMBv1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 21:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765484AbXHMBv0
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 21:51:26 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:15930 "EHLO
	asav02.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763700AbXHMBv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 21:51:26 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AglXAKdVv0ZKhvbzRmdsb2JhbACBVIUlhxEBAQE1AQ
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav02.insightbb.com with ESMTP; 12 Aug 2007 21:51:25 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 8D0A4309F31; Sun, 12 Aug 2007 20:51:15 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <11869508753328-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55740>

On Sun, Aug 12, 2007 at 10:34:34PM +0200, Steffen Prohaska wrote:
> This together with the patch that follows fixes a problem, which
> is most likely to bite Windows users. I recognized it by setting
> autocrlf globally to true and doing a fresh checkout of msysgit.
> The checkout contained etc/termcap converted to CRLF, although
> is was marked as '-crlf' in etc/.gitattributes.
> 
> If we believe autocrlf is a reasonable default for Windows users,
> we really should use it ourselves, to find such problems. 
> 
> The fixed problem is not really critical but may be quite annoying,
> and complex to understand.

I have a case in a live repository where this is not merely annoying.

I have a test data in one of my repositories that must never be
converted.  It has a mix of Unix and Windows line-endings in it.  I
marked the appropriate files with the "-crlf" attribute.

With the current git behavior, cloning this repository with "autocrlf"
globally set irreversably corrupts the files (converting the LF
line-enders to CRLF) on checkout.  If the user is careless upon commit,
these corrupted files will then be committed back (probably with all
CRLFs, since at that point the .gitattributes is present and the -crlf
attribute will be honored.)

There is kind of an ugly chicken-and-egg problem here, but I think it
would be good to figure it out to avoid this kind of broken behavior.

I would also vote for this handling to be in the plumbing, since the
autocrlf processing is in the plumbing as well.

Another thing to consider with respect to attribute access -- It would
be nice for git-cvsserver to be able to send the correct -k option to
the remote side for line endings.  Doing this correctly involves
accessing attributes, but git-cvsserver never has a full working
directory.  Having the attribute machinery work without a working
directory (either directly from trees or from an index) would be a great
benefit here.

-bcd

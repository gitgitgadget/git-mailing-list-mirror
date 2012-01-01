From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCH resend] Do not create commits whose message contains NUL
Date: Sun, 01 Jan 2012 11:27:31 -0500
Message-ID: <1325435251.4752.104.camel@drew-northup.unet.maine.edu>
References: <1323777368-19697-1-git-send-email-pclouds@gmail.com>
	 <20111213175932.GA1663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 01 17:30:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RhOIL-0007wA-0J
	for gcvg-git-2@lo.gmane.org; Sun, 01 Jan 2012 17:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab2AAQ34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jan 2012 11:29:56 -0500
Received: from basalt.its.maine.edu ([130.111.32.66]:57101 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab2AAQ3z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jan 2012 11:29:55 -0500
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id q01GRXSH019941
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 1 Jan 2012 11:27:38 -0500
In-Reply-To: <20111213175932.GA1663@sigill.intra.peff.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: basalt.its.maine.edu 1003; Body=3
	Fuz1=3 Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: q01GRXSH019941
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1326040155.57478@7K26WEbedGVH0gjFERYFxg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187826>

On Tue, 2011-12-13 at 12:59 -0500, Jeff King wrote:
> It looks like we already have a check for is_utf8, and this is not
> failing that check. I guess because is_utf8 takes a NUL-terminated
> buffer, so it simply sees the truncated result (i.e., depending on
> endianness, "foo" in utf16 is something like "f\0o\0o\0", so we check
> only "f"). We could make is_utf8 take a length parameter to be more
> accurate, and then it would catch this.
> 
> However, I think that's not quite what we want. We only check is_utf8 if
> the encoding field is not set. And really, we want to reject NULs no
> matter _which_ encoding they've set, because git simply doesn't handle
> them properly.

I had already started experimenting with automatically detecting decent
UTF-16 a long while back so that compatible platforms could handle it
appropriately in terms of creating diffs and dealing with newline
munging between platforms. There is no 100% sure-fire check for UTF-16
if you don't already suspect it is possibly UTF-16. If we really want to
check for possible UTF-16 specifically I can scrape out the check I
wrote up and send it along.
The is_utf8 check was not written to detect 100% valid UTF-8 per-se. It
seems to me that it was written as part of the "is this a binary or not"
check in the add/commit path. I have thought for some time that
specifying buffer length in that whole code path would be a good idea
(but I thought that somebody else had taken up that battle while I was
busy dealing with other problems elsewhere), if for no other reason it
would force it to deal with NULs more intelligently.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59

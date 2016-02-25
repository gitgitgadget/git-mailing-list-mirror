From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] t5313: test bounds-checks of corrupted/malicious
 pack/idx files
Date: Thu, 25 Feb 2016 17:07:24 -0500
Message-ID: <20160225220724.GB10267@sigill.intra.peff.net>
References: <20160225142004.GA17678@sigill.intra.peff.net>
 <20160225142112.GA17811@sigill.intra.peff.net>
 <56CF523A.8050208@kdbg.org>
 <xmqq4mcwo7lb.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Jacek Wielemborek <d33tah@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 23:07:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ44J-0002Y3-1u
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 23:07:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbcBYWH2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 17:07:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:49431 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751123AbcBYWH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 17:07:27 -0500
Received: (qmail 27236 invoked by uid 102); 25 Feb 2016 22:07:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 17:07:26 -0500
Received: (qmail 25634 invoked by uid 107); 25 Feb 2016 22:07:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 25 Feb 2016 17:07:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 25 Feb 2016 17:07:24 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4mcwo7lb.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287445>

On Thu, Feb 25, 2016 at 12:31:12PM -0800, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > Am 25.02.2016 um 15:21 schrieb Jeff King:
> >> +munge () {
> >> +	printf "$3" | dd of="$1" bs=1 conv=notrunc seek=$2
> >> +}
> >
> > Instead of adding another call of dd, would it be an option to insert
> > the following patch at the front of this series and then use
> > test_overwrite_bytes?
> 
> It would be an option, but I'd want to merge this to 'next' today
> without waiting for a reroll.  Change from dd to custom script can
> be done as a follow-up topic after the dust settles, if necessary.

That's fine with me, and in general I am fine with the conversion from
dd to perl. I have to look up the dd command line options each time
anyway (was it "skip" or "seek"...?). ;)

But note that the use of "dd" in the "bogus offset inside extended
table" test in my patch is different from the others. It copies a set
amount of bytes, and inserts some custom data, and then copies more.

I think you could replace the first with "head -c", and the latter with
"tail -c". In the latter you'd have to compute the distance from the end
rather than the seek offset, but we know that already: it's 20 + 20 for
the trailing sha1s. Like this, I think:

diff --git a/t/t5313-pack-bounds-checks.sh b/t/t5313-pack-bounds-checks.sh
index a8a587a..20bc0a3 100755
--- a/t/t5313-pack-bounds-checks.sh
+++ b/t/t5313-pack-bounds-checks.sh
@@ -144,10 +144,10 @@ test_expect_success 'bogus offset inside v2 extended table' '
 	# We have to make extra room for the table, so we cannot
 	# just munge in place as usual.
 	{
-		dd if=$idx bs=1 count=$(($(ofs_table 2) + 4)) &&
+		head -c $(($(ofs_table 2) + 4)) $idx &&
 		printf "\200\0\0\0" &&
 		printf "\377\0\0\0\0\0\0\0" &&
-		dd if=$idx bs=1 skip=$(extended_table 2)
+		tail -c 40 $idx
 	} >tmp &&
 	mv tmp "$idx" &&
 	clear_base &&

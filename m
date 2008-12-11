From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [JGIT PATCH 4/6] Add QuotedString class to handle C-style quoting rules
Date: Thu, 11 Dec 2008 01:33:51 +0100
Message-ID: <200812110133.51614.robin.rosenberg@dewire.com>
References: <1228946751-12708-1-git-send-email-spearce@spearce.org> <200812110022.03719.robin.rosenberg@dewire.com> <20081210234130.GB32487@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:35:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAZWQ-0004H5-9r
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 01:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbYLKAdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 19:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753660AbYLKAdz
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 19:33:55 -0500
Received: from mail.dewire.com ([83.140.172.130]:8111 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753639AbYLKAdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 19:33:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 27D98147CECD;
	Thu, 11 Dec 2008 01:33:53 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iw6ls65tbch9; Thu, 11 Dec 2008 01:33:52 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 8014B8006B9;
	Thu, 11 Dec 2008 01:33:52 +0100 (CET)
User-Agent: KMail/1.10.3 (Linux/2.6.27-10-generic; KDE/4.1.3; i686; ; )
In-Reply-To: <20081210234130.GB32487@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102753>

torsdag 11 december 2008 00:41:30 skrev Shawn O. Pearce:
> > > +	public void testQuote_OctalAll() {
> > > +		assertQuote("\1", "\\001");
> > > +		assertQuote("~", "\\176");
> > > +		assertQuote("\u00ff", "\\303\\277"); // \u00ff in UTF-8
> > > +	}
> >
> > What do we do with non-UTF8 names? I think we should
> > follow the logic we use when parsing commits and paths
> > in other places.
> 
> Then we're totally f'd.
> 
> Git has no specific encoding on file names.  If we get a standard
> Java Unicode string and get asked to quote it characters with
> code points above 127 need to be escaped as an octal escape code
> according to the Git style.  Further the Git style only permits
> octal escapes that result in a value <= 255, aka an unsigned char.
> 
> The name needs to be encoded into an 8-bit encoding, and UTF-8 is
> the only encoding that will represent every valid Unicode character.
> Elsewhere we sort of take the attitude that when writing data *out*
> we produce UTF-8, even if we read in ISO-whatever.  Here I'm doing
> the same thing.

So this should pass, right?

	public void testDeQuote_Latin1() {
		assertDequote("\u00c5ngstr\u00f6m", "\\305ngstr\\366m"); // Latin1
	}

	public void testDeQuote_UTF8() {
		assertDequote("\u00c5ngstr\u00f6m", "\\303\\205ngstr\\303\\266m");
	}

And possibly these actuall unquoted names, which can be produced when
core.quotepath is false

	public void testDeQuote_Rawlatin() {
		assertDequote("\u00c5ngstr\u00f6m", "\305ngstr\366m");
	}

	public void testDeQuote_RawUTF8() {
		assertDequote("\u00c5ngstr\u00f6m", "\303\205ngstr\303\266m");
	}

You also reversed the arguments to testQuote. It think we should follow the
"expected"-first conventions here too. The case above works neither way.
Using Constant.encode in the test is kind of dangerous as it does too
many conversions, so you don't know what you're testing anymore. Changing
assertDequote like this makes us able to feed byte sequences as strings
to the test method (which we cannot do if we assume UTF-8 encoding). ISO-
latin-encoding allows any byte sequence to be entered conveniently.

	private static void assertDequote(final String exp, final String in) {
		final byte[] b;
		try {
			b = ('"' + in + '"').getBytes("ISO-8859-1");
		} catch (UnsupportedEncodingException e) {
			throw new RuntimeException(e);
		}
		final String r = C.dequote(b, 0, b.length);
		assertEquals(exp, r);
	}

-- robin

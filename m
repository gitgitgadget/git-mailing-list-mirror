From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-email: rfc2047-quote subject lines with
	non-ascii characters
Date: Sat, 29 Mar 2008 17:45:16 -0400
Message-ID: <20080329214516.GB30851@coredump.intra.peff.net>
References: <20080328212700.GA9529@coredump.intra.peff.net> <200803291039.43355.robin.rosenberg.lists@dewire.com> <20080329094322.GA21814@coredump.intra.peff.net> <200803291354.47269.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Sat Mar 29 22:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JfisD-0008TF-Pi
	for gcvg-git-2@gmane.org; Sat, 29 Mar 2008 22:46:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbYC2VpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Mar 2008 17:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbYC2VpU
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Mar 2008 17:45:20 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3981 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752274AbYC2VpT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Mar 2008 17:45:19 -0400
Received: (qmail 7518 invoked by uid 111); 29 Mar 2008 21:45:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 29 Mar 2008 17:45:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Mar 2008 17:45:16 -0400
Content-Disposition: inline
In-Reply-To: <200803291354.47269.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78485>

On Sat, Mar 29, 2008 at 01:54:47PM +0100, Robin Rosenberg wrote:

> > There were several given in the "OS X normalize your UTF-8 filenames"
> > thread a while back. They generally boil down to "a<UMLAUT MODIFIER>"
> > versus "<A WITH UMLAUT>" both of which are valid UTF-8.
> 
> That is what /OS X/ does with file names. It changes one unicode code point
> to a sequence of other "equivalent" code points. I'm pretty sure perl does
> not do that.

My point is that we don't _know_ what is happening in between the decode
and encode. Does that intermediate form have the information required to
convert back to the exact same bytes as the original form? I don't think
you've provided any evidence that it does or does not.

But here is some evidence that it does work:

$ cat test.pl
sub is_valid {
  my $orig = shift;
  my $test = $orig;
  utf8::decode($test);
  utf8::encode($test);
  return $orig eq $test ? "yes" : "no";
}
print "utf-8: ", is_valid("\xc3\xb6"), "\n";
print "latin-1: ", is_valid("\xc3"), "\n";
print "utf-8 w/ combining: ", is_valid("o\xcc\x88"), "\n";

$ perl test.pl
utf-8: yes
latin-1: no
utf-8 w/ combining: yes

But it still feels a little wrong to test by converting. There must be
some way to ask "is this valid utf-8" (there are several candidate
functions, but I don't think either of us quite knows the right way to
invoke them).

-Peff

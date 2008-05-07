From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 4/5] Make boundary characters for --color-words
	configurable
Date: Wed, 7 May 2008 15:45:24 -0400
Message-ID: <20080507194524.GA31500@sigill.intra.peff.net>
References: <46dff0320805040935n22354e1bta85b3f3fe7c16cad@mail.gmail.com> <7v63ttq0y8.fsf@gitster.siamese.dyndns.org> <46dff0320805041840g1b9362d3u138b9d40cde160f2@mail.gmail.com> <7vprs1ny5e.fsf@gitster.siamese.dyndns.org> <46dff0320805050510t3bc5fd0eq44e0d58d1bb57629@mail.gmail.com> <46dff0320805051740o65eee07eqc7073e4fa7996277@mail.gmail.com> <alpine.DEB.1.00.0805060954470.30431@racer> <46dff0320805061815k6aca9020g285b09da2bcf29c3@mail.gmail.com> <alpine.DEB.1.00.0805071223450.30431@racer> <7viqxqc4gs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ping Yin <pkufranky@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 21:46:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtpak-0005zx-L1
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 21:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763490AbYEGTp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 15:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762618AbYEGTpZ
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 15:45:25 -0400
Received: from peff.net ([208.65.91.99]:1495 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761316AbYEGTpW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 15:45:22 -0400
Received: (qmail 19131 invoked by uid 111); 7 May 2008 19:45:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 07 May 2008 15:45:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 May 2008 15:45:24 -0400
Content-Disposition: inline
In-Reply-To: <7viqxqc4gs.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81476>

On Wed, May 07, 2008 at 12:13:39PM -0700, Junio C Hamano wrote:

>  /* this executes the word diff on the accumulated buffers */
> @@ -441,27 +473,18 @@ static void diff_words_show(struct diff_words_data *diff_words)
>  	xdemitconf_t xecfg;
>  	xdemitcb_t ecb;
>  	mmfile_t minus, plus;
> -	int i;
> +	unsigned long sz;

strbuf uses size_t; since we pass sz in as a pointer to strbuf_detach,
there can be a pointer type mismatch.

But more big-picture, comparing the output of the old color words and
this implementation, there is one thing I don't like: the new one
doesn't bring together runs of additions and deletions, which can make
parsing text much easier. For example:

  $ echo This is a complete sentence. >one
  $ echo Here is some totally different text. >two

  # with old implementation; /-.../ is red, /+.../ is green
  $ git diff --color-words one two
  ...
  /-This/ /+Here/ is /-a complete sentence./+some totally different text./

  # with this patch
  $ git diff --color-words one two
  ...
  /-This/+Here/ is /-a/+some/ /-complete/+totally/ /-sentence./+different text./

-Peff

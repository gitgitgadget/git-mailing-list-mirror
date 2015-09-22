From: Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH] Makefile: Change library order for static linking
Date: Tue, 22 Sep 2015 22:37:59 +0200
Message-ID: <20150922203759.GB9793@cruxbox>
References: <1442524332-10180-1-git-send-email-repk@triplefau.lt>
 <xmqqfv2cj03t.fsf@gitster.mtv.corp.google.com>
 <20150917212016.GF606@cruxbox>
 <xmqq7fnoitra.fsf@gitster.mtv.corp.google.com>
 <20150918071525.GA482@cruxbox>
 <xmqqh9mnbswv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 22:38:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeUKR-0004pt-Fm
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 22:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934713AbbIVUiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 16:38:07 -0400
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:54655 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934699AbbIVUiC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 16:38:02 -0400
Received: from mfilter26-d.gandi.net (mfilter26-d.gandi.net [217.70.178.154])
	by relay2-d.mail.gandi.net (Postfix) with ESMTP id E82F5C5A50;
	Tue, 22 Sep 2015 22:37:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter26-d.gandi.net
Received: from relay2-d.mail.gandi.net ([IPv6:::ffff:217.70.183.194])
	by mfilter26-d.gandi.net (mfilter26-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id GZN8-d5XCZFn; Tue, 22 Sep 2015 22:37:58 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id A5BD3C5A3C;
	Tue, 22 Sep 2015 22:37:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqqh9mnbswv.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278431>

On Mon, Sep 21, 2015 at 10:09:52AM -0700, Junio C Hamano wrote:
> I think I said this already, but I found these bits from your patch
> 
> -		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
> +		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
> 
> that first uses libcurl and then libs (which has ssl bits) totally
> sensible.  Shouldn't that be sufficient?

That is not sufficient on its own because -lssl is not added in $(LIBS), it
is only added in $(CURL_LIBCURL) if NEEDS_SSL_WITH_CURL is set.

> 
> > The proper variable I should have used is
> > NEEDS_SSL_WITH_CURL. But this variable is not setted on Linux and not
> > configurable,...
> 
> Really?  Anything is configurable from your config.mak, I would have
> thought.

You right using the parts you find sensible and adding
"NEEDS_SSL_WITH_CURL=YesPlease" in config.mak makes git compile fine. So
I will resubmit with only the sensible part of the patch.

I have one last question thought. Wouldn't it be nice if we had
configure to autodetect the need for -lssl with libcurl ? We could make
configure to check for Curl_ssl_init function symbol in libcurl,
which is only present if libcurl has been compiled with openssl support,
by adding something like that in configure.ac:

AC_CHECK_LIB([curl], [Curl_ssl_init],
	[NEEDS_SSL_WITH_CURL=YesPlease],
	[NEEDS_SSL_WITH_CURL=])

The thing that I'm afraid of is that checking a function that is not part
of official libcurl API could be not very reliable, don't you think ?

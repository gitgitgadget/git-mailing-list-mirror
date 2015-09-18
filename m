From: Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH] Makefile: Change library order for static linking
Date: Fri, 18 Sep 2015 09:17:14 +0200
Message-ID: <20150918071525.GA482@cruxbox>
References: <1442524332-10180-1-git-send-email-repk@triplefau.lt>
 <xmqqfv2cj03t.fsf@gitster.mtv.corp.google.com>
 <20150917212016.GF606@cruxbox>
 <xmqq7fnoitra.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>,
	Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 09:17:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zcpv9-0005mh-UI
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 09:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752556AbbIRHRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 03:17:20 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43513 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbbIRHRT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 03:17:19 -0400
Received: from mfilter22-d.gandi.net (mfilter22-d.gandi.net [217.70.178.150])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id 7FCD917242A;
	Fri, 18 Sep 2015 09:17:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter22-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter22-d.gandi.net (mfilter22-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id KnpQgIDs90n4; Fri, 18 Sep 2015 09:17:16 +0200 (CEST)
X-Originating-IP: 81.57.43.44
Received: from localhost (mon75-1-81-57-43-44.fbx.proxad.net [81.57.43.44])
	(Authenticated sender: repk@triplefau.lt)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 8B983173A1E;
	Fri, 18 Sep 2015 09:17:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <xmqq7fnoitra.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278181>

On Thu, Sep 17, 2015 at 03:08:25PM -0700, Junio C Hamano wrote:
> That is, for most people, linking with -lcrypto was sufficient, but
> some people needed to grab things from -lssl when they need to do
> so, because things in -lcrypto referred to what was only in -lssl.

Oh I see what you mean, I misinterpreted what NEEDS_SSL_WITH_CRYPTO
does.

The problem on static compiled target is that libcurl.a got linked with
libssl symbols. The proper variable I should have used is
NEEDS_SSL_WITH_CURL. But this variable is not setted on Linux and not
configurable, this is why I wrongly used NEEDS_SSL_WITH_CRYPTO.

I see several ways to fix static compilation:

	1) Make NEED_SSL_WITH_CURL overridable by configure (the same
	way NEEDS_SSL_WITH_CRYPTO is). Then static target should run
	"NEED_SSL_WITH_CURL=YesPlease ./configure"

	2) Make configure know that static compilation is asked (ie
	./configure --static) and automatically set NEED_SSL_WITH_CURL.

	3) Use "curl-config --static-libs" to fill CURL_LIBCURL in
	Makefile when ones use "./configure --static".

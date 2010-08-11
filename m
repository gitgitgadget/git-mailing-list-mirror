From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Query: Patches break with Microsoft exchange server.
Date: Wed, 11 Aug 2010 17:30:34 +0100
Message-ID: <1281544234.5107.25.camel@localhost>
References: <4C5F9B25.8080401@st.com>
	 <AANLkTinxwRFLUibJECm0c3_oL5mYRkmscsw-xXgAHSTe@mail.gmail.com>
	 <4C624AE1.30504@st.com> <4C62C5BD.3020808@mnsu.edu>
	 <1281542305.5107.11.camel@localhost>
	 <AANLkTi=9xVdfXJXpkNPUMahc7AsbxjVbZFSxeBrzvbmS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>,
	viresh kumar <viresh.kumar@st.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" 
	<linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Justin P. Mattock" <justinmattock@gmail.com>,
	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>,
	Valeo de Vries <valeo@valeo.co.cc>,
	Linus Walleij <linus.ml.walleij@gmail.com>,
	Matti Aarnio <matti.aarnio@zmailer.org>, mihai.dontu@gmail.com,
	richardcochran@gmail.com, "Gadiyar, Anand" <gadiyar@ti.com>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 18:31:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjECg-000731-Uq
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 18:30:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753179Ab0HKQan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 12:30:43 -0400
Received: from casper.infradead.org ([85.118.1.10]:50865 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537Ab0HKQam (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 12:30:42 -0400
Received: from [2001:8b0:10b:1:225:64ff:fee8:e9df]
	by casper.infradead.org with esmtpsa (Exim 4.72 #1 (Red Hat Linux))
	id 1OjECK-0008SI-AZ; Wed, 11 Aug 2010 16:30:36 +0000
In-Reply-To: <AANLkTi=9xVdfXJXpkNPUMahc7AsbxjVbZFSxeBrzvbmS@mail.gmail.com>
X-Mailer: Evolution 2.31.6 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153264>

On Wed, 2010-08-11 at 12:18 -0400, Avery Pennarun wrote:
> 
> Out of curiosity, why fall back to one chunk at a time?  It seems to
> me that IMAP should be able to still support multiple outstanding
> requests in that case, but you'd just get errors on the latter chunks.
> 
> It is just that there was no point optimizing the workaround case?

There wasn't a lot of point in optimising it.

The current logic, shown in the patch I referenced, is to keep fetching
new chunks while the stream position matches the end of the previous
chunk we attempted to fetch.

To handle multiple outstanding requests, especially if they can be
satisfied out-of-order, would have been more complex because the stream
position (in the 'really_fetched' variable) wouldn't necessarily match
anything interesting. We'd have to keep more state, and the whole thing
would get a lot more intrusive.

Also, for the common case where the server isn't broken and the mail
size happens not to fall on a chunk boundary, the current implementation
results in no extra fetch requests. Doing otherwise would either mean
extra fetch requests even for this common case, or would mean even more
complexity to 'catch up' by issuing additional fetch requests as soon as
we realise the server lied about RFC822.SIZE (which is when we receive
the last chunk, and it runs over the size we expected).

It may be that there's a neat and simple way to handle all of the above,
and if so then patches would be welcome -- but personally, I just
couldn't be bothered to think too hard about it. There were more
pressing matters to attend to, like implementing QRESYNC support.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse@intel.com                              Intel Corporation

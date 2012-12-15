From: Florian Achleitner <florian.achleitner2.6.31@gmail.com>
Subject: Re: [PATCH 1/3] remote-testsvn: fix unitialized variable
Date: Sat, 15 Dec 2012 11:29:34 +0100
Message-ID: <2763981.Tc7o2WorU3@flomedio>
References: <20121214220903.GA18418@sigill.intra.peff.net> <20121214221144.GA19677@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: git@vger.kernel.org,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 15 12:24:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tjpqw-00006R-DV
	for gcvg-git-2@plane.gmane.org; Sat, 15 Dec 2012 12:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab2LOLYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2012 06:24:03 -0500
Received: from mailrelay.tu-graz.ac.at ([129.27.2.202]:36413 "EHLO
	mailrelay.tugraz.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751588Ab2LOLYB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2012 06:24:01 -0500
X-Greylist: delayed 3233 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 Dec 2012 06:24:01 EST
Received: from flomedio.localnet (cm56-227-93.liwest.at [86.56.227.93])
	(authenticated bits=0)
	by mailrelay2.tugraz.at (8.14.4/8.14.4) with ESMTP id qBFATmYC018845
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 15 Dec 2012 11:29:50 +0100 (CET)
User-Agent: KMail/4.9.3 (Linux/3.0.0-25-generic; KDE/4.9.3; x86_64; ; )
In-Reply-To: <20121214221144.GA19677@sigill.intra.peff.net>
X-TUG-Backscatter-control: qyH/vN2riZ/masrHmZoJqQ
X-Spam-Scanner: SpamAssassin 3.003000 
X-Spam-Score-relay: 0.6
X-Scanned-By: MIMEDefang 2.70 on 129.27.10.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211530>

On Friday 14 December 2012 17:11:44 Jeff King wrote:

> [...]
> We can fix it by returning "-1" when no note is found (so on
> a zero return, we always found a valid value).

Good fix. Parsing of the note now always fails if the note doesn't contain the 
expected string, as it should.

> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I think this is the right fix, but I am not too familiar with this code,
> so I might be missing a case where a missing "Revision-number" should
> provide some sentinel value (like "0") instead of returning an error. In
> fact, of the two callsites, one already does such a zero-initialization.
> 
>  remote-testsvn.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/remote-testsvn.c b/remote-testsvn.c
> index 51fba05..5ddf11c 100644
> --- a/remote-testsvn.c
> +++ b/remote-testsvn.c
> @@ -90,10 +90,12 @@ static int parse_rev_note(const char *msg, struct
> rev_note *res) if (end == value || i < 0 || i > UINT32_MAX)
>  				return -1;
>  			res->rev_nr = i;
> +			return 0;
>  		}
>  		msg += len + 1;
>  	}
> -	return 0;
> +	/* didn't find it */
> +	return -1;
>  }
> 
>  static int note2mark_cb(const unsigned char *object_sha1,

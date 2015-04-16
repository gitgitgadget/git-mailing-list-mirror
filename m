From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] utf8-bom: introduce skip_utf8_bom() helper
Date: Thu, 16 Apr 2015 14:14:07 -0400
Message-ID: <20150416181407.GA12517@peff.net>
References: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
 <1429206774-10087-1-git-send-email-gitster@pobox.com>
 <1429206774-10087-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 20:14:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YioIq-0001Rz-Re
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 20:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754840AbbDPSOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 14:14:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:46370 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754498AbbDPSOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 14:14:09 -0400
Received: (qmail 13191 invoked by uid 102); 16 Apr 2015 18:14:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 13:14:09 -0500
Received: (qmail 27387 invoked by uid 107); 16 Apr 2015 18:14:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Apr 2015 14:14:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2015 14:14:07 -0400
Content-Disposition: inline
In-Reply-To: <1429206774-10087-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267319>

On Thu, Apr 16, 2015 at 10:52:52AM -0700, Junio C Hamano wrote:

> @@ -576,10 +576,8 @@ int add_excludes_from_file_to_list(const char *fname,
>  
>  	el->filebuf = buf;
>  
> -	if (size >= 3 && !memcmp(buf, utf8_bom, 3))
> -		entry = buf + 3;
> -	else
> -		entry = buf;
> +	entry = buf;
> +	skip_utf8_bom(&entry, size);
>  
>  	for (i = 0; i < size; i++) {
>  		if (buf[i] == '\n') {

I'm surprised that in both yours and the original that we do not need to
subtract 3 from "size".

It looks like we advance "entry" here, not "buf", and then iterate over
"buf". But I think that makes the later logic weird:

   if (entry != buf + i && entry[0] != '#')

because if there is a BOM, we end up with "entry > buf + i", which I
think this code isn't expecting. I'm not sure it does anything bad, but
I think it might be simpler as just:

  /* save away the "real" copy for later, as we do now */
  el->filebuf = buf;

  /*
   * now pretend as if the BOM was not there at all by advancing
   * the pointer and shrinking the size
   */
  skip_utf8_bom(&buf, &size);

  /*
   * and now we do our usual magic with "entry"
   */
  entry = buf;
  for (i = 0; i < size; i++)
     ...

-Peff

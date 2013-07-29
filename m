From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] imap-send: use Apple's Security framework for base64
 encoding
Date: Sun, 28 Jul 2013 20:35:33 -0700
Message-ID: <20130729033533.GB2890@elie.Belkin>
References: <1374957092-41505-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeremy Huddleston <jeremyhu@apple.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 05:35:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3eFK-00050Z-M0
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 05:35:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149Ab3G2Dfi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jul 2013 23:35:38 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:65075 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332Ab3G2Dfi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jul 2013 23:35:38 -0400
Received: by mail-pa0-f44.google.com with SMTP id jh10so5314723pab.31
        for <git@vger.kernel.org>; Sun, 28 Jul 2013 20:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=hh0C3Ps/hnAZ8LoEHTETcykWxXq/ONZqfpoF68XRsRY=;
        b=Cm8u1gVWEfNRrn26V3Pnkpj4kmTC5924Fg4BAROpj/3lYwxfBx1HoAb1BRvy6/Sa9g
         Orc+hfTPwzJQJbYnXj+L3V27kmZNu7O4mMp2mvA+DAIsfpOvzhaUjA43YkcHMOF6JH0L
         0sjKwTB5yScSVBb+dxs7ujR2quHAz3v3cNFRWttDb01o+XAy+//jJP0U1kd1UidGNfu0
         vv0LgVd++CiRukPy+8G0Zf+nB0fvqOlUjP8DFOmmBnaJxwiBSyAXPagtoVlVX0wojhxC
         XF5CrBoOspMNHi/V39pX5z+RzVCBMgreX7X4OE/put7/xcXvPLqNsCxWfPxiXSdYI0dD
         8xwQ==
X-Received: by 10.68.114.131 with SMTP id jg3mr61384490pbb.111.1375068937510;
        Sun, 28 Jul 2013 20:35:37 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id bs3sm74077979pbc.42.2013.07.28.20.35.35
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 28 Jul 2013 20:35:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1374957092-41505-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231271>

Hi,

David Aguilar wrote:

> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -22,14 +22,11 @@
>   *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
>   */
>  
> -#include "cache.h"
> -#include "exec_cmd.h"
> -#include "run-command.h"
> -#include "prompt.h"
>  #ifdef NO_OPENSSL
>  typedef void *SSL;
>  #else
>  #ifdef APPLE_COMMON_CRYPTO
> +/* git-compat-util.h overwrites ctype.h; this must be included first */
>  #include <CommonCrypto/CommonHMAC.h>

Thanks for your work on this.

Currently each translation unit of git includes git-compat-util.h or a
header like cache.h that includes git-compat-util.h before doing
anything else, since otherwise feature test macros are not set before
the first system header is included.

The above (CommonCrypto needing to be included before some of the
definitions from git-compat-util.h) suggests to me that CommonCrypto
should just be included directly from git-compat-util.h in some
appropriate place.  That way any other header that needs CommonCrypto
routines only has to include git-compat-util.h first as usual and
doesn't have to worry about the order of other #includes.  Could that
work?

Thanks and hope that helps,
Jonathan

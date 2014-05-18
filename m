From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3] format-patch --signature-file <file>
Date: Sun, 18 May 2014 10:49:54 -0700
Message-ID: <20140518174954.GA30558@hudson.localdomain>
References: <1400342542-11256-1-git-send-email-jmmahler@gmail.com>
 <1400342542-11256-2-git-send-email-jmmahler@gmail.com>
 <20140518112020.GA2153@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 18 19:50:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wm5Dm-0006Wl-Va
	for gcvg-git-2@plane.gmane.org; Sun, 18 May 2014 19:50:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbaERRt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 13:49:59 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34634 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbaERRt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 13:49:58 -0400
Received: by mail-pa0-f53.google.com with SMTP id kp14so4710738pab.40
        for <git@vger.kernel.org>; Sun, 18 May 2014 10:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=hXdHG4Yz5B4/ojdRNzpITi9bSILedtG9JBh0d/q6cHw=;
        b=uzLq7k7g6fAkIFFBjS7HIEW/0NXbuVWX2WTU8+jGgGWExc21QJdAsCEHdOlzv0+ElT
         uFXMrEECHSWwAPln0qpIYRCpmIliy5fwTkxVA7RshHnq3TZLD5fL+NmnSlOGl1vejtly
         ZpeW4526YLnDwim32a8ED9wG7I/yhttJPu5wdYEgNHrCuKXg7NA4wg9LPaP/7ZnVJlFC
         pdipTVZ4nyWU3+nlesS0FE8zTm/M9p/oN+AwS/Nz7BpKVNN8Q6I6amnPz3RNaXUC/gtE
         VIIX/6hgm2fvre4gxfyPzTIZANP3bI20S7ytf8t+mNPi/BpzBXWGP0DB/qAFYvaK98+v
         kTJA==
X-Received: by 10.68.230.41 with SMTP id sv9mr37253961pbc.23.1400435398269;
        Sun, 18 May 2014 10:49:58 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id xk1sm64165021pac.21.2014.05.18.10.49.55
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 18 May 2014 10:49:57 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Sun, 18 May 2014 10:49:54 -0700
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140518112020.GA2153@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249503>

Peff,

Lots of good suggestions.  I had to expand upon the signature
pattern match to get to work.

On Sun, May 18, 2014 at 07:20:20AM -0400, Jeff King wrote:
> On Sat, May 17, 2014 at 09:02:22AM -0700, Jeremiah Mahler wrote:
> 
...
> > +test_expect_success 'format-patch --signature-file file' '
> > +	git format-patch --stdout --signature-file expect -1 >output &&
> > +	check_patch output &&
> > +	fgrep -x -f output expect >output2 &&
> 
> Both of these fgrep options are in POSIX, but it looks like this will be
> the first use for either of them. I'm not sure if they will give us any
> portability problems.
> 
> We could probably do something like:
> 
>   sed -n '/^-- $/,$p'
> 

This gets the signature out but it will have '--' and
some trailing blank lines which were not in the original signature.
So then test_cmp won't work directly.

What I came up with was to use head and tail to remove the first line
and the last two lines.  Then test_cmp can be used normally.

test_expect_success 'format-patch --signature-file=file' '
	git format-patch --stdout --signature-file=expect -1 >output &&
	check_patch_output output &&
	sed -n "/^-- $/,\$p" <output | head --lines=-2 | tail --lines=+2 >output2 &&
	test_cmp expect output2
'

-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler

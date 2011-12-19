From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 4/3] gitweb: Fix fallback mode of to_utf8 subroutine
Date: Mon, 19 Dec 2011 13:11:57 +0100
Message-ID: <201112191311.58787.jnareb@gmail.com>
References: <1324113743-21498-1-git-send-email-jnareb@gmail.com> <201112190154.19107.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Juergen Kreileder <jk@blackdown.de>,
	Junio Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 13:12:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rcc4h-0007SY-Jp
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 13:12:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752931Ab1LSMMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 07:12:06 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:33155 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab1LSMME (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 07:12:04 -0500
Received: by eekc4 with SMTP id c4so5369018eek.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 04:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=TiLvSpNphtXNRGPLmfcrVY/0I0Q8qvt5WSbu1MNsNJs=;
        b=dKp5zTysQSAniUFGqqmOKz3ysh0bPVQFo3yM0HT8EAi6bPe2/dOE6bPOI28UuTbSAb
         9XJfLWdrKnlM1FBeH0rZ6uXaQsPkPYe27IxUzHNn1fFf1KzwXcXhOoqMN9TU3cOQP5Q/
         tTaZk5P0MLhr6/oOkNbpCHW9dW9iJNh+oriOs=
Received: by 10.213.2.131 with SMTP id 3mr2599706ebj.102.1324296723189;
        Mon, 19 Dec 2011 04:12:03 -0800 (PST)
Received: from [192.168.1.13] (aehn116.neoplus.adsl.tpnet.pl. [79.186.195.116])
        by mx.google.com with ESMTPS id t59sm26087415eeh.10.2011.12.19.04.12.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 19 Dec 2011 04:12:01 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201112190154.19107.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187448>

Jakub Narebski wrote:

> e5d3de5 (gitweb: use Perl built-in utf8 function for UTF-8 decoding.,
> 2007-12-04) was meant to make gitweb faster by using Perl's internals
> (see subsection "Messing with Perl's Internals" in Encode(3pm) manpage)
> 
> Simple benchmark confirms that (old = 00f429a, new = this version);
> note that it is synthetic benchmark of standalone subroutines, not
> of gitweb itself
> 
>         old  new
>   old    -- -65%
>   new  189%   --

Nb. that was about operations / second (higher is better):

           Rate  old  new
    old  2067/s   -- -65%
    new  5863/s 184%   --

Or in slightly different benchmark (more smaller lines):

          Rate  old  new
    old  277/s   -- -73%
    new 1021/s 268%   --

 old$ time ./t9500-gitweb-standalone-no-errors.sh >/dev/null

   real       1m16.788s
   user       1m0.908s
   sys        0m14.033s
   user+sys   1m14.941s

 new$ time ./t9500-gitweb-standalone-no-errors.sh >/dev/null

    real      1m12.216s
    user      0m57.300s
    sys       0m13.329s
    user+sys  1m10.639s

Though such benchmarks should have been a part of e5d3de5.


P.S. I started to get strange errors

 XML Parsing Error: xml processing instruction not at start of external entity
 Location: http://localhost/cgi-bin/gitweb/gitweb.cgi
 Line Number 37, Column 1:
 <?xml version="1.0" encoding="utf-8"?>
 ^

while "show source" shows that '<?xml version="1.0" encoding="utf-8"?>'
is the first line.  WTF?!?

P.P.S. Now I am getting errors when running gitweb, but only in some
cases (via mod_cgi not as standalone script, only when using lynx),
namely it looks like it falls back to 'latin1' when doing content
which is valid UTF-8.

Will investigate.

-- 
Jakub Narebski
Poland

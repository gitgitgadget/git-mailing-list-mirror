From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [PATCH] http: Add Accept-Language header if possible
Date: Wed, 9 Jul 2014 11:40:05 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.1407091127490.22132@ds9.cixit.se>
References: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git@vger.kernel.org, Yi EungJun <eungjun.yi@navercorp.com>
To: Yi EungJun <semtlenori@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 12:40:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4pIX-0002uk-Lb
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 12:40:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682AbaGIKkU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 06:40:20 -0400
Received: from upper-gw.cixit.se ([92.43.32.133]:48014 "EHLO mail.cixit.se"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753786AbaGIKkT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 06:40:19 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by mail.cixit.se (8.14.3/8.14.3/Debian-9.4) with ESMTP id s69Ae7aG026195
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 9 Jul 2014 12:40:07 +0200
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.14.3/8.14.3/Submit) with ESMTP id s69Ae56c026192;
	Wed, 9 Jul 2014 12:40:05 +0200
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <1404834846-11812-1-git-send-email-eungjun.yi@navercorp.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.3.7 (mail.cixit.se [127.0.0.1]); Wed, 09 Jul 2014 12:40:07 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253111>

Yi EungJun:

> Example:
>  LANGUAGE= -> ""
>  LANGUAGE=ko -> "Accept-Language: ko; q=1.000, *; q=0.001"
>  LANGUAGE=ko:en -> "Accept-Language: ko; q=1.000, en; q=0.999, *; q=0.001"

Avoid adding "q=1.000". It is redundant (the default for any 
unqualified language names is 1.0, and additionally there has 
historically been some buggy servers that failed if it was included.

> +	p1 = getenv("LANGUAGE");

You need a fallback mechanism here to parse all the possible language 
variables. I would use the first one I find of these:

  1. LANGUAGE
  2. LC_ALL
  3. LC_MESSAGES
  4. LANG

Only "LANGUAGE" holds a colon-separated list, but the same code can 
parse all of them, just yielding a single entry for the others.

> +				strbuf_add(buf, p1, p2 - p1);

The tokens are on the form language_COUNTRY.encoding@identifier, whereas 
Accept-Language wants language-COUNTRY, so you need to a) replace "_" 
with "-", and b) chop off anything following a "." or "@".

> +				strbuf_addf(buf, "; q=%.3f", q);
> +				q -= 0.001;

Three decimals seems a bit overkill, but some experimentation might be 
necessary.

> +		strbuf_addstr(buf, "*; q=0.001\r\n");

You should probably also add an explicit "en" here, if none was 
already included. I've seen some servers break horribly if "en" isn't 
included.



For reference, I have my LANGUAGE variable set to 
"sv_SE.utf8:sv:nb_NO.utf8:nb:da_DK.utf8:da:nn_NO.utf8:nn:en_GB.utf8:en_US.utf8:en"

-- 
\\// Peter - http://www.softwolves.pp.se/

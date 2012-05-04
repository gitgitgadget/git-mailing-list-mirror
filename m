From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Re: [PATCH 2/6] http: handle proxy proactive authentication
Date: Fri, 04 May 2012 15:55:47 +0200
Message-ID: <4FA3DFE3.5050702@seap.minhap.es>
References: <4FA2B4DA.60908@seap.minhap.es> <20120504071632.GB21895@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 04 14:59:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQI6A-0008CA-6u
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 14:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758101Ab2EDM6u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 08:58:50 -0400
Received: from luthien2.map.es ([213.9.211.102]:13960 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758057Ab2EDM6t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 08:58:49 -0400
Received: from correo.map.es (unknown [10.1.31.23])
	by luthien2.map.es (Postfix) with ESMTP id 5859BB7CE5;
	Fri,  4 May 2012 14:58:32 +0200 (CEST)
Received: from [10.47.128.147] (unknown [10.1.29.55])
	by correo.map.es (Postfix) with ESMTP id B429F203C8E;
	Fri,  4 May 2012 14:58:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:12.0) Gecko/20120424 Thunderbird/12.0
In-Reply-To: <20120504071632.GB21895@sigill.intra.peff.net>
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: 5859BB7CE5.BB84B
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1336741112.44017@C/HIBD+o+yy5NHLOQ5shNw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197017>

On 05/04/2012 09:16 AM, Jeff King wrote:
> On Thu, May 03, 2012 at 06:39:54PM +0200, Nelson Benitez Leon wrote:
> 
>> If http_proactive_auth flag is set and there is a username
>> but no password in the proxy url, then interactively ask for
>> the password.
>>
>> This makes possible to not have the password written down in
>> http_proxy env var or in http.proxy config option.
>>
>> Also take care that CURLOPT_PROXY don't include username or
>> password, as we now set them in the new set_proxy_auth() function
>> where we use their specific cURL options.
> 
> Do we actually need to do that? If we set CURLOPT_PROXYUSERNAME, will
> curl ignore it in favor of what's in the URL? 

I explicitly remove username/pass from CURLOPT_PROXY to not having to worry
about that question, to not provide cURL with two different sets of proxy auth
info, common sense dictates cURL specific proxy options should take precedence
over embedded in url by I haven't seen that mentioned by any cURL docs so we 
should look at the source to know the truth but even then that could change in
the future so I think is safer to only provide one path for auth info.

Having username/password on the CURLOPT_PROXY option gives us no special gain at
the cost of not permitting usernames with reserved characters like '@' or ':' which
are not unusual at all. So I'm inclined to preserve current set_proxy_auth() 
function and re-introduce the code that sets CURLOPT_PROXY with only $prot://$host.

Are you ok with this? or do you prefer I change set_proxy_auth() to a set_curl_proxy()
function where I embedded user/pass in CURLOPT_PROXY ? that is the remaining thing I need
to know to send a new re-roll.

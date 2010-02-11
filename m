From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 8/6 v2] receive-pack: Send internal errors over side-band
 #2
Date: Thu, 11 Feb 2010 09:34:07 +0100
Message-ID: <4B73C0FF.5020503@viscovery.net>
References: <1265767290-25863-1-git-send-email-spearce@spearce.org> <1265767290-25863-2-git-send-email-spearce@spearce.org> <4B725CB1.1080908@viscovery.net> <4B726A8C.6010600@viscovery.net> <20100210173412.GG2747@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 11 10:09:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfV3T-00021A-MU
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 10:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab0BKJJi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 04:09:38 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:28026 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752381Ab0BKJJh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 04:09:37 -0500
X-Greylist: delayed 2124 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Feb 2010 04:09:37 EST
Received: from bsmtp.bon.at (unknown [172.18.12.54])
	by lbmfmo03.bon.at (Postfix) with ESMTP id D424DCE61E
	for <git@vger.kernel.org>; Thu, 11 Feb 2010 09:35:39 +0100 (CET)
Received: from [192.168.0.200] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 65DBFA7FB6;
	Thu, 11 Feb 2010 09:34:08 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100210173412.GG2747@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139578>

Shawn O. Pearce schrieb:
> +static void report_message(const char *prefix, const char *err, va_list params)
> +{
> +	int sz = strlen(prefix);
> +	char msg[4096];
> +
> +	strncpy(msg, prefix, sz);
> +	sz += vsnprintf(msg + sz, sizeof(msg) - sz, err, params);
> +	if (sz > (sizeof(msg) - 1))
> +		sz = sizeof(msg) - 1;
> +	msg[sz++] = '\n';

Sorry, still no joy - the terminating NUL is missing (I should have 
noticed this in your v1 already). I suggest to forgo the length check for 
simplicity because this function is only called with data that is already 
guaranteed to be less than 1000 bytes, i.e.:

	strncpy(msg, prefix, sz);
	/* data is guaranteed to fit due to packet length limit in 
read_head_info() */
	sz += vsprintf(msg + sz, err, params);
	msg[sz++] = '\n';
	msg[sz++] = '\0';

-- Hannes

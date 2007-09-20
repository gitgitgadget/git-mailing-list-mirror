From: Johannes Sixt <j.sixt@eudaptics.com>
Subject: Re: [PATCH 1/5] strbuf API additions and enhancements.
Date: Thu, 20 Sep 2007 08:17:59 +0200
Message-ID: <46F21097.5030901@eudaptics.com>
References: <20070918223947.GB4535@artemis.corp>	<20070918224119.17650344AB3@madism.org> <20070919144604.7deca4f7.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Edgar Toernig <froese@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 08:18:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYFMc-0005Zy-UN
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 08:18:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbXITGSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 02:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750924AbXITGSI
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 02:18:08 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:43936 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbXITGSG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 02:18:06 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1IYFMO-0005nz-Au; Thu, 20 Sep 2007 08:18:00 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DB6CA546; Thu, 20 Sep 2007 08:17:59 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20070919144604.7deca4f7.froese@gmx.de>
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.374, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58758>

Edgar Toernig schrieb:
> Pierre Habouzit wrote:
>> +void strbuf_addvf(struct strbuf *sb, const char *fmt, va_list ap)
>> +{
>> +	int len;
>> +
>> +	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
>> +	if (len < 0) {
>> +		len = 0;
>> +	}
>> +	if (len > strbuf_avail(sb)) {
>> +		strbuf_grow(sb, len);
>> +		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
>> +		if (len > strbuf_avail(sb)) {
>> +			die("this should not happen, your snprintf is broken");
>> +		}
>> +	}
>> +	strbuf_setlen(sb, sb->len + len);
>> +}
> 
> The second vsnprintf won't work as the first one consumed all args
> from va_list ap.  You need to va_copy the ap.

Your analysis is not correct. The second vsnprintf receives the same 
argument pointer as the first, and, hence, consumes the same set of arguments.

You have to use va_copy in a variadic function, ie. if you are using 
va_start+va_end in the same function, but not in a function with a fixed 
list of arguments like this one.

-- Hannes

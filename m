From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 2/2 v3] Makefile: lazily compute header dependencies
Date: Sat, 28 Nov 2009 05:49:37 -0600
Message-ID: <20091128114937.GA10199@progeny.tock>
References: <4B0F8825.3040107@viscovery.net>
 <alpine.DEB.1.00.0911271033460.4521@intel-tinevez-2-302>
 <20091127174558.GA3461@progeny.tock>
 <20091127175043.GC3461@progeny.tock>
 <20091128092948.GA8515@progeny.tock>
 <m2bpint2yk.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Nov 28 12:37:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NELcO-00060y-63
	for gcvg-git-2@lo.gmane.org; Sat, 28 Nov 2009 12:37:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753881AbZK1LhY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2009 06:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753842AbZK1LhY
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Nov 2009 06:37:24 -0500
Received: from mail-yw0-f182.google.com ([209.85.211.182]:58589 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841AbZK1LhX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2009 06:37:23 -0500
Received: by ywh12 with SMTP id 12so2380062ywh.21
        for <git@vger.kernel.org>; Sat, 28 Nov 2009 03:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=QrnE4oz/KlaOG2PUTPvkvXieTSZ9cb1X8SikhuHtq3o=;
        b=Z0rH8otQnRH6izOPsZD5d8jguRL39o11AlYwF0vpB7YQwhPouMBsySMUqDD6b66cXm
         sBUZ8qXUiu1eIlAcrjdwifrge8r6VMMBMUMSBYydDvCrt2Ifwra45htVoxmuwQywQsue
         tEQqYL10t7WCbO2DVzVUhI/uvSBzif3o8Pp9k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=LOagFum1piqfgQrpSvjgJZmG3M4fQK40AleMlYfIQvTuQtyo8k01Fu6Vma+MpHV5YM
         GJBHp2F5VzVv5m/BURBKf2bOlC6Rxq7HmrT9rQbb1ThVYyKjBHvD9UnAcb4PLxko6o78
         k+VpZn+PmIeVu+Sup31PjrlXb/ti/LuIegoSo=
Received: by 10.150.45.2 with SMTP id s2mr3370096ybs.162.1259408249008;
        Sat, 28 Nov 2009 03:37:29 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 16sm232378gxk.15.2009.11.28.03.37.27
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 28 Nov 2009 03:37:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m2bpint2yk.fsf@igel.home>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133955>

Andreas Schwab wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  GIT-CFLAGS: .FORCE-GIT-CFLAGS
>> +	mkdir -p deps block-sha1/deps ppc/deps compat/deps \
>> +		compat/regex/deps compat/nedmalloc/deps compat/fnmatch/deps \
>> +		xdiff/deps
> 
> IMHO the list of directories should be factored out in a variable for
> easier maintenance.

Good idea, thanks.

Perhaps the the value for such a variable could be computed at build time.
e.g.

depdirs := $(addsuffix /deps,$(sort $(dir $(OBJECTS))))

>> @@ -1873,8 +1898,10 @@ distclean: clean
>>  	$(RM) configure
>>  
>>  clean:
>> -	$(RM) *.o block-sha1/*.o arm/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
>> +	$(RM) *.o block-sha1/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
>>  		$(LIB_FILE) $(XDIFF_LIB)
>> +	$(RM) -r deps block-sha1/deps ppc/deps compat/deps \
>> +		compat/*/deps xdiff/deps

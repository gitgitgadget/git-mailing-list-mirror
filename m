From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 8/6 v2] receive-pack: Send internal errors over
	side-band #2
Date: Thu, 11 Feb 2010 07:05:47 -0800
Message-ID: <20100211150547.GL2747@spearce.org>
References: <1265767290-25863-1-git-send-email-spearce@spearce.org> <1265767290-25863-2-git-send-email-spearce@spearce.org> <4B725CB1.1080908@viscovery.net> <4B726A8C.6010600@viscovery.net> <20100210173412.GG2747@spearce.org> <4B73C0FF.5020503@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 11 16:06:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nfac9-0004dV-OF
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 16:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263Ab0BKPFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 10:05:52 -0500
Received: from mail-yx0-f196.google.com ([209.85.210.196]:50104 "EHLO
	mail-yx0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755990Ab0BKPFv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 10:05:51 -0500
Received: by yxe34 with SMTP id 34so1218014yxe.16
        for <git@vger.kernel.org>; Thu, 11 Feb 2010 07:05:51 -0800 (PST)
Received: by 10.150.184.16 with SMTP id h16mr294710ybf.344.1265900750590;
        Thu, 11 Feb 2010 07:05:50 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 8sm917188yxg.60.2010.02.11.07.05.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Feb 2010 07:05:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4B73C0FF.5020503@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139604>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Shawn O. Pearce schrieb:
>> +static void report_message(const char *prefix, const char *err, va_list params)
>> +{
>> +	int sz = strlen(prefix);
>> +	char msg[4096];
>> +
>> +	strncpy(msg, prefix, sz);
>> +	sz += vsnprintf(msg + sz, sizeof(msg) - sz, err, params);
>> +	if (sz > (sizeof(msg) - 1))
>> +		sz = sizeof(msg) - 1;
>> +	msg[sz++] = '\n';
>
> Sorry, still no joy - the terminating NUL is missing (I should have  
> noticed this in your v1 already).

Why is it necessary?

Once the msg buffer is prepared, its written using its length, sz,
not its NUL termination status.  Neither send_sideband() nor xwrite()
care about NUL termination.

The only reason to put a NUL onto this buffer is so you can do
"p msg" within GDB and get a useful result.  We don't typically do
this in these contexts.

Or did my MTA inject additional C code I didn't write?

> I suggest to forgo the length check for 
> simplicity because this function is only called with data that is already 
> guaranteed to be less than 1000 bytes, i.e.:
>
> 	strncpy(msg, prefix, sz);
> 	/* data is guaranteed to fit due to packet length limit in  
> read_head_info() */

Yea, that's true now.  We probably could have used 1200 bytes for
the msg buffer, rather than 4096.  Even the huge warnings about
current branch behavior are broken up into one string per line.

-- 
Shawn.

From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] recv_sideband: Band #2 always goes to stderr
Date: Tue, 10 Mar 2009 16:02:15 +0100
Message-ID: <49B680F7.4040103@viscovery.net>
References: <cover.1236639280u.git.johannes.schindelin@gmx.de> <e2b19f6c7c50e5b0a652c40b0d8e4947134ed669.1236639280u.git.johannes.schindelin@gmx.de> <49B61377.90103@viscovery.net> <49B61703.8030602@viscovery.net> <20090310144646.GQ11989@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com,
	Peter Harris <git@peter.is-a-geek.org>,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Nicolas Pitre <nico@cam.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 10 16:06:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh3Us-0000U1-LX
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 16:03:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754268AbZCJPCU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 11:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754179AbZCJPCU
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 11:02:20 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:4496 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752942AbZCJPCU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 11:02:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lh3TD-0004xE-EV; Tue, 10 Mar 2009 16:02:15 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2B0934FB; Tue, 10 Mar 2009 16:02:15 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090310144646.GQ11989@spearce.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112823>

Shawn O. Pearce schrieb:
> Johannes Sixt <j.sixt@viscovery.net> wrote:
>> diff --git a/sideband.c b/sideband.c
>> index cca3360..a706ac8 100644
>> --- a/sideband.c
>> +++ b/sideband.c
>> @@ -50,8 +49,8 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
>>  		switch (band) {
>>  		case 3:
>>  			buf[pf] = ' ';
>> -			buf[pf+1+len] = '\n';
>> -			safe_write(err, buf, pf+1+len+1);
>> +			buf[pf+1+len] = '\0';
>> +			fprintf(stderr, "%s\n", buf);
> 
> Can't you instead do:
> 
> 	fprintf(stderr, "%.*s\n", buf, pf + len);
> 
> like you do...
> 
>> @@ -95,12 +94,13 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
>>  					memcpy(save, b + brk, sf);
>>  					b[brk + sf - 1] = b[brk - 1];
>>  					memcpy(b + brk - 1, suffix, sf);
>> -					safe_write(err, b, brk + sf);
>> +					fprintf(stderr, "%.*s", brk + sf, b);
>>  					memcpy(b + brk, save, sf);
>>  					len -= brk;
>>  				} else {
>>  					int l = brk ? brk : len;
>> -					safe_write(err, b, l);
>> +					if (l > 0)
>> +						fprintf(stderr, "%.*s", l, b);
> 
> here?

I deliberatly avoided "%.*s" in the former hunk (1) because of the posts
that we had yesterday about potentially misbehaved fprintf in the case
where the precision is 0; and (2) because it was so easy to avoid it. I
don't think we need ultimate performance in this case, and I also consider
the plain "%s\n" more readable.

That said, the second hunk is really only the minimal change and I'd like
to rewrite it to get rid of the memcpy stuff. It is really not needed once
fprintf is in the game. But that's a separate patch.

-- Hannes

From: Sven Strickroth <sven@cs-ware.de>
Subject: Re: [PATCH] Also read SQUASH_MSG if a conflict on a merge squash
 occurred
Date: Tue, 8 Mar 2016 19:49:33 +0100
Message-ID: <56DF1EBD.8050503@cs-ware.de>
References: <56DAB71E.6000509@cs-ware.de> <56DE5272.2080009@cs-ware.de>
 <xmqq60wwlt0s.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 08 19:49:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adMhc-0007zN-R6
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 19:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbcCHStt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 13:49:49 -0500
Received: from srv1.79p.de ([213.239.234.118]:57348 "EHLO srv1.79p.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbcCHSts (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 13:49:48 -0500
X-Virus-Scanned: Debian amavisd-new at srv1.79p.de
Received: from [IPv6:2003:88:6f35:100:58e:9826:6785:be88] (p200300886F350100058E98266785BE88.dip0.t-ipconnect.de [IPv6:2003:88:6f35:100:58e:9826:6785:be88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sven@cs-ware.de)
	by srv1.79p.de (Postfix) with ESMTPSA id 0F0CD224476;
	Tue,  8 Mar 2016 19:49:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=cs-ware.de;
	s=mail2015b; t=1457462980;
	bh=AgBsYcmp0sm68uUhJZ1AbfGcC/j6x4YdnwR2xN7/T7s=;
	h=Subject:To:References:From:Date:In-Reply-To;
	b=fkk40RFmR3Pc0sVOx9TkofxP4J1zJDvGSDKLowGmJmDZQ57su7MrJaqYZjDRiJE5X
	 ER9vY9AZjC7zp5epcIXNBlDErhx87pjeDV36ftTfaFq8mxY0eXyOP3FBK4IFx0b2nP
	 Jgte8ENOoi5AwlKujF5G4OFXLoNM3ON9KQ4KnU48cB49hsE++NSzl5WcVctV6Gbpw4
	 nsgFXcVKAWDSQGlmL/kpaaxeJRzZ1xxPX4d3ydF0cHgyNSoVLnx6xRCLSGxv5QQX2g
	 MumanzJFg5g6EEYsqfxrcyxBanTUcSY0N6m933X4ALwLIRjOpzZN/qrIyQE+VrBD4x
	 f2A3J828mh2jw==
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqq60wwlt0s.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288448>

Am 08.03.2016 um 19:32 schrieb Junio C Hamano:
>> +		if (!stat(git_path_squash_msg(), &statbuf)) {
>> +			if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
>> +				die_errno(_("could not read SQUASH_MSG"));
>> +			hook_arg1 = "squash";
>> +		}
>>  	} else if (!stat(git_path_squash_msg(), &statbuf)) {
>>  		if (strbuf_read_file(&sb, git_path_squash_msg(), 0) < 0)
>>  			die_errno(_("could not read SQUASH_MSG"));
> 
> This reads MERGE_MSG first and then SQUASH_MSG; is that what we
> really want?  When you are resolving a conflicted rebase, you would
> see the original log message and then conflicts section.  What is in
> the SQUASH_MSG is the moral equivalent of the "original log message"
> but in a less summarized form, so I suspect that the list of conflicts
> should come to end.

I put them first because the squash commit list could be really long.
I'll put MERGE_MSG at the end...

> The duplicated code to read the same file bothers me somewhat.
> 
> I wondered if it makes the result easier to follow (and easier to
> update) if this part of the code is restructured like this:
> 
> 	if (file_exists(git_path_merge_msg()) ||
>             file_exists(git_path_squash_msg())) {
> 	    if (file_exists(git_path_squash_msg())) {
> 		read SQUASH_MSG;
> 	    }
>             if (file_exists(git_path_merge_msg()))
>             	read MERGE_MSG;
> 	    }
>             hook_arg1 = "merge";
> 	}

Here hook_arg1 would be always "merge" and never "squash"... Before my
change it was only "squash" if no conflict occurred.

-- 
Best regards,
 Sven Strickroth
 PGP key id F5A9D4C4 @ any key-server

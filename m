From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] unpack-trees: handle lstat failure for existing
 directory
Date: Wed, 12 Jan 2011 23:38:49 -0600
Message-ID: <20110113053849.GA10371@burratino>
References: <1230843273-11056-1-git-send-email-drizzd@aon.at>
 <1230843273-11056-2-git-send-email-drizzd@aon.at>
 <20110113022415.GA8635@burratino>
 <20110113022636.GB8635@burratino>
 <buobp3ls9l1.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Alex Riesen <raa.lkml@gmail.com>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jan 13 06:39:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdFuF-0001Ju-7Q
	for gcvg-git-2@lo.gmane.org; Thu, 13 Jan 2011 06:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752314Ab1AMFjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Jan 2011 00:39:10 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48853 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252Ab1AMFjI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jan 2011 00:39:08 -0500
Received: by gyb11 with SMTP id 11so531137gyb.19
        for <git@vger.kernel.org>; Wed, 12 Jan 2011 21:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=xrJhBluMUaw8DdU7NgSm8GOwQp9eDH2PWcx/JBp4iN0=;
        b=I18dSCF22gP3iWJQuHm4t/7yekOODQb7fEnQW37tQ6dkRHPbzJut4CTv6qDsc1F/hP
         iQJb5Clmp6qfjf3OnQq38gA6OBQnpQPu1vq6uoVt1DcCBrm8hdIk4CjdhoNUN+xupEmw
         bz13zL4CghQCLVIhiBiEC20knjP7AveaLDSbg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QqucPMkBlKeYPrYPV5gm502Ha0mBKPxSqp7JLfyYtjRMbkILj9/5I2Bfcy/NmyVYVI
         WEDGyWYJqHpM4covKfClTRO1inalDZSq2pFk0KC1iv3KiRFdQANwEZ83pnUFWzbfPKpQ
         112JWzDFjxQQMpwJqeNXOXfJ1VwFBQtfrsumQ=
Received: by 10.236.111.33 with SMTP id v21mr3464299yhg.64.1294897148046;
        Wed, 12 Jan 2011 21:39:08 -0800 (PST)
Received: from burratino ([69.209.76.37])
        by mx.google.com with ESMTPS id f13sm964913yhf.33.2011.01.12.21.39.04
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 12 Jan 2011 21:39:06 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <buobp3ls9l1.fsf@dhlpc061.dev.necel.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165039>

Miles Bader wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> @@ -1382,7 +1382,9 @@ static int verify_absent_1(struct cache_entry *ce,
>>  		return check_ok_to_remove(ce->name, ce_namelen(ce),
>>  				ce_to_dtype(ce), ce, &st,
>>  				error_type, o);
>> -
>> +	if (errno != ENOENT)
>> +		return error("cannot stat '%s': %s", ce->name,
>> +				strerror(errno));
>>  	return 0;
>
> Is errno guaranteed to be set to something relevant at this point in the
> code...?

Yes, because lstat failed.  But perhaps that is a hint that the code
should be restructured as

	} else if (lstat(... )) {
		if (errno != ENOENT)
			return error(...
		return 0;
	} else {
		return check_ok_to_remove(...
	}

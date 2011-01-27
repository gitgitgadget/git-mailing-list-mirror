From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH jn/fast-import-fix v3] fast-import: treat filemodify with
 empty tree as delete
Date: Wed, 26 Jan 2011 18:26:07 -0600
Message-ID: <20110127002607.GA30911@burratino>
References: <1291286420-13591-1-git-send-email-david.barr@cordelta.com>
 <20110103080130.GA8842@burratino>
 <20110103082458.GC8842@burratino>
 <20110126224104.GA20388@burratino>
 <AANLkTimNWLFgTk0Bueiscw-WkAX53v0Xsepn9esXOt7+@mail.gmail.com>
 <20110126230608.GA26787@burratino>
 <7vd3nji54o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 27 01:32:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiFn5-0002Uv-39
	for gcvg-git-2@lo.gmane.org; Thu, 27 Jan 2011 01:32:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754520Ab1A0Acm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Jan 2011 19:32:42 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55634 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974Ab1A0Acl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Jan 2011 19:32:41 -0500
Received: by vws16 with SMTP id 16so632783vws.19
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 16:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=e6WJ6U4CZ7Bn337n1B0P8VuWgopRPyAYOCaYTxaj+JI=;
        b=CJRNembq1c1qIK+QecPEI0+SeazId7F4+JH/WTL+fn+LC7wEHRpmmbh1zHChpLPq3Q
         z5ydiKUIsz0FfMi5GmBBKugCVt0QYqiuhhi7Z9Zdl9UN1sWD2k2/LVRCEjpbuGW3nG4E
         g9aWp7XXfTOEZgQRgtVMEBI9VyfRT7ZDhFfpI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JR7R7O5BTQV5o9P1VkJCK7UUVbIPpXkCdBalj8eTm4OBiX/9btlSzE/1auG9EcOJ6r
         7nZF0QZX6AGGSrVoJG+49zjDCAzji/bRajd/SR/yIiCVs4WyoDXs5DM+KFQqDXzyLh8f
         l9c0Kjhu0I/7FhTq8msCqD1s915VhMce7VPmo=
Received: by 10.220.179.203 with SMTP id br11mr57646vcb.264.1296087979470;
        Wed, 26 Jan 2011 16:26:19 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id j15sm5090064vcs.20.2011.01.26.16.26.15
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 26 Jan 2011 16:26:17 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vd3nji54o.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165567>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> Hmm.  I suppose on top of b2124125 (jn/fast-import-fix).
>
> Hmm, why not on top of v1.7.3-rc0~75^2 aka 334fba6 (Teach fast-import to
> import subtrees named by tree id, 2010-06-30) then?

That could work, too. ;-)

I was too lazy to check if the test case happens to work in the
absence of the fixes from the fast-import-fix branch.

>> +++ b/fast-import.c
>> @@ -2194,6 +2194,16 @@ static void file_change_m(struct branch *b)
>>  		p = uq.buf;
>>  	}
>>  
>> +	/*
>> +	 * Git does not track empty, non-toplevel directories.
>> +	 */
>> +	if (S_ISDIR(mode) &&
>> +	    !memcmp(sha1, (const unsigned char *) EMPTY_TREE_SHA1_BIN, 20) &&
>
> Do you need this cast?

No, it's not needed.

(EMPTY_TREE_SHA1_BIN is a string constant, originally intended for
use in initializers like

	static const unsigned char empty_tree_sha1[20] = EMPTY_TREE_SHA1_BIN;

memcmp does not care about such considerations.)

From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: gitweb forgets to send utf8 header for raw blob views
Date: Thu, 29 May 2008 13:32:56 +0200
Message-ID: <483E9468.1090300@gmail.com>
References: <alpine.LNX.1.10.0805282002510.19264@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Thu May 29 13:34:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1gOJ-0005DS-Gp
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 13:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbYE2LdD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 07:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbYE2LdD
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 07:33:03 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:13003 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbYE2LdB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 07:33:01 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2014404fgg.17
        for <git@vger.kernel.org>; Thu, 29 May 2008 04:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        bh=/O79gCP748EYca/sgGw2C0jIWHZIyrBliITp30AJWs4=;
        b=IEZQZXFiB8wokR6wodsuZZcxZxNxl8qOGWpe37+2QqTg0CL1iR9HPC3mXjA2BD8KH3LGVATkUtd+foNeFiLpKYP4Jllb/avssP1GWgEPTXFN9dA5zf8Req1T4X50vdzlnCxfwSzLrhoPYiIv1/KkvX5VBl6hWl84G+MOSO9Qnpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=mKY5cxXYsDNRpjdUpSI9vAd0NfpNzyuf+PGk3sdrIwJsid13qpP6V1H5lUi0G5ATfMWKsp9faEDb7NrKNpK/vHd5ipTd/AwJMIUu5/OMRdMkEDIit1UyeXc5yEzdgRWAb1B4CPzaZxA7oiyhrZU6X7yU5d/vxfkb1QnKpqx1Lww=
Received: by 10.86.84.5 with SMTP id h5mr5025958fgb.26.1212060779347;
        Thu, 29 May 2008 04:32:59 -0700 (PDT)
Received: from ?192.168.23.50? ( [91.33.212.111])
        by mx.google.com with ESMTPS id e32sm1366248fke.15.2008.05.29.04.32.57
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 29 May 2008 04:32:58 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <alpine.LNX.1.10.0805282002510.19264@fbirervta.pbzchgretzou.qr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83189>

Jan Engelhardt wrote:
> [utf8 does not work] for raw blob views like
> http://dev.medozas.de/gitweb.cgi?p=hxtools;a=blob_plain;f=bin/git-forest;hb=HEAD

Gitweb should probably not be recoding blobs, so the best I can think of 
is check for UTF-8 validity and add charset=utf-8 in that case (and in 
other cases leave the charset undeclared).

The drawback with that is that we cannot send plain blobs without 
reading them into memory (or reading them twice), since we have to check 
for UTF-8 validity of the whole blob before sending it.  (Gitweb is 
currently reading the whole blob into memory, but that's unnecessary and 
could be changed in the future.)

After my next refactoring, there *might* be some chance to easily 
implement something like "if it's smaller than x KB (e.g. 512), read it 
into memory, check for valid UTF-8 and optionally add charset=utf-8, 
otherwise don't read it into memory and send it without charset=utf-8 
[or perhaps check for BOM presence at the beginning]."  I'll remember 
if/when it comes up in my refactoring and get back to the mailing list 
about it.

-- Lea

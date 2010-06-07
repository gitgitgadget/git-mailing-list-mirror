From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: Explanation for dropping write-back in mmap
Date: Tue, 8 Jun 2010 09:13:14 +1000
Message-ID: <AD1AE06F-0986-46C4-BCEF-A496EB5CEB98@cordelta.com>
References: <AANLkTilrinkNo9awJ9Wso4tXzQKghWEd2bfDRhPHPOga@mail.gmail.com>  <7vbpbmx2er.fsf@alter.siamese.dyndns.org> <AANLkTinJE5blkIRPp5NDKEWVm2uv-Yelt_niYko6XZa_@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 01:13:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLlVY-0007FI-IH
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 01:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950Ab0FGXNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jun 2010 19:13:21 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:52630 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466Ab0FGXNU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 19:13:20 -0400
Received: by pxi8 with SMTP id 8so1327575pxi.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 16:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=e5Joj/DceF1xGrY/8RY2gYY57z5siCHWZYO+WXV/NeY=;
        b=oOdjpJJsjODpZRcKaZax6Ytm5bH7avHBwUuglvFt6hch8lV4lUf6e+P02q9y2np8+K
         91M/bSeeTQevFJIADSwuPbLhK/CUs73H58O2GBcgQgUhu9S0cfGgjbxy1ONwrrw+f/ED
         5NJb+xpiL8yePCfTu0FlwHDi82E71YzFnt7B8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=BL93Bwf7XylnAQS9IAeze0LENXEh7XdUyYoeKonK7+cfK+TTn8gLeEyKF5BcXf8lqZ
         ddBjtYvBFpFFBO2z5tbZ+kKEWi0wsmenCtu/OrDICQnJZOMCyt9A4Ho20w4p4KYcOlth
         OR64KGJP8ONzwiY9WtE4CTJH0y7/13gUwaWoQ=
Received: by 10.142.248.21 with SMTP id v21mr11371719wfh.347.1275952400170;
        Mon, 07 Jun 2010 16:13:20 -0700 (PDT)
Received: from [192.168.123.157] ([121.127.198.196])
        by mx.google.com with ESMTPS id r20sm42743200wam.17.2010.06.07.16.13.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 16:13:19 -0700 (PDT)
In-Reply-To: <AANLkTinJE5blkIRPp5NDKEWVm2uv-Yelt_niYko6XZa_@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148632>

Hi Ram,

> Shawn O. Pearce wrote:
>> I would strongly suggest finding another way to implement the SVN
>> exporter, without using MAP_SHARED.
> 
> David has already started working on using realloc + persist, but I'd
> like to know the reason for your recommendation- is it simply because
> mmap with MAP_SHARED is difficult to port, or is there some other
> reason as well?

I had a think about it, this would be a good chance to enforce append-only writes.
The general strategy would be to write batches of objects for each commit.
All of the data structures in use support this pattern.
However, I'll need to refactor string_pool slightly to make it work cleanly.

> Junio C Hamano wrote:
>> I don't think we _dropped_ a _working_ support that allowed shared
>> mapping.  IIRC the implementation emulated only private mapping well
>> enough to support the use of mmap() in our codebase (iow, instead of
>> allocating a buffer and reading into it and possibly mucking with it
>> without affecting outside world, map it to read and then possibly mucking
>> with it), but lacked input validation to make sure that no caller
>> mistakenly thinks the implementation could satisfy non private mapping.
> 
> Ah, so you did it for safety/ sanity reasons back then.

Having not read the backstory, this was my guess as to the rationale.

--
David Barr.

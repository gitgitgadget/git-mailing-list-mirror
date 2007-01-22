From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] New files in git weren't being downloaded during CVS update
Date: Mon, 22 Jan 2007 10:44:47 +0000
Message-ID: <200701221044.49467.andyparkins@gmail.com>
References: <200701211425.12971.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 22 11:45:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8wfd-00052u-K1
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 11:45:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbXAVKo5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 05:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbXAVKo5
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 05:44:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:18937 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbXAVKo4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 05:44:56 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1016341uga
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 02:44:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AT+i2rRR2pNup5UcZ9zgD5QFdiR0w8vw1ALMGqWcN4jqdv9pESoSJA8BJBgOYBZmi2HyaavU9wsfFiGDIBJ5rkzsiMy7XIKe+koSmPYG6OP4J4TV/KNNVVwHyXOh7gG9e7eIJXYIAIlewrqdMyrl7tPKw6Jh539nY0oSIJuzoa0=
Received: by 10.67.29.12 with SMTP id g12mr7342962ugj.1169462695251;
        Mon, 22 Jan 2007 02:44:55 -0800 (PST)
Received: from davejones ( [194.70.53.227])
        by mx.google.com with ESMTP id o1sm5392772uge.2007.01.22.02.44.52;
        Mon, 22 Jan 2007 02:44:52 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <200701211425.12971.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37404>

On Sunday 2007 January 21 14:25, Andy Parkins wrote:

> This is in response to Simon Schubert's suggestion that T_ADDED is an
> inappropriate category for a remotely added file.  Instead this treats
> remotely added files the same as remotely changed files.

I'm still concerned that this fix is not right.  Having thought more about it, 
I suspect that this breaks the other "added-file" case, where the file is 
added locally but not remotely.

There are three key cases:
 1. File present locally and remotely.  Modified remotely.  Response "U"
 2. File present locally only.  Response should be "A"
 3. File present remotely only.  Response should be "U"

I think the real problem is that both 2 and 3 are being handled in the same 
place.  Hence, my patch, which has fixed case 3; will have broken case 2.

I need a bit of confirmation from Martin; but I suspect that the correct fix 
is something like this:

    elsif ( (!defined($wrev) || $wrev == 0) && !defined($meta->{revision})
    {
        $log->info("Tell the client the file will be added");

If I'm correct, this would only run the added section when there is no 
matching revision in the repository - this would be case 2.  Then case 3 
would be handled as the else to this if, which handles every other case.

My testing of this works, but I'd like confirmation that I'm right in this 
thinking?  Patch to follow...


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com

From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH] rollback index if git-commit is interrupted by a signal
Date: Thu, 29 May 2008 15:19:37 +0200
Message-ID: <483EAD69.9090001@gnu.org>
References: <E1K1eXC-0005xW-Jd@fencepost.gnu.org> <alpine.DEB.1.00.0805291341290.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 29 15:22:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1i3U-0003EG-6R
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 15:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbYE2NTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 09:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752001AbYE2NTk
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 09:19:40 -0400
Received: from gv-out-0910.google.com ([216.239.58.187]:58882 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbYE2NTj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 09:19:39 -0400
Received: by gv-out-0910.google.com with SMTP id e6so1571775gvc.37
        for <git@vger.kernel.org>; Thu, 29 May 2008 06:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        bh=ziYLQWvh1KsXSgRMXPiRprIkl90H6sJNFMdv/P/1l90=;
        b=FwLhi+k1RscfWXKBHU74fHrbkUrZp9CsZe6rdfY5bOSDJ1L5/PgFdoqJPYlDKbjM8cOEEETXdM6AmPdb58L4to4/FLrV5kTbH/mqg8+cEOw1C8Hsj2TwQ1RRPDbGIkLeST8gcd+qkfPDtSWj1a3kz4E8J+nU5gQJcjPbXlR7th4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=c7+guUKKcp1DmLKsCb9nhbXXnYzAO0YS+o4HXmAF5ASoNMbja9En27k7Z/ez0+Bb7nGwPbqlq79ZeJfnjKA4JtGxLCqpC37mdHYXZR98kqyog5XsIpevTGGRSfgJYHMLbdR9aDGwSZlr4FvPfSu4Xy7Ws9Vt30yhe2izLbErRE0=
Received: by 10.103.201.5 with SMTP id d5mr2693587muq.18.1212067176914;
        Thu, 29 May 2008 06:19:36 -0700 (PDT)
Received: from scientist-2.local ( [195.176.178.209])
        by mx.google.com with ESMTPS id e10sm1473092muf.3.2008.05.29.06.19.33
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 29 May 2008 06:19:35 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <alpine.DEB.1.00.0805291341290.13507@racer.site.net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83198>


>>  static void rollback_index_files(void)
>>  {
>> -	switch (commit_style) {
>> -	case COMMIT_AS_IS:
>> -		break; /* nothing to do */
>> -	case COMMIT_NORMAL:
>> -		rollback_lock_file(&index_lock);
>> -		break;
>> -	case COMMIT_PARTIAL:
>> -		rollback_lock_file(&index_lock);
>> -		rollback_lock_file(&false_lock);
>> -		break;
>> -	}
>> +	rollback_lock_file(&index_lock);
>> +	rollback_lock_file(&false_lock);
>>  }
> 
> Your commit message gives _no_ good reason for this change.  As a matter 
> of fact, I imagine that this could be a regression.

Without this change, there could be races between the time the lock file 
is created and the time the commit_style variable is set, leading to the 
rollback not being performed.  You're right however about my sloppiness 
in the commit message: I thought the cover letter did explain this,

	rollback_index_files handles cleanly the case when the lock
	had not been established

but what I meant was *rollback_lock_file* "handles cleanly the case when 
the lock had not been established".  In fact, rollback_lock_file is very 
careful:

         if (lk->filename[0]) {
                 if (lk->fd >= 0)
                         close(lk->fd);
                 unlink(lk->filename);
         }
         lk->filename[0] = 0;

and in turn, lock_file never leaves the filename set

         lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
         if (0 <= lk->fd) {
		...
	}
         else
                 lk->filename[0] = 0;

This has always been like this.  It was there in commit 021b6e45, which 
introduces lockfile.c based on index.c; and it was also there in 415e96c 
which introduced index.c.

Paolo

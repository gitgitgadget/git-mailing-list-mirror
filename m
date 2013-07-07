From: Kyle McKay <mackyle@gmail.com>
Subject: Re: [PATCH 2/2] git-svn: allow git-svn fetching to work using serf
Date: Sat, 6 Jul 2013 19:46:40 -0700
Message-ID: <3871C226-16AE-4E25-8AD3-007EDAB0E25F@gmail.com>
References: <ABDE5FFA-C19F-44BF-A360-3FD5D74F2B28@gmail.com> <20130707002430.GE30132@google.com> <8CACBE8F-8672-43AB-882E-4ADA05B4D822@gmail.com> <20130707022332.GD4193@google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, David Rothenberger <daveroth@acm.org>,
	Petr Baudis <pasky@ucw.cz>,
	Daniel Shahaf <danielsh@apache.org>,
	Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 07 04:46:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvf02-0007Vc-6A
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 04:46:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441Ab3GGCqq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 22:46:46 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:51668 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259Ab3GGCqp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 22:46:45 -0400
Received: by mail-pd0-f174.google.com with SMTP id 10so3015806pdc.19
        for <git@vger.kernel.org>; Sat, 06 Jul 2013 19:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc:x-mailer;
        bh=q0FPk1WMiD584AMWOhum+4kZGAvtU8fghW1+mHhqJP0=;
        b=FkFJrW0paEzLbvvmpsj3z9G2DxzFcpqoVVeH6RbyN3bwjKqYgQi+rZS+7cdXB5Jd3S
         q4cLxxptaBWS0iIi5KCLIJSZTxzg8cpGOYh9JNrT1DojBJ9A1bKnvHb/NiRfexruKs37
         8F4Q9TlvQ+j3GR0bnDBlf4AMBasxNG33rwYy3vNxtaFerG3TtyH6HyehI4WccjpDBkzY
         /ov9MOYZpoKb+GPiX8pCm2/MrhVtoxIfoATXIXRUidT2f5GuGOuQ07mjEpdBFcqqRdn6
         BrururHA1DyA1zPMjQ3jFU3nBZ7Ide8VHgPp5tK/65n7NXUjvOm43rmABX5uSenE5k3z
         jQ5w==
X-Received: by 10.68.201.66 with SMTP id jy2mr15573739pbc.90.1373165204534;
        Sat, 06 Jul 2013 19:46:44 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id we2sm16119099pab.0.2013.07.06.19.46.43
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 06 Jul 2013 19:46:43 -0700 (PDT)
In-Reply-To: <20130707022332.GD4193@google.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229719>

On Jul 6, 2013, at 19:23, Jonathan Nieder wrote:
> Kyle McKay wrote:
>
>> Unless bulk updates are disabled when using the serf access method
>> (the only one available with svn 1.8) for https?: urls,
>> apply_textdelta does indeed get called multiple times in a row
>> without an intervening temp_release.
>
> You mean "Unless bulk updates are enabled" and "without an intervening
> close_file", right?

The problem seems to be skelta mode although it may just be the fact  
that ra_serf has multiple connections outstanding and since ra_neon  
only ever has one it can't happen over ra_neon.

If the server disables bulk updates (SVNAllowBulkUpdates Off) all  
clients are forced to use skelta mode, even ra_neon clients.

> This sounds like something that should be fixed in ra_serf.

Yes, but apparently it will not be.

> But if the number of overlapping open text nodes is bounded by a low
> number, the workaround of using multiple temp files sounds ok as a way
> of dealing with unfixed versions of Subversion.

I believe it will never exceed twice ('svn_delta...' and  
'git_blob...') the maximum number of serf connections allowed.  Four  
by default (hard-coded prior to svn 1.8).  Limited to between 1 and 8  
on svn 1.8.  Actually it looks like from my testing that it won't ever  
exceed twice the (max number of serf connections - 1).

Kyle

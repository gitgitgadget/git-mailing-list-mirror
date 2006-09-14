From: "Rajkumar S" <rajkumars+git@gmail.com>
Subject: Re: cvsimport fails with cvsps core dump
Date: Thu, 14 Sep 2006 12:52:25 +0530
Message-ID: <64de5c8b0609140022q1b645416kfcc4012145fb5085@mail.gmail.com>
References: <64de5c8b0609120914p4ea47860x60a294093d43bc24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 14 09:22:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNlYN-00023J-B1
	for gcvg-git@gmane.org; Thu, 14 Sep 2006 09:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWINHW2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Sep 2006 03:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWINHW2
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Sep 2006 03:22:28 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:50842 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751396AbWINHW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Sep 2006 03:22:27 -0400
Received: by nz-out-0102.google.com with SMTP id n1so1112845nzf
        for <git@vger.kernel.org>; Thu, 14 Sep 2006 00:22:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ZLSpM3YKrrwYsHNPwaDeCJMuXN/qU2vdseJ+ChfTgemxzX/mZPYR6IrUfdB/7kpZRqru/vUg24gKyv99qwRHKN5zA8IAyXgQiDEjuHmz9N+4ft7EXHAE6aopQ4ruDIRNp9gaV+ck350YIApZizR0vOizt94olUSoX6uBq3TwF0o=
Received: by 10.65.122.15 with SMTP id z15mr9708842qbm;
        Thu, 14 Sep 2006 00:22:27 -0700 (PDT)
Received: by 10.65.248.1 with HTTP; Thu, 14 Sep 2006 00:22:25 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <64de5c8b0609120914p4ea47860x60a294093d43bc24@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: aaeeef1f8bdeae08
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26990>

On 9/12/06, Rajkumar S <rajkumars+git@gmail.com> wrote:
> While trying to cvsimport pfsense [1] source [2], cvsps coredumps and
> cvsimport aborts with the following error.

the function read_line does not check if the string is bigger that the
space alloted, and core dumps when such a string is encountered.

I have a small patch which prevents the crashing, by stopping the copy
when the buffer is full.

diff --git a/cvs_direct.c b/cvs_direct.c
index 920487d..3857ce2 100644
--- a/cvs_direct.c
+++ b/cvs_direct.c
@@ -679,8 +679,11 @@ static int read_line(CvsServerCtx * ctx,
        }
        p++;
        len++;
+       if (len >= BUFSIZ){
+           *p = 0;
+           break;
+       }
     }
-
     return len;
 }

raj

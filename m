From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] xread(): Fix read error when filtering >= 2GB on Mac OS X
Date: Sat, 17 Aug 2013 13:25:45 -0700
Message-ID: <0EC822B9-E5BB-4FF5-B054-167866EA2075@gmail.com>
References: <1376743205-12618-1-git-send-email-prohaska@zib.de>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sat Aug 17 22:28:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAn6e-0003P1-2D
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 22:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754592Ab3HQUZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Aug 2013 16:25:49 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:57951 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab3HQUZs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Aug 2013 16:25:48 -0400
Received: by mail-pa0-f46.google.com with SMTP id fa1so3202287pad.33
        for <git@vger.kernel.org>; Sat, 17 Aug 2013 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=i9EafC4e4FRBxNZc5GzzarOSKsefj5njwhag1ucHs2Y=;
        b=OPGvYu2+J4odm3REaRl2HnI2oIE+CA2MtEYPdIWSNQhApPr0ThE0vmUozvjx+1iHkU
         f1hGmCQy2MabNGPR1zhSikP8hAUOW/Anfcixptej4uNAwmGz7/VT4QanoWYL8QMBRSZN
         NdBfeqV7fU6b0L7ec4hG6H0kyNfpY/YSQdqNaNrPUCIPN4i+XBnT0SN/pAUr7C68LilU
         5iintKz4JBqg2wNU68WsgGhbb4x1txaE/pJe1Z61OZRs6vzvPvEnxFnyW8ykkcBpD7UP
         Os+T+JOeHXav7Tknof9ARw47Q2sKmZJOlACXuLnsBSQ6L4kXMn6qC89guM8wDFit+nOB
         LSig==
X-Received: by 10.66.175.133 with SMTP id ca5mr4570938pac.40.1376771148058;
        Sat, 17 Aug 2013 13:25:48 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id bg3sm5364304pbb.44.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 17 Aug 2013 13:25:47 -0700 (PDT)
In-Reply-To: <1376743205-12618-1-git-send-email-prohaska@zib.de>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232469>

On Aug 17, 2013, at 05:40, Steffen Prohaska wrote:

> Previously, filtering more than 2GB through an external filter (see
> test) failed on Mac OS X 10.8.4 (12E55) with:
>
>    error: read from external filter cat failed
>    error: cannot feed the input to external filter cat
>    error: cat died of signal 13
>    error: external filter cat failed 141
>    error: external filter cat failed
>
> The reason is that read() immediately returns with EINVAL if len >=  
> 2GB.
> I haven't found any information under which specific conditions this
> occurs.

According to POSIX [1] for read:

If the value of nbyte is greater than {SSIZE_MAX}, the result is  
implementation-defined.


The write function also has the same restriction [2].

Since OS X still supports running 32-bit executables, and SSIZE_MAX is  
2GB - 1 when running 32-bit it would seem the same limit has been  
imposed on 64-bit executables.  In any case, we should avoid  
"implementation-defined" behavior for portability unless we know the  
OS we were compiled on has acceptable "implementation-defined"  
behavior and otherwise never attempt to read or write more than  
SSIZE_MAX bytes.

[1] http://pubs.opengroup.org/onlinepubs/009695399/functions/read.html
[2] http://pubs.opengroup.org/onlinepubs/009695399/functions/write.html

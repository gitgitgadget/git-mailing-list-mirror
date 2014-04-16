From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH 1/3] rebase: avoid non-function use of "return" on FreeBSD
Date: Tue, 15 Apr 2014 21:32:40 -0700
Message-ID: <FAD02895-24B2-46C3-ABEF-E9CE17926FF9@gmail.com>
References: <438458da797bcab97449bfa931a9d1d@74d39fa044aa309eaea14b9f57fe79c> <0779303f7d2257a618b5bed00260a8a@74d39fa044aa309eaea14b9f57fe79c> <xmqqob03le3v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 06:32:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaHWl-0003ep-HW
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 06:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbaDPEcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 00:32:46 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:48942 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbaDPEco (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Apr 2014 00:32:44 -0400
Received: by mail-pd0-f180.google.com with SMTP id v10so10282859pde.39
        for <git@vger.kernel.org>; Tue, 15 Apr 2014 21:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=VeYNKDVbR9kXLIBgyHf/wywXtRm2YqUU3qe+ukIw5gg=;
        b=nrf3EZ3m3pQ+BgFI/ghkNcLuU35E9pP9Wgz9/m4vC0ZuH9rD92HugXLMyxMRgjCt4W
         yTffpYCknuK49nREISa6HIOCkvO2W10ed/6heN3tRSqYKAbSSc1pmo1Ycsg7ZCiISQ08
         SQAIbpHl5V9Dhm1606zjz/1O/eenQhiyjvrxIjOw/cuLAfgOqWMQlDcOpXZS3EpQUJH4
         0+3wTKXAMTO2bx8iZo+IDmrkJHh8+q6Ik9H2lecEsIrAe6ZwyOj/LN83SdhiGwk40yRh
         I92gfBhW92tP5dzbip8tsH1+WGCgpwI7WQYjzl629AXkvHqkayJBKxxgNkPOIqkSDe8X
         PK3Q==
X-Received: by 10.68.197.66 with SMTP id is2mr6187741pbc.96.1397622763774;
        Tue, 15 Apr 2014 21:32:43 -0700 (PDT)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ei4sm43891795pbb.42.2014.04.15.21.32.42
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 15 Apr 2014 21:32:42 -0700 (PDT)
In-Reply-To: <xmqqob03le3v.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246314>

On Apr 14, 2014, at 15:51, Junio C Hamano wrote:
> I think we would want to see the actual change formatted this way
> (without needing to pass "-w" to "git show"), as it will make it
> clear that this artificial extra level of "define the whole thing
> inside a function and then make a single call to it" is a workaround
> of specific shell's glitch that we would not have to have in an
> ideal world ;-)
>
> Besides that would make it less likely to cause conflicts with the
> real changes in flight.

Sounds good to me.

> Please double check what I queued on 'pu' when I push out today's
> integration result.

> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index a4f683a5..2ab514ea 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -4,6 +4,13 @@
>  # Copyright (c) 2010 Junio C Hamano.
>  #
>
> +# The whole contents of the file is run by dot-sourcing this file  
> from
> +# inside a shell function, and "return"s we see below are expected to
> +# return from that function that dot-sources us.  However, FreeBSD
> +# /bin/sh misbehaves on such a construct, so we will work it around  
> by
> +# enclosing the whole thing inside an extra layer of a function.
> +git_rebase__am () {

I think the wording may be just a bit off:

> and "return"s we see below are expected to return from that function
> that dot-sources us.

I thought that was one of the buggy behaviors we are working around?

Maybe I'm just reading it wrong...

Does this wording seem any clearer?

	and "return"s we see below are expected not to return
	from the function that dot-sources us, but rather to
	the next command after the one in the function that
	dot-sources us.

Otherwise the patch in pu looks fine (all t34*.sh tests pass for me on  
FreeBSD with pu at 8d8dc6db).

Thank you for adding the comments.

If I'm the only one getting a wrong meaning from the comments, then no  
reason to change them.

--Kyle

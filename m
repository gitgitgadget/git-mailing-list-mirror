From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] transport-helper: check when helpers fail
Date: Mon, 22 Oct 2012 16:31:22 +0200
Message-ID: <CAMP44s1m9eVqqrgJFuWOBa3DCZAzAqpVwG8Nxn-6MbXWbF_2fw@mail.gmail.com>
References: <1350847158-14154-1-git-send-email-felipe.contreras@gmail.com>
	<5084E931.3010809@viscovery.net>
	<CAMP44s2XDkLhKkqvxnGH+U5X=42dXU1550xVQvyQk=WD2p0c6Q@mail.gmail.com>
	<50854E20.1040303@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:31:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQJ2U-0000VV-QO
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 16:31:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353Ab2JVObY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 10:31:24 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:50056 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753871Ab2JVObX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 10:31:23 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so2457412oag.19
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 07:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=S2uZ8SlYZ1DPQ4g2hmJsP4criWUutLFwInyPfv6X4CI=;
        b=WIg+ynMlf8v9/KS3XZJF0+yQ1oQ0ZV0nCwO6LP0y5e6LQ2HrXnYXDxrSXs5y+1UeXF
         hovzWlI14RX5wpkz93YexYA7i0RWxqk1mvTi1JEIhwdiNLRm/6bQF09RgzaIJwSls6kF
         MWvRBLEuzwca09h8m9aFq2wljL+Vyu/btlxonp+hdfNzjXadTJeA70j821ibJyW+7byJ
         hk64t2cRx+AM0CX+yTE7aFc7A8R2NB+bJxerNx96JYt4Z+yyD48zjvvwcQ8pYz9byWZN
         qe+GILjRWlU1ZnAWbIH/FPnvXE+rulgkqY+Ht4iBSUYNLeHbPgNS9rPbgkOy+VOdm1FJ
         v92A==
Received: by 10.60.32.19 with SMTP id e19mr8536876oei.9.1350916282651; Mon, 22
 Oct 2012 07:31:22 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Mon, 22 Oct 2012 07:31:22 -0700 (PDT)
In-Reply-To: <50854E20.1040303@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208190>

On Mon, Oct 22, 2012 at 3:46 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 10/22/2012 13:50, schrieb Felipe Contreras:
>> On Mon, Oct 22, 2012 at 8:35 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Another thought: In your use-case, isn't it so that it would be an error
>>> that the process exited for whatever reason? I.e., even if it exited with
>>> code 0 ("success"), it would be an error because it violated the protocol?
>>
>> How is that violating the protocol?
>
> Because the helper stops talking too early. But as I said, I actually
> don't know the protocol.

We could use the 'feature done' of fast-import, but this causes
problems because of the way transport-helper uses it:

-> import refs/heads/master
<- exported stuff
<- done
-> import refs/heads/devel
<- exported stuff
<- done

'done' will terminate the fast-import process, so the second exported
stuff won't be processed; the fast-import process is reused.

For some reason remote-testgit doesn't exercise this multiple import
stuff properly, but my remote-hg certainly does, so I can't just say
'done'.

It would be much better if the transport-helper protocol was something
like this:

-> import-begin
<- feature X
<- feature Y
-> import refs/heads/master
<- exported stuff
-> import refs/heads/devel
<- exported stuff
-> import-end
<- done

This would certainly makes things easier for transport-helpers that
support multiple ref selections (like my remote-hg). Maybe I should
add code that does this if certain feature is specified (so it doesn't
break other helpers)

But at least on my tests, even with 'feature done' the crash is not
detected properly, either by the transport-helper, or fast-import.

And also, the msysgit branch does the same check for fast-export,
which actually uses the 'done' feature always, so it should work fine,
but perhaps because of the strange issue with fast-import I just
mentioned, it's not actually detected. I should add tests for this
too.

> I was just infering what I saw in transport-helper.c: get_helper() dup's
> the output of the helper process and stores it in data->out (after
> fdopen()ing on it). (The original file descriptor is handed over to
> fast-import or fast-export.)
>
> Actually, I didn't find a spot where data->out was used except to fclose()
> it. But I take it that there is a reason that it exists and infer that
> further output from the helper is expected by something after fast-import
> or fast-export have exited.
>
> But I may be completely off...

Yes, further output is expected, or at least in theory.

Cheers.

-- 
Felipe Contreras

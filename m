From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Makefile: fix misdetection of relative pathnames
Date: Thu, 05 Feb 2009 17:16:13 -0500
Message-ID: <498B652D.8060708@gmail.com>
References: <4985E8E1.90303@gmail.com> <7vhc39guv2.fsf@gitster.siamese.dyndns.org>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>, Pascal Obry <pascal@obry.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 23:17:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVCXY-0006fE-Qe
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 23:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbZBEWQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 17:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752645AbZBEWQS
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 17:16:18 -0500
Received: from yx-out-2324.google.com ([74.125.44.28]:38618 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbZBEWQR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 17:16:17 -0500
Received: by yx-out-2324.google.com with SMTP id 8so223252yxm.1
        for <git@vger.kernel.org>; Thu, 05 Feb 2009 14:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id
         :disposition-notification-to:date:from:reply-to:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=6jwAjShapSlhbTXlRsJQrXZa32hNGmyNh3y6UD7kjV0=;
        b=Fkf9++KynX8lazlZ61bnUFf4Z/oqziw4pdpyF4WmHxRbrWNqWfQZ7kpFwf8tu2Im4Y
         G+mk8PWw0PdAleuDjoTWvaJQ/CnqWO2JV9TQQMa+w5F+tdV3i/U3pk49NMffuIo8HD/N
         7tGmUiiSk0rrF4mDr6muezfE6konTlkn1r/G0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:disposition-notification-to:date:from:reply-to
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        b=faEsGy+L9wfWeKkQGbveYcLL4C9lmAzEUcNrAw46zQglKRL7n90fLxW4Ft57qO1Z1s
         L+1DXOMY6B/bLp6iG2+Xmvs6ejiIsIhaplUDqtG2EE3axprb6XaHxD7/CDlPH/PlxqJx
         72B4mJKsm8P3DEGe0JhfKsruxP4K2NRk7z6Nk=
Received: by 10.100.137.12 with SMTP id k12mr555652and.124.1233872175599;
        Thu, 05 Feb 2009 14:16:15 -0800 (PST)
Received: from ?10.0.0.6? (c-66-177-19-100.hsd1.fl.comcast.net [66.177.19.100])
        by mx.google.com with ESMTPS id b32sm2004084ana.55.2009.02.05.14.16.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 05 Feb 2009 14:16:15 -0800 (PST)
User-Agent: Thunderbird 1.5.0.10 (X11/20060911)
In-Reply-To: <7vhc39guv2.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108630>

Junio C Hamano wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
> 
>> In 026fa0d5ad9538ca76838070861531c037d7b9ba, "Move computation of
>> absolute paths from Makefile to runtime (in preparation for
>> RUNTIME_PREFIX)", the following change was made to the Makefile. The
>> problem is that $(abspath names...) is a relatively recent addition to
>> GNU make and when used in an older GNU make, the test always fails
>> resulting incorrect installation dirs for the templates and commands.
>>
>> The new test is also wrong; (for *nix systems) in that it really wants
>> to test if the first character is a '/'
> 
> Ok, here is the final one from me that I am considering to commit, but it
> would be nice to hear success/failure feedback from people who had trouble
> with Steffen's changes.  I'd also like to hear from people who have been
> happy with Steffen's changes that this does not break things for them.
> 
> -- >8 --
> 
> The installation rules wanted to differentiate between a template_dir that
> is given as an absolute path (e.g. /usr/share/git-core/templates) and a
> relative one (e.g. share/git-core/templates) but it was done by checking
> if $(abspath $(template_dir)) and $(template_dir) yield the same string.
> 
> This was wrong in number of ways.
> 
>  * The user can give template_dir with a trailing slash from the command
>    line to invoke make, or in the included config.mak.  A directory path
>    ought to mean the same thing with or without such a trailing slash but
>    use of $(abspath) means with an absolute path with a trailing slash
>    fails the test.
> 
>  * The compilation could be done inside /usr directory with a relative
>    pathname share/git-core/templates and it will be mistaken as an
>    absolute path.
> 
>  * Versions of GNU make older than 3.81 do not have $(abspath) to begin
>    with.
> 
> This changes the detection logic to see if the given path begins with a
> slash.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Tested-by: A Large Angry SCM <gitzilla@gmail.com>

From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH 00/28] clean-ups of static functions and returns
Date: Mon, 14 Aug 2006 16:30:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608141618470.21705@chino.corp.google.com>
References: <Pine.LNX.4.63.0608141314350.19383@chino.corp.google.com>
 <7vlkpqdikx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 01:31:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCltp-0003Cm-BZ
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 01:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965061AbWHNXbJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 19:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965063AbWHNXbJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 19:31:09 -0400
Received: from smtp-out.google.com ([216.239.45.12]:49397 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP id S965061AbWHNXbI
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 19:31:08 -0400
Received: from zps35.corp.google.com (zps35.corp.google.com [172.25.146.35])
	by smtp-out.google.com with ESMTP id k7ENUrDq006300;
	Mon, 14 Aug 2006 16:30:53 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:cc:subject:in-reply-to:
	message-id:references:mime-version:content-type;
	b=iGq4t9vk4qExLTsx2q/W8iH3QcxpZSRe8+E2ykURJsTQk/MZTfbHTpe6W/nBOiGI/
	+NklKPiycLjNZwuo34Anw==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps35.corp.google.com with ESMTP id k7ENUqrs027000;
	Mon, 14 Aug 2006 16:30:52 -0700
Received: by localhost (Postfix, from userid 24081)
	id 1E5A187D71; Mon, 14 Aug 2006 16:30:51 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id AFB6A87D70;
	Mon, 14 Aug 2006 16:30:51 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkpqdikx.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25424>

On Mon, 14 Aug 2006, Junio C Hamano wrote:

> Interesting.  Did you use some automated tool to spot them?
> 

No, these changes are from my own personal tree that optimizes everything for 
speed since I am working with terabytes of data.  I only submitted changes that 
I thought would be beneficial for your project as well.

>  * Making stricter error checking in the future harder.  There
>    are three classes, but the lines between them are fuzzy.
> 
>         [PATCH 04/28] builtin-diff.c cleanup
>         [PATCH 06/28] make cmd_log_walk void
>         [PATCH 07/28] builtin-mailinfo.c cleanup
>         [PATCH 09/28] makes prune_dir void
>         [PATCH 11/28] makes append_ref and show_indepedent void
>         [PATCH 12/28] makes generate_tar void
>         [PATCH 13/28] builtin-unpack-objects.c cleanup
>         [PATCH 14/28] make do_reupdate void
>         [PATCH 16/28] daemon.c cleanup
>         [PATCH 17/28] makes diff_cache void
>         [PATCH 19/28] makes finish_pack void
>         [PATCH 20/28] makes fetch_pack void
>         [PATCH 23/28] makes peek_remote void
> 
>    The callers of the first group check their return values, so
>    we could make error checking of these functions stricter in
>    the future without affecting the rest of the code.  The ones
>    that currently die() (or usage()) could be made into more
>    libified form to return error codes.
> 
>    So I do not think it is worth doing these.
>    

I disagree.  Having static functions return ints that are the same for _every_ 
code path and are checked against upon return is never good style.  It implies 
that error checking is already done and the return value is of importance.  It 
also suggests you can program against a specific return value with expected 
results which are, in fact, true for any return.  Additionally, changes in the 
future will be easier, in my opinion, because a void -> int change is very 
simple and existant calls need not be changed (their return values are 
discarded) so that the implementer can make the checks where necessary.

I do not understand your point about making error checking of the functions 
stricter without affecting the rest of the code when int returns are discarded 
if not assigned upon return.  It would certainly be bad style to declare new 
error codes with a specific meaning without checking all the affected code and 
we certainly cannot predict this behavior now.

		David

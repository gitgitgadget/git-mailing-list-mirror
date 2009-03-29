From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/2] send-email: refactor and ensure prompting doesn't 
	loop forever
Date: Sat, 28 Mar 2009 21:48:29 -0400
Message-ID: <76718490903281848l5102afc3x89eed40ed6083dcc@mail.gmail.com>
References: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 29 03:50:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnkAF-0006Ji-Qh
	for gcvg-git-2@gmane.org; Sun, 29 Mar 2009 03:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbZC2Bsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 21:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753038AbZC2Bsc
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 21:48:32 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:29882 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380AbZC2Bsc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 21:48:32 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1501034yxl.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 18:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vMWCqzRGOqsLzVJ5J2wWe80LeUjsYBYQjz0JGE4zksc=;
        b=vZlSj8MxuAa1+cLu8JXFOXiQp9EO71ZQmMMMISmT2c84eae6WU9hH4Wv5HKa/3JapU
         L/Yqx00XK2RQGN4lDkuDGQftvCaUEka+S4EFpU3fpWiOWzlcGLFhex7zmQhfI+hZ6Rhr
         DyJ+xR50UIl8KkboAs3+7Fiqi3xRLAO04cArI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xN2FT7HHuKV5lO+srVOSyxryJ3Ox5LVEoRwrmPilXDoLD4gk7m6xgU7Ch523oqpZY2
         FFV1+fh1vRCfwoSeeRF77D593ibshykreovINXOc7sXWfiSSYMDaNS5nTCRN+kZ7kaTt
         dK8InrmI2t9stisXyN9Y0yMhLTtVMS+/deKlY=
Received: by 10.150.133.13 with SMTP id g13mr7261827ybd.232.1238291309864; 
	Sat, 28 Mar 2009 18:48:29 -0700 (PDT)
In-Reply-To: <1238290751-57461-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114996>

On Sat, Mar 28, 2009 at 9:39 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> There are three callers of the function:

Where by "three" I mean "four". Please use this commit message instead:

---snip---
Several places in send-email prompt for input, and will do so forever
when the input is EOF. This is poor behavior when send-email is run
unattended (say from cron).

This patch refactors the prompting to an ask() function which takes a
prompt, an optional default, and an optional regex to validate the
input. The function returns on EOF, or if a default is provided and the
user simply types return, or if the input passes the validating regex
(which accepts all input by default). The ask() function gives up after
10 tries in case of invalid input.

There are four callers of the function:

1) "Who should the emails appear to be from?" which provides a default
sender. Previously the user would have to type ctrl-d to accept the
default. Now the user can just hit return, or type ctrl-d.

2) "Who should the emails be sent to?". Previously this prompt passed a
second argument ("") to $term->readline() which was ignored. I believe
the intent was to allow the user to just hit return. Now the user
can do so, or type ctrl-d.

3) "Message-ID to be used as In-Reply-To for the first email?".
Previously this prompt passed a second argument (effectively undef) to
$term->readline() which was ignored. I believe the intent was the same
as for (2), to allow the user to just hit return. Now the user can do
so, or type ctrl-d.

4) "Send this email?". Previously this prompt would loop forever until
it got a valid reply. Now it stops prompting on EOF or a valid reply. In
the case where confirm = "inform", it now defaults to "y" on EOF or the
user hitting return, otherwise an invalid reply causes send-email to
terminate.

A followup patch adds tests for the new functionality.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---snip---

Thanks,

j.

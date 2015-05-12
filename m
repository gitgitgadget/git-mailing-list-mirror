From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 13:07:06 -0700
Message-ID: <xmqqh9rhftlh.fsf@gitster.dls.corp.google.com>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
	<1431384645-17276-4-git-send-email-dturner@twopensource.com>
	<xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
	<1431455779.16652.20.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 12 22:07:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsGSQ-0006Sm-Nr
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 22:07:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933699AbbELUHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 16:07:10 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:32898 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753748AbbELUHI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 16:07:08 -0400
Received: by iebgx4 with SMTP id gx4so12337450ieb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 13:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=sttGOfP5h61YY0L8QhDsdcHh+Rs6MQc+heCVe1MnFVk=;
        b=sI2Dd8jkBQVdXZw/BzNZUn0OLBGGhAHpfhy1k0aof+VvfBgxjlidtD9KuacoMMPFWi
         xYNwHOW8G7KrK6mskcgIL/OxdmboZ/UW28XwwfM0xRutNNzZQt4bkiyNPAhpKsAFctRq
         ARNtLDHku8E/nfInwuTcCphDgeRtTp8OybTZcnnWRDl8fJKCkN8Kst+YFGoQcJ2ClzDQ
         Oq/2feRZUl9XPzwAcuwqUZ7Vcp1qYI2SavDI7X0Oi5QrEMAVVpMI6GneF2Fn8JPX8aeS
         2rF1BVeh6H8xjCDS0Y1SPLzZd4I42pQtSb0brQGOU0sk8DCVMQujIUdYXOYbiTGNWseB
         ZQgA==
X-Received: by 10.42.149.136 with SMTP id w8mr2809619icv.18.1431461228116;
        Tue, 12 May 2015 13:07:08 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id i185sm12595286ioi.24.2015.05.12.13.07.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 13:07:07 -0700 (PDT)
In-Reply-To: <1431455779.16652.20.camel@ubuntu> (David Turner's message of
	"Tue, 12 May 2015 14:36:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268878>

David Turner <dturner@twopensource.com> writes:

>>  * I am not sure if HEAD:link that points at HEAD:link should be
>>    reported as "missing".  It may be better to report the original
>>    without any dereferencing just like a link that points at outside
>>    the tree? i.e. "symlink 4 LF link".
>
> Unfortunately, a symlink loop might include relative symlinks
> (e.g. ../a).  If we return a relative symlink, the user will
> not be able to distinguish it from a non-loop, out-of-tree symlink.  So
> I think we may not return symlink 4 LF ../a for these cases.  

I do not follow.  Let's start from a shared example.

    HEAD:sub/link is a symbolic link whose value is ../nextlink
    HEAD:nextlink is a symbolic link whose value is sub/link

That's a loop.  Now, I think what I am sugesting is

	$ git cat-file --batch-check --follow-symlinks <<\EOF
	HEAD:sub/link
        HEAD:nextlink
	EOF
	symlink ../nextlink
        symlink sub/link

If you asked about sub/link and then got ../nextlink back, then
isn't it clear for the reading script that it is about nextlink
at the top-level?  Why can't it tell it from out-of-tree link?


	

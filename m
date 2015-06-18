From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] format-patch: introduce format.outputDirectory configuration
Date: Thu, 18 Jun 2015 13:05:55 -0700
Message-ID: <xmqqoakceq8s.fsf@gitster.dls.corp.google.com>
References: <1434626280-4610-1-git-send-email-kuleshovmail@gmail.com>
	<xmqq616ley7y.fsf@gitster.dls.corp.google.com>
	<20150618195751.GA14550@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 18 22:06:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g4Z-0000TB-97
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:06:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756915AbbFRUF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:05:59 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38371 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752764AbbFRUF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:05:57 -0400
Received: by igblz2 with SMTP id lz2so3309245igb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 13:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=pTPoLYMqEP0uDewLlc6oeTIpZibucdHAKM+/6Lo/LwE=;
        b=ZavgdgJcomlsqLqhkbkl+d/SRpVPfsTd0vK1ghrIspuRtwDn4sZG5iFLWto/S+g2wh
         XtZdfzk1RDphUJiPC1mJl8LmnNo3Ko5qxuWn31BT+4sQfYInPRqK8DCfj/OeC62QwGHw
         UqPGN1Su2J/nZCzUoeLkgzTqjTpctuPXVJJk8Au1kP490zzV+nc1d0ofYkD2UmhVIYwZ
         EBqgOpz/5eeI/78T6+NDmM9uxtB8WxIeygJGRIFJSTzTflHbzV9i9t8Tn4SWSxgkLA/0
         1WtHrF0HWeUZIfUEOSWV18yYlB2db3Kn73e/wpx1jguGnJf4Nj9yWUT7xH4iZG7rFjW2
         9tnA==
X-Received: by 10.50.43.227 with SMTP id z3mr20251066igl.12.1434657956978;
        Thu, 18 Jun 2015 13:05:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id 140sm5588470ion.16.2015.06.18.13.05.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 13:05:56 -0700 (PDT)
In-Reply-To: <20150618195751.GA14550@peff.net> (Jeff King's message of "Thu,
	18 Jun 2015 15:57:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272040>

Jeff King <peff@peff.net> writes:

>> This change looks ugly and unnecessary.  All the machinery after and
>> including the point set_outdir() is called, including reopen_stdout(),
>> work on output_directory variable and only that variable.
>> 
>> Wouldn't it work equally well to have
>> 
>> 	if (!output_directory)
>>         	output_directory = config_output_directory;
>> 
>> before a call to set_outdir() is made but after the configuration is
>> read (namely, soon after parse_options() returns), without making
>> any change to this function?
>
> Don't we load the config before parsing options here? In that case, we
> can use our usual strategy to just set output_directory (which is
> already a static global) from the config callback, and everything Just
> Works.
>
> We do have to bump the definition of output_directory up above the
> config callback, like so (while we are here, we might also want to
> drop the unnecessary static initializers, which violate our style guide):

You would also need to remove the "oh you gave me -o twice?" check,
and change the semantics to "later -o overrides an earlier one",
wouldn't you?  Otherwise you would never be able to override what
you read from the config, I am afraid.

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: enhanced remote ref namespaces
Date: Wed, 12 Aug 2015 11:54:35 -0700
Message-ID: <xmqqegj8l4lw.fsf@gitster.dls.corp.google.com>
References: <CA+P7+xocd+LE2A+srH0p1qTuXKRXanTp5E+imC1GE+9-biqR6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Jeff King <peff@peff.net>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 20:54:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPbAg-0005xp-6T
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 20:54:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbbHLSyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 14:54:38 -0400
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35513 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751321AbbHLSyh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 14:54:37 -0400
Received: by pdrg1 with SMTP id g1so10155560pdr.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 11:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=vVKvW9zckdhqnUJgp/YdLelOotRxUWWriQRb7ZiYMZY=;
        b=U5Ywcsn7YL/EoH9M28pCz8J3S978jXqoS/A1vPLnqA8PJC/DObnmsz8ZHF6WgEuEZL
         TVKq0Aos3lzsBodbdk35O33qbPsXeWmPo3wKYt1O3fA6N2qnWxFvNCyqV3fqwJUFVd2W
         5fdbaqI+gfX8kBSf+9fj3AAAttQzrDfTAWPvM3uz13vchy5u0Voqp7RabRozEiJiDHxu
         jd1QYnlQRYlFnNBenr0zoGTZnEvArdRuvGYH9eYbQh+hiZ+9C0E76XjIjp57wMdXEw2c
         9V3ONyVILSKBWoHTECOQRgsEcVAuGnZ42JroDvjZPeJJmicM6mWqiK4rZ3uaMmy2+VMR
         fu8A==
X-Received: by 10.70.52.97 with SMTP id s1mr70819586pdo.167.1439405676940;
        Wed, 12 Aug 2015 11:54:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id tg5sm7347774pab.1.2015.08.12.11.54.36
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 11:54:36 -0700 (PDT)
In-Reply-To: <CA+P7+xocd+LE2A+srH0p1qTuXKRXanTp5E+imC1GE+9-biqR6A@mail.gmail.com>
	(Jacob Keller's message of "Wed, 12 Aug 2015 11:34:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275795>

Jacob Keller <jacob.keller@gmail.com> writes:

>> Just thinking aloud, perhaps we can introduce a brand new top level
>> hierarchy refs/remote/$O/{heads,tags,notes,...}, and give backward
>> compatibility by making a moral equivalent of a symbolic link from
>> refs/remote/$O/heads to refs/remotes/$O/.  The true remote-tracknig
>> refs continue to live in refs/remotes/$O/* and old tools that do not
>> know the new layout would not be hurt.  New tools that want to
>> ignore and look only at refs/remote/$O/* can do so through the moral
>> equivalent of a symbolic link.  "remote remove" needs to be taught
>> about this single exception (i.e. "the symbolic link"), but the
>> places it needs to touch is limited only to two places and will not
>> grow.
>
> I think this proposal makes the sense..  I'd go with something like:
>
> refs/tracking/<origin>/(heads|tags|notes|replace|etc)/*
>
> with a symlink from or into
>
> refs/tracking/<origin>/heads -> refs/remotes/<origin>

I actually do not think we even need the "symlink" thing.

We can just say refs/remotes/$O has been and forever will be where
the remote-tracking branches will live.  With or without the symlink
for backward compatibility, the updated Git will need to be aware of
the two places to deal with older and newer repositories anyway.

"everything is now under refs/tracking/$O, not spread over many
unbounded number of places like refs/remotes-$foo/$O" may appear to
be cleaner but two is already not too bad and will greatly reduce
the transition pain.

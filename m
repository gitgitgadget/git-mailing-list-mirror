From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/6] remote.c: introduce a way to have different remotes
 for fetch/push
Date: Fri, 22 Mar 2013 16:41:08 -0700
Message-ID: <20130322234108.GL12223@google.com>
References: <1363938756-13722-1-git-send-email-artagnon@gmail.com>
 <1363938756-13722-5-git-send-email-artagnon@gmail.com>
 <20130322212159.GJ12223@google.com>
 <7vli9f5bho.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 00:41:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJBaf-0001nB-9I
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 00:41:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655Ab3CVXlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 19:41:14 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36190 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565Ab3CVXlN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 19:41:13 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl13so148996pab.4
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 16:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=l/IlyGjuyYrFGOWM7kfdvc8FPHFGK1UhXjG1zglNxy8=;
        b=GSc2z1Rpj/wjO8DXTbbDL42EZ75YAf7WoJLlAhmJ4Y2zd4zum/ZGkvg/rVvPMgOZ2E
         N97BTwQZsYSyDMxBSxS3s65aHvi5xGzJR24EFXqHndZYOgx8hqWmFTEfnBkd2736A2N8
         2Mqv4E60b+91AY+FNymhGynnw9e1RVW3HqxA/yylI4/SN3hgJxrawSHE0h1j8LUN0Kxv
         /exIRZ3RI9K21tF9KEmMdBb2iILg3r0CXE5S9tWTGPk0tistepN9CdngLoKDyIdBtDgZ
         blsZMrTLo+j569wOkNcOtquq9xpfO5JOO2M5fRNkZZ/FCGK5cdQIW+XYvbWWSmJ2+O+H
         hsRQ==
X-Received: by 10.66.163.69 with SMTP id yg5mr5936167pab.109.1363995672938;
        Fri, 22 Mar 2013 16:41:12 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPS id ip8sm3917180pbc.39.2013.03.22.16.41.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 16:41:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vli9f5bho.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218869>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>> -	struct remote *remote = remote_get(repo);
>>> +	struct remote *remote = pushremote_get(repo);
>>
>> "struct remote" has url and pushurl fields.  What do they mean in the
>> context of these two accessors?  /me is confused.
>>
>> Is the idea that now I should not use pushurl any more, and that I
>> should use pushremote_get and use url instead?
[...]
>               At the programming level, you would still ask what the
> URL to be pushed to to the remote obtained here, and would use
> pushurl if defined, or url otherwise.

Ah, I think I see.  It might be more convenient to the caller if
pushremote_get returned a remote with url set to the pushurl, but
that would prevent sharing the struct with other callers that want
that remote for fetching.

So instead, the idea is something like

	remote: support a different default remote for pushing

	Teach remote_get() to accept an argument FOR_FETCH or FOR_PUSH
	that determines, when no remote is passed to it, whether to use
	the default remote for fetching or the default for pushing.

	The default remote for fetching is stored in the static var
	"default_remote_name", while the default for pushing, if set,
	is in "default_push_remote_name".

	Currently there is never a different default for pushing set
	but later patches will change that.

If remote_get() gained a new required parameter, that would force all
call sites to be examined (even any potential call sites added by new
patches in flight) and there would no longer be need for the
remote_get_1() function.

What do you think?
Jonathan

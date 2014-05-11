From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: optimising a push by fetching objects from nearby repos
Date: Sun, 11 May 2014 07:40:36 +0530
Message-ID: <536EDC1C.5040101@gmail.com>
References: <536E2C19.3000202@gmail.com> <xmqqtx8xuz3b.fsf@gitster.dls.corp.google.com> <536ECC93.1070102@gmail.com> <1399772049733.13154@student.bi.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	milki <milki@rescomp.berkeley.edu>
To: "Storm-Olsen, Marius" <Marius.Storm-Olsen@student.bi.no>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 11 04:10:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WjJE8-0000rk-9c
	for gcvg-git-2@plane.gmane.org; Sun, 11 May 2014 04:10:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757390AbaEKCKn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 May 2014 22:10:43 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:49758 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbaEKCKm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 May 2014 22:10:42 -0400
Received: by mail-pa0-f46.google.com with SMTP id kq14so1808883pab.19
        for <git@vger.kernel.org>; Sat, 10 May 2014 19:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6LPPi9Er0LHzLTD9OIqSvI2GrOMfoXwQw5ktmBXLUpw=;
        b=vZkfiGOc0yesc4dzndjP+8eHYeWf6fgmGj8o/GY5YGfzGPHDHo4t2OTRR7XH3pribH
         ry8EhMqIg+9tsXQ6ofaTpJFQLtwVp0udAH/SDls4objMaCqIYtnG43KCj+3JRWX7df/C
         Ww9P/FT0+OWbf3ZkmOfT9vYwBTNLL9f9yggMWIz2s+6IvbzU2utd6vJo9Xdz/hznLyAc
         HSOP2v/qR6tmRSUkvuAKJghnwUoG59uU4NhvFg40EzH3B2CNgh08WeJZBbNGH09Uzhsn
         rzKus4W30TLYugSysfcYM1d5f+bQdpR7yKFlMr/Lli990JwH+fduX35kGWUad5vvh7FU
         ND8A==
X-Received: by 10.66.148.230 with SMTP id tv6mr770962pab.155.1399774241880;
        Sat, 10 May 2014 19:10:41 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.195.174.132])
        by mx.google.com with ESMTPSA id qw8sm15202086pbb.27.2014.05.10.19.10.38
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 10 May 2014 19:10:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1399772049733.13154@student.bi.no>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248670>

On 05/11/2014 07:04 AM, Storm-Olsen, Marius wrote:
> On 5/10/2014 8:04 PM, Sitaram Chamarty wrote:
>> On 05/11/2014 02:32 AM, Junio C Hamano wrote: That's an interesting
>> thread and it's recent too.  However, it's about clone (though the
>> intro email mentions other commands also).
>>
>> I'm specifically interested in push efficiency right now.  When you
>> "fork" someone's repo to your own space, and you push your fork to
>> the same server, it ought to be able to get most of the common
>> objects from disk (specifically, from the repo you forked), and only
>> what extra you did from the network.
>>
> ...
>>
>> I do have a way to do this in gitolite (haven't coded it yet; just
>> thinking).  Gitolite lets you specify something to do before
>> git-*-pack runs, and I was planning something like this:
>
> And here you're poking the stick at the real solution to your problem.
>
> Many of the Git repo managers will neatly set up a server-side repo
> clone for you, with alternates into the original repo saving both
> network and disk I/O.

Gitolite already has a "fork" command that does that (though it uses
"-l", not alternates).  I specifically don't want to use alternates, and
I also specifically am looking for something that activates on a push --
in the situations I am looking to optimise, the clone already happened.

> So your work flow would instead be:
>     1. Fork repo on server
>     2. Remotely clone your own forked repo
>
> I think it's more appropriate to handle this higher level operation
> within the security context of a git repo manager, rather than directly
> in git.

Yes, because of the "read access" check in my suggested procedure to
handle this.  (Otherwise this is as valid as the plan suggested for
clone in Junior's email in [1]).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/243918/focus=245397

I will certainly be doing this in gitolite.  The point of my post was to
validate the flow with the *git* experts in case they catch something I
missed, not to say "this should be done *in* git".

From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Implement ACL module architecture and sample MySQL ACL module
Date: Tue, 14 Aug 2012 10:26:30 -0700
Message-ID: <CAJo=hJu7W6JnNLYvahaQ43ZNqDtrurTOLCnLfZacVJKeL6VMFg@mail.gmail.com>
References: <feafacf49186d7cf0eed0002a82289b318f56ff8.1344938189.git.minovotn@redhat.com>
 <7v1uj98nbj.fsf@alter.siamese.dyndns.org> <CAJo=hJtYz3OX1C6HS7ivhJKBOSg=Ex3rKEdTYSbcDfFT1Jh4hw@mail.gmail.com>
 <7vsjbp768y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michal Novotny <minovotn@redhat.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 19:27:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1KtU-0005pC-KG
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 19:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633Ab2HNR0y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 13:26:54 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:63519 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516Ab2HNR0v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 13:26:51 -0400
Received: by vbbff1 with SMTP id ff1so585236vbb.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ObLSJKwZ1SwemQyn2zsrkE50HlsIFHDtzCGKwHDU8HQ=;
        b=Du5Rhl5WSaJ+BLp3489FQkyZu7yi1KmM0xn/i8cRX7T/dXh1F/x2iV/drEKWdo9LVQ
         J3cT3bS1IzPpVQ4A/sqMSUZqW/DM74k14q5CikE/FQAQxe1eIniwtvXkfumiuC8L/Gzh
         PD6q4QRq+fZYGvv7Ij2KJd20UREmqoXWdFyh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=ObLSJKwZ1SwemQyn2zsrkE50HlsIFHDtzCGKwHDU8HQ=;
        b=dpy3vxuQoK8vLmF77C79H6ho2jWehRl5z+5iAHvgY+oEkVbRFlwAsWIHzwO1nfZpBJ
         ocfVELa6upjMe4qBDTZS2Sc5Ym9bvk9BbZ/GJ2lFHzFT7jw1oa7uRKk88YjIDrOxqSeQ
         f9KguffRlQV5qY0T9G5JPShPdzqd1zsY5PvizkYIbnQfneQ8T7ToYgNnTs/8BchZ7XSY
         nz4QPlG8iYx180iUChkNnUVXP6URSPsoVfpGWeFoSaYMWBE4ieKGhraisIvZg6pzU10u
         02Ofc0nW61dcCDi/4K8SP477l0hA6OTo8SFn4CKD3uY5IM3bQB7ICep3wP+hMJSOYxCH
         NJuQ==
Received: by 10.42.129.145 with SMTP id q17mr13771935ics.54.1344965210366;
 Tue, 14 Aug 2012 10:26:50 -0700 (PDT)
Received: by 10.64.22.231 with HTTP; Tue, 14 Aug 2012 10:26:30 -0700 (PDT)
In-Reply-To: <7vsjbp768y.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkdf2nNrrkkU0PdF3D+zDrO8MxvXjRWZdZueavsbPv2Lr+nscM3TpSbcFTKlUUvghf6vCnE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203419>

On Tue, Aug 14, 2012 at 10:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>> Parsing the request line of git-daemon is easy. But we could make it
>> easier. An alternative arrangement would be to add a new command line
>> flag to git daemon like --command-filter that names an executable
>> git-daemon will invoke after parsing the request line. It can pass
>> along the client IP address, command request, repository name, and
>> resolved repository path, and tie stdin/stdout to the client. This
>> binary can decide to exec the proper git binary for the named command,
>> or just exit to disconnect the client and refuse service. This makes
>> it simple for a tool like gitolite to plug into the git-daemon
>> authorization path, without needing to be the network daemon itself,
>> worry about number of active connection slots, etc.
>
> I think that is a good direction to go in, except that I am unsure
> what kind of conversation do you want to allow between the "command
> filter" helper and the client by exposing standard input and output
> stream to to the helper.

Sorry, I was thinking the helper would exec the git command, and thus
pass along the stdin/stdout socket.

>  If the client side has a matching "pre
> negotiate command" helper support, then presumably the helpers can
> discuss what Git protocol proper does not care about before deciding
> to allow the connection go through, but until that happens, opening
> the stdio streams up to the helper sounds like an accident waiting
> to happen to me (e.g. "fetch-pack" connects, the server side helper
> reads the first pkt-line from the client, says "OK, you may proceed"
> to the daemon, then the daemon spawns the "upload-pack", which will
> obviously see a corrupt request stream from "fetch-pack").

But seeing this, yes, that is a bad idea. Better to treat that like a
hook, where exit status 0 allows the connection to continue, and exit
status non-zero causes the connection to be closed. Maybe with an
error printed to stderr (if any) being echoed first to the client if
possible using the ERR formatting notation.

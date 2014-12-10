From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] pkt-line: allow writing of LARGE_PACKET_MAX buffers
Date: Wed, 10 Dec 2014 04:56:05 -0500
Message-ID: <CAPig+cS4461U4MH3+2UFJgm4K3puBfKg95zNCVYFq6SpwJUrag@mail.gmail.com>
References: <20141209174958.GA26167@peff.net>
	<20141209180916.GA26873@peff.net>
	<xmqqa92wla34.fsf@gitster.dls.corp.google.com>
	<20141210073447.GA20298@peff.net>
	<CAPig+cQQThA7wiz8iwkKX=ipg1n5w+gyeS8NqtbjGui986Hn+g@mail.gmail.com>
	<20141210094702.GA8917@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 10:56:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xye0E-00070p-E0
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 10:56:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754467AbaLJJ4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 04:56:07 -0500
Received: from mail-yh0-f49.google.com ([209.85.213.49]:57946 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446AbaLJJ4G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 04:56:06 -0500
Received: by mail-yh0-f49.google.com with SMTP id f10so1113220yha.22
        for <git@vger.kernel.org>; Wed, 10 Dec 2014 01:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=W/Tjjx3TaHuKIBByuQhy8iynw0zi91yZ704wWplNfTA=;
        b=cE8gUSbId3+0FquQ6Or6/4v/ozwJgK4OumAUx6JdshX4HMUZ9CJOVzj4im+TcQN6kg
         zMvzYawU/D1ZAzSJ0u7EO48ViUuwAiIcuQgtJ5J9l3lF6O+pUGk+XkZOe7FtZwmPTg7u
         9KTjS2FmntbJdMERtNWNGUkfJS+rsO4rLmDNxVQwshYHtUhCqpkoOYipP2kmwOAXX5X6
         /jQNH+NxpeRPgo3oNSG2GsIsZlUfyAyqZCAAfl4UeIuvu7dQ0poyVfz+OFhEjXNxobHr
         7sWFQ0a5U9FNaEGoCvgq7L3+D2n38zFu6uOOyriulGIJxK0nIpu4YAEtNDUo+cuINgMo
         eV8g==
X-Received: by 10.170.78.130 with SMTP id u124mr2042406yku.91.1418205365539;
 Wed, 10 Dec 2014 01:56:05 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Wed, 10 Dec 2014 01:56:05 -0800 (PST)
In-Reply-To: <20141210094702.GA8917@peff.net>
X-Google-Sender-Auth: d_X3T4OCiIVg41hPKWFftTtAnjU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261204>

On Wed, Dec 10, 2014 at 4:47 AM, Jeff King <peff@peff.net> wrote:
> On Wed, Dec 10, 2014 at 03:36:31AM -0500, Eric Sunshine wrote:
>
>> On Wed, Dec 10, 2014 at 2:34 AM, Jeff King <peff@peff.net> wrote:
>> > Below is a another iteration on the patch. The actual code changes are
>> > the same as the strbuf one, but the tests take care to avoid assuming
>> > the filesystem can handle such a long path. Testing on Windows and OS X
>> > is appreciated.
>>
>> All three new tests fail on OS X. Thus far brief examination of the
>> first failing tests shows that 'expect' and 'actual' differ:
>>
>> expect:
>>     long
>>     master
>>
>> actual:
>>     master
>
> Ugh. It looks like the packed-refs reader uses a PATH_MAX-sized buffer
> to read each line, and simply omits the ref. That may be something we
> want to work on, but it's a separate topic.  I think there are platforms
> whose PATH_MAX is much smaller than what they can actually represent.
> So ideally we would lift the arbitrary PATH_MAX limitations inside git,
> and just let the OS complain when we exceed its limits.
>
> Even if we fix that, though, I think the push test would still fail on
> systems that have a true limit on the filesystem.  Writing to a ref
> requires taking a lock in the filesystem, which will involve creating
> the too-long path. I think there are simply some systems that will not
> support long refs well, and the tests need to be skipped there.
>
> So here's a re-roll that uses prerequisites.

On OS X, this version correctly skips the two final tests as intended.

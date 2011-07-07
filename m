From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC 3/3] upload-archive: use start_command instead of fork
Date: Fri, 8 Jul 2011 00:37:48 +0200
Message-ID: <CABPQNSbUx3Z-JCsr1rpjqEvKHSoOLnRP3f7pN6cMfNEiNoZBhg@mail.gmail.com>
References: <1310038989-5724-1-git-send-email-kusmabite@gmail.com>
 <1310038989-5724-4-git-send-email-kusmabite@gmail.com> <20110707191528.GD12044@sigill.intra.peff.net>
 <CABPQNSYZqpfGwgQXqk4YFBXhSHTen1w7m2hwaF7YDsZmsaYY5Q@mail.gmail.com> <20110707222726.GA23424@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jul 08 00:38:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QexDO-0007yG-Dv
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 00:38:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743Ab1GGWia (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 18:38:30 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52748 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751829Ab1GGWi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 18:38:29 -0400
Received: by pwj7 with SMTP id 7so765090pwj.19
        for <git@vger.kernel.org>; Thu, 07 Jul 2011 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=zwThvyzTTUt2NmdB2V2vH29n4Q9ow9sioO8Auyzw1FM=;
        b=O+x1objWPC6jSedaSvNEbSCPxZtS3tRM096RUhSKlcREV4e2N3ey+CUYJPZLk7v3u8
         ugmNklrvUkknp8jh4T7w/VQL6BXc4M3g1ecUvuTtGcZDdWx2l+vZ0lbQU9CosVF2n0tv
         GXq04xML2eBOM19+7K8TCoxHInA1+ejJdkA0c=
Received: by 10.68.49.234 with SMTP id x10mr1804327pbn.424.1310078308039; Thu,
 07 Jul 2011 15:38:28 -0700 (PDT)
Received: by 10.68.43.198 with HTTP; Thu, 7 Jul 2011 15:37:48 -0700 (PDT)
In-Reply-To: <20110707222726.GA23424@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176785>

On Fri, Jul 8, 2011 at 12:27 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jul 08, 2011 at 12:25:00AM +0200, Erik Faye-Lund wrote:
>
>> On Thu, Jul 7, 2011 at 9:15 PM, Jeff King <peff@peff.net> wrote:
>> > On Thu, Jul 07, 2011 at 01:43:09PM +0200, Erik Faye-Lund wrote:
>> >
>> >> The POSIX-function fork is not supported on Windows. Use our
>> >> start_command API instead.
>> >
>> > Is start_command the right solution? From my reading, the fork is
>> > actually because we want to set up a sideband multiplexer. Should we not
>> > just be using start_async() to start a thread, as we do in receive-pack?
>>
>> I considered that, but discarded it because I figured it required me
>> to plug through a file descriptor all the way through the code. But
>> perhaps I was wrong, and dup2 will make that job a lot easier?
>
> Yeah, exactly. The current code is already using dup2 in the same way.
>

It does, but I'm not entirely sure how dup2 works when start_async is
implemented with threads. Won't cause the multiplexer to fail (the
multiplexer and the archive-thread needs different stdouts), because
file descriptors are process-resources, and not thread-resources?

I guess I could dup stdout/stderr before dup2'ing, and have the
multiplexer write to explicitly to the duped fds. It's starting to
sound very confusing to my ears, but perhaps it's the best option
still ;)

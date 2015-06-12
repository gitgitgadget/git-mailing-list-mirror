From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/3] pkt-line: tighten sideband PACK check when tracing
Date: Fri, 12 Jun 2015 14:43:19 -0700
Message-ID: <CAGZ79kZs8snjB1Yi+Z3KctjHZN6VM6nRcHZ5Aa-iODcFxa7Gfg@mail.gmail.com>
References: <20150612212526.GA25447@peff.net>
	<20150612212814.GB25757@peff.net>
	<CAGZ79kb+DBUqAy45+Bc=MTA6HuGrj9MzyODZGTvOcP_XefAu=A@mail.gmail.com>
	<20150612214152.GA26217@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Augie Fackler <augie@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 12 23:43:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3WjV-00035z-54
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 23:43:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbbFLVnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 17:43:21 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:34184 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbFLVnU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 17:43:20 -0400
Received: by yhid80 with SMTP id d80so18709568yhi.1
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 14:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sLnAt86yn/UXl5eIyeFIiytK/p+1/ABwDCnT4GulM28=;
        b=mdwkbaYkXfd2vCSA8+LfcRWtx303JJ9u91u1+9OO6AhJZKNlzwj9VLSTtdI217v++E
         HBQ2CGh+pNrp6f7QPK/Tjaw1wtSbvSpaAwRIlrnjvWUx6jhZfAaTeEkdf09Ewxf5vRIc
         w1wjReVi9t5sBip5yGD4NbiS/IHagN8a5O+PwurhavbzwnLK8DjxCAwIZRpMiqyYGUcV
         wfLtnpqdNQh1ZJh1m6BQDY6Jf0bi4bw+R0YrCaSmQD/MYOq1AD9FRBC5bqLfkQDO8sJ8
         WEKgeSp5/HDVgzn0NSiAt0sswrrMhCrbRb5Av/j1Tn7MbkTM1AlaSA10VxdrVJqIeAl9
         23hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=sLnAt86yn/UXl5eIyeFIiytK/p+1/ABwDCnT4GulM28=;
        b=dclHBk+h1d4uu03bvjRA0+TWVxvzAAbtlC9HLa6FR5jmQaax4au7Wwu7od+KnAKgkA
         WD20miK0tmeULCmayN454UPCjsDpjX62eSEk0YkMCL++lOmr6XFd2udhINVeq5ADvH4+
         HPOjppD99XHwH157juzoFiCSncyeotLRMu2fbntmzN4Fszy3olKGmHtRHz6WW3d0t87H
         8/8BgAhvc8m0CcyeeCGWAJ8Np145+IOEy1a5w1YXy2Q439eepHCVUMrJzlEtJgBZC7PK
         0ZH0JI+NyobQWvb8uerNdWaLgRy4DucOf72QIal6kF/LjdldCz8x3yv9qHnxe0fXFsGn
         Fbfw==
X-Gm-Message-State: ALoCoQkNFhYtqkoO0Y+9cmOH38I1UlYAlaYMrPYfNzw+omB+VDzRu1pqKuyQjEQ6yvqJC8HFah69
X-Received: by 10.129.46.1 with SMTP id u1mr6373584ywu.1.1434145399781; Fri,
 12 Jun 2015 14:43:19 -0700 (PDT)
Received: by 10.37.101.197 with HTTP; Fri, 12 Jun 2015 14:43:19 -0700 (PDT)
In-Reply-To: <20150612214152.GA26217@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271532>

On Fri, Jun 12, 2015 at 2:41 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Jun 12, 2015 at 02:39:01PM -0700, Stefan Beller wrote:
>
>> > -       if (starts_with(buf, "PACK") || starts_with(buf + 1, "PACK")) {
>> > +       if (starts_with(buf, "PACK") || starts_with(buf, "\1PACK")) {
>>
>> This answers the question on the previous patch actually, maybe the
>> code could be improved to
>>
>>     if (is_sidechannel(out, ...)
>>         out++;
>>     if (starts_with(buf, "PACK") {
>>         ...
>
> If it's not a PACK, then we don't want to skip past the side-channel
> character (we show it as part of the trace).
>
> Hopefully the end result after patch 3 reads well, as it sets an
> explicit "sideband" flag.

Yeah, I just looked at that, and realized I should not worry about
these first two patches
as the line is deleted anyway. :( Writing faster than I can think.

>
> -Peff

From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv13 5/7] git submodule update: have a dedicated helper for cloning
Date: Fri, 19 Feb 2016 08:47:55 -0800
Message-ID: <CAGZ79kbp+A1J4isLGftMiA2UZM16NO6nUycraj4U==2Zv6kHVQ@mail.gmail.com>
References: <1455838398-12379-1-git-send-email-sbeller@google.com>
	<1455838398-12379-6-git-send-email-sbeller@google.com>
	<20160219120310.GB10204@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 17:48:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWoDp-0007qC-Eg
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 17:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1427257AbcBSQr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 11:47:57 -0500
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35236 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573AbcBSQr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 11:47:56 -0500
Received: by mail-ig0-f175.google.com with SMTP id hb3so38856855igb.0
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 08:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ouP3SBUyypx8e9sMN4gkPi3emOiLf0PPkQl9A+AzMWE=;
        b=ayNkl23kFTuPSJ0/QWRDs4jaaLNEbJPCL9F84OVl48seRBf3G8jTpF8sWJ9tcKnPUQ
         dNdA3awrXu2hS9VD1mQw37fgJ3GmcZV4UiwZh9O/P38jtYIujjIWQJpY6ZYIGQnnXTAu
         CDeyP6zNZDnpq0licC8gibizF6CTNzkbhleBZiXfZlW3cV3OzgHXw0bmXHTWFbFednli
         Ix/bVEsjFnSprBZ8jR/ZwTPaHTuiHlsu5k4ri2cRDX5FRe95YR5Q819JodWpdgov/xSc
         gSx4MBIWsImOwCjPjEvP0Ug7S30Kql6QFAQS/FMlgMlxPFGd1Mqd47rJtne6QcRdORT/
         pOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ouP3SBUyypx8e9sMN4gkPi3emOiLf0PPkQl9A+AzMWE=;
        b=J/vMXYHRcNweZNr2X5CO9y3ueZkD4rHwBl5hWYaI0xdFNMXzGfzC1sbzelmo4iVbv2
         32vleRVusxVr7yV0qCLjCRG7UYS3Po77KgPmYYhXqTMs5LK4fy/zrBNsCvUQYrzKIPIp
         CEJShZNIjzYRkJM/vPao8QnH77mlBX+tkmuyeSei04zOtkAhEErkF6XUpD1CcQUIjBst
         ocLWPdu92bFh+D9qSo1xOsEegBXvMuFdJ5+L3eHsmXv8MLSWtz3aw6x3r2joz9dpgNgk
         z/QuT6GPE1///J7UFJ5wd6JmVoaHfYTgIA8R0T+o/GrksgDrpYq1RB/kQqlNf9ckXbhs
         bL4A==
X-Gm-Message-State: AG10YOT/Djjme3aOxQkMac7iab6wx+tRL8k25U9dl9iuJ0Sz/+Ay1PiLx1cAn3ZBUfGHzZljmxD79Fj9oIQsKIgn
X-Received: by 10.50.138.76 with SMTP id qo12mr10242016igb.85.1455900475445;
 Fri, 19 Feb 2016 08:47:55 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Fri, 19 Feb 2016 08:47:55 -0800 (PST)
In-Reply-To: <20160219120310.GB10204@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286717>

On Fri, Feb 19, 2016 at 4:03 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 18, 2016 at 03:33:16PM -0800, Stefan Beller wrote:
>
>> +     if (needs_cloning) {
>> +             cp->git_cmd = 1;
>> +             cp->no_stdin = 1;
>> +             cp->stdout_to_stderr = 1;
>> +             cp->err = -1;
>> +             argv_array_push(&cp->args, "submodule--helper");
>> +             argv_array_push(&cp->args, "clone");
>> +             if (pp->quiet)
>> +                     argv_array_push(&cp->args, "--quiet");
>> +
>> +             if (pp->prefix)
>> +                     argv_array_pushl(&cp->args, "--prefix", pp->prefix, NULL);
>> +
>> +             argv_array_pushl(&cp->args, "--path", sub->path, NULL);
>> +             argv_array_pushl(&cp->args, "--name", sub->name, NULL);
>> +             argv_array_pushl(&cp->args, "--url", strdup(url), NULL);
>
> No need to strdup() here; argv_array handles its own memory, so this
> just leaks (and if we were keeping it, it should be xstrdup(), of
> course).

We cannot remove the strdup as the url is a local variable we read in from
git_config_get_string and the local variable is going out of scope before the
child process ends?

I'll change it to xstrdup then.

>
> -Peff

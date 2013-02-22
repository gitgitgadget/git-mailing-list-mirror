From: Joshua Clayton <stillcompiling@gmail.com>
Subject: Re: [PATCH] Fix in Git.pm cat_blob crashes on large files (resubmit
 with reviewed-by)
Date: Fri, 22 Feb 2013 11:17:17 -0800
Message-ID: <CAMB+bf+LkrnfW=gQsdDhGC9LzfP_vvVG5QdsytD--Hr5_uZeEA@mail.gmail.com>
References: <CAMB+bfLvpKNLaEUyUUYsO5n2y+9tyd_QcnPVzX0s2Z2t3Fr9=g@mail.gmail.com>
	<20130222183419.GB18934@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 22 20:17:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8y7q-0005eC-LK
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 20:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757069Ab3BVTRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 14:17:18 -0500
Received: from mail-ia0-f174.google.com ([209.85.210.174]:57318 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754071Ab3BVTRR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 14:17:17 -0500
Received: by mail-ia0-f174.google.com with SMTP id u20so842654iag.33
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 11:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=oQjxd8m/mr1R7CBCrEyTZFuVj27NcElaMDnZRDcl/8s=;
        b=rF1uuGYB8kzOqZH9Ec3pmUNT+jj2TCchK/heSNLs0ywVLJcjxhGm7n5GdrfGj4iQ/g
         zf5rgHPxBR3asapP+mEUjkjCHo276W2D5zEgsVG2YQEMe0Tgv39ik8D6IApc3YjgFxRt
         uJp+ohrZXz928GCA0rXr6S1CA1bndt1WynnSgtUwz16ckjpSRak7AWbozYgQt2O/8M3B
         KfNQXDxVoZ16yh7/LkS1oFf3dsr5lshDwi4gGxcYUyMC4tACGtl8NLC7V5VOddkDr4I1
         m+Gzmz3dJO9ZtMyzMttk8cM/iyZ7dHM2EoXm345YllQ+Db66DC1XrqD1JMmC90ejKdHJ
         QwHg==
X-Received: by 10.50.182.137 with SMTP id ee9mr113702igc.96.1361560637414;
 Fri, 22 Feb 2013 11:17:17 -0800 (PST)
Received: by 10.42.79.80 with HTTP; Fri, 22 Feb 2013 11:17:17 -0800 (PST)
In-Reply-To: <20130222183419.GB18934@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216855>

Thanks for all the input and patience.

On Fri, Feb 22, 2013 at 10:34 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 22, 2013 at 09:30:57AM -0800, Joshua Clayton wrote:
>
>> Read and write each 1024 byte buffer, rather than trying to buffer
>> the entire content of the file.
>
> OK. Did you ever repeat your timing with a larger symmetric buffer? That
> should probably be a separate patch on top, but it might be worth doing
> while we are thinking about it.
>
>> Previous code would crash on all files > 2 Gib, when the offset variable
>> became negative (perhaps below the level of perl), resulting in a crash.
>
> I'm still slightly dubious of this, just because it doesn't match my
> knowledge of perl (which is admittedly imperfect). I'm curious how you
> diagnosed it?

I first had the memory exhaustion problem running my git repo on a 32 vm.
After bumping the memory from 512 to 4 GiB, and that failing to fix it
I moved to my workstation with 16 GiB
...reproduced
After the initial crash, I added

print $size, " ", $bytesToRead, " ", $bytesRead, "\n";

right before the read command, and it does indeed crash right after
the $bytesRead variable crosses LONG_MAX
...
2567089913 1024 2147482624
2567089913 1024 2147483648
2567089913 1024 2147484672
Offset outside string at /usr/share/perl5/Git.pm line 901, <GEN36> line 2604.

Note that $bytesRead is still positive.
I know very little perl, but that symptom seems pretty clear

>
>> On a 32 bit system, or a system with low memory it might crash before
>> reaching 2 GiB due to memory exhaustion.
>>
>> Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
>> Reviewed-by: Jeff King <peff@peff.net>
>
> The commit message is a good place to mention any side effects, and why
> they are not a problem. Something like:
>
>   The previous code buffered the whole blob before writing, so any error
>   reading from cat-file would result in zero bytes being written to the
>   output stream.  After this change, the output may be left in a
>   partially written state (or even fully written, if we fail when
>   parsing the final newline from cat-file). However, it's not reasonable
>   for callers to expect anything about the state of the output when we
>   return an error (after all, even with full buffering, we might fail
>   during the writing process).  So any caller which cares about this is
>   broken already, and we do not have to worry about them.
>
>> ---
>>  perl/Git.pm |   12 +++++-------
>>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> The patch itself looks fine to me.
>
> -Peff

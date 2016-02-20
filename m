From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] submodule: Fetch the direct sha1 first
Date: Sat, 20 Feb 2016 02:52:03 -0800
Message-ID: <CA+P7+xrjE5fF9QKe5AvAcuwNtx4O5yq8FfkXtyrR8r7+E=d8Bw@mail.gmail.com>
References: <1455908253-1136-1-git-send-email-sbeller@google.com> <xmqqpovsbdyu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, dborowitz@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 11:52:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX59K-0005S3-PQ
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 11:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993824AbcBTKwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 05:52:25 -0500
Received: from mail-io0-f169.google.com ([209.85.223.169]:34036 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993759AbcBTKwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 05:52:23 -0500
Received: by mail-io0-f169.google.com with SMTP id 9so134995811iom.1
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 02:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=dw+9+nFVByuoREGA19ZkPK9SErkPsComLLU0LlA+ln8=;
        b=Pqsu1msKakW0t23bHWBxzp+6CJ10SEvXDgW9A6ZXUl0rddryjSL7ki44G8EerLKhw4
         8BFIjQ2zwGs9Yi9lLe85/APqnfIZ8pXQ9+l/wNIRgWIb7UPOubhqd1w+QNY0DkpcHzPz
         Cen7nPIwTuVA9sUkiUh9VE+dAveIVy5AYZns8a+QH9plXVbY/Rk0Wue9I/gYj6Nd2Dxa
         GLxlm9hSQprZQPZZfmFCV9kpSs6LkU2tJd6kDrLNgI9GajT43A4jhBVARM58YkiaeRjC
         b591KGWQZmGBonE5ReN3Py5pZoKKJ0QBGLsx7QEKr5Kv8z1lHSVcaLrKZEs2ynMRoBUK
         39Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=dw+9+nFVByuoREGA19ZkPK9SErkPsComLLU0LlA+ln8=;
        b=Tsdanu20H1VVPHPPfN77Cehgp4GKBkvjisD6ItYL4k5dXWIaIO329Gf7c2pK5fDHHg
         T/bIluF+GiqSU4Z94YZiKNzLWQ5fJkf2GnNfN1jv/cCKwvZnyImD4EwH+mvg662He9kS
         6ItYIs0fZJTonO6WhgZ5x7MBTgJx1nfSjRsg3AWcx/d8iy8ZZaQlkniw7PcbVTEkV4lr
         48ncWgDMRvnXHE4KAKlYdD2Npe7y/lXUdWfuv81ZmDaAjaMweydbbPJS3Itd9WEiZ4tG
         zcWU8McDtheI3K1o+IjdMCf7GCXmh3ElJeHivQCj7za701fRKXGeY2vZaArg38tEWY8+
         w9iw==
X-Gm-Message-State: AG10YOShfimW+nmY1upWP1uPG20QpaJy8wLl1uaMJe7pM6mG0jaxDcCqSKZaRDxSbOPkArdlgeYNA7Y0s0ek+g==
X-Received: by 10.107.170.79 with SMTP id t76mr23128471ioe.71.1455965542845;
 Sat, 20 Feb 2016 02:52:22 -0800 (PST)
Received: by 10.107.20.76 with HTTP; Sat, 20 Feb 2016 02:52:03 -0800 (PST)
In-Reply-To: <xmqqpovsbdyu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286777>

On Fri, Feb 19, 2016 at 1:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Regarding performance, the first fetch should fail quite fast iff the fetch
>> fails and then continue with the normal fetch. In case the first fetch works
>> fine getting the exact sha1, the fetch should be faster than a default fetch
>> as potentially less data needs to be fetched.
>
> "The fetch should be faster" may not be making a good trade-off
> overall--people may have depended on the branches configured to be
> fetched to be fetched after this codepath is exercised, but now if
> the commit bound to the superproject tree happens to be complete,
> even though it is not anchored by any remote tracking ref (hence the
> next GC may clobber it), the fetch of other branches will not
> happen.
>
> My knee-jerk reaction is that the order of fallback is probably the
> other way around.  That is, try "git fetch" as before, check again
> if the commit bound to the superproject tree is now complete, and
> fallback to fetch that commit with an extra "git fetch".
>

FWIW, I think the order you suggest here is probably better. It would
be lower risk of breaking something since we'd only do something more
in this case if the current fetch fails.

I've definitely been bit by this before thinking that the sub module
would be able to be fetched just fine only to discover that it wasn't
able to locate the change.

Regards,
Jake

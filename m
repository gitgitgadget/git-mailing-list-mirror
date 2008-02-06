From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: [PATCH] Make git prune remove temporary packs that look like write failures
Date: Wed, 6 Feb 2008 19:57:41 +0000
Message-ID: <e1dab3980802061157r36dfa8b9uab49af013cb8e963@mail.gmail.com>
References: <Pine.GSO.4.63.0802051844220.15867@suma3>
	 <alpine.LFD.1.00.0802051357420.2732@xanadu.home>
	 <47A9E4F9.8050100@nrlssc.navy.mil>
	 <e1dab3980802061059m5bf9c291s892da586248e229c@mail.gmail.com>
	 <47AA0D60.60504@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"David Steven Tweed" <d.s.tweed@reading.ac.uk>,
	git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: "Brandon Casey" <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:58:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqPW-0006Yn-CJ
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 20:58:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbYBFT5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 14:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756173AbYBFT5t
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 14:57:49 -0500
Received: from ti-out-0910.google.com ([209.85.142.191]:23982 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752304AbYBFT5s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 14:57:48 -0500
Received: by ti-out-0910.google.com with SMTP id 28so319343tif.23
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 11:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=rETFPFDSmm2lmm+bh+cQWY8VSSFO6/eNWquJh1FFh3o=;
        b=rtbobDlXn/9S5pNmY+NKkqXGnja6QImy9h/1dCcjjouKBu3Tw4bw/iZ5LK8TaKZaTNDmK+WX4q430ytP7UDPGLS1uaAKh0q2U7xK7B441zZpNxj1wyU9q7gmVpb6HTESWrhOYXEnHREm+6oRwkSqk6ope9QM+QdGc2qDiaACWYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qcdX04fzHL6ekNr1qSyhursERInmsEA+he//6OQuVy3DUJEde3iataehK24DyLGE+p+F3bOD8uPZwIN7GhekvD4EBkIyuXlYSts0vWrqtwJd/1qI1qKB/Whi2YP9Akgq4C2wdbllvQEulWWmuKy6HNllnhAoPBefDIQT+DVdTtU=
Received: by 10.150.139.15 with SMTP id m15mr4367419ybd.99.1202327861981;
        Wed, 06 Feb 2008 11:57:41 -0800 (PST)
Received: by 10.150.149.2 with HTTP; Wed, 6 Feb 2008 11:57:41 -0800 (PST)
In-Reply-To: <47AA0D60.60504@nrlssc.navy.mil>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72837>

On Feb 6, 2008 7:41 PM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
> They use sprintf for the "%02x" part, but they use memcpy to copy the return
> of get_object_directory() into a fixed string and then append onto that,
> rather than repeatedly writing the same string over and over. Ok, there is one
> instance in builtin-prune.c that repeatedly writes path, but builtin-prune-packed.c
> does the memcpy thing.

Given I'm the only person (AFAICS from the list archives) who's ever
talked about failed temporary packs, I assume that almost everyone
using git is using filesystems with sufficient space that they don't
get write errors, so the path building will generally be done 0 times
per --prune. (Using a USB disk that's almost full, along with
occasionally filling up my /home with experiment output, is the
occasions I get them.) So I don't think efficiency is an issue. So the
big (genuine) question is: is a properly checked snprintf more or less
readable/canonical git style than doing more complicated strlcpy
things? (I know I need to really think about what the below is doing,
and what the correctness conditions are.)

> Something like:
>
>         char pathname[PATH_MAX];
>         ...
>
>         /* check length of dirname not too long */
>
>         memcpy(pathname, dirname, len);
>
>         if (len && pathname[len-1] != '/')
>                 pathname[len++] = '/';
>
>         ...
>
>         while ((de = readdir(dir)...) {
>                 if (!prefixcmp(...
>                         if (strlcpy(pathname + len, de->d_name, PATH_MAX - len)
>                             >= PATH_MAX - len) {
>                                 warning("too long path encountered: %s%s",
>                                         pathname, de->d_name);
>                                 continue;
>                         }
>
>                         ...

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot

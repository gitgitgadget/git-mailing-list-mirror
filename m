From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 5/6] gitweb: last-modified time should be commiter, not 
	author
Date: Thu, 12 Feb 2009 10:52:06 +0100
Message-ID: <cb7bb73a0902120152h7b3e0ac6w379bd9319712ea2b@mail.gmail.com>
References: <1232970616-21167-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200902111018.39699.jnareb@gmail.com>
	 <cb7bb73a0902110154h325ed146h4d1161d4a8dcb1ca@mail.gmail.com>
	 <200902121007.29867.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Deskin Miller <deskinm@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 10:53:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXYGJ-0005Pq-0O
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 10:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756462AbZBLJwM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 04:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756355AbZBLJwJ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 04:52:09 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:65481 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756088AbZBLJwI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 04:52:08 -0500
Received: by ewy14 with SMTP id 14so516086ewy.13
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 01:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JtE86oUoSCDQdzdvEwcCP3+LGAy56ajkRCXITguzknA=;
        b=T0jbzNYFfqMc+CfeixaCXssuVpV6gKtOc16Vy5jXDord/jfAH1/N4885nOf0bwzIMY
         sSqFSqFX5c+AV3qWwgpNlv1+BwjqITKAba6O6qe8oyI9wdcQcx4ufS8PGICZOn8Mm5sQ
         e65r8jYUsJS/V+t0GMW0zA4uFBnrUSV6cdyiw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QErtififb1Ao2uFGwDM1C7x0Jsqu2lbTNiN19jatAGgI1Ag5OgsKy4ur6wpgq1crVY
         oqpKmcg2hlI2ZmYUrCfmASOnjaccuLqRo4loNh8sDG6OgHwlp1dNko43Dt+81RrznyfR
         NiL/aygP56jDdEUsMKku7+xUXaIZX+72WO4J0=
Received: by 10.210.19.7 with SMTP id 7mr530564ebs.169.1234432326063; Thu, 12 
	Feb 2009 01:52:06 -0800 (PST)
In-Reply-To: <200902121007.29867.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109592>

On Thu, Feb 12, 2009 at 10:07 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 11 Feb 2009, Giuseppe Bilotta wrote:
>> On Wed, Feb 11, 2009 at 10:18 AM, Jakub Narebski <jnareb@gmail.com> wrote:

>>> Assuming that you have reflog enabled (yes, it is default now)...
>>> So you would have to provide fallback in the case there is no reflog.
>>>
>>> BTW. "git reflog" is porcelain; it would be better to parse reflog
>>> directly, I think.
>>
>> Does disabling reflog remove old reflogs? IOW, can I check if reflog
>> is enabled just by opening the reflog file and assuming reflog isn't
>> enabled if it's not there? Falling back to the commit date would still
>> work decently.
>
> You can disable reflog by setting core.logAllRefUpdates to false...
> which of course do not remove reflog.  But checking for this config
> variable in gitweb shouldn't be too hard, although you would need
> to somehow change assumption that we are interested only in ^gitweb\.
> section of config.
>
> There is other side of this issue: reflog is expired, so you can
> have empty reflog if branch was updated long time ago.

I'm thinking that what I could do (that should always work as
expected) is to consider as 'last modified' the most recent date
between the commit date and the reflog date (if the reflog is found).
This basically implements an 'automatic' fallback for
disabled/obsolete/expired reflog to commit date. (Of course, assuming
the last commit doesn't suffer from a ridicously long clockskew in the
future.)

>> Since we're only interested in the last reflog date, what we can do is
>> to read the last line and get the unix time which is held two places
>> before the tab separating the metadata from the log message. Correct?
>
> Almost correct.  Some tools (old StGit for example) didn't provide
> reflog message, and with empty message they forgot to append TAB
> separator.  So you would have to provide for legacy
>
>  <old sha-1> <new-sha-1> <committer> <timestamp> <timezone>
>
> instead of correct (for empty reflog message)
>
>  <old sha-1> <new-sha-1> <committer> <timestamp> <timezone> TAB

That's the easy part: split at TAB, get the first array entry, split
at spaces, get the last two. But thanks for making me aware of the
possibly missing TAB

> P.S. It is a pity that due to packed refs stat-ing branch tip file
> $GIT_DIR/refs/heads/<branch> is not enough...

Yeah, that's what the other rbot developer suggested initially (then I
found out that cloning the repo was enough to NOT have branch heads).

-- 
Giuseppe "Oblomov" Bilotta

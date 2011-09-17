From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCH] Configurable hyperlinking in gitk
Date: Sun, 18 Sep 2011 11:33:06 +1200
Message-ID: <4E752E32.2010208@gmail.com>
References: <20110917022903.GA2445@unpythonic.net> <4E7467B7.1090201@gmail.com> <20110917134527.GA28463@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
X-From: git-owner@vger.kernel.org Sun Sep 18 01:35:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R54Pc-0000Pc-Mg
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 01:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593Ab1IQXcx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 19:32:53 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:53380 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515Ab1IQXcw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 19:32:52 -0400
Received: by pzk1 with SMTP id 1so6209499pzk.1
        for <git@vger.kernel.org>; Sat, 17 Sep 2011 16:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=E5WZAFCGbrNROBaREkNSlcWyLU2LMCtWxlqAzTJLKI0=;
        b=jqQ2c3qtKvtHLkD0lt00lm/g8/t+RBh6ACih/29cw+q8uAyDX965CsjwN+okrPzTcC
         sWTRIt3QNoJAX2ygESCHj3Dncwi2znXilepHMfHRL95qzR/oKzpQGNZ9yoH32TjD4fer
         ii3em0n+7Ylr91h9FKayaxF7THH254dhbzym8=
Received: by 10.68.38.135 with SMTP id g7mr1624999pbk.140.1316302371816;
        Sat, 17 Sep 2011 16:32:51 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPS id e3sm49195671pbi.7.2011.09.17.16.32.48
        (version=SSLv3 cipher=OTHER);
        Sat, 17 Sep 2011 16:32:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.20) Gecko/20110804 SUSE/3.1.12 Thunderbird/3.1.12
In-Reply-To: <20110917134527.GA28463@unpythonic.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181586>

On 18/09/11 01:45, Jeff Epler wrote:
>>> There are probably better names for the configuration options, too.
>>
>> It'd be nice if the config variables weren't gitk specific. .re and .sub
>> could be applied to gitweb and maybe other git viewers outside of
>> gig.git might decide to use them. My bikeshedding suggestion would be to
>> just drop the gitk prefix and have linkify.re and linkify.sub.
> 
> This seems like a reasonable idea, though since the implementation
> languages of gitk and gitweb are different it means some REs might get
> different interpretations in the different programs.
> 
>> Sometimes when a commit fixes multiple bugs we put all the bug numbers
>> in separated by commas. I don't know Tcl well enough to tell if your
>> code supports that or not.
> 
> Multiple matches per line are OK, but they must be non-overlapping.
> 
> Looking at the actual practice in Debian changelogs, I see that they do
> this:
>     evince/changelog.Debian.gz:        (Closes: #388368, #396467, #405130)
> so my original example would only linkify "Closes: #388638".  But a
> revised pattern of #(\d+) would linkify "#388368", "#396467" and "#405130".
> (but risk a few more "false positive" links).  I should revise my
> example accordingly.
> 
> As for the problems with your substitutions, "&" is special in a tcl
> regsub (it stands for the whole matched string, like \0), so you'd want
> to use a substitution like
>     git config gitk.linkify.debian-bts.sub \
>         'http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=\1\&foo=bar'

Hmm no joy with \&. Seems to upset the invocation of git web-browse

  git config gitk.linkify.bugtracker.sub \
       'https://internalhost/code\&stuff/bugs.php?id=\1'

  gitk
  /home/chrisp/libexec/git-core/git-web--browse: line 167:
stuff/bugs.php?id=bug123: No such file or directory
  fatal: 'web--browse' appears to be a git command, but we were not
  able to execute it. Maybe git-web--browse is broken?

Using the following works as expected with no error with your updated patch.

  git config gitk.linkify.bugtracker.sub \
       'https://internalhost/code%26stuff/bugs.php?id=\1'

> The problem with "%" has to do with Tk's event substitution and it's a
> bug that this happens; I should manually double the % at the proper
> point.
> 

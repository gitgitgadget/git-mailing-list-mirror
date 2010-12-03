From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCH 06/10] parse-options: never suppress arghelp if LITERAL_ARGHELP
 is set
Date: Fri, 03 Dec 2010 01:16:15 -0800
Message-ID: <4CF8B55F.8020203@gmail.com>
References: <20101201232728.GA31815@burratino> <20101201233136.GG31815@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 10:16:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PORkk-000195-S8
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 10:16:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475Ab0LCJQY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 04:16:24 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50057 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab0LCJQW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 04:16:22 -0500
Received: by qwb7 with SMTP id 7so9377010qwb.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 01:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=1/Up3dOzGCI7WPWMFPALL4Ih93oVNPEb6g1CMGFD9OM=;
        b=F3z3ivlDhhFtGivxWz66HMqzClIrM9PNp6JPuf+JE+EX/GPYDR85DdutAWbnhoj8eQ
         /ym+GYXnYcolqnJTOSR2sfUoR4nUr/7CuYeEXIwsZdEY+pJeIYGCB1PIfY38aKbBmQzt
         hntVsrvnPVDfC+2f458a1U7OBYRPjSUpEevXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=DTyysAkTNn/YegHLbmXolZVNfUF08Os3+s9sfGqSIZit5HRy2Tce4DwVtn05fJP6UP
         YM49tDG/SjTW/tK68N+5ML2AZEG4K4IpywjXf+AttcgoHNFZgsh4h0UfB7/AirpXu51Y
         4PCYgTSddBdcX1RIskN1slbfYAzovIWn+WeSo=
Received: by 10.229.81.71 with SMTP id w7mr1050916qck.158.1291367781515;
        Fri, 03 Dec 2010 01:16:21 -0800 (PST)
Received: from [192.168.1.104] ([75.85.182.25])
        by mx.google.com with ESMTPS id m7sm1082016qck.13.2010.12.03.01.16.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 01:16:20 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.12) Gecko/20101108 Lightning/1.0b3pre Thunderbird/3.1.6
In-Reply-To: <20101201233136.GG31815@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162781>

On 12/01/10 15:31, Jonathan Nieder wrote:
> The PARSE_OPT_LITERAL_ARGHELP flag allows a program to override the
> standard "<argument> for mandatory, [argument] for optional" markup in
> its help message.  Extend it to override the usual "no text for
> disallowed", too (for the PARSE_OPT_NOARG | PARSE_OPT_LITERAL_ARGHELP
> case, which was previously meaningless), to be more intuitive.
> 
> The motivation is to allow update-index to correctly advertise
> 
> 	--cacheinfo <mode> <object> <path>
> 	                      add the specified entry to the index
> 
> while abusing PARSE_OPT_NOARG to disallow the "sticked form"
> 
> 	--cacheinfo=<mode> <object> <path>
> 
> Noticed-by: Stephen Boyd <bebarino@gmail.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> This seems like the intuitive thing to do, but the motivating use case
> is iffy.  Might be better to introduce a PARSE_OPT_NOSTICKED flag.

parse-options should accept both forms of --cacheinfo above if the
option isn't marked PARSE_OPT_NOARG. Marking it NOARG to get rid of the
equals sign in the usage seems wrong when both the equals sign and no
equals sign can be accepted. The fault lies in the implementation of the
low-level callback. It needs to handle more of the parsing.

If --cacheinfo is marked PARSE_OPT_NOARG it should show

	--cacheinfo

If --cacheinfo is marked PARSE_OPT_OPTARG it should show

	--cacheinfo[=<argh>]

If --cacheinfo isn't marked either of the above it should show

	--cacheinfo <argh>

which looks like what you want and it also says it takes an argument
unconditionally (perfect?). On top of that, the equals sign is optional
(or at least should be). At the point of get_value() p->opt will contain
whatever is after the equals sign for the option that is parsed. For
options which take no value (NOARG) they'll fail the test if they have
anything with an equals sign after it.

By not marking the cacheinfo option NOARG, we've successfully gotten
what we want so far. Now we just need to make the cacheinfo callback a
bit more like get_arg() and have it look at the context argument. If
p->opt is set, we should pull <mode> out of that and make sure we have
two more arguments. If p->opt isn't set, we should make sure we have 3
arguments and basically do what is already there.

I know this is a bit more code, but it also means that we don't have
this approach bite someone else down the line when they make assumptions
about options marked as NOARG not taking arguments.

We should probably add another check like "if argh is set and
PARSE_OPT_NOARG is true error out" so this can't be done.

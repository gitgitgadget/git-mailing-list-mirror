From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] sequencer: preserve commit messages
Date: Fri, 27 Feb 2015 16:31:52 +0100
Message-ID: <54F08DE8.3080907@drmicha.warpmail.net>
References: <1424540906.15539.22.camel@scientia.net>	<f58ae048d7fd468cfdd7f7d369b3b4fc0a564641.1424697676.git.git@drmicha.warpmail.net>	<xmqqsidwtq4i.fsf@gitster.dls.corp.google.com>	<54EC98BD.7060100@drmicha.warpmail.net>	<xmqq8ufnrwm1.fsf@gitster.dls.corp.google.com>	<54ED9AF7.6080908@drmicha.warpmail.net>	<xmqqoaohonpt.fsf@gitster.dls.corp.google.com>	<54EEFDF7.8090306@drmicha.warpmail.net> <xmqq61aomp1d.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Christoph Anton Mitterer <calestyo@scientia.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 16:32:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRMtU-0005zd-82
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 16:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbbB0Pb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2015 10:31:56 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:32806 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751334AbbB0Pbz (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2015 10:31:55 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id D9CA420D7F
	for <git@vger.kernel.org>; Fri, 27 Feb 2015 10:31:53 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 27 Feb 2015 10:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=AZxTmNZAapCR1wGnDvN6RP
	wpepk=; b=TZb26x+Woxehqbr83BWW45drbnCYOSW+kKRkKYcnQKcmk3JdIb6byl
	jR+zY4JJ/lY7Aby8hgXONlNeGXEdyPRfwwGVX64gyKZifsF/rw3OJk6j58S7Ag6p
	ZA7atqmKUwlFBGTWuz23sTtjiRTM+sKmWlXnMlbLay3v+vfs7B9EY=
X-Sasl-enc: VeLJmu5IffzlxvzkWqv1k9BE1f+Nt60Fj3avygslNC45 1425051114
Received: from localhost.localdomain (unknown [88.71.97.79])
	by mail.messagingengine.com (Postfix) with ESMTPA id 0DCB5680179;
	Fri, 27 Feb 2015 10:31:53 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqq61aomp1d.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264499>

Junio C Hamano venit, vidit, dixit 26.02.2015 20:49:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> Hmm. With "--edit", current config being in effect should be expected,
>> right? So how about:
>>
>> In case of no conflict: force cleanup=verbatim unless --edit is used?
> 
> Perhaps something like that.
> 
> Stepping back a bit and imagine a world where the sole purpose of
> cherry-pick were to recreate the original commit as faithfully as
> possible.  The commit log message would not be cleaned up in such
> a case by default, and the users need cherrypick.cleanup setting
> if they do not like that default.
> 
> The implementation of cherry-pick that does not spawn the editor
> in that world would look like this:
> 
>     - read the cleanup mode from cherrypick.cleanup config; if there
>       is none, read the cleanup mode from commit.cleanup config; if
>       neither is defined, then use 'verbatim' as the default;
> 
>     - invoke "commit --cleanup=" + that mode from the command line
>       to force the mode chosen by the above.
> 
> Thanks to the falling back to commit.cleanup, the above logic would
> be usable even before we invent cherrypick.cleanup configuration,
> i.e. in today's world.  If there is no commit.cleanup defined by the
> user, the above logic would still use 'verbatim' as the default for
> 'cherry-pick', while using the 'default' for 'commit'.
> 
> When cherry-pick invokes the editor, then the first part would be
> different.  So my conclusion would be something like:
> 
>     #if IN_THE_FUTURE
>         if (config_exists(cherrypick.cleanup))
>             mode = config_value(cherrypick.cleanup);
>         else
>     #endif
>         if (config_exists(commit.cleanup))
>             mode = config_value(commit.cleanup);
>         else
>             mode = editing ? 'verbatim' : 'default';
> 
>         invoke "commit --cleanup=" + mode;
> 
> perhaps?
> 

Without any config being set the result is certainly what I'm after.

What I'm still wondering about is the case without --edit but with
commit.cleanup: It seems to me that "git commit" being involved in a
conflict-less cherry-pick is solely an implemention detail (and it could
be done differently). Applying commit.* in this situation is a total
surpise to the normal user, isn't it? I mean, again, what's the
difference to rebase from a user perspective?

Michael

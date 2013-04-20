From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Teach git to change to a given directory using -C option
Date: Sat, 20 Apr 2013 15:18:38 -0700
Message-ID: <20130420221752.GA9980@elie.Belkin>
References: <1366374108-23725-1-git-send-email-ayiehere@gmail.com>
 <20130419161250.GC14263@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nazri Ramliy <ayiehere@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 21 00:19:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTg7Z-0004jH-O4
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 00:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755705Ab3DTWSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Apr 2013 18:18:51 -0400
Received: from mail-da0-f46.google.com ([209.85.210.46]:35252 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755616Ab3DTWSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Apr 2013 18:18:50 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so2453550dan.5
        for <git@vger.kernel.org>; Sat, 20 Apr 2013 15:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=gYY2ItKC2o3lA7vOCUMspyB8JfhJdzvyIQtM4nVLIWg=;
        b=SnaUKqhPeDLUd0f2OSUM25p82FX1mL73VxWQOuMqcaoCrz0fGQlpVzonp40fKejtFb
         Qn9r6LeQd5+88A/7h7Z02LLiVWVVwq1LgcULbkrQ17fFzcqn1VvuBMLGGwnd+6mgk7/i
         rKA5fRAX3OhkjG+ro6AwOw0+8/ZKi4NLxR9aOm9H4MaAJRKOVTAOliNFz5Zb6D47g6p+
         MQKnn1DSzaaf4WiIoWq90dD+0LpSFR/oM/iCqX2TZa/VqC72patX/803nDE19e57KfNB
         WKM/UQfNFFZJoDUEnBXa9wekOSFKROHH1L7myXrZUEqsb5SscEYgvlxjkUaiafQlifRt
         bMdQ==
X-Received: by 10.66.158.36 with SMTP id wr4mr8895706pab.28.1366496330028;
        Sat, 20 Apr 2013 15:18:50 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id g8sm20258753pae.7.2013.04.20.15.18.48
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 20 Apr 2013 15:18:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130419161250.GC14263@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221878>

Jeff King wrote:
> On Fri, Apr 19, 2013 at 08:21:48PM +0800, Nazri Ramliy wrote:

>> Often I find myself needing to find out quickly the status of a repository that
>> is not in my currenct working directory, like this:
>>
>>          $ (cd ~/foo; git log -1)
>>
>> With this patch now i can simply do:
>>
>>          $ git -C ~/.zsh log -1 
>> 
>> That's just one example.
[...]
> You can _almost_ do this with "git --git-dir". But it expects the actual
> git directory, not a starting point for finding the git directory.
[...]
> It is redundant with "(cd foo && git ...)" in the shell, as you note,
> but sometimes it is more convenient to use "-C" (especially if you are
> exec-ing git from another program and want to avoid the shell entirely
> for quoting reasons).

When I want to run "git log" for a repository outside the cwd, I do
use --git-dir (or more precisely,

	$ GIT_DIR=$HOME/src/git/.git git log

), which works.

The "sometimes you just want to pass a command to 'exec'" use case
does not convince me.  I equally well might want to run "git" after
another command, or run "git" if and only if a repository exists
there, or do any number of other things.  If someone asked me how to
do that by passing a command to 'exec', I'd point them to

	sh -c 'cd foo && git ...'

as a way to answer all such questions at the same time.  So we're left
with "--git-dir does not automatically append .git when appropriate"
as the problem being solved, which is a real problem.  Maybe that is
worth fixing more directly?

It might also be convenient to be able to do something like

	git --git-dir=~/src/git log -- Documentation/

which this -C option makes easy.  *checks*  Actually it works without,
but for subtle reasons.  A more sensible way to spell that is

	git --git-dir=<wherever> -- :/Documentation/

which works fine.

All that said, I don't mind -C terribly as long as it can maintain
itself, which means including thorough documentation that covers the
purpose and how pathname parameters and envvars interact with the new
option and including tests under t/ to ensure it continues to work
correctly in the future.

Thanks for an interesting patch, and hope that helps,
Jonathan

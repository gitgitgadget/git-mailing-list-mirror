From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] shell: pay attention to exit status from 'help'
 command
Date: Sun, 10 Feb 2013 23:52:45 -0800
Message-ID: <20130211075245.GO15329@elie.Belkin>
References: <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <20130211035908.GA4543@sigill.intra.peff.net>
 <20130211041404.GA15329@elie.Belkin>
 <20130211041714.GA12281@sigill.intra.peff.net>
 <20130211042609.GC15329@elie.Belkin>
 <20130211043322.GA12735@sigill.intra.peff.net>
 <20130211055604.GE15329@elie.Belkin>
 <20130211055847.GG15329@elie.Belkin>
 <7vd2w7pbh5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sitaram Chamarty <sitaramc@gmail.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:53:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4oCT-0007y7-AT
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752805Ab3BKHwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:52:54 -0500
Received: from mail-da0-f43.google.com ([209.85.210.43]:40340 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752731Ab3BKHwx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:52:53 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so2600292dak.2
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 23:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=nYKsn5dwFhgCttyBoVpLmYTpSTG3ees40TRzgSlpf2w=;
        b=rEfc+3+iTaliPunLmUO36lk2kqsRhCr+lZqltandeuErAVm81WAIyhOzEFwFs36sPJ
         MTQFIcStG5MbuC8R9uV9wyUeFvhoVXECKqxLUGfF5L0oxVIuv71GZrR0kTuuzSto4Q76
         aZzNMwOzpJJ8CvHfaPlTcic/YKyK1IDh6KPjtWqyUOfvmgVNTGURuxKz1hruEptYY30n
         j9aQZVmpZrgCwUnqg1OfN8XDkfVQmKVZv3WYCDMGdQcIHTBroI7IIq5xeLEnpo/WHeP7
         PdOB+CD9AqXsmsrKcxb+0FRs12Ga6xFfFUmdYB21x6/A5F2BZCGrNZN506p6vDvvSloz
         ltUA==
X-Received: by 10.66.84.202 with SMTP id b10mr39243059paz.71.1360569173360;
        Sun, 10 Feb 2013 23:52:53 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id e6sm66131676paw.16.2013.02.10.23.52.50
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 23:52:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vd2w7pbh5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216020>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> +To disable interactive logins, displaying a greeting instead:
>> ++
>> +----------------
>> +$ chsh -s /usr/bin/git-shell
>> +$ mkdir $HOME/git-shell-commands
>> +$ cat >$HOME/git-shell-commands/help <<\EOF
>> +#!/bin/sh
>> +printf '%s\n' "Hi $USER! You've successfully authenticated, but I do not"
>
> Where in the sshd to git-shell exec chain is $USER variable set for
> the user?  Just being curious if this is the simplest but one of the
> more robust ways to get the user's name.

That's a good question.  environment= in an authorized_keys file is
obsolete, so USER generally represents the actual logged in user.

That means the main way to base behavior on private key (letting one
system user represent multiple people) is a gitolite-style command=
wrapper that checks SSH_ORIGINAL_COMMAND.  In that setup, there is no
reason to forward simple no-args "are you there?" requests to the
git-shell, so we can forget about it here.

So by the time we get to git-shell, most likely either

 A) this is a generic system user, with a username like "git", and the
    above example would insult the client with "Hi git!" or "Hi
    project-x-git!"

or

 B) each person has a separate account on the system, perhaps to help
    the admin to set filesystem permissions based on users and groups,
    and the above would address the user by her normal name.

Jonathan

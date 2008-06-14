From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: [RFC/PATCH (WIP)] gitweb: Use Test::WWW::Mechanize::CGI to test
 gitweb output
Date: Sat, 14 Jun 2008 23:12:27 +0200
Message-ID: <4854343B.40707@gmail.com>
References: <200806141447.28052.jnareb@gmail.com> <200806142007.35288.jnareb@gmail.com> <48540E70.4030507@gmail.com> <200806142059.52373.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 14 23:13:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7d3l-000679-I3
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 23:13:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbYFNVLz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 17:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754620AbYFNVLy
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 17:11:54 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:1881 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbYFNVLx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 17:11:53 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3030888fgg.17
        for <git@vger.kernel.org>; Sat, 14 Jun 2008 14:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=aT/Ma/KkEhUBSy7oYUnb5zzWVjpzScdsFLJRqS2SCYk=;
        b=g5i+bTNE/I7frGrfc72yM2L+bXwCQPke4ta0gxdawDcqmXww14NYb8k1nePaICLukh
         8QSm4zM13Umjd1hRAEy0qkVdUOlvue3sX/5zWfu4iibX3kowtxL78EUnmSrl1w1NTb8V
         5+k2AGrhckxKAv/AdzdHsqGlMNXqQtcWRYDUY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=mdOBw2q+R7RCP2TE9R3pAWmvKUCgHTqlV1lI+gQHsNLEIm0iQW4y2s0b1Z4IhzayQ1
         t9J26TpPikT6Z++CxX4RxAW+Am7Pv7kn8gdnSfP2axs7qitmMZzidIUzcT0oE5XfYGyO
         5rDzPHPiUhk0v470wfT8MoteEDYrKBKyjIbVw=
Received: by 10.86.1.11 with SMTP id 11mr6360406fga.27.1213477911988;
        Sat, 14 Jun 2008 14:11:51 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.200.93])
        by mx.google.com with ESMTPS id l19sm9585804fgb.7.2008.06.14.14.11.49
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Jun 2008 14:11:51 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <200806142059.52373.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85043>

Jakub Narebski wrote:
> Well, I'd divert stderr in tests cases (or use simply 'test_external'),
> or better filter stderr, only in those cases where there is spurious
> but not dangerous thing on stderr.

Since you can only run whole perl scripts with test_external, we'll have 
to resort to using those discard_/restore_stderr functions.  I doubt 
filtering for specific messages is worth the effort.

> But again, I think the solution would be either to add feature to
> Git.pm, something like command_output_pipe_no_stderr, which would
> redirect stderr to /dev/null,

(FYI, Git.pm has such a feature in the command method, though it it 
simply closes STDERR and doesn't properly re-open it, I believe.)  The 
Git::Repo API I'm writing doesn't currently generate any spurious output 
on stderr, but if it ever does I'll make sure it gets discarded.

>> Since you're accessing http://localhost/ URLs, the web server's PATH is 
>> in effect,...
> 
> It isn't.  http://localhost/ is just access convention,

Yup, I should've read TFM. :)  On my system, $PATH is empty in 
gitweb.cgi for some strange reason, but since using an absolute path for 
$GIT works, I won't track it down for now.

> [*1*] it would be nice to have perl_application in WWW::Mechanize::CGI,
> which would simply setup %ENV and use do() instead of system() on
> provided application.

Gitweb and probably CGI::Carp qw(fatalsToBrowser) use 'exit', so we'd 
have to use Test::Trap (or so) to catch those.  I think we should defer 
this until performance actually becomes an issue.

-- Lea

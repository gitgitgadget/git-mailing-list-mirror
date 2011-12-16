From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Gitweb: Avoid warnings when a repo does not have a valid HEAD
Date: Fri, 16 Dec 2011 15:55:36 +0100
Message-ID: <201112161555.37472.jnareb@gmail.com>
References: <1323982737-19065-1-git-send-email-jratt0@gmail.com> <7v62hhmr2s.fsf@alter.siamese.dyndns.org> <7vty51lbb0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Joe Ratterman <jratt0@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 15:56:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbZCj-0003wq-Uq
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 15:56:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab1LPO4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 09:56:04 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44468 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab1LPO4B (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 09:56:01 -0500
Received: by eekc4 with SMTP id c4so3286122eek.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 06:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=kEsTzuZsdopd5MiX2rjd/o0b6YG/UdPaK0ljepim0FY=;
        b=VY1sIHdw+Hk+8+++5d5e4oqwCM+5Bw1z7xLL2zbJMsTWWJ1yOiMyU68L2PkSk034QA
         fT5DQG5SzxAmxGQeIu970WW7q/hRdGdrUL6paEypawcjEUpN7UyT1nSnG6VQnRkrz3Dx
         X2liuKt9vE7JHVPNxyfovjfG+KpI4MlhMY1jk=
Received: by 10.213.26.16 with SMTP id b16mr1380990ebc.61.1324047360612;
        Fri, 16 Dec 2011 06:56:00 -0800 (PST)
Received: from [192.168.1.13] (abwb78.neoplus.adsl.tpnet.pl. [83.8.225.78])
        by mx.google.com with ESMTPS id x12sm38916716eef.9.2011.12.16.06.55.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Dec 2011 06:55:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vty51lbb0.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187280>

On Thu, 15 Dec 2011, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Joe Ratterman <jratt0@gmail.com> writes:
>>
>>> It is possible that the HEAD reference does not point to an existing
>>> branch.  When viewing such a repository in gitweb, a message like this
>>> one was sent to the error log:
>>>
>>>   gitweb.cgi: Use of uninitialized value in string eq at /usr/src/git/gitweb/gitweb.cgi line 5115.
>>>
>> ..., but in that case a repository with
>> a HEAD that points at an unborn branch _and_ have other refs that do point
>> at existing commit is already screwed-up, so if we want to be extremely
>> pedantic then perhaps ...
>>
>>     my $curr = ((defined $head && exists $ref{"id"} && defined $ref{"id"})

       my $curr = ((defined $head && defined $ref{"id"})

is enough, because '!exists $hash{key}' implies '!defined $hash{key}'
(though reverse is not true).

>> 		? ($ref{"id"} eq $head)
>>                 : 0);
> 
> Just in case, I was not suggesting to update the patch to look like the
> above by "if we want to be extremely pedantic".
> 
> After all, that error message in the log may be a good thing that notifies
> the site administrators about a suspicious repository so that it can be
> fixed (even though it was not a designed "feature" but something that
> happens to work).

Well, but for that those error messages should describe error; the above
is quite hard to translate to 

  warning: HEAD points to an unborn branch in repository foo.git

BTW. we should probably warn about this situation more clear, perhaps
by showing warning instead of empty place where subject of current commit
is usually shown.


Anyway git marks up branches (sic!) that _point to_ the same commit as
HEAD because we calculate it anyway, at least for 'summary' view.

Better solution would be to examine HEAD (either using Perl, or using
"git symbolic-ref") to get _name_ of current branch.  I'd rather avoid
yet another command call.

-- 
Jakub Narebski
Poland

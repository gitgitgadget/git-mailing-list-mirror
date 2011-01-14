From: Maaartin-1 <grajcar1@seznam.cz>
Subject: Re: [RFC/PATCH 2/1] fixup! Documentation: start to explain what git
 replace is for
Date: Fri, 14 Jan 2011 18:44:09 +0100
Message-ID: <4D308B69.1050003@seznam.cz>
References: <746745466.20110111134101@mail.ru> <m3lj2rbmq5.fsf@localhost.localdomain> <20110112000812.GA31950@burratino> <loom.20110112T232501-316@post.gmane.org> <20110114084903.GD11343@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Aleksey Shumkin <zapped@mail.ru>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 14 18:44:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdnhG-0003MD-Ex
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 18:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757303Ab1ANRoR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 12:44:17 -0500
Received: from smtp.seznam.cz ([77.75.76.43]:49398 "EHLO smtp.seznam.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190Ab1ANRoQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 12:44:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=beta; d=seznam.cz;
	h=X-Seznam-DomainKeys:X-Seznam-SPF:X-Virus-Info:Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Smtpd:X-Seznam-User:X-Session:X-Country:X-QM-Mark;
	b=cbxbsMulSp0tWa0UWPTdWhvj5KDTKG1NgubXk8R85UcgZPgXoDNK3yV808/5kXquH
	QgF3CfwqmCW6gSVPDCyLObUZq5J40urYIVpfvQ30p8Waun7QgrJDdmNPwDOYMnkLi6S
	hMd7WnPfE49KXZvemtMaILtI6Mv1dnjT1qTlFRo=
X-Seznam-DomainKeys: unknown
X-Seznam-SPF: neutral
X-Virus-Info: clean
Received: from [10.0.3.100] (188-120-198-113.luckynet.cz [188.120.198.113])
	by email-relay2.ng.seznam.cz (Seznam SMTPD 1.2.14@16206) with ESMTP;
	Fri, 14 Jan 2011 18:44:12 +0100 (CET)  
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.2; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110114084903.GD11343@burratino>
X-Smtpd: 1.2.14@16206
X-Seznam-User: grajcar1@seznam.cz
X-Session: 13455
X-Country: CZ
X-QM-Mark: email-qm2<573649597>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165115>

On 11-01-14 09:49, Jonathan Nieder wrote:
> Some tweaks suggested by Maaartin:

[snip]

> [side note: please do not prune the cc list; I only stumbled on this
> message in the online archive by luck]

What could I have done about it? I didn't received it by email and
answered using post.gmane.org. There's no way to add CC there. If I'd
wrote an email instead, it wouldn't be placed in the thread.

[snip]

>>> +<1> Find all parentless commits in the 'master' branch;
>>> +for 'master' read the branch holding v2.5 history.
>>
>> Aren't you later calling it "FIRST" and assuming there's only one?
> 
> Hmm.  I want to say that there _could_ be multiple parentless commits
> in the v2.5 history and we are treating one of them as its root (just
> like git master has multiple parentless ancestors but e83c5163 is
> conventionally considered its beginning).  Not sure how to write that
> clearly.

Maybe just something like "Let's assume there's only one and let's call
it FIRST". For the example, this is enough.

>> Isn't the combination of "-i" (=in-place edit) with redirection wrong?
> 
> Good catch (the "-i" is a typo).

I'd go the other way round and use "-i" so I'd need only one file. Using
a shell variable instead would be even better, s. below.

[snip]

I tried to use the vars instead of files below, but never tested it. I
used "first_commit" instead of both "tmp" and "new", which is not really
nice.

> +$ git rev-list master --parents | grep -v ' '
> +$ first=$(git rev-list master --parents | grep -v ' ') <1>
> +$ git rev-parse v2.4                                   <2>
> +$ git cat-file commit $first >tmp                      <3>

$ first_commit = $(git cat-file commit FIRST)       <3>

> +$ sed "/^tree / a \\
> +parent $(git rev-parse v2.4)" <tmp >new                <4>

$ first_commit = $($ echo $first_commit |
sed  "/^tree / a \\
parent $(git rev-parse v2.4)")                      <4>

Unfortunately, the line got too long. For sed unaware people like me it
may not be obvious that a line break is required. I'd use perl, anyway.

$ first_commit = $($ echo $first_commit |
perl -p
"s/^tree .*/$&\nparent $(git rev-parse v2.4)/")      <4>

> +$ new_commit=$(git hash-object -t commit -w new)       <5>

$ new_commit=$(echo $first_commit |
git hash-object -t commit -w --stdin)       <5>

[snip]

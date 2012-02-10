From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Fri, 10 Feb 2012 20:19:25 -0000
Organization: OPDS
Message-ID: <1175EF538DAF4FE092F2CD307D0427C9@PhilipOakley>
References: <201202042045.54114.jnareb@gmail.com> <201202071531.08385.jnareb@gmail.com> <CALKQrge821x7OoSekkWw7vUjP642jhbE0D9oWPcCxuuTXOqQHA@mail.gmail.com> <201202102038.55710.jnareb@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Jakub Narebski" <jnareb@gmail.com>,
	"Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Feb 10 21:19:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvww5-0006Gz-7k
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 21:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293Ab2BJUTG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 15:19:06 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:54376 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754713Ab2BJUTE (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 15:19:04 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMFAHN6NU9cHIWw/2dsb2JhbABEhRCFTaUEgQiBbQEEAQEEAQgBARkVEQUIAQEhCwIDBQIBAw4GAQECAgIFIQICFAEECBACBgcXBgEHAgkIAgECAwEMBIUngisJAwameJFxgS+HC4MDAhcTAgIBAgECBQcBNQkNGwGDXwVPBwQCgiEzYwSNT5Jxh1Q
X-IronPort-AV: E=Sophos;i="4.73,398,1325462400"; 
   d="scan'208";a="369840509"
Received: from host-92-28-133-176.as13285.net (HELO PhilipOakley) ([92.28.133.176])
  by out1.ip05ir2.opaltelecom.net with SMTP; 10 Feb 2012 20:19:02 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190448>

From: "Jakub Narebski" <jnareb@gmail.com> Sent: Friday, February 10, 2012 
7:38 PM
> On Tue, 7 Feb 2012, Johan Herland wrote:
>
>> (we are pretty much in violent agreement, so I will only comment where
>> I find it necessary)
>
> So now comes the hard part: actually implementing (well, designing and
> implementing) prototypes for 'secret' trait and 'public' trait...

It all sounds very sensible.

The one additional implemenation idea I'd like is to have, which is somewhat 
at a tangent to the secrecy issue, is having some record of what was pushed 
(made Public). For the sub-module case this is so that its super project can 
know if its submodules are public or not. A public super project that has 
'secret' sub-modules is awkward to say the least.

That's my thought anyway...

>
>> On Tue, Feb 7, 2012 at 15:31, Jakub Narebski <jnareb@gmail.com> wrote:
>
>> > Also, when thinking about different scenarios of why one would like to
>> > mark commit as 'secret', we might want to be able to mark commit as
>> > secret / unpublishable with respect to _subset_ of remotes, so e.g.
>> > I am prevented from accidentally publishing commits marked as 'secret'
>> > to public repository, or to CI/QA repository, but I can push (perhaps
>> > with warning) to group repository, together with 'secret'-ness state
>> > of said commit...
>> >
>> > ... though it wouldn't be as much 'secret' as 'confidential' ;-)
>>
>> Another way to achieve this would be to have a config flag to control
>> whether Git checks for the 'secret' flag before pushing. This config
>> flag could be set at the system/user level (to enable/disable the
>> feature as a whole), at the repo level (to enable/disable it in a
>> given repo), at the remote level (to enable/disable it on a given
>> repo), and finally at the branch level (to enable-disable it for a
>> given branch (and its upstream)). Thus you could have a .git/config
>> that looked like this:
>>
>>   [core]
>>   refusePushSecret = true
>>
>>   [remote "foo"]
>>   refusePushSecret = false
>>   url = ...
>>   fetch = ...
>>
>>   [branch "baz"]
>>   remote = foo
>>   merge = refs/heads/baz
>>   refusePushSecret = true
>>
>> This config would:
>>
>>  - refuse to push 'secret' commits from branch 'baz'
>> (branch.baz.refusePushSecret == true)
>>
>>  - but allow to push other branches with 'secret' commits to remote
>> 'foo' (remote.foo.refusePushSecret == false)
>>
>>  - but refuse to push 'secret' commits to other remotes
>> (core.refusePushSecret == true)
>>
>> (The order of precedence would be: branch config > remote config >
>> repo config > user config > system config > default when unset)
>
> You read my mind.
>
>> I am unsure whether the 'secret'-ness of a commit should follow across
>> the push, but if you do (assuming we store the 'secret' flag using
>> git-notes) this is simply a matter of synchronizing the
>> refs/notes/secret to the same remote.
>
> I think it should, so that 'secret' commit would not escape by accident
> via a group secret repository.
>
> What makes it hard (I think) is that we would prefer to transfer
> 'secret'-ness only for pushed commits.  That might be problem for notes
> based implementation of 'secret' annotation and 'secret'-ness transfer...
> though I guess knowing that there exist 'secret' commit with given SHA1
> which we do not have and should not have is not much breach of
> confidentiality.  Still...
>
> -- 
> Jakub Narebski
> Poland
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> -----
> No virus found in this message.
> Checked by AVG - www.avg.com
> Version: 2012.0.1913 / Virus Database: 2112/4801 - Release Date: 02/10/12
> 

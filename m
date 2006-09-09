From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: reset input record separator in parse_commit even on error
Date: Sun, 10 Sep 2006 00:00:18 +0200
Organization: At home
Message-ID: <edvdgb$mtt$1@sea.gmane.org>
References: <20060909151236.GA25518@liacs.nl> <20060909205159.GC16906@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 10 00:00:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMAru-0001QG-4B
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 00:00:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWIIWAA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 18:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWIIWAA
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 18:00:00 -0400
Received: from main.gmane.org ([80.91.229.2]:6867 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964883AbWIIV77 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 9 Sep 2006 17:59:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GMAre-0001Ng-TT
	for git@vger.kernel.org; Sat, 09 Sep 2006 23:59:50 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 23:59:50 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 09 Sep 2006 23:59:50 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26771>

Jeff King wrote:

> On Sat, Sep 09, 2006 at 05:12:36PM +0200, Sven Verdoolaege wrote:
> 
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index 7afdf33..60dd598 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -897,8 +897,8 @@ sub parse_commit {
>>              my $fd = git_pipe("rev-list", "--header", "--parents", "--max-count=1", $commit_id)
>>                      or return;
>>              @commit_lines = split '\n', <$fd>;
>> -            close $fd or return;
>>              $/ = "\n";
>> +            close $fd or return;
>>              pop @commit_lines;
>>      }
>>      my $header = shift @commit_lines;
> 
> You missed the other early return from git_pipe. However, I think the
> approach is wrong; this is a great opportunity to use the dynamic
> scoping offered by 'local':
> 
>   else {
>     local $/ = "\0";
>     # do stuff with $/ as "\0"
>   }
>   # $/ has automatically been reset at the end of the block

And this should be done consistently, for all plain formats 
(blob_plain, blobdiff_plain, commitdiff_plain), and some other
 places.

Sometimes it is
  local $/ = "\0";
more often
  local $/ = undef;
(or equivalently but slightly less human friendly, just 'local $/');

> Looking further at this bit of code, it seems even more confusing,
> though. We split the output of rev-list on NUL, grab presumably the
> entire thing (since there shouldn't be any NULs in the output, right?)
> and then split it on newline into a list. Why aren't we doing this:
>   else {
>     open my $fd, ...;
>     @commit_lines = map { chomp; $_ } <$fd>;
>     ...

That is because by default git-rev-list separates output for different
commits (when --header option is used) bu NULL... only because of 
"--max-count=1" there is only _one_ record... nevertheless it ends with 
"\0" (NULL) character.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 6/9] gitweb: Change appereance of marker of refs pointing to given object
Date: Tue, 15 Aug 2006 18:34:17 +0200
Organization: At home
Message-ID: <ebst0v$3gt$1@sea.gmane.org>
References: <200608140202.46160.jnareb@gmail.com> <200608140214.20450.jnareb@gmail.com> <7vy7tqc06u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 15 18:34:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD1ru-0007f1-L0
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 18:34:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030376AbWHOQeF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 12:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWHOQeF
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 12:34:05 -0400
Received: from main.gmane.org ([80.91.229.2]:33192 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030376AbWHOQeD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 12:34:03 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GD1rR-0007Ze-8g
	for git@vger.kernel.org; Tue, 15 Aug 2006 18:33:49 +0200
Received: from host-81-190-28-152.torun.mm.pl ([81.190.28.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 18:33:49 +0200
Received: from jnareb by host-81-190-28-152.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Aug 2006 18:33:49 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-28-152.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25463>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> Change git_get_references to include type of ref in the %refs value, which
>> means putting everything after 'refs/' as a ref name, not only last
>> part of the name.  Instead of separating refs pointing to the same
>> object by " / " separator, use anonymous array reference to store all
>> refs pointing to given object.
>>
>> Use 'git-ls-remote .' if $projectroot/$project/info/refs does not
>> exist.  (Perhaps it should be used always.)
>>
>> Refs are now in separate span elements.  Class is dependent on the ref
>> type: currently known classes are 'tag', 'head', 'remote', and 'ref'
>> (last one for HEAD and other refs in the main directory).  There is
>> encompassing span element of class refs, just in case of unknown ref
>> type.
> 
> I do not see definition that matches "span.refs span.remote" in
> the CSS, though.

It get's default style "span.refs span" (and fefault colors).

>> +                    # e.g. tags/v2.6.11 or heads/next
>> +                    if ($ref =~ m!^(.*?)s?/(.*)$!) {
>> +                            $type = $1;
>> +                            $name = $2;
>> +                    } else {
>> +                            $type = "ref";
>> +                            $name = $ref;
>> +                    }
> 
> Hmph.  Maybe have a hash that defines the ones you know how to
> handle, and do something like:
> 
>         if ($ref =~ m|^([^/]+)/(.*)$| &&  exists $i_know_this_class{$1}) {
>               $type = $1;
>               $name = $2;
>       }
>         else {
>               $type = 'ref';
>               $name = $ref;
>       }

But what types are known is defined in CSS, not in gitweb.perl. The rule
is that type is defined by first component of the ref name, in singular form
(so with optional final s removed, refs -> ref, tags -> tag, remotes -> remote).
All unknown types get default "span.refs span" format, thanks to encompassing
span element.

"ref" class is for refs directly in $GIT_DIR, like HEAD or ORIG_HEAD (as of now
you cannot get such a ref due to the regexp used in git_get_references, and
the fact that you have no such refs in $GIT_DIR/info/refs file, and 
'git-ls-remote .' gives only HEAD; but we could add them 'by hand').

>> @@ -561,18 +578,24 @@ sub git_get_project_owner {
>>...
>> +            if ($line =~ m/^([0-9a-fA-F]{40})\trefs\/($type\/?[^\^]+)/) {
>>                      if (defined $refs{$1}) {
>> -                            $refs{$1} .= " / $2";
>> +                            push @{$refs{$1}}, $2;
>>                      } else {
>> -                            $refs{$1} = $2;
>> +                            $refs{$1} = [ $2 ];
>>                      }
>>              }
> 
> It would work as in your patch, but I would have preferred to
> see "exists $refs{$1}" there instead of "defined".
> 
> Or lose the if() and do it like this, which would be cleaner?
> 
>       if ($line =~ ...) {
>               push @{$refs{$1}}, $2;
>       }

That's even better.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] gitweb: href() function to generate URLs for CGI
Date: Tue, 22 Aug 2006 10:18:29 +0200
Organization: At home
Message-ID: <eceekl$b0l$2@sea.gmane.org>
References: <200608211739.32993.jnareb@gmail.com> <7v1wrauex2.fsf@assigned-by-dhcp.cox.net> <eccujr$90h$1@sea.gmane.org> <7vlkphqmac.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Tue Aug 22 10:19:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFRTr-0007bA-AZ
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 10:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128AbWHVITE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 04:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWHVITE
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 04:19:04 -0400
Received: from main.gmane.org ([80.91.229.2]:6039 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932097AbWHVITC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 04:19:02 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFRTD-0007TP-3l
	for git@vger.kernel.org; Tue, 22 Aug 2006 10:18:47 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 10:18:47 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 10:18:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25838>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> This doesn't work as expected. Map works on _every_ element of list; if
>> expression doesn't return anything it just puts undef I think. For example
>> while
>>
>>         print join(";", 
>>                 map { 
>>                         "a/$_" if ($_ eq lc($_)) 
>>                 } ("a", "b", "C", "d")),
>>                 "\n";'
>>
>> returns "a/a;a/b;;a/d" (notice the doubled ';'), the correct way would be to
> 
> ... say this, than using extra grep {}.
> 
>         print join(";", 
>                 map { 
>                         ($_ eq lc($_)) ? "a/$_" : ()
>                 } ("a", "b", "C", "d")),
>                 "\n";

That's better. I didn't know about this trick. Patch will follow.

BTW. I have encountered this error in true situation, while doing history
pagination because I forgot in parse_difftree_raw_line that the
map(function, list) works only for prototyped functions, and had undef fed
to href.

>> What about my proposed solution? Don't sort, use sorted keys instead, i.e.
>> something like (after unmangling whitespace)
>>
>> sub href(%) {
>>         my @mapping = ( project => "p",
>>                         action => "a",
>>                         hash => "h",
>>                         hash_parent => "hp",
>>                         hash_base => "hb",
>>                         file_name => "f",
>>                         file_parent => "fp",
>>                         page => "pg",
>>                         searchtext => "s",
>>                         );
>>         my %mapping;
>>         my @mapping_keys;                        
>>         for (my $i = 0; $i < @mapping; $i += 2) {
>>                 my ($k, $v) = ($mapping[$i], $mapping[$i+1]);
>>                 $mapping{$k} = $v;
>>                 push @mapping_keys, $k;
>>         }
> 
> Now this loop got an expensive way to say %mapping = @mapping
> plus assigning @mapping_keys, so I would do only the push part
> in the loop for readability while changing the name of the
> variable a bit more meaningful.
> 
>       my %mapping = @mapping;
>         my @valid_params;
>       for (my $i = 0; $i < @mapping; $i += 2) {
>               push @valid_params, $mapping[$i];
>       }
> 
> But aside from that, I very much prefer your version that loops
> over what _we_ define (i.e. @valid_params), rather than what the
> user happens to throw at us (i.e. keys %params).

So perhaps

        my %mapping = @mapping;
        my @params_keys_sorted;
        for (my $i = 0; $i < @mapping; $i += 2) {
                if (exists $params{$mapping[$i]}) {
                        push @params_keys_sorted, $mapping[$i];
                }
        }

This way we have only one loop over all valid parameter names,
and we wouldn't need grep nor conditional expression in map,
and map would loop over all (valid) params keys only.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

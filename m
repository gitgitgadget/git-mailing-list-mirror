From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] gitweb: href() function to generate URLs for CGI
Date: Mon, 21 Aug 2006 20:38:45 +0200
Organization: At home
Message-ID: <eccujr$90h$1@sea.gmane.org>
References: <200608211739.32993.jnareb@gmail.com> <7v1wrauex2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Aug 21 20:39:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFEgE-0000nC-7X
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 20:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWHUSjT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 14:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750718AbWHUSjT
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 14:39:19 -0400
Received: from main.gmane.org ([80.91.229.2]:43673 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750714AbWHUSjS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Aug 2006 14:39:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFEfv-0000je-2X
	for git@vger.kernel.org; Mon, 21 Aug 2006 20:39:03 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 20:39:03 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 21 Aug 2006 20:39:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25811>

Junio C Hamano wrote:

> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> In first version of href() function we had
>> (commit 06a9d86b49b826562e2b12b5c7e831e20b8f7dce)
>>
>>      my $href = "$my_uri?";
>>      $href .= esc_param( join(";",
>>              map {
>>                      "$mapping{$_}=$params{$_}"
>>              } keys %params
>>      ) );
>>
>> First, there was a question what happend if someone would enter 
>> parameter name incorrectly, and some key of %params is not found in 
>> %mapping hash. The above code would generate warnings (which web admins 
>> frown upon), and empty (because undef) parameters corresponding to e.g. 
>> mistyped parameter name. 
> 
> The one in "next" seems to do this (the diff is between "master"
> and "next"):
> 
> @@ -204,7 +277,9 @@ sub href(%) {
>  
>       my $href = "$my_uri?";
>       $href .= esc_param( join(";",
> -             map { "$mapping{$_}=$params{$_}" } keys %params
> +             map {
> +                     "$mapping{$_}=$params{$_}" if defined $params{$_}
> +             } keys %params
>       ) );
>  
>       return $href;
> 

This doesn't work as expected. Map works on _every_ element of list; if
expression doesn't return anything it just puts undef I think. For example
while

        print join(";", 
                map { 
                        "a/$_" if ($_ eq lc($_)) 
                } ("a", "b", "C", "d")),
                "\n";'

returns "a/a;a/b;;a/d" (notice the doubled ';'), the correct way would be to
use grep instead:

        print join(";",
                map {
                        "a/$_"
                } grep { 
                        ($_ eq lc($_)) 
                } ("a", "b", "C", "d")),
                "\n";

returns correct "a/a;a/b;a/d". So the fragment should read what I wrote:

        my $href = "$my_uri?";
        $href .= esc_param( join(";",
                map {
                        "$mapping{$_}=$params{$_}"
                } grep { exists $mapping{$_} } keys %params
        ) );

>> Second problem is that using href() function, although it consolidates 
>> to generate URL for CGI, it changes the order of CGI parameters. It 
>> used to be that 'p' (project) parameter was first, then 'a' (action) 
>> parameter, then hashes ('h', 'hp', 'hb'), last 'f' (filename) or 
>> 'p' (page) or 's' (searchtext). The simplest and fastest solution would 
>> be to create array with all keys of %mapping in appropriate order and 
>> do something like this:
>>
>>      my @mapping_sorted = ('project', 'action', 'hash',
>>              'hash_parent', 'hash_base', 'file_name', 'searchtext');
>>
>>      my $href = "$my_uri?";
>>      $href .= esc_param( join(";",
>>              map {
>>                      "$mapping{$_}=$params{$_}"
>>              } grep { exists $params{$_}} @mapping_sorted;
>>      ) );
>>
>> The problem is of course updating both %mappings and @mapping_sorted.
>>
>> Is this really a problem, should this (ordering of CGI parameters)
>> addressed?
> 
> Keeping the generated URL stable would be a very desirable
> feature.  Perhaps something like this?
> 
> sub href(%) {
>         my @mapping = ( project => "p",
>                         action => "a",
>                         hash => "h",
>                         hash_parent => "hp",
>                         hash_base => "hb",
>                         file_name => "f",
>                         file_parent => "fp",
>                         page => "pg",
>                         searchtext => "s",
>                         );
>       my %mapping;                        
>         for (my $i = 0; $i < @mapping; $i += 2) {
>               my ($k, $v) = ($mapping[$i], $mapping[$i+1]);
>                 $mapping{$k} = [$i, $v];
>         }
>       my %params = @_;
>       $params{"project"} ||= $project;
> 
>       my $href = "$my_uri?";
>       $href .= esc_param( join(";",
>               map { $_->[1] }
>               sort { $a->[0] <=> $b->[0] }
>               map {
>                       (defined $params{$_} && exists $mapping{$_})
>                       ? [ $mapping{$_}[0], "$mapping{$_}[1]=$params{$_}" ]
>                         : ();
>               } keys %params
>       ) );
> 
>       return $href;
> }

What about my proposed solution? Don't sort, use sorted keys instead, i.e.
something like (after unmangling whitespace)

sub href(%) {
        my @mapping = ( project => "p",
                        action => "a",
                        hash => "h",
                        hash_parent => "hp",
                        hash_base => "hb",
                        file_name => "f",
                        file_parent => "fp",
                        page => "pg",
                        searchtext => "s",
                        );
        my %mapping;
        my @mapping_keys;                        
        for (my $i = 0; $i < @mapping; $i += 2) {
                my ($k, $v) = ($mapping[$i], $mapping[$i+1]);
                $mapping{$k} = $v;
                push @mapping_keys, $k;
        }
        my %params = @_;
        $params{"project"} ||= $project;

        my $href = "$my_uri?";
        $href .= esc_param( join(";",
                map { "$mapping{$_}=$params{$_}" }
                grep { exists $params{$_} } 
                @mapping_keys
        ) );

        return $href;
}

This has the advantage and disadvantage of constant cost, linear with number
of %mapping keys, instead of N log N cost where N is number of parameters.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

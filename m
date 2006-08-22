From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] gitweb: href() function to generate URLs for CGI
Date: Tue, 22 Aug 2006 01:55:51 -0700
Message-ID: <7vodudno88.fsf@assigned-by-dhcp.cox.net>
References: <200608211739.32993.jnareb@gmail.com>
	<7v1wrauex2.fsf@assigned-by-dhcp.cox.net> <eccujr$90h$1@sea.gmane.org>
	<7vlkphqmac.fsf@assigned-by-dhcp.cox.net> <eceekl$b0l$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 22 10:56:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFS3F-0005qS-4y
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 10:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWHVIz6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 04:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWHVIz6
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 04:55:58 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:61606 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932143AbWHVIz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 04:55:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822085551.SQBW554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 04:55:51 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eceekl$b0l$2@sea.gmane.org> (Jakub Narebski's message of "Tue,
	22 Aug 2006 10:18:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25842>

Jakub Narebski <jnareb@gmail.com> writes:

> So perhaps
>
>         my %mapping = @mapping;
>         my @params_keys_sorted;
>         for (my $i = 0; $i < @mapping; $i += 2) {
>                 if (exists $params{$mapping[$i]}) {
>                         push @params_keys_sorted, $mapping[$i];
>                 }
>         }
>
> This way we have only one loop over all valid parameter names,
> and we wouldn't need grep nor conditional expression in map,
> and map would loop over all (valid) params keys only.

At that point I suspect that loop can do everything your map {}
did, and would look simpler (albeit perhaps a little bit less
Perlish) like this:

sub href(%) {
	my %params = @_;
	$params{"project"} ||= $project;
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
	my @result = (); 
        for (my $i = 0; $i < @mapping; $i += 2) {
        	my ($name, $symbol) = ($mapping[$i], $mapping[$i+1]);
		if (defined $params{$name}) {
			push @result, "$symbol=$params{$name}";
		}
	}
        return "$my_uri?" . esc_param(join(';', @result));
}

By the way, is it really what we want to do to call esc_param()
on joined result?

Maybe I am not reading this code correctly, but this feels quite
counter-intuitive.  Actually, it feels downright wrong.

Semicolons and equals are used as separators between key-value
pairs (i.e. syntactic elements) so if we have a value
$params{$name} that happens to contain a ';' or '=' character I
suspect we would want to quote that but not the one we use
before the value or between tuples.  Otherwise, how is a search
text that is "a = b;" encoded in the resulting href?

So the last part of the above should perhaps read:

	my @result = (); 
        for (my $i = 0; $i < @mapping; $i += 2) {
        	my ($name, $symbol) = ($mapping[$i], $mapping[$i+1]);
		if (defined $params{$name}) {
			push @result, join('=', esc_param($symbol),
						esc_param($params{$name}));
		}
	}
        return "$my_uri?" . join(';', @result);

We would also need to fix esc_param to quote ';' and '=' as
well, which does not seem to quote them.

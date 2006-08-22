From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] gitweb: href() function to generate URLs for CGI
Date: Tue, 22 Aug 2006 00:09:31 -0700
Message-ID: <7vlkphqmac.fsf@assigned-by-dhcp.cox.net>
References: <200608211739.32993.jnareb@gmail.com>
	<7v1wrauex2.fsf@assigned-by-dhcp.cox.net> <eccujr$90h$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 22 09:09:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFQOG-0003nE-AG
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 09:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWHVHJd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 03:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWHVHJd
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 03:09:33 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:25272 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751108AbWHVHJc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 03:09:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822070931.XABJ21457.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 03:09:31 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eccujr$90h$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	21 Aug 2006 20:38:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25836>

Jakub Narebski <jnareb@gmail.com> writes:

> This doesn't work as expected. Map works on _every_ element of list; if
> expression doesn't return anything it just puts undef I think. For example
> while
>
>         print join(";", 
>                 map { 
>                         "a/$_" if ($_ eq lc($_)) 
>                 } ("a", "b", "C", "d")),
>                 "\n";'
>
> returns "a/a;a/b;;a/d" (notice the doubled ';'), the correct way would be to

... say this, than using extra grep {}.

        print join(";", 
                map { 
                        ($_ eq lc($_)) ? "a/$_" : ()
                } ("a", "b", "C", "d")),
                "\n";

> What about my proposed solution? Don't sort, use sorted keys instead, i.e.
> something like (after unmangling whitespace)
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
>         my %mapping;
>         my @mapping_keys;                        
>         for (my $i = 0; $i < @mapping; $i += 2) {
>                 my ($k, $v) = ($mapping[$i], $mapping[$i+1]);
>                 $mapping{$k} = $v;
>                 push @mapping_keys, $k;
>         }

Now this loop got an expensive way to say %mapping = @mapping
plus assigning @mapping_keys, so I would do only the push part
in the loop for readability while changing the name of the
variable a bit more meaningful.

	my %mapping = @mapping;
        my @valid_params;
	for (my $i = 0; $i < @mapping; $i += 2) {
	        push @valid_params, $mapping[$i];
	}

But aside from that, I very much prefer your version that loops
over what _we_ define (i.e. @valid_params), rather than what the
user happens to throw at us (i.e. keys %params).

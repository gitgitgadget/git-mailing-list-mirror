From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] gitweb: href() function to generate URLs for CGI
Date: Mon, 21 Aug 2006 11:22:49 -0700
Message-ID: <7v1wrauex2.fsf@assigned-by-dhcp.cox.net>
References: <200608211739.32993.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 21 20:23:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFEQU-0005nm-SV
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 20:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWHUSWx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 14:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWHUSWx
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 14:22:53 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:6364 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751187AbWHUSWw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 14:22:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060821182250.CQDW4015.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Aug 2006 14:22:50 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200608211739.32993.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 21 Aug 2006 17:39:32 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25809>

Jakub Narebski <jnareb@gmail.com> writes:

> In first version of href() function we had
> (commit 06a9d86b49b826562e2b12b5c7e831e20b8f7dce)
>
> 	my $href = "$my_uri?";
> 	$href .= esc_param( join(";",
> 		map {
> 			"$mapping{$_}=$params{$_}"
> 		} keys %params
> 	) );
>
> First, there was a question what happend if someone would enter 
> parameter name incorrectly, and some key of %params is not found in 
> %mapping hash. The above code would generate warnings (which web admins 
> frown upon), and empty (because undef) parameters corresponding to e.g. 
> mistyped parameter name. 

The one in "next" seems to do this (the diff is between "master"
and "next"):

@@ -204,7 +277,9 @@ sub href(%) {
 
 	my $href = "$my_uri?";
 	$href .= esc_param( join(";",
-		map { "$mapping{$_}=$params{$_}" } keys %params
+		map {
+			"$mapping{$_}=$params{$_}" if defined $params{$_}
+		} keys %params
 	) );
 
 	return $href;

So we perhaps would want to say:

	if (defined $params{$_} && exists $mapping{$_})

instead there?

> Second problem is that using href() function, although it consolidates 
> to generate URL for CGI, it changes the order of CGI parameters. It 
> used to be that 'p' (project) parameter was first, then 'a' (action) 
> parameter, then hashes ('h', 'hp', 'hb'), last 'f' (filename) or 
> 'p' (page) or 's' (searchtext). The simplest and fastest solution would 
> be to create array with all keys of %mapping in appropriate order and 
> do something like this:
>
> 	my @mapping_sorted = ('project', 'action', 'hash',
> 		'hash_parent', 'hash_base', 'file_name', 'searchtext');
>
> 	my $href = "$my_uri?";
> 	$href .= esc_param( join(";",
> 		map {
> 			"$mapping{$_}=$params{$_}"
> 		} grep { exists $params{$_}} @mapping_sorted;
> 	) );
>
> The problem is of course updating both %mappings and @mapping_sorted.
>
> Is this really a problem, should this (ordering of CGI parameters)
> addressed?

Keeping the generated URL stable would be a very desirable
feature.  Perhaps something like this?

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
        for (my $i = 0; $i < @mapping; $i += 2) {
        	my ($k, $v) = ($mapping[$i], $mapping[$i+1]);
                $mapping{$k} = [$i, $v];
        }
	my %params = @_;
	$params{"project"} ||= $project;

	my $href = "$my_uri?";
	$href .= esc_param( join(";",
		map { $_->[1] }
		sort { $a->[0] <=> $b->[0] }
		map {
                	(defined $params{$_} && exists $mapping{$_})
			? [ $mapping{$_}[0], "$mapping{$_}[1]=$params{$_}" ]
                        : ();
		} keys %params
	) );

	return $href;
}

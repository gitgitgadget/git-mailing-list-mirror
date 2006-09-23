From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Sat, 23 Sep 2006 05:29:48 +0200
Message-ID: <20060923032948.GE8259@pasky.or.cz>
References: <200609212356.31806.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sham Chukoury <eleusis@xmms.org>
X-From: git-owner@vger.kernel.org Sat Sep 23 05:30:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQyDF-0007HP-97
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 05:29:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbWIWD3v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 23:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWIWD3v
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 23:29:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55483 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750755AbWIWD3u (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 23:29:50 -0400
Received: (qmail 8558 invoked by uid 2001); 23 Sep 2006 05:29:48 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200609212356.31806.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27556>

Dear diary, on Thu, Sep 21, 2006 at 11:56:31PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Below there is preliminary (hence RFC) committag support for gitweb,
> based on the idea introduced by Sham Chukoury to gitweb-xmms2.
> 
> The code has all the possible committags I could think of enabled;
> not all are tested, though. This includes existing commitsha tag
> support (full sha links to commit view, is sha is sha of commit),
> mantis bug and feature tags from gitweb-xmms2 (there is no release
> committag of gitweb-xmms2, but it should be fairly easy to add it),
> bugzilla committag for the Linux kernel, plain text URL committag
> (probably doesn't work that well, marking as links examples, and
> sometimes protocol specification), and Message-Id committag via
> GMane git mailing list (and not only) archive -- not tested.

I think that's a good test. People will certainly want more but that can
be added over time.

> -- >8 --
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 7ed963c..5eb0dd0 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -173,6 +173,118 @@ sub feature_pickaxe {
>  	return ($_[0]);
>  }
>  
> +# You define site-wide comittags defaults here; override them with
> +# $GITWEB_CONFIG as necessary.
> +our %committags = (
> +	# 'committag' => {
> +	# 	'pattern' => regexp (use 'qr' quote-like operator)
> +	# 	'sub' => committag-sub (subroutine),
> +	# 	'enabled' => is given committag enabled,
> +	# fields below can be defined, but don't need to
> +	# 	'options' => [ default options...] (array reference),
> +	# 	'insubject' => should given committag be enabled in commit/tag subject,
> +	# 	'islink' => if the result is hyperlink,
> +	# }
> +	#
> +	# You should ensure that enabled committags cannot overlap
> +	#
> +	# The committag subroutine is called with match for pattern,
> +	# and options if they are defined. Match is replaced by return
> +	# value of committag-sub.

You should note that the pattern matches in an already HTML-escaped
text. Which is actually quite ugly especially wrt. the &nbsp;, perhaps
it would be worth considering converting the spaces after this? (The
Marc links would need fixing tho'.)

..snip..
> +	'message_id' => {
> +		'pattern' => qr/(message|msg)[- ]?id&nbsp;&lt;([^&]*)&rt;/i,
> +		'enabled' => 1,
> +		'options' => [
> +			'http://news.gmane.org/find-root.php?message_id=',
> +			\&quote_msgid_gmane ],
> +		'sub' => \&tag_msgid},

Mention quote_msgid_marc() (and the URL) in a comment so that it's not
completely unreferenced?

> +);
..snip..
> +sub quote_msgid_gmane {
> +	my $msgid = shift || return;
> +
> +	return '<'.(quotemeta $msgid).'>';
> +}

<> should be HTML-escaped (unless CGI::a() does that).

> @@ -577,18 +693,43 @@ ## which don't beling to other sections
..snip..
> -	if ($line =~ m/([0-9a-fA-F]{40})/) {
> -		my $hash_text = $1;
> -		if (git_get_type($hash_text) eq "commit") {
> -			my $link =
> -				$cgi->a({-href => href(action=>"commit", hash=>$hash_text),
> -				        -class => "text"}, $hash_text);
> -			$line =~ s/$hash_text/$link/;
> +
> +	foreach my $ct (@tags) {
> +		next unless exists $committags{$ct};

At this point, I'd complain (even die) rather than silently pass, that's
definitely a bug.

> +		my $wrap = $a_attr && %$a_attr && $committags{$ct}{'islink'};

$a_attr can't be but a hashref, that test is redundant.

> @@ -626,12 +767,13 @@ sub format_subject_html {
>  	$extra = '' unless defined($extra);
>  
>  	if (length($short) < length($long)) {
> -		return $cgi->a({-href => $href, -class => "list subject",
> -		                -title => $long},
> -		       esc_html($short) . $extra);
> +		my $a_attr = {-href => $href, -class => "list subject", -title => $long};
> +		return $cgi->a($a_attr,
> +		       format_log_line_html($short, $a_attr, @subjecttags) . $extra);
>  	} else {
> -		return $cgi->a({-href => $href, -class => "list subject"},
> -		       esc_html($long)  . $extra);
> +		my $a_attr = {-href => $href, -class => "list subject"};
> +		return $cgi->a($a_attr,
> +		       format_log_line_html($long,  $a_attr, @subjecttags) . $extra);
>  	}
>  }
>  

Subjects are often clickable and we don't want links in those.

> @@ -693,9 +835,9 @@ sub git_get_type {
>  
>  	open my $fd, "-|", git_cmd(), "cat-file", '-t', $hash or return;
>  	my $type = <$fd>;
> -	close $fd or return;
> +	close $fd or return "unknown";
>  	chomp $type;
> -	return $type;
> +	return ($type || "unknown");
>  }
>  
>  sub git_get_project_config {

> P.S. I've corrected git_get_type for comparison
>   git_get_type($hash) eq "commit"
> to work without Perl syntax errors.

Hey it's just a warning. ;-) And if you are calling git_get_type() on a
non-existing object, don't you have a problem you should better know
about? Couldn't this break git_get_refs_list()?

> @@ -1585,7 +1727,7 @@ sub git_print_log ($;%) {
>  			$empty = 0;
>  		}
>  
> -		print format_log_line_html($line) . "<br/>\n";
> +		print format_log_line_html($line, @committags) . "<br/>\n";
>  	}
>  
>  	if ($opts{'-final_empty_line'}) {

What about the tags? Or perhaps even blobs, for that matter?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)

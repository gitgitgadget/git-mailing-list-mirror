From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Sat, 23 Sep 2006 10:34:49 +0200
Message-ID: <200609231034.49545.jnareb@gmail.com>
References: <200609212356.31806.jnareb@gmail.com> <20060923032948.GE8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 23 10:35:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR2yM-0002wp-Ty
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 10:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWIWIev (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 04:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbWIWIev
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 04:34:51 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:52917 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751145AbWIWIeu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 04:34:50 -0400
Received: by ug-out-1314.google.com with SMTP id o38so324159ugd
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 01:34:49 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nFOQyXbe4ylve8pCZN3PnOHoYuMYvF0mGFKrO6DeZuy59hV+sJnYXVCh3kHMr+n9jJeTuMDXUIka3+VRNouY2tJdpRIBvSDfLGdsJ1FlPk9Er0iKdojTGb7R/QuH59O/2Zg5FqBxfgDlGCDkiFm9LXzZTIqVyGRmGXOfoAAwX8Q=
Received: by 10.67.101.8 with SMTP id d8mr1367119ugm;
        Sat, 23 Sep 2006 01:34:48 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id k1sm105087ugf.2006.09.23.01.34.48;
        Sat, 23 Sep 2006 01:34:48 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <20060923032948.GE8259@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27569>

Petr "Pasky" Baudis wrote:
> Dear diary, on Thu, Sep 21, 2006 at 11:56:31PM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...

> > +	# The committag subroutine is called with match for pattern,
> > +	# and options if they are defined. Match is replaced by return
> > +	# value of committag-sub.
> 
> You should note that the pattern matches in an already HTML-escaped
> text. Which is actually quite ugly especially wrt. the &nbsp;, perhaps
> it would be worth considering converting the spaces after this? (The
> Marc links would need fixing tho'.)

Perhaps we better use "white-space: pre;" for commit (and tag) messages
instead of 'manually' doing this via converting ' ' to '&nbsp;'.
 
> ..snip..
> > +	'message_id' => {
> > +		'pattern' => qr/(message|msg)[- ]?id&nbsp;&lt;([^&]*)&rt;/i,
> > +		'enabled' => 1,
> > +		'options' => [
> > +			'http://news.gmane.org/find-root.php?message_id=',
> > +			\&quote_msgid_gmane ],
> > +		'sub' => \&tag_msgid},
> 
> Mention quote_msgid_marc() (and the URL) in a comment so that it's not
> completely unreferenced?

Well, that is RFC. I'm not sure if the final patch would have all those
committags, all those committags but disabled with exception of commitsha/sha,
or just commitsha tag in source and the rest in commit message as examples.

For MARC:

	'options' => [
		'http://marc.theaimsgroup.com/?i=',
		\&quote_msgid_marc ],

> > +);
> ..snip..
> > +sub quote_msgid_gmane {
> > +	my $msgid = shift || return;
> > +
> > +	return '<'.(quotemeta $msgid).'>';
> > +}
> 
> <> should be HTML-escaped (unless CGI::a() does that).

CGI::a() probably does that. But true, "<" and ">" should be "params quoted":

	return '%3c' . (quotemeta $msgid) . '%3e';

(Quotemeta is because Message-Id contains '@').

> > @@ -577,18 +693,43 @@ ## which don't beling to other sections
> ..snip..
> > -	if ($line =~ m/([0-9a-fA-F]{40})/) {
> > -		my $hash_text = $1;
> > -		if (git_get_type($hash_text) eq "commit") {
> > -			my $link =
> > -				$cgi->a({-href => href(action=>"commit", hash=>$hash_text),
> > -				        -class => "text"}, $hash_text);
> > -			$line =~ s/$hash_text/$link/;
> > +
> > +	foreach my $ct (@tags) {
> > +		next unless exists $committags{$ct};
> 
> At this point, I'd complain (even die) rather than silently pass,
> that's definitely a bug.

I've programmed defensively. Perhaps too defensively.

> > +		my $wrap = $a_attr && %$a_attr && $committags{$ct}{'islink'};
> 
> $a_attr can't be but a hashref, that test is redundant.

$a_attr can be undefined or be a hashref. It could theoretically
be empty hashref, but that is a mistake (<a>...</a>).

> > @@ -626,12 +767,13 @@ sub format_subject_html {
> >  	$extra = '' unless defined($extra);
> >  
> >  	if (length($short) < length($long)) {
> > -		return $cgi->a({-href => $href, -class => "list subject",
> > -		                -title => $long},
> > -		       esc_html($short) . $extra);
> > +		my $a_attr = {-href => $href, -class => "list subject", -title => $long};
> > +		return $cgi->a($a_attr,
> > +		       format_log_line_html($short, $a_attr, @subjecttags) . $extra);
> >  	} else {
> > -		return $cgi->a({-href => $href, -class => "list subject"},
> > -		       esc_html($long)  . $extra);
> > +		my $a_attr = {-href => $href, -class => "list subject"};
> > +		return $cgi->a($a_attr,
> > +		       format_log_line_html($long,  $a_attr, @subjecttags) . $extra);
> >  	}
> >  }
> >  
> 
> Subjects are often clickable and we don't want links in those.

The extra code with $a_attr is to have links within links. It works
quite well, I'd say. The subject link is broken, and the committag
link is inserted in the break (gitweb-xmms2 committag code did the same,
but did not preserved all the subject link attributes, like title or class,
only the target of the link).

The result is somethink like:

  <a href="..." class="subject" ...>Fix </a><a href="...=137">BUG(137)</a><a href="..." class="subject" ...>: ...</a> 

> > @@ -693,9 +835,9 @@ sub git_get_type {
> >  
> >  	open my $fd, "-|", git_cmd(), "cat-file", '-t', $hash or return;
> >  	my $type = <$fd>;
> > -	close $fd or return;
> > +	close $fd or return "unknown";
> >  	chomp $type;
> > -	return $type;
> > +	return ($type || "unknown");
> >  }
> >  
> >  sub git_get_project_config {
> 
> > P.S. I've corrected git_get_type for comparison
> >   git_get_type($hash) eq "commit"
> > to work without Perl syntax errors.
> 
> Hey it's just a warning. ;-) And if you are calling git_get_type() on a
> non-existing object, don't you have a problem you should better know
> about? Couldn't this break git_get_refs_list()?

There are many cherry-picked comments with commitsha of object which
existed on some topic branch, was pruned, and does not exist anymore.
Perhaps we should add "2> /dev/null", too...

I've not tested how this change works with git_get_refs_list(), and other
subroutines that use git_get_type().

> > @@ -1585,7 +1727,7 @@ sub git_print_log ($;%) {
> >  			$empty = 0;
> >  		}
> >  
> > -		print format_log_line_html($line) . "<br/>\n";
> > +		print format_log_line_html($line, @committags) . "<br/>\n";
> >  	}
> >  
> >  	if ($opts{'-final_empty_line'}) {
> 
> What about the tags? Or perhaps even blobs, for that matter?

What about? In commit messages you usually reference other commits
(as: this correct some commit, this finishes what was started in commit,
this reverts commit (!), cherry-picked commit).

Thanks for all the comments.
-- 
Jakub Narebski
Poland

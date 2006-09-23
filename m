From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Sat, 23 Sep 2006 14:11:34 +0200
Message-ID: <20060923121134.GM13132@pasky.or.cz>
References: <200609212356.31806.jnareb@gmail.com> <20060923032948.GE8259@pasky.or.cz> <200609231034.49545.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 14:11:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR6M8-0002RS-8i
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 14:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbWIWMLh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 08:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWIWMLh
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 08:11:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18381 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750790AbWIWMLg (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 08:11:36 -0400
Received: (qmail 15144 invoked by uid 2001); 23 Sep 2006 14:11:34 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200609231034.49545.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27583>

Dear diary, on Sat, Sep 23, 2006 at 10:34:49AM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Perhaps we better use "white-space: pre;" for commit (and tag) messages
> instead of 'manually' doing this via converting ' ' to '&nbsp;'.

+1

> > ..snip..
> > > +	'message_id' => {
> > > +		'pattern' => qr/(message|msg)[- ]?id&nbsp;&lt;([^&]*)&rt;/i,
> > > +		'enabled' => 1,
> > > +		'options' => [
> > > +			'http://news.gmane.org/find-root.php?message_id=',
> > > +			\&quote_msgid_gmane ],
> > > +		'sub' => \&tag_msgid},
> > 
> > Mention quote_msgid_marc() (and the URL) in a comment so that it's not
> > completely unreferenced?
> 
> Well, that is RFC. I'm not sure if the final patch would have all those
> committags, all those committags but disabled with exception of commitsha/sha,
> or just commitsha tag in source and the rest in commit message as examples.

I'd disable mantis and bugzilla by default (but leave them in the code
commented out) since those are totally project-specific, but a lot of
OSS projects use gmane and URL and commitsha are universally beneficial.

Also, there is a fundamental limitation for the multi-word patterns that
they won't work if the line wraps at that point in the log message. This
will likely be a problem especially for the msgids, because those are
very long and are very likely to cause a linewrap immediately before.

By the way, I don't think taking just 40-digits sha1s is very useful,
since that's insanely long and besides the linewrap issue, a lot of
people just shorten that to some 8 to 12 digits now - I'd use {8-40}
instead (the enforced minimum is 4 in the Git autocompletion code but we
shouldn't encourage people to write so ambiguous sha1s to persistent
records).

> > > +);
> > ..snip..
> > > +sub quote_msgid_gmane {
> > > +	my $msgid = shift || return;
> > > +
> > > +	return '<'.(quotemeta $msgid).'>';
> > > +}
> > 
> > <> should be HTML-escaped (unless CGI::a() does that).
> 
> CGI::a() probably does that. But true, "<" and ">" should be "params quoted":
> 
> 	return '%3c' . (quotemeta $msgid) . '%3e';

Ah, sillly me, I didn't notice that it goes into the URL.

> (Quotemeta is because Message-Id contains '@').

Hmm, and at which point would that be eaten?

> > > @@ -577,18 +693,43 @@ ## which don't beling to other sections
> > > +		my $wrap = $a_attr && %$a_attr && $committags{$ct}{'islink'};
> > 
> > $a_attr can't be but a hashref, that test is redundant.
> 
> $a_attr can be undefined or be a hashref. It could theoretically
> be empty hashref, but that is a mistake (<a>...</a>).

Yes so no point in testing the emptiness. But this is just nitpicking.

> > > @@ -626,12 +767,13 @@ sub format_subject_html {
> > >  	$extra = '' unless defined($extra);
> > >  
> > >  	if (length($short) < length($long)) {
> > > -		return $cgi->a({-href => $href, -class => "list subject",
> > > -		                -title => $long},
> > > -		       esc_html($short) . $extra);
> > > +		my $a_attr = {-href => $href, -class => "list subject", -title => $long};
> > > +		return $cgi->a($a_attr,
> > > +		       format_log_line_html($short, $a_attr, @subjecttags) . $extra);
> > >  	} else {
> > > -		return $cgi->a({-href => $href, -class => "list subject"},
> > > -		       esc_html($long)  . $extra);
> > > +		my $a_attr = {-href => $href, -class => "list subject"};
> > > +		return $cgi->a($a_attr,
> > > +		       format_log_line_html($long,  $a_attr, @subjecttags) . $extra);
> > >  	}
> > >  }
> > >  
> > 
> > Subjects are often clickable and we don't want links in those.
> 
> The extra code with $a_attr is to have links within links. It works
> quite well, I'd say. The subject link is broken, and the committag
> link is inserted in the break (gitweb-xmms2 committag code did the same,
> but did not preserved all the subject link attributes, like title or class,
> only the target of the link).
> 
> The result is somethink like:
> 
>   <a href="..." class="subject" ...>Fix </a><a href="...=137">BUG(137)</a><a href="..." class="subject" ...>: ...</a> 

I don't think this is good idea though - if I'm clicking at links, I
don't want to have to carefully watch where that bit of the link leads.
IMHO this would be just annoying.

> > > @@ -693,9 +835,9 @@ sub git_get_type {
> > >  
> > >  	open my $fd, "-|", git_cmd(), "cat-file", '-t', $hash or return;
> > >  	my $type = <$fd>;
> > > -	close $fd or return;
> > > +	close $fd or return "unknown";
> > >  	chomp $type;
> > > -	return $type;
> > > +	return ($type || "unknown");
> > >  }
> > >  
> > >  sub git_get_project_config {
> > 
> > > P.S. I've corrected git_get_type for comparison
> > >   git_get_type($hash) eq "commit"
> > > to work without Perl syntax errors.
> > 
> > Hey it's just a warning. ;-) And if you are calling git_get_type() on a
> > non-existing object, don't you have a problem you should better know
> > about? Couldn't this break git_get_refs_list()?
> 
> There are many cherry-picked comments with commitsha of object which
> existed on some topic branch, was pruned, and does not exist anymore.

Then I think it's better to explicitly state that "in this case, this
object may not exist" by checking the return value for undef first.

> Perhaps we should add "2> /dev/null", too...

Yes that would be sensible.

> > > @@ -1585,7 +1727,7 @@ sub git_print_log ($;%) {
> > >  			$empty = 0;
> > >  		}
> > >  
> > > -		print format_log_line_html($line) . "<br/>\n";
> > > +		print format_log_line_html($line, @committags) . "<br/>\n";
> > >  	}
> > >  
> > >  	if ($opts{'-final_empty_line'}) {
> > 
> > What about the tags? Or perhaps even blobs, for that matter?
> 
> What about? In commit messages you usually reference other commits
> (as: this correct some commit, this finishes what was started in commit,
> this reverts commit (!), cherry-picked commit).

I meant that we should consider substituting the committags in those as
well.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)

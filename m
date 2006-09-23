From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Sat, 23 Sep 2006 15:33:01 +0200
Message-ID: <200609231533.02455.jnareb@gmail.com>
References: <200609212356.31806.jnareb@gmail.com> <200609231034.49545.jnareb@gmail.com> <20060923121134.GM13132@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Sep 23 15:33:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR7d2-0001rV-WF
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 15:33:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWIWNdH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 09:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751174AbWIWNdH
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 09:33:07 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:25004 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751172AbWIWNdG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 09:33:06 -0400
Received: by ug-out-1314.google.com with SMTP id o38so336923ugd
        for <git@vger.kernel.org>; Sat, 23 Sep 2006 06:33:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=phV6r+Qe3WUG/4gs4ecPeVzQZ+Gazur+b38lLg+n7v9jluWwTNwG4WKcsh7oi8ZdMdPTTNThM92M2THUhhgKJHgDmFkrYfotfxW91jm1ZRr73rHr7K9U5ZOlbl7u1cugMwnq16PikMWyTzscmagQicAoaDSVrP0FVKHzE4wBcmM=
Received: by 10.66.240.12 with SMTP id n12mr1571129ugh;
        Sat, 23 Sep 2006 06:33:04 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id o24sm292349ugd.2006.09.23.06.33.03;
        Sat, 23 Sep 2006 06:33:04 -0700 (PDT)
To: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <20060923121134.GM13132@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27589>

Petr Baudis wrote:

> Dear diary, on Sat, Sep 23, 2006 at 10:34:49AM CEST, I got a letter
> where Jakub Narebski <jnareb@gmail.com> said that...

> Also, there is a fundamental limitation for the multi-word patterns that
> they won't work if the line wraps at that point in the log message. This
> will likely be a problem especially for the msgids, because those are
> very long and are very likely to cause a linewrap immediately before.

We do not wrap log messages in gitweb. So the problem is only when
commit message is wrongly wrapped itself (pre imples nowrap).

>> > > +);
>> > ..snip..
>> > > +sub quote_msgid_gmane {
>> > > +	my $msgid = shift || return;
>> > > +
>> > > +	return '<'.(quotemeta $msgid).'>';
>> > > +}
>> > 
>> > <> should be HTML-escaped (unless CGI::a() does that).
>> 
>> CGI::a() probably does that. But true, "<" and ">" should be "params quoted":
>> 
>> 	return '%3c' . (quotemeta $msgid) . '%3e';
> 
> Ah, silly me, I didn't notice that it goes into the URL.

Should it be "params quoted" or not? What are valid characters
in message-id? (And in which RFC it is defined?)

>> (Quotemeta is because Message-Id contains '@').
> 
> Hmm, and at which point would that be eaten?

In the substitution phase... but perhaps I was to defensive.
s/$from/$to/g where $to can have '@'. 

>> > > @@ -626,12 +767,13 @@ sub format_subject_html {
>> > >  	$extra = '' unless defined($extra);
>> > >  
>> > >  	if (length($short) < length($long)) {
>> > > -		return $cgi->a({-href => $href, -class => "list subject",
>> > > -		                -title => $long},
>> > > -		       esc_html($short) . $extra);
>> > > +		my $a_attr = {-href => $href, -class => "list subject", -title => $long};
>> > > +		return $cgi->a($a_attr,
>> > > +		       format_log_line_html($short, $a_attr, @subjecttags) . $extra);
>> > >  	} else {
>> > > -		return $cgi->a({-href => $href, -class => "list subject"},
>> > > -		       esc_html($long)  . $extra);
>> > > +		my $a_attr = {-href => $href, -class => "list subject"};
>> > > +		return $cgi->a($a_attr,
>> > > +		       format_log_line_html($long,  $a_attr, @subjecttags) . $extra);
>> > >  	}
>> > >  }
>> > >  
>> > 
>> > Subjects are often clickable and we don't want links in those.
>> 
>> The extra code with $a_attr is to have links within links. It works
>> quite well, I'd say. The subject link is broken, and the committag
>> link is inserted in the break (gitweb-xmms2 committag code did the same,
>> but did not preserved all the subject link attributes, like title or class,
>> only the target of the link).
>> 
>> The result is somethink like:
>> 
>>   <a href="..." class="subject" ...>Fix </a><a href="...=137">BUG(137)</a><a href="..." class="subject" ...>: ...</a> 
> 
> I don't think this is good idea though - if I'm clicking at links, I
> don't want to have to carefully watch where that bit of the link leads.
> IMHO this would be just annoying.

The committag links within subject link are clearly visually distinguished:
first they have default link color (blue for not visited, dark red for
visited links), second they are not bold width (as opposed to gitweb-xmms2,
where bold font was due to <b>...</b> element and not CSS styling 
of a.subject).

I have just noticed that somehow git_log ("log" view) doesn't use
format_subject_line (perhaps because it is not shortened) and that
committags are not used there. And that is not only place where
subjecttags (committags in clickable subject line) are not used.

By the way, you can easily disable some committags in subject, either
removing 'insubject' field, or setting it to false.

>> > > @@ -1585,7 +1727,7 @@ sub git_print_log ($;%) {
>> > >  			$empty = 0;
>> > >  		}
>> > >  
>> > > -		print format_log_line_html($line) . "<br/>\n";
>> > > +		print format_log_line_html($line, @committags) . "<br/>\n";
>> > >  	}
>> > >  
>> > >  	if ($opts{'-final_empty_line'}) {
>> > 
>> > What about the tags? Or perhaps even blobs, for that matter?
>> 
>> What about? In commit messages you usually reference other commits
>> (as: this correct some commit, this finishes what was started in commit,
>> this reverts commit (!), cherry-picked commit).
> 
> I meant that we should consider substituting the committags in those as
> well.

Ahh... For tags I guess it is a good idea (especially that I think that
fixes for bugtracker tracked bugs and feature request should be marked by tags,
e.g. b/<bugid>, to be used to link to commit/change/patch from bugtracker. 

By the way, should we use some color for PGP signature block in signed tags?

-- 
Jakub Narebski
ShadeHawk on #git
Torun, Poland

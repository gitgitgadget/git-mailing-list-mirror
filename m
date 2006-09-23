From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH] gitweb: Add committags support
Date: Sat, 23 Sep 2006 16:05:35 +0200
Message-ID: <20060923140535.GK8259@pasky.or.cz>
References: <200609212356.31806.jnareb@gmail.com> <200609231034.49545.jnareb@gmail.com> <20060923121134.GM13132@pasky.or.cz> <200609231533.02455.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 16:05:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GR88h-000074-8H
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 16:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWIWOFh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 10:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWIWOFh
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 10:05:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60346 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750720AbWIWOFh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Sep 2006 10:05:37 -0400
Received: (qmail 25508 invoked by uid 2001); 23 Sep 2006 16:05:35 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200609231533.02455.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27590>

Dear diary, on Sat, Sep 23, 2006 at 03:33:01PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> Petr Baudis wrote:
> 
> > Dear diary, on Sat, Sep 23, 2006 at 10:34:49AM CEST, I got a letter
> > where Jakub Narebski <jnareb@gmail.com> said that...
> 
> > Also, there is a fundamental limitation for the multi-word patterns that
> > they won't work if the line wraps at that point in the log message. This
> > will likely be a problem especially for the msgids, because those are
> > very long and are very likely to cause a linewrap immediately before.
> 
> We do not wrap log messages in gitweb. So the problem is only when
> commit message is wrongly wrapped itself (pre imples nowrap).

The commit message is not "wrongly" wrapped but just wrapped to fit into
72 or whatever columns. It would be silly to mandate users to use msg-id: <200609231533.02455.jnareb@gmail.com>
with the message id stretching far away just for the sake of some
gitweb limitations when having the message wrapped such as msg-id:
<200609231533.02455.jnareb@gmail.com> looks much more reasonable.

> >> > > +);
> >> > ..snip..
> >> > > +sub quote_msgid_gmane {
> >> > > +	my $msgid = shift || return;
> >> > > +
> >> > > +	return '<'.(quotemeta $msgid).'>';
> >> > > +}
> >> > 
> >> > <> should be HTML-escaped (unless CGI::a() does that).
> >> 
> >> CGI::a() probably does that. But true, "<" and ">" should be "params quoted":
> >> 
> >> 	return '%3c' . (quotemeta $msgid) . '%3e';
> > 
> > Ah, silly me, I didn't notice that it goes into the URL.
> 
> Should it be "params quoted" or not? What are valid characters
> in message-id? (And in which RFC it is defined?)

RFC2822. Unfortunately there can be all kind of crap inside if you put
it inside quotes, so yes, it should.

What a pity that (apparently) noone supports RFC2392.

> >> (Quotemeta is because Message-Id contains '@').
> > 
> > Hmm, and at which point would that be eaten?
> 
> In the substitution phase... but perhaps I was to defensive.
> s/$from/$to/g where $to can have '@'. 

$ perl -le 'my $x="a\@bc"; my $y="@"; $x =~ s/$y/$y.$y/g; print $x;'
a@.@bc

You probably should regexp-quote $from if you don't yet, though,
although a misbehaviour from that side is not very probable.

> >> > Subjects are often clickable and we don't want links in those.
> >> 
> >> The extra code with $a_attr is to have links within links. It works
> >> quite well, I'd say. The subject link is broken, and the committag
> >> link is inserted in the break (gitweb-xmms2 committag code did the same,
> >> but did not preserved all the subject link attributes, like title or class,
> >> only the target of the link).
> >> 
> >> The result is somethink like:
> >> 
> >>   <a href="..." class="subject" ...>Fix </a><a href="...=137">BUG(137)</a><a href="..." class="subject" ...>: ...</a> 
> > 
> > I don't think this is good idea though - if I'm clicking at links, I
> > don't want to have to carefully watch where that bit of the link leads.
> > IMHO this would be just annoying.
> 
> The committag links within subject link are clearly visually distinguished:
> first they have default link color (blue for not visited, dark red for
> visited links), second they are not bold width (as opposed to gitweb-xmms2,
> where bold font was due to <b>...</b> element and not CSS styling 
> of a.subject).

Ok, in that case it's better though I'm still feeling somewhat
uncomfortable about it. What if the _whole_ subject is just "Bug 1324"?
I can click the 'commit' link instead but it throws exception in my
brain I need to handle and I need to move my mouse around.

> > I meant that we should consider substituting the committags in those as
> > well.
> 
> Ahh... For tags I guess it is a good idea (especially that I think that
> fixes for bugtracker tracked bugs and feature request should be marked by tags,
> e.g. b/<bugid>, to be used to link to commit/change/patch from bugtracker. 

For blobs, the point is mainly comments, those can contain all kinds of
stuff.

> By the way, should we use some color for PGP signature block in signed tags?

Sounds like a good idea.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)

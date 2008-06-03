From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue, 3 Jun 2008 13:18:49 -0700 (PDT)
Message-ID: <839911.60903.qm@web31810.mail.mud.yahoo.com>
References: <m34p8a2173.fsf@localhost.localdomain>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 22:26:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3d5N-0000U3-Ee
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 22:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755671AbYFCUZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 16:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbYFCUZb
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 16:25:31 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:45563 "HELO
	web31810.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752706AbYFCUZ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Jun 2008 16:25:29 -0400
X-Greylist: delayed 397 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jun 2008 16:25:29 EDT
Received: (qmail 61252 invoked by uid 60001); 3 Jun 2008 20:18:49 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-Mailer:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Message-ID;
  b=WPB4Ry5yAQAp36aetqYCt2sxcywzeDDzN54U8akDutB+IQ0DDaM1enjW4aDkN1rolDLJoeOYQhplRfwrq17FRsbvpbrd8pKGhw6LGUolbudS3tNGjv9LnOxX2lBiMYZLTeP9SynkNPhIoCcQ9nzHt89fLCaBAMzqqyJ6ZARTPHo=;
Received: from [99.159.44.58] by web31810.mail.mud.yahoo.com via HTTP; Tue, 03 Jun 2008 13:18:49 PDT
X-Mailer: YahooMailWebService/0.7.199
In-Reply-To: <m34p8a2173.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83702>

--- On Tue, 6/3/08, Jakub Narebski <jnareb@gmail.com> wrote:
> From: Jakub Narebski <jnareb@gmail.com>
> Subject: Re: [PATCH] Avoid errors from git-rev-parse in gitweb blame
> To: "Rafael Garcia-Suarez" <rgarciasuarez@gmail.com>
> Cc: git@vger.kernel.org, "Luben Tuikov" <ltuikov@yahoo.com>
> Date: Tuesday, June 3, 2008, 4:43 AM
> Cc-ed Luben Tuikov, author of this part.

Thanks guys! :-)

> Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
> writes:
> 
> > git-rev-parse will abort with an error when passed a
> non-existent
> > revision spec, such as "deadbeef^" where
> deadbeef has no parent.

Yes, I've known about this ever since I coded this.
The reasoning was that the value of parsing up the "tree" of
parent changes was a lot more (valuable) than the value of detecting that
"deadbeef^" had no parent -- which would've been logically apparent
to the coder/reviewer/user of "blame2".

> > Using the --revs-only parameter makes this error go
> away, while
> > retaining functionality, keeping the web server error
> log nice
> > and clean.

Ok, that's fine, as long as indeed the functionality is preserved.
I leave it up to Jakub and Junio to make sure that indeed the
functionality is preserved. (I.e. saving us yet another patch
from anyone of us.)

> Thanks.  This error wasn't detected earlier probably
> because
> 'blame' view is rarely enabled; and repo.or.cz
> gitweb which has
> 'blame' enabled IIRC use gitweb which is modified
> there, allowing
> incremental blame using AJAX.

I'm a heavy user of "blame2", often exploring the course of
"evolution" of the code and/or code lines and segments.  I value this
in gitweb (being easier/more visual to use as opposed to command
line).

> 
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index 55fb100..f3b4b24 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -4226,9 +4226,9 @@ git_blame2
> >  			              esc_html($rev));
> >  			print "</td>\n";
> >  		}
> > -		open (my $dd, "-|", git_cmd(),
> "rev-parse", "$full_rev^")
> > +		open (my $dd, "-|", git_cmd(),
> "rev-parse", '--revs-only',
> "$full_rev^")
> >  			or die_error(undef, "Open git-rev-parse
> failed");
> > -		my $parent_commit = <$dd>;
> > +		my $parent_commit = <$dd> || '';
> >  		close $dd;
> >  		chomp($parent_commit);
> >  		my $blamed = href(action => 'blame',
> 
> I'd rather remove this, correct it, or make it optional
> (this is very
> fork-heavy).
> 
> But this patch is good as it is now...

Yes, I agree it is good.  Just you guys make sure that it doesn't change
the value of the functionality of the code.

Thanks everyone!
   Luben

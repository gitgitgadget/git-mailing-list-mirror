From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] Add options to specify snapshot file name, prefix
Date: Sat, 5 Nov 2011 09:47:14 +0100
Message-ID: <201111050947.15440.jnareb@gmail.com>
References: <1320302318-28315-1-git-send-email-dermoth@aei.ca> <m3fwi350ou.fsf@localhost.localdomain> <4EB488C9.2050301@aei.ca>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-4"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Guyot-Sionnest <dermoth@aei.ca>
X-From: git-owner@vger.kernel.org Sat Nov 05 09:47:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMbuK-0006Se-P6
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 09:47:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752058Ab1KEIrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Nov 2011 04:47:16 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43423 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750974Ab1KEIrP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Nov 2011 04:47:15 -0400
Received: by faao14 with SMTP id o14so3404074faa.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 01:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=J40FuoU/C5n13rqv+X0wprypdn8Dt0wZgRdreLlgKFw=;
        b=Er1Dzy7F7/AEacecCa7GeFIeW8KcZC6uNbz7zv5NeNekC9DBJ2bWCSGHKPbibmQFHF
         YpGkHtsGeMWWd/cvUc7lKJmK+sPaM9RI53k3nJ/1rSZl6V+1CB8eY+EgMPfobATk2IsY
         5OJDmlslOYggESguVDDTXCkTrYkUxSBqaJzMc=
Received: by 10.223.91.68 with SMTP id l4mr30493871fam.16.1320482833532;
        Sat, 05 Nov 2011 01:47:13 -0700 (PDT)
Received: from [192.168.1.13] (abwn145.neoplus.adsl.tpnet.pl. [83.8.237.145])
        by mx.google.com with ESMTPS id y17sm20572090faa.22.2011.11.05.01.47.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Nov 2011 01:47:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4EB488C9.2050301@aei.ca>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184837>

On Sat, 5 Nov 2011, Thomas Guyot-Sionnest wrote:
> On 11-11-04 12:10 PM, Jakub Narebski wrote:
> > Thomas Guyot-Sionnest <dermoth@aei.ca> writes:
> >
> > > commit b629275 implemented "smart" snapshot names and prefixes. I have
> > > scripts that used to rely on the old behaviour which allowed in some
> > > cases to have fixed prefix, and would require modifications to work with
> > > newer Gitweb.
[...]
> > > This patch adds two parameters for overriding the snapshot name and
> > > prefix, sn and sp respectively. For example, to get a snapshot
> > > named "myproject.[suffix]" with no prefix one can add this query string:
> > >   ?sn=myproject;sp=
> >
> > Would you need support for expandable parameters in both (a la
> > 'action' feature)?
> 
> I'm not sure what you mean... I never tinkered with gitweb.pl directly
> before.

I'm sorry I didn't make it clear what I meant here.

What I wanted to ask is if you would need support for snapshot names
like for example

   myproject-<full sha1>.tar.gz
 
It means that snapshot name depends on commit / tag / tree being archived;
for that you would need e.g.

   ...?sn=myproject-%H.tar.gz;sp=

But even if there would be need for this, it should be anyway put into
separate commit.


In short: forget about this comment.

[...]
> > > @@ -6684,11 +6686,19 @@ sub git_snapshot {
> > >  	}
> > >
> > >  	my ($name, $prefix) = snapshot_name($project, $hash);
> > > +	if (defined($input_params{'snapshot_name'})) {
> > > +		$name = $input_params{'snapshot_name'};
> > > +	}
> > > +	if (defined($input_params{'snapshot_prefix'})) {
> > > +		$prefix = $input_params{'snapshot_prefix'};
> > > +	} else {
> > > +		$prefix .= '/';
> > > +	}
> > >  	my $filename = "$name$known_snapshot_formats{$format}{'suffix'}";
> > >  	my $cmd = quote_command(
> > >  		git_cmd(), 'archive',
> > >  		"--format=$known_snapshot_formats{$format}{'format'}",
> > > -		"--prefix=$prefix/", $hash);
> > > +		"--prefix=$prefix", $hash);
> > >  	if (exists $known_snapshot_formats{$format}{'compressor'}) {
> > >  		$cmd .= ' | ' . quote_command(@{$known_snapshot_formats{$format}{'compressor'}});
> > >  	}
> >
> > I wonder if you really want to allow prefix which do not end in '/'
> 
> I kind of agree, yet considering its lack of "front-end" visibility it
> made me think of plumbing commands like git-checkout-index (which I use
> sometimes to replace the "missing" git export) where prefix is nothing
> more than an appended string to file names.
> 
> And now I remember, this is also exactly how git-archive works.

Right.

I wonder if anybody is using "git archive" with prefix that DOESN'T
end with a '/'...
 
> > (which would be suprising, isn't it), or just allow empty prefix too.
> >
> >
> > For example
> >
> >   @@ -6684,11 +6686,19 @@ sub git_snapshot {
> >    	}
> >
> >    	my ($name, $prefix) = snapshot_name($project, $hash);
> >   +	if (defined($input_params{'snapshot_name'})) {
> >   +		$name = $input_params{'snapshot_name'};
> >   +	}
> >   +	if (defined($input_params{'snapshot_prefix'})) {
> >   +		$prefix = $input_params{'snapshot_prefix'};
> >   +	}
> >    	my $filename = "$name$known_snapshot_formats{$format}{'suffix'}";
> >    	my $cmd = quote_command(
> >    		git_cmd(), 'archive',
> >    		"--format=$known_snapshot_formats{$format}{'format'}",
> >   -		"--prefix=$prefix/", $hash);
> >   +		($prefix eq "" ? () : "--prefix=$prefix"), $hash);
> >    	if (exists $known_snapshot_formats{$format}{'compressor'}) {
> >    		$cmd .= ' | ' . quote_command(@{$known_snapshot_formats{$format}{'compressor'}});
> >    	}
> >
> 
> You still have to add the /, i.e.:
> 
> >   +		($prefix eq "" ? () : "--prefix=$prefix/"), $hash);

True.  Sorry about that.
 
> And personally, I think git-archive is the one that should add a / - it
> has much more visibility to end-users than this obscure query-string.

So should we expect a re-roll?


P.S. I'd like to point out that git is now in pre-release feature freeze,
so please don't expect for these changes to appear in 'master' soon, though
most probably they would be available in 'pu' for the time being.

-- 
Jakub Narebski
Poland

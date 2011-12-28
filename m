From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] git-svn, perl/Git.pm: add central method for prompting passwords honoring GIT_ASKPASS and SSH_ASKPASS
Date: Wed, 28 Dec 2011 19:56:29 +0100
Message-ID: <201112281956.30289.jnareb@gmail.com>
References: <4EC52508.9070907@tu-clausthal.de> <4EFA5EB3.4000802@tu-clausthal.de> <7vboqt2zm4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 28 19:56:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rfyg5-00051b-Rd
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 19:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754379Ab1L1S4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 13:56:36 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:34920 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206Ab1L1S4e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 13:56:34 -0500
Received: by eekc4 with SMTP id c4so12494976eek.19
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 10:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=JmYLpx5g3UWLVlfFtAsee3TviR5xUxC25Dp8yztO16Q=;
        b=SsFvWvYj2NCvk2L07wdxoY8iGVNGEJqn8WgxV/13mu5pJ8Dc9EggM2+XQw2AdP+MeA
         G5uw6kcF+RprMAgUANLnIolt6mDsnXPewDCPg6jUafCNqtpIy9B7oIogK/b4Is+mOG5u
         +tjhn35KNtpSWdcuJrUi9s6Xu+KH8SHfdJO40=
Received: by 10.213.34.71 with SMTP id k7mr9561575ebd.18.1325098593063;
        Wed, 28 Dec 2011 10:56:33 -0800 (PST)
Received: from [192.168.1.13] (abwj79.neoplus.adsl.tpnet.pl. [83.8.233.79])
        by mx.google.com with ESMTPS id a60sm123790421eeb.4.2011.12.28.10.56.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 28 Dec 2011 10:56:32 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vboqt2zm4.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187753>

Junio C Hamano wrote:
> Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> I only have a few minor nits, and request for extra set of eyeballs from
> Perl-y people.
> 
> >  sub _read_password {
> >  	my ($prompt, $realm) = @_;
> > -	my $password = '';
> > -	if (exists $ENV{GIT_ASKPASS}) {
> > -		open(PH, "-|", $ENV{GIT_ASKPASS}, $prompt);
> > -		$password = <PH>;
> > -		$password =~ s/[\012\015]//; # \n\r
> > - ...
> > -		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
> > -			last if $key =~ /[\012\015]/; # \n\r
> > -			$password .= $key;
> > -		}
> > - ...
> > +	my $password = Git->prompt($prompt);
> >  	$password;
> >  }
> > ...
> > +Check if GIT_ASKPASS or SSH_ASKPASS is set, use first matching for querying
> > +user and return answer. If no *_ASKPASS variable is set, the variable is
> > +empty or an error occoured, the terminal is tried as a fallback.
> 
> Looks like a description that is correct, but I feel a slight hiccup when
> trying to read the first sentence aloud.  Perhaps other reviewers on the
> list can offer an easier to read alternative?

Perhaps

  Query user for password with given PROMPT and return answer.  It respects
  GIT_ASKPASS and SSH_ASKPASS environment variables, with terminal in a
  password mode (no echo) as a fallback.  Returns undef if it cannot ask
  for password. 

> > +sub prompt {
> > +	my ($self, $prompt) = _maybe_self(@_);
> > +	my $ret;
> > +	if (exists $ENV{'GIT_ASKPASS'}) {

Wouldn't it be simpler and more resilent to just check for $ENV{'GIT_ASKPASS'}?
Assuming that nobody uses command named '0' it would cover both GIT_ASKPASS
not being set (!exists) and being set to empty value (eq '').

> > +		$ret = _prompt($ENV{'GIT_ASKPASS'}, $prompt);
> > +	}
> > +	if (!defined $ret && exists $ENV{'SSH_ASKPASS'}) {
> > +		$ret = _prompt($ENV{'SSH_ASKPASS'}, $prompt);
> > +	}
> > +	if (!defined $ret) {
> > +		print STDERR $prompt;
> > +		STDERR->flush;
> > +		require Term::ReadKey;
> > +		Term::ReadKey::ReadMode('noecho');
> > +		while (defined(my $key = Term::ReadKey::ReadKey(0))) {
> > +			last if $key =~ /[\012\015]/; # \n\r
> > +			$ret .= $key;

I wonder if the last part wouldn't be better to be refactored into
a separate subroutine, e.g. _prompt_readkey.

> 
> Unlike the original in _read_password, $ret ($password over there) is left
> "undef" here; I am wondering if "$ret .= $key" might trigger a warning and
> if that is the case, probably we should have an explicit "$ret = '';"
> before going into the while loop.

No that is not a problem.  In Perl undefined variable functions as 0 in
numeric context ($foo++), as '' in string context ($foo .= $key), and []
in arrayref context (push @$foo, $key).

> > +sub _prompt {
> > +	my ($askpass, $prompt) = @_;
> > +	unless ($askpass) {
> > +		return undef;
> > +	}
> 
> Perl gurus on the list might prefer to rewrite this with statement
> modifier as "return undef unless (...);" but I am not one of them.
> 
> > +	my $ret;
> > +	open my $fh, "-|", $askpass, $prompt || return undef;
> 
> I am so used see this spelled with the lower-precedence "or" like this
> 
> 	open my $fh, "-|", $askpass, $prompt
>         	or return undef;
> 
> that I am no longer sure if the use of "||" is Ok here. Help from Perl
> gurus on the list?

It is incorrect, which you can check with B::Deparse.

$ perl -MO=Deparse,-p -e 'open my $fh, "-|", $askpass, $prompt || return undef;'

  open(my $fh, '-|', $askpass, ($prompt || return(undef)));
 
Anyway, wouldn't it be simpler and better to use command_oneline or its
backend here?

> > +	$ret = <$fh>;
> > +	$ret =~ s/[\012\015]//g; # strip \n\r, chomp does not work on all systems (i.e. windows) as expected
> 
> The original reads one line from the helper process, removes the first \n
> or \r (expecting there is only one), and returns the result. The new code
> reads one line, removes all \n and \r everywhere, and returns the result.
> 
> I do not think it makes any difference in practice, but shouldn't this
> logically be more like "s/\r?\n$//", that is "remove the CRLF or LF at the
> end"?
> 
> > +	close ($fh);
> 
> It seems that we aquired a SP after "close" compared to the
> original. What's the prevailing coding style in our Perl code?
> 
> This close() of pipe to the subprocess is where a lot of error checking
> happens, no? Can this return an error?
> 
> I can see the original ignored an error condition, but do we care, or not
> care?
 
If we use command_oneline or its backend we wouldn't have to worry
about this.

-- 
Jakub Narebski
Poland

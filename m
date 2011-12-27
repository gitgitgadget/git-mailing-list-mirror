From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] honour GIT_ASKPASS for querying username in git-svn
Date: Tue, 27 Dec 2011 06:33:51 -0800 (PST)
Message-ID: <m3d3baf5kd.fsf@localhost.localdomain>
References: <4EC52508.9070907@tu-clausthal.de>
	<CABPQNSZ0iPAE+BnDU6Nz8_PkrAtPbjL4RoJuQS=Um2wxPt-2DQ@mail.gmail.com>
	<4EC65DE4.90005@tu-clausthal.de>
	<CABPQNSbfM0JRVPk3fxfSEq7QaO-fynHM8FBGpPribdgeRqpZKA@mail.gmail.com>
	<4ED0CE8B.70205@tu-clausthal.de>
	<20111130064401.GC5317@sigill.intra.peff.net>
	<4EF907F1.1030801@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Tue Dec 27 15:34:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfY6J-00027K-Pi
	for gcvg-git-2@lo.gmane.org; Tue, 27 Dec 2011 15:34:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754440Ab1L0Odz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Dec 2011 09:33:55 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:44572 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754414Ab1L0Ody (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Dec 2011 09:33:54 -0500
Received: by eekc4 with SMTP id c4so11692623eek.19
        for <git@vger.kernel.org>; Tue, 27 Dec 2011 06:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=wHlAcg8tVm027ghoeL07DuAxsTE+BTnGise7i7B08w0=;
        b=WOF+ocsV8436C5eu5SMP382eT1YcI5FkjwbuirJd/iqV9Wln2q5No428Ghf00GvhG9
         M0Z+u68oJ8t/TwVIViLDyTENozueQmLMoM4tco7QBP3go1wpPQxIHrQd6Cn5jCiizcSj
         pW8YDgxjkjBpsaJ1OonlkxtsrCZVXJ3Lug01s=
Received: by 10.213.14.72 with SMTP id f8mr660165eba.127.1324996433061;
        Tue, 27 Dec 2011 06:33:53 -0800 (PST)
Received: from localhost.localdomain (abwg97.neoplus.adsl.tpnet.pl. [83.8.230.97])
        by mx.google.com with ESMTPS id q67sm45341412eea.8.2011.12.27.06.33.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Dec 2011 06:33:51 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBREX7Vj029465;
	Tue, 27 Dec 2011 15:33:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBREWotk029458;
	Tue, 27 Dec 2011 15:32:50 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4EF907F1.1030801@tu-clausthal.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187712>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> +=item prompt ( PROMPT)
> +
> +Checks if GIT_ASKPASS or SSH_ASKPASS is set, and if yes
> +use it and return answer from user.
> +
> +=cut

I think it would be good idea to describe what this function is for...

> +sub prompt {
> +	my ($self, $prompt) = _maybe_self(@_);
> +	if (exists $ENV{'GIT_ASKPASS'}) {
> +		return _prompt($ENV{'GIT_ASKPASS'}, $prompt);
> +	} elsif (exists $ENV{'SSH_ASKPASS'}) {
> +		return _prompt($ENV{'SSH_ASKPASS'}, $prompt);
> +	} else {
> +		return undef;
> +	}
> +}

...and provide some kind of fallback even if neither of GIT_ASKPASS
nor SSH_ASKPASS are set (perhaps assuming that some Perl packages from
CPAN are installed).

> +sub _prompt {
> +	my ($self, $askpass, $prompt) = _maybe_self(@_);
> +	my $ret;
> +	open(PH, "-|", $askpass, $prompt);
> +	$ret = <PH>;
> +	$ret =~ s/[\012\015]//g; # strip \n\r
> +	close(PH);
> +	return $ret;
> +}

Please, use modern Perl, in particula use lexical filehandles instead
of typeglobs (which are global variables), i.e.

  +	open my $fh, "-|", $askpass, $prompt
  +		or die "...";
  +	$ret = <$fh>;
  +	chomp($ret);
  +	close($fh)
  +		or die "...";


> -- 
> 1.7.7.1.msysgit.0
> 
> From ef4c6557d1b0e33440d13c64742d44b2a22143f3 Mon Sep 17 00:00:00 2001
> From: Sven Strickroth <email@cs-ware.de>
> Date: Tue, 27 Dec 2011 00:34:09 +0100
> Subject: [PATCH 2/4] switch to central prompt method
> 
> Signed-off-by: Sven Strickroth <email@cs-ware.de>

Please send those patches as a separate emails, not concatenated in a
single email (perhaps even with cover letter).

See Documentation/SubmittingPatches

[...]
-- 
Jakub Narebski

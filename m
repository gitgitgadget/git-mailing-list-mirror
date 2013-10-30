From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cvsserver: Determinize output to combat Perl 5.18 hash randomization
Date: Wed, 30 Oct 2013 10:30:46 -0700
Message-ID: <xmqqeh72d5tk.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.2.00.1310300413430.20647@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, 727226@bugs.debian.org
To: Anders Kaseorg <andersk@MIT.EDU>
X-From: git-owner@vger.kernel.org Wed Oct 30 18:30:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbZba-0003Ej-PV
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 18:30:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752503Ab3J3Raw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 13:30:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46538 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993Ab3J3Rav (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 13:30:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 433DB4DC0C;
	Wed, 30 Oct 2013 13:30:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bTg0dFLz8PqfLSj2UPzUMX1FB8s=; b=M3mmCs
	bT4TE+HCEOvn9XHF5klQCuviiRB88SJ+rEwDf5nN1Ayb9DJAp63NzvfWy34Y6Q/B
	xtShX3npbnikqVm0zuihHPRo4Hv077Uut/R+6kSQ1zGAqv+5EfF+kpH/5bNZvdM5
	S62GkoddTXUL3389y+GP5lcPbYDg1qBt6M7uo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L1zNP4zUUubU7qx3sjJ8664BO5Ijy6Pf
	bv/HXPr6eHdNscqh/Eu42fs/tENriPJ3M0cvEqQHKTWcPwzbBgqIHvCGD53IGqKA
	YbcIUV9yji2Vf63juWv4HDDY3JAn7rv330sChSw1O7PwnBVIr3esnpJXWhReHJfB
	wWV77vbAcZY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3287F4DC0A;
	Wed, 30 Oct 2013 13:30:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A4124DC01;
	Wed, 30 Oct 2013 13:30:49 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1310300413430.20647@dr-wily.mit.edu> (Anders
	Kaseorg's message of "Wed, 30 Oct 2013 04:44:43 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 049F1290-4189-11E3-9E45-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237041>

Anders Kaseorg <andersk@MIT.EDU> writes:

> Perl 5.18 randomizes the seed used by its hash function, so iterating
> through hashes results in different orders from run to run:
>   http://perldoc.perl.org/perl5180delta.html#Hash-overhaul
>
> This usually broke t9400 (gitcvs.dbname, gitcvs.ext.dbname, when
> running cmp on two .sqlite files) and t9402 (check [cvswork3] diff,
> when running test_cmp on two diffs).
>
> To fix this, hide the internal order of hashes with sort when sending
> output or running database queries.
>
> (An alternative workaround is PERL_HASH_SEED=0, but this seems nicer.)
>
> Signed-off-by: Anders Kaseorg <andersk@mit.edu>

Thanks, will queue.

> ---
>  git-cvsserver.perl | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 67b1e7b..6177f4a 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -430,10 +430,10 @@ sub req_validrequests
>  
>      $log->debug("req_validrequests");
>  
> -    $log->debug("SEND : Valid-requests " . join(" ",keys %$methods));
> +    $log->debug("SEND : Valid-requests " . join(" ",sort keys %$methods));
>      $log->debug("SEND : ok");
>  
> -    print "Valid-requests " . join(" ",keys %$methods) . "\n";
> +    print "Valid-requests " . join(" ",sort keys %$methods) . "\n";
>      print "ok\n";
>  }
>  
> @@ -2124,7 +2124,7 @@ sub req_diff
>              print "M retrieving revision $meta2->{revision}\n"
>          }
>          print "M diff ";
> -        foreach my $opt ( keys %{$state->{opt}} )
> +        foreach my $opt ( sort keys %{$state->{opt}} )
>          {
>              if ( ref $state->{opt}{$opt} eq "ARRAY" )
>              {
> @@ -4050,7 +4050,7 @@ sub update
>              close FILELIST;
>  
>              # Detect deleted files
> -            foreach my $file ( keys %$head )
> +            foreach my $file ( sort keys %$head )
>              {
>                  unless ( exists $seen_files->{$file} or $head->{$file}{filehash} eq "deleted" )
>                  {
> @@ -4078,7 +4078,7 @@ sub update
>      }
>  
>      $self->delete_head();
> -    foreach my $file ( keys %$head )
> +    foreach my $file ( sort keys %$head )
>      {
>          $self->insert_head(
>              $file,

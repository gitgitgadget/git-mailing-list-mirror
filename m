From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] New send-email option smtpserveroptions.
Date: Sat, 04 Sep 2010 09:21:02 -0700
Message-ID: <7v4oe5xyxd.fsf@alter.siamese.dyndns.org>
References: <1283616372-3340-1-git-send-email-pascal@obry.net>
 <1283616372-3340-3-git-send-email-pascal@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Sat Sep 04 18:21:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrvUS-0004Wr-GG
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 18:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108Ab0IDQVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 12:21:11 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45381 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902Ab0IDQVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 12:21:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 55FCDD351D;
	Sat,  4 Sep 2010 12:21:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AfIsVX4DOjcUalocS3r4s4PwsWw=; b=JSxAOg
	COrJk8rbvhJ5x4wGDDVDorDu/Lp2pJseVmBaHX9QfgzbG8OqNIdJLqkxuyWlbSS5
	PjAOkk9+2IGpxADNFgx8MGjXBMyG8v0Ve2IPkt3+ZLslCkHpBZOY+1Hy2dCsVWcI
	9Rr+0SbvIKqn2G4cK0U3L/WE0ox5LMqZzwCvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XYPbD/rErW2IyI0OcJQupCHLpT9gQoxr
	FMCtHl8+DzHAm6ag+Q24d7DRYkZuxnd1UCkkFMsFY3k56Cdi0u7mUoy7taMqWY09
	bEJ9GBxvqTVRvh1/3WUR3xA8+DpQtjdFGpEo4Ff09tZjJz7XjoEmi6qpQ6fp2PKn
	OdSTfuma1f0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CFDAD3519;
	Sat,  4 Sep 2010 12:21:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DA9BD3516; Sat,  4 Sep
 2010 12:21:04 -0400 (EDT)
In-Reply-To: <1283616372-3340-3-git-send-email-pascal@obry.net> (Pascal
 Obry's message of "Sat\,  4 Sep 2010 18\:06\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6BDDC3E6-B840-11DF-8ED4-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155338>

Pascal Obry <pascal@obry.net> writes:

> diff --git a/git-send-email.perl b/git-send-email.perl
> index 0063606..e5cdda7 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -60,6 +60,7 @@ git send-email [options] <file | directory | rev-list options >
>      --envelope-sender       <str>  * Email envelope sender.
>      --smtp-server       <str:int>  * Outgoing SMTP server to use. The port
>                                       is optional. Default 'localhost'.
> +    --smtp-server-options   <int>  * Outgoing SMTP server options to use.

Is it really an int?

> @@ -279,6 +282,7 @@ my $rc = GetOptions("sender|from=s" => \$sender,
> ...
> +		    "smtp-server-options=s" => \$smtp_server_options,
> @@ -1015,6 +1019,9 @@ X-Mailer: git-send-email $gitversion
>  		}
>  	}
>  
> +	unshift (@sendmail_parameters, $smtp_server_options)
> +	    if (defined $smtp_server_options);
> +

I suspect this would not work, unless you are aiming to add just a
singular $smtp_server_option, as the actual program invocation looks like
this later in the program:

	} elsif ($smtp_server =~ m#^/#) {
		my $pid = open my $sm, '|-';
		defined $pid or die $!;
		if (!$pid) {
			exec($smtp_server, @sendmail_parameters) or die $!;
		}
		print $sm "$header\n$message";

Somebody in the code before this unshift needs to split the single string
in $smtp_server_options into multiple parameters, or better yet, it needs
to accept more than one --smtp-server-option=foo --smtp-server-option=bar
and accumulate them in @smtp_server_options.

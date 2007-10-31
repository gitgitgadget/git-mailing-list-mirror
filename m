From: Baz <brian.ewins@gmail.com>
Subject: Re: [PATCH] Implement sending mails over TLS in git-send-email.
Date: Wed, 31 Oct 2007 23:59:24 +0000
Message-ID: <2faad3050710311659s10cab8fbj45bac505b22bb0c2@mail.gmail.com>
References: <1193845859-1788-1-git-send-email-Simon.Sasburg@gmail.com>
	 <2faad3050710311445l51d1152cs6761803e2f3a77d3@mail.gmail.com>
	 <981e6de60710311504v666943beve3b87c6a713fb18c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Simon Sasburg" <simon.sasburg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 00:59:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InNTI-00087m-L9
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 00:59:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbXJaX71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 19:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbXJaX71
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 19:59:27 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:46015 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbXJaX70 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 19:59:26 -0400
Received: by an-out-0708.google.com with SMTP id b36so48380ana
        for <git@vger.kernel.org>; Wed, 31 Oct 2007 16:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ULiuw2QWI33Czhq3jsNDNRHexQn6qEcenWGiVQw6pyQ=;
        b=B6SpKQAlEoD9wr5iGOqjhFAv7EtSqx7PmAQcrviBQRoC6eF99LiX5ungYpFyNLfJ6b+HrTkpYwTWDuoRmiyb8S5Xxp7gthG99p/XLwxLlXNofUB5odiEddkNq5cDyZsKjZP9cOISyD17t6sK1QlVkEZZ9Dem/4ifPdFCGoMZs1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uhTZGe5LLnU9OxhAqWjekxid3bEEqxu0qsFM+yoE/v8W8VYEBAjbw8iQ2w2HUuQ7BYrDJ5HBDsG2Hd5eRxknOil1jgJhLdS1XYlewu+EiTVMVd5TFUaanUYCSeOeAAITQwUlW5tsAOByt6NpomrKseD01ZUkYuiefz0fyyO9+T4=
Received: by 10.142.212.19 with SMTP id k19mr2257212wfg.1193875164506;
        Wed, 31 Oct 2007 16:59:24 -0700 (PDT)
Received: by 10.142.43.18 with HTTP; Wed, 31 Oct 2007 16:59:24 -0700 (PDT)
In-Reply-To: <981e6de60710311504v666943beve3b87c6a713fb18c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62898>

On 31/10/2007, Simon Sasburg <simon.sasburg@gmail.com> wrote:
> > In other words, this patch should be entirely unnecessary if you have
> > Authen::SASL installed - could you try this? (I've checked for myself,
> > git-send-email sends me mail fine via gmail without this patch)
>
> Well, it fails here, maybe maybe you can show me exactly what you did
> (configuration/parameters etc)?
>
> This is what i do now:
> > git-send-email testfile.patch -to simon.sasburg@gmail.com --chain-reply-to --smtp-server smtp.gmail.com --smtp-user simon.sasburg --smtp-pass secret --smtp-ssl --smtp-server-port 587
> and it fails, while the same line using --smtp-tls instead of
> --smtp-ssl with my patch applied works.
>
> What am i missing?
>

ok I'm going to downgrade what I said to 'it works fine with gmail' -
it just doesnt do starttls, your code does.

git-send-email --from 'brian.ewins@gmail.com' --to
'brian.ewins@gmail.com' --smtp-server smtp.gmail.com  --smtp-user
'brian.ewins@gmail.com' --smtp-pass 'secret' --smtp-ssl
0001-the-patch-goes-here

That's using SSL on port 465, not TLS. Did this not work for you? I
thought Net::SMTP passed its constructor options to IO::Socket, but
no. An alternate way of getting starttls to work, without using
Net::SMTP::TLS, is this:

#connect with Net::SMTP - not ::SSL or the connect will fail
$smtp = Net::SMTP->new('smtp.gmail.com',
                                 Port => 587,
                                 Debug => 1) or die "Could not connect
to server\n";
#issue the starttls command, assuming user asked for this
$smtp->command('STARTTLS');
$smtp->response();
#if server says 220, then go ahead and convert the socket. Bless as
Net::SMTP::SSL
# - necessary to inherit both IO::Socket::SSL and Net::SMTP
#start_SSL has been renamed, twice. Nice stable api :)
#extra args for checking server cert etc can be passed to start_SSL.
$smtp->code() == 220 and $smtp = Net::SMTP::SSL->start_SSL($smtp) or
die "STARTTLS failed! ".$smtp->message;
# say hello again to get server features (including auth)
$smtp->hello();
# now continue as before, with $smtp->auth()...

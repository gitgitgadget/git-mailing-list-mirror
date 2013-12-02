From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 3/3] send-email: set SSL options through IO::Socket::SSL::set_client_defaults
Date: Tue, 03 Dec 2013 00:23:28 +0100
Message-ID: <87k3fmon0v.fsf@linux-1gf2.Speedport_W723_V_Typ_A_1_00_098>
References: <3bb0c80c70e1c40236034552bec037cb0c26167c.1385938050.git.tr@thomasrast.ch>
	<c5308d5ffb34b70cbfea5a39e08902904fac1400.1385938050.git.tr@thomasrast.ch>
	<CALkWK0nn867+3+cToc=QMyA0u+0oPJkq+nmB1T3DP+kiiwb72Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 00:23:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vncq9-0006F8-Ik
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 00:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752130Ab3LBXXl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 18:23:41 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:41816 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686Ab3LBXXk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 18:23:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id B690F4D6579;
	Tue,  3 Dec 2013 00:23:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Io8kqXvAyZkf; Tue,  3 Dec 2013 00:23:28 +0100 (CET)
Received: from linux-1gf2.Speedport_W723_V_Typ_A_1_00_098.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id B670F4D64C4;
	Tue,  3 Dec 2013 00:23:27 +0100 (CET)
In-Reply-To: <CALkWK0nn867+3+cToc=QMyA0u+0oPJkq+nmB1T3DP+kiiwb72Q@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Mon, 2 Dec 2013 16:14:09 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238659>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Thomas Rast wrote:
>> When --smtp-encryption=ssl, we use a Net::SMTP::SSL connection,
>> passing its ->new all the options that would otherwise go to
>> Net::SMTP->new (most options) and IO::Socket::SSL->start_SSL (for the
>> SSL options).
>>
>> However, while Net::SMTP::SSL replaces the underlying socket class
>> with an SSL socket, it does nothing to allow passing options to that
>> socket.  So the SSL-relevant options are lost.
>
> Both [1/3] and [2/3] look good. However, I'm curious about this one:
> Net::SMTP::SSL inherits from IO::Socket::SSL, where new() is defined.
> In the documentation for IO::Socket::SSL,
>
>   $ perldoc IO::Socket::SSL
>
> I can see examples where SSL_verify_mode and SSL_ca_path are passed to
> new(). So, I'm not sure what this patch is about.

Net::SMTP::SSL is merely steals all the code from Net::SMTP into a class
that has IO::Socket::SSL as its first inheritance line.

This works because Net::SMTP (no SSL) inherits from IO::Socket::INET
instead, and uses SUPER:: methods to access the latter's features.  So
by effectively replacing IO::Socket::INET with IO::Socket::SSL,
Net::SMTP::SSL can apply all of Net::SMTP's code on an SSL socket.

However!

That SUPER:: access does not pass anything SSLey.  In particular,
Net::SMTP::SSL->new (which is just the same as Net::SMTP->new) runs this
to initialize its socket:

    $obj = $type->SUPER::new(
      PeerAddr => ($host = $h),
      PeerPort => $arg{Port} || 'smtp(25)',
      LocalAddr => $arg{LocalAddr},
      LocalPort => $arg{LocalPort},
      Proto     => 'tcp',
      Timeout   => defined $arg{Timeout}
      ? $arg{Timeout}
      : 120
      )

Note the conspicuous absence of any kind of SSL arguments, or any kind
of args-I-don't-know-myself passthrough.

If you _do_ specify SSL arguments (i.e. key-value style arguments that
would normally be accepted by IO::Socket::SSL->new) to
Net::SMTP::SSL->new, they will simply be ignored, because of how the
key-value argument passing treats the argument list as a hash.

Does that clarify it?

This is all assuming I got the details vaguely correct, and the source
snippets are from my perl v5.18.1 installed by opensuse 13.1.

It turns out the server I was trying to talk to on Sunday had an expired
certificate, and despite the code from 35035bb, my efforts to set
SSL_VERIFY_NONE were futile.  Until I noticed the set_client_defaults()
trick.  So I'm pretty convinced the patch does *something* right.

-- 
Thomas Rast
tr@thomasrast.ch

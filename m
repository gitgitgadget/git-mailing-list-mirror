From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 4/5] tcp: unify ipv4 and ipv6 code paths
Date: Thu, 8 Mar 2012 16:39:02 +0100
Message-ID: <CABPQNSYfv19cVQoAoUyXVaF1TpLXTYDRFnHE4vr=X42W771tbA@mail.gmail.com>
References: <20120308124857.GA7666@burratino> <20120308130913.GD9426@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 16:39:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5fRd-0004R5-Da
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 16:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757529Ab2CHPjo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 10:39:44 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42346 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757310Ab2CHPjm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 10:39:42 -0500
Received: by dajr28 with SMTP id r28so554422daj.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 07:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=JLHforEnZkmdUee3KngCqH/c7DfVTc9j9qRAajyfn8o=;
        b=NFbMtZ1Gpb0O09Y/OwnP6V+YkZrPfEfO8VPH4gRrY2IUAihVa0va+3KYkxXCxxIO7F
         HyXC1V2dCq3N0rwEXnkhQn/5jW+v2dSfDTF7Ore9Wh5xB3r11l8YIz4zmVhTUJWJdYeK
         F8c5xD/9PtiTyk976VZ3xoi8085Pt+3aLF/tKxZfnXoWn0yMTZQbuDkBhzLNrnLqaEj+
         4GZu/JvtGdSg0XqBqZna16hvebX74JZzV+tjyRdKm+cLCMH93EzUeRdAWZMVzFLANbg5
         PP1u/SrHfKQyc0aqKBM73ErEIVZJku/oVEw2LUfpX9SRceyhV3c8rJcIIj4hyBdDfVSz
         U58w==
Received: by 10.68.240.41 with SMTP id vx9mr10396938pbc.10.1331221182157; Thu,
 08 Mar 2012 07:39:42 -0800 (PST)
Received: by 10.68.1.135 with HTTP; Thu, 8 Mar 2012 07:39:02 -0800 (PST)
In-Reply-To: <20120308130913.GD9426@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192612>

On Thu, Mar 8, 2012 at 2:09 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Date: Mon, 6 Jun 2011 04:41:28 -0500
>
> The new DNS API abstracts away differences between the gethostbyname-
> and getaddrinfo-centric interfaces for looking up a host, making the
> code to use them in connect.c a little easier to read.
>
> To make a lookup:
>
> =A0 =A0 =A0 =A0resolver_result ai;
> =A0 =A0 =A0 =A0dns_resolve(host, port, 0, &ai);
> =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0dns_free(ai);
>
> To iterate over responses:
>
> =A0 =A0 =A0 =A0resolved_address i;
> =A0 =A0 =A0 =A0for_each_address(i, ai) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0}
>
> In the !NO_IPV6 codepath, the git_locate_host function that is used t=
o
> find the canonical IP and hostname for a git server's public address
> (for virtual hosting) tells getaddrinfo to restrict attention to TCP
> services after this patch. =A0That should make no difference because =
the
> service parameter is NULL.
>
> No functional change intended.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> This is the title feature, corresponding to
> http://thread.gmane.org/gmane.comp.version-control.git/175106/focus=3D=
175111
>
> It needed changes to adjust to released changes in the code it touche=
s,
> but nothing is fundamentally different from v1.
>
> =A0Makefile =A0 | =A0 =A05 ++
> =A0dns-ipv4.c | =A0 33 +++++++++++
> =A0dns-ipv4.h | =A0 69 +++++++++++++++++++++++
> =A0dns-ipv6.c | =A0 49 ++++++++++++++++
> =A0dns-ipv6.h | =A0 31 +++++++++++
> =A0tcp.c =A0 =A0 =A0| =A0182 +++++++++++-----------------------------=
--------------------
> =A06 files changed, 218 insertions(+), 151 deletions(-)

I'm not entirely sure I understand the motivation here. We already had
well-tested, implementations of IPv4 and IPv6 tcp-socket setup. Here
you unify the code by adding abstraction, but it ends up amounting to
more lines of code, with the details scattered around in different
source files.

=46or me, this means that I have to learn a new API, and to see what
really happens when something goes wrong, I have to jump between
multiple source files.

And I'm not entirely sure what this patch actually improves. If it was
likely that we'd get support for yet another IP-stack version, then
this would probably be a win. But that's not likely, is it?

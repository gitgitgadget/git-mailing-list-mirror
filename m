From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH RFC3.5 06/12] send-email: Cleanup and streamline the SMTP code in send_message
Date: Sun, 19 Apr 2009 22:49:29 -0500
Message-ID: <49ebf2f6.050cc00a.2e8d.ffffbde4@mx.google.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-4-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-5-git-send-email-mfwitten@gmail.com>
 <7vzlecnlsh.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 06:00:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvkgB-0000Sd-UA
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 06:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753123AbZDTD6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Apr 2009 23:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbZDTD6s
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Apr 2009 23:58:48 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:34785 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbZDTD6s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Apr 2009 23:58:48 -0400
Received: by yx-out-2324.google.com with SMTP id 3so677926yxj.1
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 20:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc:date
         :subject:in-reply-to:references;
        bh=rlwz+YapW8/uOMWG6BGpjDJ6EeJSkgYV4QW/bEaNzBE=;
        b=MEqhZ849ItAoPmGS1wCD4SMoldbT2EzJFzPCRBuW787hreukDftm0OeaQ0ia3S2ZUS
         L2dgOMCZRYuavjD+Lon/utr6PoH3vhWKu5ZLAqdqEdgJq9imij7MEEIqTb1hHSOA9vL2
         qsiSqp+W9RRwtyfAZKM9VqAiGhLHnT4kLbENw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:cc:date:subject:in-reply-to:references;
        b=klS2FyUDRvHNmKJJBB0kNnGtFCzWKI91hO9NXTPghNVQD/S2gGED32vHzur2lsLwNC
         MQIv+qzuWvNWFJwkgMlY4/UIE4L2mQ52/UMfrtfFVs2CSg5bHpOJFSN9q1j5TEUn6rnv
         W5CzwGJLzuf6vfnxUoAWVUqVgH6e3xcRhxAmo=
Received: by 10.101.70.14 with SMTP id x14mr2477368ank.85.1240199927102;
        Sun, 19 Apr 2009 20:58:47 -0700 (PDT)
Received: from gmail.com (97-116-107-50.mpls.qwest.net [97.116.107.50])
        by mx.google.com with ESMTPS id 5sm5532792ywl.38.2009.04.19.20.58.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Apr 2009 20:58:46 -0700 (PDT)
In-Reply-To: <7vzlecm4lg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116931>

On Sun, Apr 19, 2009 at 20:42, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Witten <mfwitten@gmail.com> writes:
> ...
>> Now, the 'host:port' server URI form is handled regardless of the
>> documentation deficiencies of Net::SMTP{,::SSL}.
>
> You said that in 01/12, too but I do not think there is any problem with
> Perl documentation.
>
> My installed copy of /usr/share/perl/5.10.0/Net/SMTP.pm has this:
>
>    B<Host> - SMTP host to connect to. It may be a single scalar, as defined for
>    the C<PeerAddr> option in L<IO::Socket::INET>, or a reference to
>    an array with hosts to try in turn. The L</host> method will return the value
>    which was used to connect to the host.
>
> and of course PeerAddr allows host:port.
>
> Please stop placing a false blame on others.  I think it is you who lack
> ability to read the documentation correctly in this particular case.

Take a look again at my commit message for 01/12:

	The 'host:port' form of argument for --smtp-server was only
	working for SSL connections, because the SSL connection code
	was relying on undocumented behavior of Net::SMTP::SSL (really,
	undocumented behavior of Net::SMTP's new method)...

Clearly my beef is with Net::SMTP--->::SSL<---

I touch upon this in the commit message for 06/12:

	The code could even be simplified further, because Net::SMTP{,::SSL}
	both take the PORT variable in their new methods (which, as of this
	commit, are actually the same method). Moreover, both take a server
	URI of the form 'host:port' that trumps any value passed to PORT.

	Unfortunately, none of this is documented publicly, so it isn't
	exploited out of purity.

Net::SMTP doesn't document the PORT key, even though it's the one that
implements the constructor for both Net::SMTP and Net::SMTP::SSL. Also,
Net::SMTP:SSL doesn't document whether PORT shadows the ':port' in any
'host:port' input.

So... I remain resolved in my stance: The documentation is poor and
"--smtp-server host:port" only worked because the code relies on the
undocumented behavior of the ':port' taking precedence of over any
PORT specification. 

> I think you just did not read the documentation carefully enough in this
> case.

Actually, I think I read it too carefully and thought about it too much.

On Sun, Apr 19, 2009 at 21:38, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Please stop placing a false blame on others.  I think it is you who lack
>> ability to read the documentation correctly in this particular case.
>
> Sorry, this came out stronger than I intended.

That's OK. I tend to sound harsher than I want as well.

> Your ability has never been an issue (otherwise there wouldn't have been
> this patch series).

I appreciate that remark; I'm admittedly not important, but I hope that
I'm at least useful.

Now let's get back to work!

Sincerely,
Michael Witten

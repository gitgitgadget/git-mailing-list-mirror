From: Michael Witten <mfwitten@gmail.com>
Subject: Subject: Re: [PATCH RFC3.5 02/12] send-email: No longer repeatedly test if $smtp_server is a command
Date: Sun, 19 Apr 2009 23:53:16 -0500
Message-ID: <49ec020a.050cc00a.2a50.ffffd0e3@mx.google.com>
References: <1240074128-16132-1-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-2-git-send-email-mfwitten@gmail.com>
 <1240074128-16132-3-git-send-email-mfwitten@gmail.com>
 <7veivop0dx.fsf@gitster.siamese.dyndns.org>
 <b4087cc50904191937x55f94dc3sb6fbda27f380b105@mail.gmail.com>
 <7viql0lzuw.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 07:06:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvliB-0002Vp-6t
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 07:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbZDTFDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 01:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbZDTFDJ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 01:03:09 -0400
Received: from mail-qy0-f126.google.com ([209.85.221.126]:35433 "EHLO
	mail-qy0-f126.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751659AbZDTFDI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 01:03:08 -0400
Received: by qyk32 with SMTP id 32so1332353qyk.33
        for <git@vger.kernel.org>; Sun, 19 Apr 2009 22:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc:date
         :subject:in-reply-to:references;
        bh=hQd98atM2XOIWyRQj1CTm00s9GVGwUah3uBDl1AmwOw=;
        b=R5jnncgbIy8x9+jg5gkzlMMesM8FHcxobpHtNLG7W7C5xOoXk5l4wEAun+3EGsLw6I
         V16dtYW5DIlm5DjCffjCYtjDiEeMslUY+CzU+Ys6QsVVLiUIkhHljHqEkPbIqqR02Jgl
         DqTmpHoS0/CkkCLwfWQ6Gf1otnL08EJxDL5TY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:cc:date:subject:in-reply-to:references;
        b=hHugW2U0/bXroBYRsPpL8zmUlUQITresG/hCXFcYkn3xRh4phxqYqY4igNzLsRBp5v
         77jsvxlw8x9ybtTrmjTkfAIPYDLE2df+eSZTeILWZj78e2aDopMEbsbSzUcDote++hLI
         mp8JrmixE5WkKbAYxs2BgfTOomnjz/py5qSjY=
Received: by 10.220.77.18 with SMTP id e18mr5191126vck.85.1240203786813;
        Sun, 19 Apr 2009 22:03:06 -0700 (PDT)
Received: from gmail.com (97-116-107-50.mpls.qwest.net [97.116.107.50])
        by mx.google.com with ESMTPS id 5sm5671975ywl.8.2009.04.19.22.03.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Apr 2009 22:03:06 -0700 (PDT)
In-Reply-To: <7viql0lzuw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116935>

On Sun, Apr 19, 2009 at 23:21, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Witten <mfwitten@gmail.com> writes:
>
>> ...
>>> I think a genuine improvement would be something like:
>>>
>>> 	if (!defined $smtp_server) {
>>> 		$smtp_server = 'localhost';
>>> 	}
>>
>> You don't care to search for a possible sendmail?
>
> That's something you already did before setting smtp_server
> unconditionally to localhost, right?  You do (in the above):
>
> 	if (user gave $smtp_server) {
> 		use it, notice and note if it is a command;
> 	} else {
> 		if (standard binary avaiable) {
> 			use it, note it is a command;
> 		}
> 		# otherwise it still is undef
> 	}
> 	if (!defined $smtp_server) {
> 		set it to localhost;
> 	}
>
> But I would probably write it this way:
>
> 	if (user didn't give us $smtp_server) {
> 		if (standard binary avaiable) {
> 			use it, note it is a command;
> 		} else {
> 			use localhost;
> 		}
> 	}
> 	if ($smtp_server looks like a command) {
> 		$smtp_server_is_a_command = true;
> 	}
>
>

I suppose it's hard to tell from the patch, but it's actually
a combination of those two:

	if (user gave $smtp_server) {
		use it, notice and note if it is a command;
	} else { # use a default:
		if (standard binary avaiable) {
			use it, note it is a command;
		} else {
			use localhost;
			# automatically noted as a command
			# without doing anything (this would
			# cause warnings if $smtp_is_a_command
			# is used in places other than the bool
			# context, because it will be undef);
			# thus, my choice is a bad choice in
			# the long run, but I'm sticking to it.
		}
	}

The actual code:

	if (defined $smtp_server) {

		$smtp_server_is_a_command = ($smtp_server =~ m{^/});

	} else { # use a default:

		foreach (qw( /usr/sbin/sendmail /usr/lib/sendmail )) {
			if (-x $_) {
				$smtp_server = $_;
				$smtp_server_is_a_command = 1;
				last;
			}
		}

		$smtp_server = 'localhost' # 127.0.0.1 is not compatible with IPv6
			unless $smtp_server_is_a_command;
	}

(I'll remove the "127.0.0.1" comment).

There's a minimum of checking and assigning; it's beautiful.
Plus, this organization fits in well with the server/port
verification (if I recall).

P.S.

I also like:

	$smtp_server_is_a_command or ($smtp_server = 'localhost');

or, maybe:

	$smtp_server_is_a_command or $smtp_server = 'localhost;

However, I wasn't sure if that is acceptable to others; more
importantly (:-D), I'm not sure that perl is smart enough to
optimize away the unnecessary comparison of the values, so I
figured that the modifier 'unless' is morally superior, because
it probably has the advantage of fewer cycles than the 'or' form,
and it has greater readability than the curly-braced conditional.
I absolutely loathe curly braces around a body of one line:

	if ($you_loath_this) {
		print "Clap Your Hands!\n";
	}

If only the curly-braces weren't there. I don't know why, they
just bug me terribly.

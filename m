From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: git-send-email generates mail with invalid Message-Id
Date: Tue, 28 Jul 2009 12:44:23 +0200
Message-ID: <20090728104423.GA12947@vidovic>
References: <200907280446.22890.elendil@planet.nl> <40aa078e0907280217g76cbfai8544edde605f8772@mail.gmail.com> <200907281127.44558.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@googlemail.com>,
	Frans Pop <elendil@planet.nl>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jul 28 12:50:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVkG5-0001Vz-GK
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 12:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbZG1Kod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 06:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753068AbZG1Kob
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 06:44:31 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:23882 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbZG1Ko3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 06:44:29 -0400
Received: by ey-out-2122.google.com with SMTP id 9so986517eyd.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 03:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=t6BdJvK2v+gOqmAoLWLRxezeTtPVvgaESd4e/gnU77Q=;
        b=Ovdgo3yGSRdvhmC7fjCdZpLZwS8PjEPrfSd7GgOT4qOp3cdFknS56JSX9vBYmMQe4f
         IM6ucgzQvR+2KDQZBeRCrAd/ypCzo6yJ/FJ4oKwfsVFQ7XazLMWSrT6UD+DQvji98ySj
         bFOC8Ns0YSJTRfogmNa9tIEnIPAzDEhB7VA6s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ume8a2CHwclMhSaSXeEfjuh6kWCG/dJ52xI+u/GZBtWsrkTlHl4h959w4qW56eTr0D
         EfGQ9gMZf/ww94Pg3HBBf19in3qKmuNdn04UxA1dvOWMYbReHGPzqzuqB8Oek0WGD988
         Z/nFoyLNHo3xRWKyuwNavyzUMJ2TLXR4PcbOM=
Received: by 10.210.111.5 with SMTP id j5mr9790099ebc.55.1248777867990;
        Tue, 28 Jul 2009 03:44:27 -0700 (PDT)
Received: from @ (91-165-131-3.rev.libertysurf.net [91.165.131.3])
        by mx.google.com with ESMTPS id 7sm2217551eyb.52.2009.07.28.03.44.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 03:44:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <40aa078e0907280217g76cbfai8544edde605f8772@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124233>

Erik Faye-Lund wrote:
> On Tue, Jul 28, 2009 at 4:46 AM, Frans Pop<elendil@planet.nl> wrote:
>
> > I assume that this is a configuration issue in the git setup of the
> > sender, but shouldn't git-send-email refuse to send out messages with an
> > invalid Message-Id?

Stricly speacking, it is not an invalid Message-Id. RFC 2822 says that
the Message-Id has to be unique. The right hand side may not contain a
domain identifier. It is a RECOMMENDED practice (a good one, though).

IMHO, inn2 does a wrong assumption.

> Not quite. git-send-email generates these message-ids itself (those
> who contain "-git-send-email-", that is), and should as such be able
> to rely on them being generated correctly. [...]
> I'm no perl-expert, but the code looks pretty much correct to me.

Looks good here too. That said, if $du_part is still empty after all the
stuff over, we could add a fake domain name. This prevent the Message-Id
from ending with "-git-send-email->".

---
This is untested.

 git-send-email.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index d508f83..82fb3b9 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -748,6 +748,9 @@ sub make_message_id
                use Sys::Hostname qw();
                $du_part = 'user@' . Sys::Hostname::hostname();
        }
+       if (not defined $du_part or $du_part eq '') {
+               $du_part = 'git@fake.dom';
+       }
        my $message_id_template = "<%s-git-send-email-%s>";
        $message_id = sprintf($message_id_template, $uniq, $du_part);
        #print "new message id = $message_id\n"; # Was useful for debugging
-- 
Nicolas Sebrecht

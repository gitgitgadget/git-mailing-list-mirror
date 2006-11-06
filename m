X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Janos Farkas <chexum+dev@gmail.com>
Subject: git PATH reordering
Date: Mon, 6 Nov 2006 14:33:04 +0100
Message-ID: <priv$efbe06146839$619d340665@200611.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 6 Nov 2006 13:34:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:sender;
        b=IP3sQZA9ja26GVDPAPe+BvfIKS4gKT7OiFPEO/WQPriBt8e+A5rqhwosOt2s2X/GINOhaY4JvfG6w21ecanouJV39+IMTm9jlQ9ZbCeFOUFbMyQuZd2VnOPgREWbzShCyhb+6ho9MtBehu7PHKDnsIY9xHK6aC/SEYbq5KsUc8Q=
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31011>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gh4bb-0002G1-Nx for gcvg-git@gmane.org; Mon, 06 Nov
 2006 14:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753098AbWKFNd1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 08:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753099AbWKFNd1
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 08:33:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:44182 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1753098AbWKFNd0
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 08:33:26 -0500
Received: by nf-out-0910.google.com with SMTP id x30so2595422nfb for
 <git@vger.kernel.org>; Mon, 06 Nov 2006 05:33:25 -0800 (PST)
Received: by 10.48.48.18 with SMTP id v18mr548406nfv.1162820004850; Mon, 06
 Nov 2006 05:33:24 -0800 (PST)
Received: from localhost ( [212.112.241.159]) by mx.google.com with ESMTP id
 p45sm11774521nfa.2006.11.06.05.33.17; Mon, 06 Nov 2006 05:33:23 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi!

I'm facing an issue which seems to originate about a year ago, so I'm a
bit late :)

Apparently, most git commands seem to tweak their PATH to make sure the
corresponding version of a subcommand gets ran in the case there are
multiple ones in there.

The thing is, since this "ensuring" is done by prepend_to_path(), which
can then change all exec() afterwards.   Usually, that's not a problem,
but that made git run an unexpectedly different ssh command for remote
access.  When I discovered what the problem is, I easily fixed it by
setting GIT_SSH to the explicit path, and I can live with that, but it's
a bit confusing.

I don't want to start a neverending thread, so if my bikeshed doesn't
interest you, I'll give up :)  But the way it's done now seems to be for
the case which should be very rare.

As I see, all this PATH manipulation logic was meant to solve the case
when the desired "git" version is not in the path or some mismatching
components of it is.  Including the case when you want to point some
higher level tool to one specific version of "git" to be used,
irrespective of PATH.  Is this the right way to do it?  Is it
really required at all?

Apart from getting rid of this (possibly useful?) munging, I could see
about two ways to change the behavior to less surprising:

- Don't make PATH munging if "our" path is in the PATH already.
- Save the PATH before munging, and restore before any non-git command
  is run.  This is a bit complex, as multiple languages are used,
  including sh..

Both could make sense, but I don't think either is the correct way.

What bit me, if someone cares about the details, is that on my system,
everything is in the correct path, even git*.  There is however a private
~/bin at the front of the PATH containing some preferred/fixed versions
of some system tools.  When git (living as a normal citizen in /usr/bin)
does its PATH munging, it puts /usr/bin in the front of the path,
skipping this well built house of cards.  As I said, I can live with
that, since only ssh is one that I can designate as "important", and
that one can be set separately with GIT_SSH, but still..


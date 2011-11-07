From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 3/4] git-p4: importing labels should cope with missing
 owner
Date: Mon, 7 Nov 2011 17:34:23 -0500
Message-ID: <20111107223423.GA19362@arf.padd.com>
References: <1320701799-26071-1-git-send-email-luke@diamand.org>
 <1320701799-26071-4-git-send-email-luke@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 23:34:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNXlx-0004uq-4t
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 23:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592Ab1KGWe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 17:34:29 -0500
Received: from honk.padd.com ([74.3.171.149]:48666 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab1KGWe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 17:34:28 -0500
Received: from arf.padd.com (unknown [50.52.169.245])
	by honk.padd.com (Postfix) with ESMTPSA id C1E4C2820;
	Mon,  7 Nov 2011 14:34:27 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 180D4313DA; Mon,  7 Nov 2011 17:34:23 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1320701799-26071-4-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185042>

luke@diamand.org wrote on Mon, 07 Nov 2011 21:36 +0000:
> In p4, the Owner field is optional. If it is missing,
> construct something sensible rather than crashing.

Nice.  One question:

>                      owner = labelDetails["Owner"]
>                      tagger = ""
> -                    if author in self.users:
> +                    if not owner:
> +                        tagger = "%s <a@b> %s %s" % (self.p4UserId(), epoch, self.tz)
> +                    elif author in self.users:
>                          tagger = "%s %s %s" % (self.users[owner], epoch, self.tz)
>                      else:
>                          tagger = "%s <a@b> %s %s" % (owner, epoch, self.tz)

We trust p4 always returns a key "Owner", but it could
be an empty string?  I'm okay with that, if that's how it works.

Should be "author in self.users"?  I'm looking at the
creation of the committer string above, and guessing
that we try to use owner, and if that doesn't exist, try
to use author just like as above, so something like:

    if owner:
	if owner in self.users:
	    email = self.users[owner]
	else:
	    email = "%s <a@b>" % owner
    else:
	if author in self.users:
	    email = self.users[author]
	else:
	    email = "%s <a@b>" % author

I could misunderstand this.

Maybe that lookup in self.users[] and <a@b> default wants to
have a function since it will be repeated three times now.

Ack to the whole series.

		-- Pete

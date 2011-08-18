From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 1/4] git-p4: Allow setting rename/copy detection
 threshold.
Date: Thu, 18 Aug 2011 08:18:47 -0700
Message-ID: <20110818151847.GA2043@padd.com>
References: <1313629459-22937-1-git-send-email-vitor.hda@gmail.com>
 <1313629459-22937-2-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 17:18:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qu4Mx-0005R2-5T
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 17:18:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755409Ab1HRPSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 11:18:49 -0400
Received: from honk.padd.com ([74.3.171.149]:49224 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119Ab1HRPSs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 11:18:48 -0400
Received: by honk.padd.com (Postfix, from userid 7770)
	id E20805B48; Thu, 18 Aug 2011 08:18:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1313629459-22937-2-git-send-email-vitor.hda@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179603>

vitor.hda@gmail.com wrote on Thu, 18 Aug 2011 02:04 +0100:
> Copy and rename detection arguments (-C and -M) allow setting a threshold value
> for the similarity ratio. If the similarity is below this threshold the rename
> or copy is ignored and the file is added as new.
> This patch allows setting git-p4.detectRenames and git-p4.detectCopies options
> to an integer value to set the respective threshold.
[..]
> -        if self.detectRenames:
> +        diffOpts = ""
> +        if self.detectRenames.lower() == "true":
>              diffOpts = "-M"
> -        else:
> -            diffOpts = ""
> +        elif self.detectRenames != "":
> +            self.detectRenames = int(self.detectRenames)
> +            if self.detectRenames >= 0 and self.detectRenames <= 100:
> +                diffOpts = "-M%d" % self.detectRenames
>  

This is a good idea.  But I notice that -M, -C, -B can take
a diverse set of option forms, including floating point and
optional "%".  "-B" can take two args, separated by a "/".

See diff_scoreopt_parse().  It would be weird for git-p4 to limit
that set to integers like you do here.

Would you be willing to change it to pass the string blindly?
Just filter out the special values, and pass everything else
unchanged.

    "true" -> "-M"
    "false" -> ""
    "" -> ""
    ".*" -> "\1"

Dunno if you care about --break-rewrites.  Just pointing to it
as a similar option to -M and -C in case you missed it.

		-- Pete

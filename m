From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH JGIT] Circular references shouldn't be created
Date: Thu, 17 Sep 2009 17:40:12 -0400
Message-ID: <32541b130909171440w1a6d2394t4acc6a2f791c143@mail.gmail.com>
References: <C89280B882467443A695734861B942B28759DB95@DEWDFECCR09.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Sohn, Matthias" <matthias.sohn@sap.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 23:40:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoOiV-0002oc-AT
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 23:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbZIQVk3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2009 17:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbZIQVk3
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 17:40:29 -0400
Received: from mail-yw0-f175.google.com ([209.85.211.175]:62411 "EHLO
	mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbZIQVk2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2009 17:40:28 -0400
Received: by ywh5 with SMTP id 5so572794ywh.4
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 14:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=5DXDJuGJfT/Nzz/tc37jKugeiEzR6n/7tI96Pih2Dvo=;
        b=ff/R5wq/ypBTBSRmkjen//ymw80qyef6z0THl7Q1nlBxIPmsdzTCWg4EUkQz980y33
         veuTMJ+L+fYLBcGdoCTbIv6s+vN3Qz4/8J3mWl68aVDHSf6K601gKNcYFvlr4O8kMw87
         4m5VlucenzDRQtkiZTUK2NPHhzRlOn5QTB294=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tqy+IsR1/S0wP+MMutI1cRa4Thr0SWuun3si08FVWCNXQjTW1m1xeGMcqVjqZ09bAD
         0WxddjjmKd7V2EjOMY9DyGOMXRLRX48KbG6kNUxSzcS3mq1TnAM2ovTtvSzsDWd6Kl9/
         65BaPVfivEPDlAYfd75wujHCjkQo2NhIeAO8Q=
Received: by 10.150.214.2 with SMTP id m2mr1985041ybg.235.1253223632123; Thu, 
	17 Sep 2009 14:40:32 -0700 (PDT)
In-Reply-To: <C89280B882467443A695734861B942B28759DB95@DEWDFECCR09.wdf.sap.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128773>

On Thu, Sep 17, 2009 at 3:23 PM, Sohn, Matthias <matthias.sohn@sap.com>=
 wrote:
> =A0 =A0 =A0 =A0void link(final String name, final String target) thro=
ws IOException {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (name.equals(target))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 throw new IllegalArgume=
ntException(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "illegal circular reference : symref " + name
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + " cannot refer to " + target=
);

This isn't a very thorough fix.  It doesn't catch longer loops, like

    HEAD -> chicken -> HEAD

or

   a -> b -> c -> d -> a

Experimenting with original git.git's implementation, I see that this
is allowed:

   git symbolic-ref refs/heads/boink refs/heads/boink

It succeeds and creates a file that looks like this:

   ref: refs/heads/boink

And "git show-ref refs/heads/boink" says: nothing (but returns an error=
 code).

And "git log refs/heads/boink" says:

   warning: ignoring dangling symref refs/heads/boink.
   fatal: ambiguous argument 'refs/heads/boink': unknown revision or
path not in the working tree.
   Use '--' to separate paths from revisions

Clearly, in git.git, symref loops are caught at ref read time, not
write time.  This makes sense, since someone might foolishly twiddle
the repository by hand and you don't want to get into an infinite loop
in that case.  Also, it's potentially useful to allow people to set
invalid symrefs *temporarily*, as part of a multi step process.

Have fun,

Avery

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 06/19] git_remote_helpers: push all refs during a
 non-local export
Date: Thu, 9 Jun 2011 03:09:12 -0500
Message-ID: <20110609080912.GB4885@elie>
References: <1307558930-16074-1-git-send-email-srabbelier@gmail.com>
 <1307558930-16074-7-git-send-email-srabbelier@gmail.com>
 <20110608194205.GI27715@elie>
 <20110608221908.GB15530@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 09 10:09:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUaJ6-0003tY-Tz
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 10:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757101Ab1FIIJ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 04:09:27 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33059 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756748Ab1FIIJT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 04:09:19 -0400
Received: by iyb14 with SMTP id 14so1108045iyb.19
        for <git@vger.kernel.org>; Thu, 09 Jun 2011 01:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2P7lT+hsbUVtejuVLrTCfT5H8cpTPcdoQJaN0/mCEAA=;
        b=w11UdF7dn3oyf7za4H/ERc3KB6SYxKDM4WIGZlA4B4f26hH0OEotskW38dmzpyP0JQ
         9z+cquDcmRU8cb/ZMNN4WmoDrvjUQoTILYCDBDbqnnlWtYqfoQ/1sgJGNbaEH0zvK1x3
         NbTfkoqp2Sd4kBcjAVfZCKHhhrGo/wWNKivK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FvO8bL84DGDkcU1qgh+qkviH7TUBhzgVolOJ2fhtMCt6Qyg4diOCAThLGuxZdUX6Yf
         rPsgI1CyQDuNP7no2QTBCn+82mA2249HqPiQp1eXo85tYro7Tb+nkTNuzLlddhV60ego
         0ZHUGkzwBKMcwtgSgp2oU+LrHrxXuN0jcGnBA=
Received: by 10.231.47.193 with SMTP id o1mr530296ibf.79.1307606958913;
        Thu, 09 Jun 2011 01:09:18 -0700 (PDT)
Received: from elie (adsl-69-209-61-87.dsl.chcgil.sbcglobal.net [69.209.61.87])
        by mx.google.com with ESMTPS id v15sm672355ibh.62.2011.06.09.01.09.16
        (version=SSLv3 cipher=OTHER);
        Thu, 09 Jun 2011 01:09:17 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110608221908.GB15530@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175503>

Jeff King wrote:

> If we do a fix that allows "refs/heads/foo:refs/heads/bar", then it
> should also properly allow "+refs/heads/foo:refs/heads/bar".  Which I
> think means changing the single "export" command in the ref-helper to
> something like:
>
>   export refs/heads/foo
>   export refs/heads/foo:refs/heads/bar
>   export +refs/heads/force

Thanks for explaining.  The spirit of what you're saying seems right,
so I'd like to spell it out a little to make sure.

If we imagine that the remote helper author wants to write as little
code as possible (which seems reasonable), then probably their
"export" command will simply feed its input to a vcs-fast-import
program.  git fast-export doesn't know how to do ref mapping and
neither would vcs-fast-import.  So one is led to wonder which stage in
the pipeline can make the adaptations to make "git push hgrepo
HEAD:refs/heads/bar" work.

To be friendly to remote helper authors, it would be nice to take
care of the ref mapping somewhere on the transport-helper side, unless
fast-import learns a new mode that does not label its result with
refs.  In the latter case, the "export" command could look like[*]

	export :1 refs/heads/foo
	export :2 refs/heads/bar
	export :3 +refs/heads/force

with :1, :2, and :3 being marks in the fast-import stream.

In the former case, the transport-helper could arrange for a stream
that sets up refs/heads/foo, refs/heads/bar, and refs/heads/force
to be written to stdout, but there would need to be a way to mention
in the stream that the update to refs/heads/force is allowed to be
non fast-forward.  fast-import has a --force option for that, which
unfortunately can't be controlled ref by ref.

Which is all a long way to say, I think you're right and that
something like the syntax marked with [*] would be nice.

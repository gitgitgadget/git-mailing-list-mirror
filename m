From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Escape file:// URL's to meet subversion SVN::Ra
 requirements
Date: Fri, 4 Nov 2011 01:38:05 -0500
Message-ID: <20111104063805.GD24388@elie.hsd1.il.comcast.net>
References: <1320251895-6348-1-git-send-email-bwalton@artsci.utoronto.ca>
 <1320251895-6348-2-git-send-email-bwalton@artsci.utoronto.ca>
 <20111102182015.GA11401@elie.hsd1.il.comcast.net>
 <1320260449-sup-479@pinkfloyd.chass.utoronto.ca>
 <20111102220941.GA3925@dcvr.yhbt.net>
 <1320372215-sup-8341@pinkfloyd.chass.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git <git@vger.kernel.org>
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Fri Nov 04 07:38:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMDQY-0003v9-Nw
	for gcvg-git-2@lo.gmane.org; Fri, 04 Nov 2011 07:38:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974Ab1KDGiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Nov 2011 02:38:14 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40071 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807Ab1KDGiN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2011 02:38:13 -0400
Received: by ywf7 with SMTP id 7so2181907ywf.19
        for <git@vger.kernel.org>; Thu, 03 Nov 2011 23:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LAc64PA+ketqvtxdmOTyOjpubBtjcH8OD/YScogFCL0=;
        b=OSEtzqA34LcpRtdAoLjJp8Nh87rhHB0hEdRyKqZtMe9pttBBCxR3IxcN6NshH4Qm34
         WpE6CxJrc6fuZjd9ZvtP/MTdFH91BTXmMq8E3YAxlO+Svvwf1lCr9MSzacUaRureSy0c
         H89V4sffkoTsKGJP3O4+6XvdcyNSs0S2IN/iY=
Received: by 10.236.156.5 with SMTP id l5mr17589824yhk.29.1320388692736;
        Thu, 03 Nov 2011 23:38:12 -0700 (PDT)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id z28sm13706689yhl.4.2011.11.03.23.38.11
        (version=SSLv3 cipher=OTHER);
        Thu, 03 Nov 2011 23:38:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1320372215-sup-8341@pinkfloyd.chass.utoronto.ca>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184759>

Ben Walton wrote:

> Fixing this locally to the use of the minimized url let me move on
> farther but I then got another core dump.

If it continues like this, it might be possible to get help from svn
developers.

E.g., I would love to see a nice summary of the relevant API changes,
like so (except with more truth):

  Previously the svn_frob() function would accept a filename with
  spaces in it in its "path" argument.  Only the svn_plugh() function
  and its relatives required escaped paths.  And all functions
  returning paths would unescape them.

  With Subversion 1.7, passing a filename with a space in it to
  svn_frob() trips an assertion, so we have to escape the "path"
  argument.  This requires ... changes in application code.

  Unfortunately, back in Subversion 1.6, svn_frob() escapes its
  argument, so an application modified as above will find its "path"
  argument to be double-escaped.  There does not seem to be any
  way for applications to target both Subversion 1.6 and 1.7 without
  doing ...

  Subversion 1.8 should follow the following simple, consistent
  semantics when requested with a flag, which would allow me to easily
  target my code against both SVN >= 1.8 and <= 1.6 with a few "if"
  statements (forgetting 1.7 as if it were a bad dream).
 
Or to put it another way: if getting git-svn to cooperate starts to
prove difficult, maybe abstracting away from git and understanding
what changed for libsvn callers in general could help.  On one hand,
it could help in making sure the guarantees that libsvn offers are
well documented, stable in the future, and clear.  On the other hand,
it might make the appropriate changes to git more obvious.

Sorry for the ramble.  I wish I could offer a fix instead.
Jonathan

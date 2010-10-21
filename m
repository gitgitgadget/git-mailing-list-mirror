From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Converting to Git using svn-fe (Was: Speeding up the initial
 git-svn fetch)
Date: Thu, 21 Oct 2010 11:16:29 -0500
Message-ID: <20101021161629.GB3732@burratino>
References: <20101018051702.GD22376@kytes>
 <201010202244.39728.jnareb@gmail.com>
 <1287652097.9207.31.camel@wpalmer.simply-domain>
 <201010211752.59514.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Will Palmer <wmpalmer@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Bash <bash@genarts.com>,
	Matt Stump <mstump@goatyak.com>, git@vger.kernel.org,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Tomas Carnecky <tom@dbservice.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 18:20:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8xsc-0002Bd-IR
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 18:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754024Ab0JUQUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 12:20:31 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36319 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750932Ab0JUQUa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 12:20:30 -0400
Received: by yxm8 with SMTP id 8so2492200yxm.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 09:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=DlsCrSfNxB5GvPYJSLkdAhr+o34KAaji46+tb826flw=;
        b=OuRhPZdooBnxZTDfYfFYekhbXAnBMRSwaVd0oHcKgiyuqEa+mUmn5l1koksJURxMOZ
         kKYwOLlrEthAoGLgrDWo9ImkALcfF/r6CiosV+G6kGjl8YomTvESNpp99uLLBbNCaHr2
         0DpjFLVfEFLNQmcpKc0cXuydo1Ej5H+Nra8vw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mEbvUXYGIGutiF+JbFoCNwWF9MWW1eNAFr5Q4Cs/0Z7mAPI5A3jyoIOeWhWpqkzKT1
         lChlc1FybeQ2Tr+8Scjlwp0cR1WpmLxTOtpTLku30hJU28njv2kzGLpIZ1/JaIyvjPPs
         QkyM+jv8kidEjnU1PJDGtNXUGZZiI01SC/sjU=
Received: by 10.239.131.199 with SMTP id 7mr255322hbo.79.1287678015435;
        Thu, 21 Oct 2010 09:20:15 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id c40sm643769vcs.25.2010.10.21.09.20.12
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 21 Oct 2010 09:20:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201010211752.59514.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159520>

Jakub Narebski wrote:

> The major problem is that svn:log etc. are _unversioned_ properties (see
> http://svnbook.red-bean.com/en/1.5/svn.ref.properties.html), so I am not
> sure if there is a way for Subversion server to tell that some svn:log
> properties changed.  Perhaps there is a log, even if properties are
> unversioned... otherwise we would have to detect somehow that properties
> changed.

There has been brief discussion of that possibility on the Subversion
list [1]:

 "What we might need is an RA call that has
  the server provide the N last revisions to have undergone revprop edits..."

I'm guessing that there is not such a log now but the developers might
be open to a patch adding such a log (for the sake of svnsync and
similar use cases, like this one).

> Later we fetch again from SVN repository, and besides new revisions to
> be converted we notice somehow that svn:log property for revision 'n'
> changed from A to B.
> 
> We now create replacement commit BB in Git, with the same Git parent
> as commit AA, and with commit message changed to BB.  Then we add
> commit BB as replacement for AA:
> 
>   $ git replace -f AA BB

Yes, exactly.  In some cases, this "git replace" step would have to be
accomplished by a separate command (or even "by hand") to get the job
done:

 alice> git clone svn://svn.example.com/
 upstream> svnadmin propedit ...
 bob> git clone svn://svn.example.com/

In this situation, alice and bob have diverging histories, just as
if upstream had rewritten history (because, well, upstream has).

Now if alice fetches from bob and notices that, then she must do

 alice> git replace AA BB

(or its user-friendly equivalent, or a batch equivalent to search for
and handle cases like this). 

[...]
> If changes to unversioned revision properties are rare, then replacement
> technique is much superior to using notes, which generates unnatural git
> repository.  When changing commit messages (svn:log) and the like are 
> common and often, which would result in great many replacements, the
> notes technique could be better because of performance reasons.

Exactly.  Well, one can mitigate the performance problems by running
"git filter-branch" every once in a while. :)

Regards,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.subversion.devel/122840/focus=122944

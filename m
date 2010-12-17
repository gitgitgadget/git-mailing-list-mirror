From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Performance issue exposed by git-filter-branch
Date: Thu, 16 Dec 2010 21:37:15 -0600
Message-ID: <20101217033715.GA7302@burratino>
References: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com>
 <20101217014539.GA6775@burratino>
 <1FBB24BF-6517-4906-99D5-A5DDBEA14D6D@irridia.com>
 <20101217032232.GC7003@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jakub Narebski <jnareb@gmail.com>
To: Ken Brownfield <krb@irridia.com>
X-From: git-owner@vger.kernel.org Fri Dec 17 04:37:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTR8X-0003MO-5L
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 04:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab0LQDhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 22:37:35 -0500
Received: from mail-gx0-f180.google.com ([209.85.161.180]:61944 "EHLO
	mail-gx0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752063Ab0LQDhe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 22:37:34 -0500
Received: by gxk19 with SMTP id 19so147420gxk.11
        for <git@vger.kernel.org>; Thu, 16 Dec 2010 19:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hyzufJQ6goGDlyYBIDwzMYFZw2cKpKxm2Kq28/a3nNE=;
        b=uw1q0vbaRBQHTfkGRp9CdDbH+lUhwadDGRNl7X39I2XSahlv3LIf8QLMFtaGAKD+mh
         VHqMm274wasacMCKvKxnM7PDQjp5H3BmsC/Vj4PefSMnlTbYSgdmC9WdCh7+ExG02NQl
         sNtQcaYTKMXeqrXrr/FVM89WHHfXN/1et1OWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HaEtkFTPyN7N2QoCdLcjbjq8ir/TJqaW22uWz+z6hHqqDSbmqVMrIHcO4Xp8QZSPDA
         tSO4sJmtYa7GQHctcsjY1m4IBtlEMhrHJmUXHSm88aycwsYHuMpmF4mHEYeNEXh8bicC
         1BTOdDiu78dLCPhdfTRtTCrNn1Ty6PbTUB8jM=
Received: by 10.90.88.6 with SMTP id l6mr1634183agb.177.1292557053786;
        Thu, 16 Dec 2010 19:37:33 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.ameritech.net [69.209.48.248])
        by mx.google.com with ESMTPS id w4sm3675488anw.36.2010.12.16.19.37.31
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 16 Dec 2010 19:37:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20101217032232.GC7003@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163858>

Jonathan Nieder wrote:
> Ken Brownfield wrote:

>> The thread titled "git and larger trees, not so fast?".
>
> Here it is[1].  Sorry to say, the improvements discussed there
> were made right away and indeed had a dramatic effect.

Of course I missed your point. :)

filter-branch --index-filter works a little like this: for
each commit:

. find the underlying tree
. read-tree: unpack that tree and all of its subtrees into
the index file.  That is, convert from a recursive structure
   /:
	COPYING
	Documentation/
	INSTALL
	Makefile
	...

   Documentation/:
	CodingGuidelines
	Makefile
	...

into a flat structure

	COPYING
	Documentation/CodingGuideLines
	Documentation/Makefile
	Documentation/RelNotes/1.5.0.txt
	...
. rm: find entries matching certain patterns and remove them
from the index file.  This takes two passes through the index:
first to find matching entries, second to write the result to
disk.
. write-tree: write new trees for the object store.  That is,
convert from a flat structure back to a recursive structure.

This is convenient, but it does not sound to me like the most
efficient way to eliminate a few subtrees from each commit.  That is
why I was suggesting a method that avoids unpacking some trees
altogether.

That said, speedups for read-tree, rm, and write-tree would certainly
be nice to have.  One project of interest to some people is to give
the index file a recursive structure, so finding the entries to remove
in the "git rm" example could be faster.

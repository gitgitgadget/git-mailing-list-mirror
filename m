From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] fix recursive-merge of empty files with different
	permissions
Date: Thu, 13 Mar 2008 13:52:29 +0100
Message-ID: <20080313125229.GA24758@localhost>
References: <20080308171726.GA16129@localhost> <alpine.LSU.1.00.0803081850470.3975@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 13 13:53:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZmvm-0007hz-Sq
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 13:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYCMMwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 08:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752000AbYCMMwb
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 08:52:31 -0400
Received: from wx-out-0506.google.com ([66.249.82.224]:11933 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbYCMMwa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 08:52:30 -0400
Received: by wx-out-0506.google.com with SMTP id h31so3705460wxd.4
        for <git@vger.kernel.org>; Thu, 13 Mar 2008 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        bh=MH5u96+TA9/6dn29R8uYUmUnLOfC/mFdxINI42xKkH4=;
        b=wOmPIxh9/J57/c3PSPOyspn0YJQo61h+Fm5+UjxoaUuo+qdXHlyzodv4pCmT0eheOCj25AzLDSBV70NHvl2Plgxri/NvKMaXfAgQknJftr9nYO4Y7CagwQd4KR0B9DcjneuurIcewIhJmmQFvwTJvAp8/5oNaqEEJIOkEQO2DUI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=RzdT4Ix6jg0jNDt2tbbjW52S3H5dog7R9JatV/MsDnvaVJDJTMXpQ+rentxtydcDXQXRzil5AIKUWJwVa+S6nK7ksTysGB2EAlfMZ+vmMUDLVa2tHkDEkgKiTek73b9W2JDu1r72UqrcfVBG73zlQvkRKuyXqJw89cv66j5IPxk=
Received: by 10.141.141.3 with SMTP id t3mr5698147rvn.52.1205412748689;
        Thu, 13 Mar 2008 05:52:28 -0700 (PDT)
Received: from darc.dyndns.org ( [88.117.51.108])
        by mx.google.com with ESMTPS id u1sm6619314uge.14.2008.03.13.05.52.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Mar 2008 05:52:26 -0700 (PDT)
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1JZmv7-0006iA-Ma; Thu, 13 Mar 2008 13:52:29 +0100
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803081850470.3975@racer.site>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77071>

Hi,

On Sat, Mar 08, 2008 at 06:17:26PM +0100, Clemens Buchacher wrote:
> If git-merge-recursive attempts to merge two empty new files with
> different executable flags, eventually xdl_merge() is called and produces
> empty diffs for both files and therefore does not choose either file as
> successor. Make xdl_merge() choose one of the files instead.

On Sat, Mar 08, 2008 at 06:51:48PM +0100, Johannes Schindelin wrote:
> On Sat, 8 Mar 2008, Clemens Buchacher wrote:
> > I do not understand why, but this does not happen if the file 
> > permissions are the same.
> 
> I think this is the biggest problem.
> 
> >  t/t6031-merge-recursive.sh |   23 +++++++++++++++++++++++
> >  xdiff/xmerge.c             |   30 ++++++++++++++----------------
> 
> ... because xdiff/xmerge.c is definitely the wrong place to "fix" this 
> issue.  xdl_merge() does not even _know_ about permissions.

After analyzing the problem in greater detail, I have to disagree. It is true,
of course, that xdl_merge() does not and should not know about permissions at
all. However, the bug is still in xdl_merge(). Different permissions are only
the trigger of the problem, because only then will xdl_merge() be called at
all.

What happens is this. Before looking at the file contents directly
merge_trees() attempts to resolve the merge trivially. If both sha1 and mode of
the head and remote entries match, the merge will be resolved as per case #5ALT
(see Documentation/trivial-merge.txt), i.e. head is chosen as the merge result.

If either sha1 _or_ mode differ between the head and remote entries, however,
merge_trees() will use xdl_merge() to merge the file content and the remote
entry's mode will be chosen as result mode.

One could argue that it would be better to mark the mismatching permissions as
a conflict. However, this is how the merge currently silently succeeds _unless_
both files are empty. If they are, xdl_merge() will effectively exit with an
error status and git-merge-recursive will fail with an internal error (as shown
in the testcase).

In any case, I think it is reasonable to expect xdl_merge() to work with empty
files. Whether or not the current "mode merging" behavior is desired is a
different matter.

Regards,
Clemens

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: long fast-import errors out "failed to apply delta"
Date: Tue, 26 Jul 2011 18:58:58 +0200
Message-ID: <20110726165858.GA2334@elie.dc0b.debconf.org>
References: <CA+gfSn8jjptyv10iVimmfXpf6QHrR_3UpkRdd+Dv1M=KgORtGQ@mail.gmail.com>
 <CA+gfSn8C-nB2hSSRTqSu1N1Z-b8ctRsVmUGAjLXTW0du_W3EQw@mail.gmail.com>
 <CA+gfSn8m=_vd91Xe5EnFXUvZnuJf-yUE6H7FU+ak8S8a+NtCjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <davidbarr@google.com>
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 18:59:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlkyQ-00005k-MF
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 18:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706Ab1GZQ7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jul 2011 12:59:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:40913 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032Ab1GZQ7H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2011 12:59:07 -0400
Received: by ewy4 with SMTP id 4so581672ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=M6S6RGS0zNDC+K339t+y53ppt2SaXhEOADNM5HW3Yew=;
        b=jQVGGgZya+/vE+v+9k40Be5XYQVI5KY2eOOkrpOS4ioxKba+9QAyE7Vd8ARMayuCI1
         NR8d4nJ2b/nscyp0eV5el1HPpmdn6mvqgUbdnGo2X7+nvs0hVl6fXJEdC6Dn82gPeBYC
         gSGitv5UGHFGR4XA1gJf8wDh4ttwBTcXOZh2c=
Received: by 10.14.37.137 with SMTP id y9mr2278526eea.202.1311699545806;
        Tue, 26 Jul 2011 09:59:05 -0700 (PDT)
Received: from elie.dc0b.debconf.org ([78.28.140.4])
        by mx.google.com with ESMTPS id v20sm493282eeh.12.2011.07.26.09.59.03
        (version=SSLv3 cipher=OTHER);
        Tue, 26 Jul 2011 09:59:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CA+gfSn8m=_vd91Xe5EnFXUvZnuJf-yUE6H7FU+ak8S8a+NtCjA@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177892>

Hi Dmitry,

Dmitry Ivankov wrote:

> 3) Is this breakage specific to tags/v1.7.3-rc0~75^2 "Teach
> fast-import to import subtrees named by tree id" 30 Jun 2010 (allowing
> M 040000 <tree id> pathname)?

Probably. :)

> The harder fix is to try to keep e->versions[0].sha1 for trees correct.

Context for those who don't remember all the details:

When first introduced, "struct tree_entry" was very simple: a mode, a
filename, and:

 - for regular objects and symlinks, a blob object name representing
   its content;

 - for subdirectories, a pointer to "struct tree_content" listing its
   contents, along with an _optional_ cached tree object name.

When modifying a tree entry, fast-import would walk through the path
to it and invalidate the cached tree names at each step.  Shawn wrote:

	Currently trees and commits aren't being deltafied when written to
	the pack and branch reloading from the current pack doesn't work,
	so at most 5 branches can be worked with at any one time.

but the advantage was that it was very simple.  Later, delta
compression arrived:

	commit 4cabf858
	Author: Shawn O. Pearce <spearce@spearce.org>
	Date:   Mon Aug 28 12:22:50 2006 -0400

	    Implemented tree delta compression in fast-import.

	    We now store for every tree entry two modes and two sha1 values;
	    the base (aka "version 0") and the current/new (aka "version 1").
	    When we generate a tree object we also regenerate the prior version
	    object and use that as our base object for a delta.  This strategy
	    saves a significant amount of memory as we can continue to use the
	    atom pool for file/directory names and only increases each tree
	    entry by an additional 24 bytes of memory.

In other words, this commit introduced a "prior" mode and tree or blob
name to give the pack-writing machinery a hint about what to delta
against.

With that in mind, it seems very weird that the version 0 tree would
ever be changed and need to have its object name invalidated.  Perhaps
we are releasing some memory too early and it is getting clobbered?
Unless I am missing something, the patch

> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1514,6 +1514,9 @@ static int tree_content_set(
>                                 if (e->tree)
>                                         release_tree_content_recursive(e->tree);
>                                 e->tree = subtree;
> +                               if (S_ISDIR(mode)) {
> +                                       hashclr(e->versions[0].sha1);
> +                               }
>                                 hashclr(root->versions[1].sha1);
>                                 return 1;

just disables deltas for trees that have been modified by a "M 040000"
command, so it feels more like a workaround than a fundamental fix.

Could you save the svn-fe output (e.g., by introducing "tee" in the
middle of the "svn-fe | fast-import" pipeline) and put it up
somewhere online?  This would also be a good starting point for coming
up with a reduced testcase.

Hope that helps,
Jonathan

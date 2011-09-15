From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fwd: vcs-svn and friends
Date: Thu, 15 Sep 2011 05:01:06 -0500
Message-ID: <20110915100106.GB2328@elie>
References: <CAFfmPPOBZ6cXG51mDHbj2VRDzjvH46Q7=_LvUWeMq0SGR40S1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org
To: David Michael Barr <davidbarr@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 12:02:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R48lg-0001Ty-69
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 12:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755896Ab1IOKBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Sep 2011 06:01:12 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:45135 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab1IOKBL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Sep 2011 06:01:11 -0400
Received: by ywb5 with SMTP id 5so2026931ywb.19
        for <git@vger.kernel.org>; Thu, 15 Sep 2011 03:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=v9xVHZpHLyhFN3mrZG+4q7FcbxphhGedv+CEoC/Sxas=;
        b=nmZ6CumcNdyOyV2V4DQPXpKsqSFIC3JXpYb+24+CmxgPFMWSbanclRjy1Y3JqR1xiq
         XDG36MMEzW5DaJPMahmn71ptEziiQVSg9dTOIh+A7d23q74HW8tSqYs3D0II+iC1bPN6
         1kELTH5ndX4pOtglWBwGgfs84Zbek9FDrvBuc=
Received: by 10.42.162.3 with SMTP id v3mr356744icx.127.1316080870467;
        Thu, 15 Sep 2011 03:01:10 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id n14sm4024386ibi.4.2011.09.15.03.01.08
        (version=SSLv3 cipher=OTHER);
        Thu, 15 Sep 2011 03:01:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFfmPPOBZ6cXG51mDHbj2VRDzjvH46Q7=_LvUWeMq0SGR40S1g@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181455>

David Michael Barr wrote:

> Thanks to the work of Dmitry, we now have a simple front-end
> that exercises the yet unmerged changes to vcs-svn that Jonathan
> and I authored a few months ago. I think there's still some work
> to be done before we can bless an integrated branch for inclusion.
> I'd like to bring attention to just how far we have diverged; see the
> email below.

Quick thoughts:

 - everything up to c5bcbcdc looks good to me (as you might expect)

 - later patches seem to be missing your sign-off.  Is this deliberate
   (as in: "withholding sign-off as a hint that these haven't received
   their final review yet") or an oversight?

 - f4472ae61 ("fast-import: be saner with temporary trees"): when I
   looked it over in $gmane/178043, I acked the patch, but not the
   change description.  Re-reading the patch, I've completely forgotten
   what it does and the commit message doesn't help.  What user-visible
   effect would the patch have, if any?

   Reading over $gmane/178043, I learn:

    - new_tree_entry() returns a tree entry from a stack of trees used
      as temporaries.  Initializing them before use is indeed the
      caller's responsibility.

    - parse_ls() uses the following idiom to retrieve content named by
      a tree-ish and path within it:

	struct tree_entry result = {0};
	struct tree_entry *root;

	root = new_tree_entry();
	hashcpy(root->versions[1].sha1, treeish_name);
	load_tree(root);
	tree_content_get(root, path, &result);
	release_tree_entry(root);

      This method that populates "root" only to free it moments later
      is somewhat wasteful --- it would be nicer to stop parsing each
      tree when the appropriate entry is found, which would speed up
      commands in the input stream like

	ls 78a7c87aabc78acb7887c89a98c87ca87ca8ca89 a/a/a/a/a/a/a

      when the relevant trees have many entries.  Oh well.

      This patch is about a detail in that sequence --- the temporary
      tree entry "root" just mentioned has uninitialized fields, such
      as versions[0].sha1.  Nobody accesses them, though, and the result
      from tree_content_get() which is the important thing has no
      uninitialized fields.  So this patch is about futureproofing or
      code clarity rather than an actual functional change.

   Would it be possible to suggest a new change description that
   clarifies that?

 - 3bba32e9 ("fast-import: allow top directory as an argument for some
   commands"): I'm not sure what the motivation is --- is this just
   about the principle of least surprise, or did it come up in practice
   somewhere?

   The change description could use some examples and a reference to
   the earlier related work it seems to be inspired by ("fast-import:
   Allow filemodify to set the root").  It would also be nice to
   update the manpage to document the change at the same time.

 - e9e480e7 ("vcs-svn,svn-fe: convert REPORT_FILENO to an option") has
   nested quote marks in the test.

   The motivating comment "Moreover it may require noticeable effort
   to setup this descriptor, if number 3 is already taken for example"
   is unjustified --- system("foo 3>wherever") or { fork();
   dup2(wherever, 3); execlp("foo", ...) } does not look noticeably
   difficult to me, though maybe there is some unexplained detail that
   makes this require more effort in some circumstance.

Ok, I notice I am starting to nitpick.  Better to make a global
comment: the change descriptions do not currently motivate each change
in a straightforward way.  I'd be glad to help with that by providing
feedback and examples where appropriate if help is needed.  I believe
that fixing this can make other pieces that need fixing easier to find
when they exist.

Thanks for your help,
Jonathan

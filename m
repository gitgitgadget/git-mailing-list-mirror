From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git fast-import : How to change parent during import?
Date: Wed, 30 Mar 2011 18:25:54 +0100
Message-ID: <20110330182554.5375787b@fenix.utopia.dhis.org>
References: <AANLkTikiEfUSdNqqTjuYy_JLJnEyCizmusSucYsEHC2r@mail.gmail.com>
	<20110308024427.GA21471@elie>
	<AANLkTini6NgeYxRdFtSDKe8GEEszDvXwRtLnuymiRNt4@mail.gmail.com>
	<20110308222328.GE26471@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 19:27:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4zAj-0006It-8X
	for gcvg-git-2@lo.gmane.org; Wed, 30 Mar 2011 19:27:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755101Ab1C3R0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2011 13:26:52 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36917 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815Ab1C3R0v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2011 13:26:51 -0400
Received: by wwa36 with SMTP id 36so1776167wwa.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2011 10:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:in-reply-to
         :references:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=rDJ/kPwUKSLC8kTcdvaaND3Ame9OzkqyOIbIeDRpPT0=;
        b=CKZxTqs+N9EM9fizm+Wio/W9XmEHmSIEbrRSnRvZpO3tUhKAY9/7Rcf5/Woa+5vU2D
         1VVqbRJfyDIWvbGCtCmQjIMiTmgEBe5cmpJVm9Wc+lUtCknTc+NOoE5/YiOx+DhFBcrY
         gxlcGucF68lHSoeN99PI9xMgQQXjvwf2TRMEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=SNLLfbyGYu0XTPRKxNYijUqyt9b7Nc+NCdlN8RF7TOf3BtlvBTBvaAw57LPKy654Ly
         GnnmLLlz+7v1GVTAlnlcwZTNufgW8jvgIdpngmu0d5NZTwtubLmOUuMvhR12tzLaku+0
         vueeZ7sb+qAEt9FLavm6A2l7w0QK9mEDx42Cg=
Received: by 10.227.196.10 with SMTP id ee10mr1577389wbb.209.1301506009936;
        Wed, 30 Mar 2011 10:26:49 -0700 (PDT)
Received: from fenix.utopia.dhis.org ([95.69.85.122])
        by mx.google.com with ESMTPS id p5sm173252wbg.11.2011.03.30.10.26.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2011 10:26:49 -0700 (PDT)
In-Reply-To: <20110308222328.GE26471@elie>
X-Mailer: Claws Mail 3.7.8 (GTK+ 2.24.3; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170396>

Hi Jonathan,

On Tue, 8 Mar 2011 16:23:28 -0600
Jonathan Nieder <jrnieder@gmail.com> wrote:

> The "tag fixup" idea is that in VCSes like CVS, tags do not
> necessarily match the content on any branch.  So the history looks
> somewhat like so (time flowing left to right):
> 
>                      TAG
>                     /
>  o --- o --- o --- o --- o --- o ...
> 
> instead of the perhaps more sensible
> 
>  o --- o --- o --- TAG --- o --- o ...
> 
> The side branch leading up to a tag does not correspond to any branch
> name; after it is in the correct state one can use the "tag" command
> to get it remembered in permanent history.  The same technique might
> be useful whenever you are creating history that is not meant to stay
> permanently on any branch.

I don't think the TAG_FIXUP trick is what I need in this case. Assume the
following:

A --- B --- C --- D ...    (branch1)
      \
       E --- F --- G ...   (branch2)

Now assume that we are at commit D when we detect a commit to branch2. At this
point there is no way of knowing the origin commit in branch1. What is currently
being done is to use commit D as the parent of branch2, which is incorrect. But
if we assume that all branches are created through a "cp" like command, then we
know that B=E. So my idea is to go over A, B, C, etc and commit E "from:" each
one and see which results in a zero differences diff-tree.

Unfortunately, the current implementation I am using doesn't feel simple enough.
Because I'm using commands external to fast-import, I need to be constantly
making use of "checkpoint". And this seems to not be good enough, because I need
to sleep during 0.1s (didn't try other values) after each "checkpoint" before
being able to use diff-tree and similar commands. I am also forced to use the
"--force" command due to all the orphan commits I leave behind.

I would really prefer to have a simpler solution. Do you, or anyone else, see
another option?

Thanks in advance,
-- 
Vitor Antunes

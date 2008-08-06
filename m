From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git reset --hard isn't resetting
Date: Wed, 6 Aug 2008 14:02:44 -0400
Message-ID: <32541b130808061102q752076a8ydc02fef4e799491f@mail.gmail.com>
References: <1c5969370808060941q59cb8f7fhabee3ef3c5107715@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Matt Graham" <mdg149@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 20:04:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQnNA-00023u-UV
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 20:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760805AbYHFSCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 14:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756125AbYHFSCr
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 14:02:47 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:30145 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760760AbYHFSCp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 14:02:45 -0400
Received: by an-out-0708.google.com with SMTP id d40so4590and.103
        for <git@vger.kernel.org>; Wed, 06 Aug 2008 11:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fZ7gSsMctwxt+nwoQeSdyfF+ho/yd1QN6hGprGmA3I0=;
        b=hlNgkfLOwyM5ttvMXgwCfnoX5uFpsujyQIQe4ogWe4K/J5Auh7Vx+38CFTrlV1TvMB
         /fyidkOo+YLFh7BsFSWTYen0M9Q6N0jN9pGsrmTvw6RmNAbWuwjwLTd+KS1Q4W+jj8El
         h7rzuiOVtiX9Wc77tmbOIwBVVuZgbeMmuvL+o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=XKgBPOOfpOt6FvyBXYTo+yq2ykoF+/5BjFbL78sU0X8XJIiK6CcXdUw/azAU0qeIyO
         TWAGPxkIf9/n2adwvl+xl3RnKWzvdNC48xrWKmOl3lwisem2/x7axl3WwGimtkkKIEHm
         P+eoHpIg+MfWMYoDt6HsqJLybxppeFUMcO2AI=
Received: by 10.100.252.17 with SMTP id z17mr794208anh.35.1218045764476;
        Wed, 06 Aug 2008 11:02:44 -0700 (PDT)
Received: by 10.100.8.19 with HTTP; Wed, 6 Aug 2008 11:02:44 -0700 (PDT)
In-Reply-To: <1c5969370808060941q59cb8f7fhabee3ef3c5107715@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91531>

On 8/6/08, Matt Graham <mdg149@gmail.com> wrote:
>  I'm using a git svn tree in Cygwin.  I tried doing an svn rebase and
>  got in some weird state with local changes I can't get rid of.  It's
>  not an issue w/ the same repository on my linux machine.
>
>  git reset --hard
>  toggles 4 files between capitalization.  The files don't appear to
>  have changed case in svn, but it's a huge repository and not easy to
>  determine with certainty.

Try:
   git log --name-only
to see which patches change which files.  It's a virtual certainty
that they were renamed in svn at some point.

git doesn't handle case-munging filesystems perfectly, and gets into
the situation you describe.  First, you need to figure out whether you
have files with *both* cases accidentally added to your index (if git
reset toggles the capitalization, this is almost certainly the case):

    git ls-tree HEAD

If you see the same files with different case, that's your problem.

Now just 'git rm' the ones with the case you don't want, and commit
the result.  (Do *not* use commit -a!)  'git status' will give you
some funny messages indicating that files you *didn't* 'git rm' have
gone away in the filesystem; it's true, of course, but don't worry
about that.  Now 'git reset --hard HEAD' and you should be okay.

I'm not really sure what git should do better in this case, although
the current behaviour is obviously a bit confusing.

Have fun,

Avery

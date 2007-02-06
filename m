From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Use of "stg sync"
Date: Tue, 6 Feb 2007 10:07:15 +0000
Message-ID: <b0943d9e0702060207v3a6ed16fs61feb34f03211a6@mail.gmail.com>
References: <20070204144233.GP5362@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
To: "Yann Dirson" <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 11:07:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HENEc-0004Tb-Tf
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 11:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbXBFKHT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 05:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbXBFKHT
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 05:07:19 -0500
Received: from an-out-0708.google.com ([209.85.132.246]:10527 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752064AbXBFKHR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 05:07:17 -0500
Received: by an-out-0708.google.com with SMTP id b33so1239044ana
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 02:07:17 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GOAQw+OYaHfDnvRHeHZBNZsy6oIhorewDWF8Pejk77YB1bSUSjb4uB6goYNvORYKCAENfi9njfLSpsFw0HFbx16MLMOja0BA3w8WGtgo1bLGWEx5I8kkYmlM8NBVYccJWiE+5fUOw9u+utD9AG/KAwOlBa1hL+jaufomSnkp/wM=
Received: by 10.114.151.13 with SMTP id y13mr732095wad.1170756436054;
        Tue, 06 Feb 2007 02:07:16 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Tue, 6 Feb 2007 02:07:15 -0800 (PST)
In-Reply-To: <20070204144233.GP5362@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38829>

On 04/02/07, Yann Dirson <ydirson@altern.org> wrote:
[...]
> Then I wanted to integrate the bugfix from "etch" into "lenny".  So I
> just tried to use "stg sync" on this patch.  It should be noted that
> this particular patch is the one that adds the Debian packaging files
> (as opposed to the other ones, which modify the upstream source
> files).
>
> Here is what I get.  I suppose that could have been expected, but that
> looks nevertheless annoying...

Have you modified the last try/except block in stgit.main.main? You
should only get an error message, not the full backtrace.

The interesting messages are:

> Synchronising "debian"...Error: File "debian/tau.files" added in branches but different
> Error: File "debian/tau-racy.files" added in branches but different
> Error: File "debian/rules" added in branches but different
> Error: File "debian/changelog" added in branches but different
> stg sync: GIT index merging failed (possible conflicts)

Which are what I would expect the 'sync' command to do - it tries a
three-way merge between the debian//top, debian@etch//top and
debian@etch//bottom (the order is probably different). Since the
debian/rules etc. files aren't present in debian@etch//bottom and you
modified them in debian@etch//top, you get a merge conflict - files
added in both branches but different.

'stg status' should show the conflict files and you have to manually
fix them. If you know that you only modified the patch in etch, you
can do 'stg resolved -a -r patched'. You could also add 'recursive =
True' argument to the git.merge() call in
stgit.commands.sync.__branch_merge_patch(). This would perform a merge
with 'git-merge-recursive' rather than 'git-read-tree -m' and it is
supposed to do a smarter two-way merging. You might not get a conflict
at all or, at least, the conflicted file would have some markers.

The reason I didn't add the recursive merge for 'sync' was the
slowness of this operation (git-read-tree -m was faster but maybe
git-merge-recursive was improved in the last weeks). Please try this
and let me know whether you get better results so I can modify the
'sync' command.

Anyway, this is a limitation of 'sync' three-way merging and I
couldn't find an easy solution. For me, the best thing is that if the
patch was synchronised, there won't be any conflicts reported and I
can be sure they are the same. You mentioned patches of patches some
time ago but these would get lost on the first rebase (unless you want
to have a patch made of sub-stacks but you get to a fractal structure
with sub-sub-...-sub-stacks :-))

-- 
Catalin

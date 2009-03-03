From: David Copeland <davetron5000@gmail.com>
Subject: Re: move files between disparate repos and maintain version history
Date: Tue, 3 Mar 2009 11:58:42 -0500
Message-ID: <f95d47890903030858xb398b5fy1aeabb19166e6077@mail.gmail.com>
References: <0d8965bb-e2ed-4f49-b323-c110f605ae2c@33g2000yqm.googlegroups.com>
	 <20090303041300.GA18136@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 18:00:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXya-0002F1-G7
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 18:00:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754692AbZCCQ6r convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 11:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753686AbZCCQ6r
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:58:47 -0500
Received: from mail-fx0-f176.google.com ([209.85.220.176]:59381 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbZCCQ6q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2009 11:58:46 -0500
Received: by fxm24 with SMTP id 24so2523707fxm.37
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 08:58:42 -0800 (PST)
Received: by 10.103.244.4 with SMTP id w4mr3650660mur.90.1236099522501; Tue, 
	03 Mar 2009 08:58:42 -0800 (PST)
In-Reply-To: <20090303041300.GA18136@coredump.intra.peff.net>
X-Google-Sender-Auth: 712aa28431736590
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112119>

The first option worked, insomuch the history of diffs is preserved,
but the dates are all today.  The second option was a little over my
head; is the idea there that you are setting up a branch that has ONLY
the files I care about (with all their history), and then I pull from
the other repo as if they are related?  That seems like it might
preserve the dates...

Dave

On Mon, Mar 2, 2009 at 11:13 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Mar 02, 2009 at 12:30:58PM -0800, davetron5000 wrote:
>
>> So, is there a way I can move a file between two git repositories,
>> maintaining the change history? =A0I guess it would be something lik=
e
>> "apply all patches that this file was involved in, but ONLY apply th=
e
>> ones affecting this file, to the new repo, then delete from the old"=
?
>
> Yes, that's more or less how you would do it. There are actually two
> separate issues, and each has two possible solutions.
>
> Issue 1 is moving the history to the new repo.
>
> One solution is, as you guessed, to export as patches and import into
> the new repo:
>
> =A0cd /path/to/app
> =A0git format-patch --stdout --root -- <path> >~/patches
> =A0cd /path/to/core
> =A0git am ~/patches
>
> where <path> can be a file, directory, or a list of either or both.
> This should work fine if the history of that path is linear, since a
> list of patches is, by definition, linear. You can see the "shape" of
> the history with:
>
> =A0cd /path/to/app
> =A0gitk -- <path>
>
> The other solution is to actually rewrite a version of git history th=
at
> sees only those paths, then merge it in. That will retain the actual
> shape of the history. You can do this using "git filter-branch":
>
> =A0cd /path/to/app
> =A0# we do our work on a temporary branch
> =A0git branch just-path
> =A0# the actual filter; note you could do more than just grep here
> =A0# if you wanted to munge the pathnames
> =A0git filter-branch --index-filter '
> =A0 =A0git ls-files -s | grep path |
> =A0 =A0 =A0GIT_INDEX_FILE=3D"$GIT_INDEX_FILE.new" git update-index --=
index-info &&
> =A0 =A0mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"
> =A0' --prune-empty just-path
>
> =A0# you can inspect just-path at this point with "gitk just-path"
> =A0cd /path/to/core
> =A0# and then pull it into core's history
> =A0git pull /path/to/app just-path
>
> The second issue is what you want to have happen in the "app"
> repository. Presumably you no longer want the moved files there. You
> _could_ filter-branch to pretend as if they were always in "core" and
> never in "app". But that is probably not a good idea because:
>
> =A01. You are rewriting history, which will make merging more complex=
 for
> =A0 =A0 your users.
>
> =A02. You may be breaking historical builds which expect the files to=
 be
> =A0 =A0 there in the past.
>
> So I think you're probably best to just remove them with a new commit
> and have the duplicated history in both.
>
> -Peff
>
> PS I think you might be able to replace the filter-branch invocation
> with a fast-export / fast-import pipeline, but I haven't tried.
>

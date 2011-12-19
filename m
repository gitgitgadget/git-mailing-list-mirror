From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git-p4: labels
Date: Mon, 19 Dec 2011 10:28:18 +0000
Message-ID: <CAOpHH-W1hE6bw51NKXrdf1QtF3T+v4aLwxMn+_5xPP5j=uJr3w@mail.gmail.com>
References: <4EEE3203.10605@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Michael Horowitz <michael.horowitz@ieee.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Mon Dec 19 11:29:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcaSr-0007SW-8I
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 11:29:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270Ab1LSK2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 05:28:55 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50684 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752077Ab1LSK2v (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2011 05:28:51 -0500
Received: by lagp5 with SMTP id p5so2107890lag.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 02:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=g72B6p5rgcMjBKwiHpq/WpkO1wOEcMIQA/qbtvk6u0A=;
        b=DJOhy0Gx/xbPt8Mh7ayDTB1uV9NLWWqu47rXRbvH4d/a5eX68zwxrdkWs8TeSow7IJ
         Tcmpd5podENRhft5g7F01k+ZkIcoU2+WRhaFCQPxOMPmANmhst5nEoPyq/MgSOZyO68H
         GvfEsNOFBUG20Lsew1oY1A3WT17F8WknmZ0Sw=
Received: by 10.152.136.39 with SMTP id px7mr1832697lab.2.1324290529291; Mon,
 19 Dec 2011 02:28:49 -0800 (PST)
Received: by 10.152.5.105 with HTTP; Mon, 19 Dec 2011 02:28:18 -0800 (PST)
In-Reply-To: <4EEE3203.10605@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187445>

On Sun, Dec 18, 2011 at 6:33 PM, Luke Diamand <luke@diamand.org> wrote:
> I've been looking at fixing the --detect-labels flag in git-p4. I'm now
> thinking that the current way it's done is just all wrong.
>
> The current code has a few annoying bugs which I mostly have fixes for:
>
> - it only works when there is no more than one label per changelist;
>
> - if the count of files in the p4 label doesn't match the count of files in
> the p4 changelist then the label gets dropped (by design);
>
> - git-p4 rebase ignores --detect-labels
>
> - it imports all the label/file mappings each time (I haven't fixed this
> yet)
>
> However, the thing that's more annoying is that it only imports labels when
> importing the changelist they are pointing at.
>
> So, for example, if you do something like this:
>
> p4 edit; p4 submit
> p4 tag TAG1
> git-p4 rebase
> p4 tag TAG2
> git-p4 rebase
>
> then TAG1 will be detected, but TAG2 won't.
>
> This is a particular nuisance for me, as I just have git-p4 running all the
> time eating commits, so there's no scope for a human to delay the git-p4 and
> pickup the label.
>
> I think what's needed is to do something completely different.
>
> This is speculation at the moment, and I'd welcome comments before I start
> hacking.
>
> There will be a new _command_, import-labels. This command will find all the
> labels that git knows about, and the labels that p4 knows about, and then do
> the obvious diff. It will then create tags as needed directly (i.e. not
> using fast-import).
>
> It will unfortunately need to hunt through the revision history looking for
> the git hash <h> that matches p4 changelist <c>. This could get quite slow,
> although no worse than O(n).
>
> Something like:
>
> p4 edit; p4 submit
> p4 tag TAG1
> git-p4 rebase
> git-p4 import-labels
> p4 tag TAG2
> git-p4 import-labels
>
> I'm going to try to work up a patch with some test cases but in the meantime
> if anyone thinks I've missed something, please let me know.

Hi Luke,

Personally, I would prefer to keep the label import working together
with git-p4 rebase/sync so that it doesn't need to go over P4 history
twice. The sanity check currently implemented seems completely bogus. In
my opinion that check should be completely rewritten (maybe move it into
a specific class method?). On a first approach it should at least check
if all files in the label exist in the repository/branch. Ideally, if
not all repository/branch files are labelled, then a special branch
should be created that would not contain those files and the label would
be applied to that. I'm not sure what to do in the case where the label
contains files that are not part of the repository/branch... maybe we
can simply ignore them with a Warning?

If you are really sure that this is not the way to go and that the
import-labels command needs to be created, then I would advise you to
search P4 history backwards until you find a label that was already
imported. This way the script only has to go over P4 history until the
last time import-labels was run. Of course, it still needs to do this
for all branches (hope you are not forgeting them ;).

-- 
Vitor Antunes

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC eb/double-convert-before-merge 0/6] merge -Xrenormalize
Date: Tue, 3 Aug 2010 22:19:35 -0500
Message-ID: <20100804031935.GA19699@burratino>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 05:21:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgUXZ-0008Bf-NS
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 05:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758119Ab0HDDU5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 23:20:57 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:65087 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757520Ab0HDDU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 23:20:56 -0400
Received: by gwb20 with SMTP id 20so1811150gwb.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 20:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=571H7utvQ2rMCz57DXP7r/RkMfM0JOWY3NTMygSO/KE=;
        b=B00fnu51ahD51bUZUxg0fWKiO36rAhZdGyPZHUM+IXwTgEvhnFRrcXxJ55h2NMzUdA
         bektEUOOPZ9E1Ew3X1xBG/drN+xHcJ/fBxc8tYmU9hCZvFNLK4gTWi3Ps1zEWDrVdvfU
         CKNrocLF/PdqJeRzJ1hqDMqKdxa5RlROeN4+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cRv+ZJDahJ24LHSqZ+GtBzAs8jRiFI9O2/nWehcizeo6ciYLT1gurqhWtv+VcQGG/U
         TziVSjI2GnkcLgPzXc7nTQjLQdBqJmhnJkJHQwL4Ntnlkh3o5t9ZfXtTjtM9pRp8NY0r
         4HDHHbyYy2YdIUDdQDqEdMhxBF1Zwfc+cS3sI=
Received: by 10.100.8.2 with SMTP id 2mr9209994anh.165.1280892054877;
        Tue, 03 Aug 2010 20:20:54 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id l6sm12880993ang.38.2010.08.03.20.20.53
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 20:20:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152555>

Hi Eyvind,

Eyvind Bernhardsen wrote:

> Here's a new version of the merge normalization series that renames t=
he
> configuration variable.  Since "merge.renormalize" got the best
> response, I went with that.

I have no idea how the following branch happened in my local git tree,
but it=E2=80=99s here now so maybe it=E2=80=99s worth something.  Someh=
ow I got the
idea that the merge_renormalize variable was a nice short-term
protection but long-term scary, and so a few patches emerged to
banish it.

Please let me emphasize that in their current form I do not think
these patches should be very usable.

But for later, they tell a nice story.  The idea is that the
"merge.renormalize" is not really about the behavior of the "git
merge" command but about the merge-recursive driver; and so it
should be usable everywhere else that driver is used, too.

So in an ideal world, you would be able to, e.g.:

	git checkout -m -Xrenormalize otherbranch

or

	git revert -Xrenormalize otherpatch

or

	git pull --rebase -Xrenormalize

Of course, the plumbing is not all there yet; many commands that
use merge drivers cannot pass through arbitrary options through
yet.

Well, enough talking.  Here are the patches; what do you think?

Patch 1 teaches blob_unchanged() to stop paying attention to the
merge_recursive variable.  It uses a parameter instead.  So from then
on, it can watch, bemused, a neutral party.

Patch 2 adds and respects a renormalize option in the merge_options
struct.  It defaults to the value of the merge_recursive global to
save callers (in particular, "git merge") the pain of adjusting.

Patch 3 lets ll_merge merge callers decide whether to renormalize,
too.  Most callers never renormalize, since they are not "git merge"
(and this is noted in new comments).

Patch 4 is a sort of a digression.  It makes "git rerere" produce nice
help output with the "git rerere -h" option.

Patch 5 lets rerere callers decide whether to renormalize, too.  Most
callers never renormalize.  But looking at that patch reveals a
serious problem: there are all kinds of other merge options (e.g.,
-Xsubtree) that rerere callers are unable to control.

=46ollowing the principle that scripted users should have about as
much power as internal ones, patch 5 reluctantly exposes the
renormalize option to rerere as a new --renormalize option.  It
should be -Xrenormalize instead.

Patch 6 eliminates the merge_recursive global once and for all, by
teaching merge_recursive callers to set the renormalize merge option
appropriately (and removing the backward-compatibility default).
Callers that are not "git merge" still never use renormalize.

=46ollowing the principle that scripted users should have as much
power as internal ones, it also exposes the nice interface of an
-Xrenormalize option.  Some redundancy between builtin/merge and
builtin/merge-recursive is noticed but left for another topic.

Jonathan Nieder (6):
  merge-trees: push choice to renormalize away from low level
  merge-trees: let caller decide whether to renormalize
  ll-merge: let caller decide whether to renormalize
  rerere: migrate to parse-options API
  rerere: let caller decide whether to renormalize
  merge-recursive: add -Xrenormalize option

 Documentation/merge-strategies.txt |    8 +++++
 builtin/checkout.c                 |   13 ++++++++-
 builtin/commit.c                   |    4 ++
 builtin/merge-recursive.c          |    2 +
 builtin/merge.c                    |   24 +++++++++++----
 builtin/rerere.c                   |   56 ++++++++++++++++++++--------=
-------
 builtin/revert.c                   |   18 ++++++++++-
 cache.h                            |    1 -
 environment.c                      |    1 -
 ll-merge.c                         |    4 +-
 ll-merge.h                         |    2 +-
 merge-file.c                       |    2 +-
 merge-recursive.c                  |   11 ++++--
 merge-recursive.h                  |    1 +
 rerere.c                           |   20 ++++++++----
 rerere.h                           |    1 +
 16 files changed, 117 insertions(+), 51 deletions(-)

--=20
1.7.2.1.544.ga752d.dirty

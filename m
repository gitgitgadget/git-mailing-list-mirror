From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] clone: introduce clone.submoduleGitDir to relocate $GITDIR
Date: Tue, 16 Apr 2013 14:06:36 +0530
Message-ID: <CALkWK0kDgSicNejydLsH6iqj-yDYGz6CKd+kbn4EW1HxgAxsBA@mail.gmail.com>
References: <1365881007-25731-1-git-send-email-artagnon@gmail.com> <20130416025840.GH3262@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 10:37:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US1OI-0003dd-7t
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 10:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754838Ab3DPIhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 04:37:20 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:63217 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752669Ab3DPIhR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 04:37:17 -0400
Received: by mail-ia0-f179.google.com with SMTP id l25so182609iad.24
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 01:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=FativpihdZJ3jfpzdVDhuebi3lzYZdTeiplZJmh0Qyk=;
        b=qJn85seT4uhF9b1yQAFtXYf/rSwMSoTxjdw6NWSA160epLC9zTE2sNf3B/XqWR3KT6
         Aw8NLWbw6vNx9v2ahMQ80loXj3JvKhB9EOdpvj4jUyg8LuajXKzQ0qcP67NqAglereQR
         8yhILnVgwKqx6ZDHKFQXfnLVQAxQa66oL77u7+2vB2x/UiE0mrWeoYpRwOZ5YaOhO9fb
         EGHbHhNoP3f1JVpRyjcHxx3KU4mJtSzsQpiFYahYWvKgHMIbG6MoEHmVSAcObN2U23sG
         Aw4kNbtn+51HGW2G+hHyzEnCrka0f/e/geIxXK6+9wUANwFuQqUiKjZNs8WJunC6Cc6P
         Zyng==
X-Received: by 10.50.50.71 with SMTP id a7mr7163871igo.14.1366101436461; Tue,
 16 Apr 2013 01:37:16 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 01:36:36 -0700 (PDT)
In-Reply-To: <20130416025840.GH3262@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221396>

Jonathan Nieder wrote:
> I quite like .git/modules/<subproject name> (for some reasons that
> I've mentioned in other threads) and don't consider it nonsense, which
> makes me assume I don't understand the goal of this patch, either.
> Please don't take that personally.

There's nothing to take personally, Jonathan.  We're designing
software, and the rationale for choosing a design is never "Jonathan
personally likes this particular design, so therefore we'll go with
it", but rather "Ram's design is objectively superior, and therefore
we'll go with it".  I'll proceed with bashing .git/modules, while your
job is to defend it:

1. The path to the object store of a submodule depends upon how deeply
it is nested in other submodules, and hence how many /modules/
components to add to the path to the project's name.  Presumably, this
is to avoid conflicts: but it's an overkill for such a simple job.  In
the 98% case, I never have two submodules with the same name in my
superproject; for the 2% case, I can live with the inconvenience of
naming a directory by hand, rather than putting up with this ugliness.

2. This ugliness complicates implementation of add/ rm/ mv, because
each of them will have to know about this contrived path solution.

3. The paths in the gitfiles in various submodules is horribly ugly
with tons of ../ components.  This is especially the case in deeply
nested submodules.  We can't use an absolute path, because the
superproject directory can be moved anywhere in the filesystem.

4. To relocate the object store and reuse it elsewhere is almost
impossible.  What if I want to remove the submodule, but work on it
independently from the superproject?  Re-clone?

My solution fixes all these problems, and we need
.git/modules/<name>.git (no path-to-submodule nonsense) only as a last
resort: #3 (ref: my email to Peff).

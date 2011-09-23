From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 2/2] diff_index: honor in-index, not working-tree, .gitattributes
Date: Thu, 22 Sep 2011 20:38:14 -0400
Message-ID: <CAG+J_DzUQ3OGfiX=vHVGC7SHvwToVjD7uwFyDa8Tq6t7YwX12Q@mail.gmail.com>
References: <1316727861-90460-1-git-send-email-jaysoffian@gmail.com>
	<1316727861-90460-2-git-send-email-jaysoffian@gmail.com>
	<7v8vpgxkvb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 02:38:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6tmW-0002z3-On
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 02:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754605Ab1IWAiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 20:38:15 -0400
Received: from mail-gw0-f42.google.com ([74.125.83.42]:33721 "EHLO
	mail-gw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab1IWAiP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 20:38:15 -0400
Received: by gwj16 with SMTP id 16so2315025gwj.1
        for <git@vger.kernel.org>; Thu, 22 Sep 2011 17:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=giA1/lGziGxzr5HHbEynscVIe3nWIos1ZVrzWxVHdCg=;
        b=SczZhTOjuWjW9MSsn8s3fNNb3dC6hy8hn1B2fLNBZ2zCtZ2MRWsrsUAibAX6I7guKh
         /5PBo4PuVoAXG0rOI7jtPv+H9ujeby8FjiO5JQ0Ctbp1QLhgkURlAD5Yi9WGyaEJhlIB
         nc5TyDS3QzttYq3FaSYXHQoQMysyuQH5FlTmI=
Received: by 10.236.173.129 with SMTP id v1mr17894924yhl.25.1316738294469;
 Thu, 22 Sep 2011 17:38:14 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Thu, 22 Sep 2011 17:38:14 -0700 (PDT)
In-Reply-To: <7v8vpgxkvb.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181939>

On Thu, Sep 22, 2011 at 6:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> When diff'ing the index against a tree (using either diff-index
>> or diff --cached), git previously looked at .gitattributes in the
>> working tree before considering .gitattributes in the index, even
>> though the diff itself otherwise ignores the working tree.
>
> We can take attributes only from one place (so far from the working tree
> and perhaps from the index), people had to live within the limitation that
> comes from the "single source only" semantics. It also happens to be
> easier to understand (recall the complexity of the examples Jeff gave
> about "textconv" during "diff" which ideally should apply from its own
> side and "funcname", which does not even have a right answer).
>
> In practice, because development progresses by making everything
> (including the .gitattributes file) better, I think "use the newer one"
> would be a good compromise when we have two possible sources to grab
> attributes from but we can only use one source.

I agree with that...

> In that sense, I am somewhat skeptical about what this patch tries to
> do. The working tree is where people make the progress to update the
> index.

... but it still seems inconsistent that --cached ignores the working
tree except for .gitattributes.

This also happens to be the only way to get diff-index to work with a
bare repo and temporary (on-disk) index. But that's less important if
we implement what's suggested in the next paragraph.

> A related tangent.
>
> I think the logical conclusion of assuming that we will keep the "single
> source only" semantics (which I think we will, by the way, unless I hear a
> concrete proposal to how we apply attributes from more than one sources in
> what way to which side of the diff) is that a patch might be an
> improvement over the current behaviour if it teaches "diff-tree" to read
> from the tree and populate the in-core index (never writing it out to
> $GIT_DIR/index) from the postimage tree (i.e. "diff preimage postimage" or
> "diff -R postimage preimage") when it is run in a bare repository.

Okay, I can give that a try.

> It
> would be a regression if the attributes mechanism is used for auditing
> purposes (as we start reading from a tree that is being audited using the
> very attributes it brings in), though.

--[no-]tree-attributes?

j.

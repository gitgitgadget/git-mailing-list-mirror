From: =?ISO-8859-1?Q?Gr=E9gory_Pakosz?= <gpakosz@visionobjects.com>
Subject: Re: git filter-branch doesn't dereference annotated tags
Date: Tue, 1 Jan 2013 21:20:14 +0100
Message-ID: <CAC_01E3VWtsFd8ww+7W8DMhRAs4WgHf=bm+xoh9wszCkb-DfUA@mail.gmail.com>
References: <CAC_01E174m_6tDwPKZ5P0BUxnLNWUf9p+VkECFosPTzip0sYsA@mail.gmail.com>
 <7vsj6mdqeo.fsf@alter.siamese.dyndns.org> <CAC_01E3twtNq8YXQ8=SU5oXxmnAQS43L-46NF=7RyT4tFQvU5g@mail.gmail.com>
 <7vfw2kbs4h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 01 21:21:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq8Kg-0003uU-L0
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 21:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752448Ab3AAUUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 15:20:48 -0500
Received: from mail.elysmail.net ([188.165.34.231]:59538 "EHLO elysmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752408Ab3AAUUr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 15:20:47 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws; q=dns;
        d=visionobjects.com; s=vo2010objects;
        h=received:received:received:mime-version:received:in-reply-to
          :references:from:date:message-id:subject:to:cc:content-type
          :x-declude-sender:x-declude-spoolname:x-declude-refid
          :x-declude-note:x-declude-scan:x-declude-tests:x-country-chain
          :x-declude-code:x-helo:x-identity;
        b=W909U5yfkBn5a0hkxNDDB7/EPMNKI0IYrs9YNC3SdCbc1NXjzLJlZKAVrslQT4Ng4
          bM7ZbilsdSMjyRJLBfyzy4aVb/6J5tjrnhWcKpXiuRLKie2+p72l4TYZI+o7FOObo
          d5iTbmxLhn8IDVrpewL3NUPBpwv7sF5TqxQz8uPTM=
Received: from mail-vb0-f53.google.com (mail-vb0-f53.google.com [209.85.212.53]) by elysmail.net with SMTP;
   Tue, 1 Jan 2013 21:20:34 +0100
Received: by mail-vb0-f53.google.com with SMTP id b23so13371922vbz.26
        for <git@vger.kernel.org>; Tue, 01 Jan 2013 12:20:35 -0800 (PST)
Received: by 10.52.35.4 with SMTP id d4mr59499545vdj.6.1357071634865; Tue, 01
 Jan 2013 12:20:34 -0800 (PST)
Received: by 10.52.65.233 with HTTP; Tue, 1 Jan 2013 12:20:14 -0800 (PST)
In-Reply-To: <7vfw2kbs4h.fsf@alter.siamese.dyndns.org>
X-Declude-Sender: gpakosz@visionobjects.com [209.85.212.53]
X-Declude-Spoolname: 21162620.eml
X-Declude-RefID: 
X-Declude-Note: Scanned by Declude 4.10.59 "http://www.declude.com/x-note.htm"
X-Declude-Scan: Outgoing Score [0] at 21:20:37 on 01 Jan 2013
X-Declude-Tests: Whitelisted
X-Country-Chain: 
X-Declude-Code: 0
X-HELO: mail-vb0-f53.google.com
X-Identity: 209.85.212.53 |  | vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212436>

> Yeah, but in that case it appears to me that you told the command to
> rewrite the tag itself and the history behind the commit the tag
> refers to, but the end result did not rewrite the tag itself and
> left the tag pointing at the original history.
>
The problem exhibits at the point git filter-branch updates the references.
I indeed asked to rewrite tagged commits by passing --tag-name-filter cat

> The "$rewritten" variable being empty in this codepath tells me that
> the command decided that it *does* want to delete the tag, but as
> J6t mentioned in his review, it is unclear to me what is expected by
> the user.
>
The history behind the commit the tag refers to is empty after
filtering has been applied.
As a user, I expected the tag to be removed: it's not illogical, all
tags that pointed to history that has been entirely filtered out
should go away imho.
--tag-name-filter doesn't allow to deleted tags as J6t mentioned and
I'm not surre what the new contract would be: empty tag name to delete
a tag so if $(map $sha1) yields '' I can decided to delete the tag?

If the tag wasn't an annotated one, I guess it would have been
successfully deleted which exhibits a different behavior between
annotated and lightweight tags.

> If the command and the filters you gave the command decided the tag
> should be removed, then not being able to delete it is a problem and
> the code you patched that compares the object name of the tag and
> the object name of the commit the tag refers to is certainly doing a
> wrong comparison.
>
That's what I believe.
The index and commit filters are made to keep only a couple of
directories and get rid of the rest.
Those directories didn't exist early in the history. Commits in that
early part of the history were tagged with annotated tags.

> But I have this suspicion that you did not want to remove the tag in
> the first place.
>
The tag pointed to something the filters decided to throw out. Since I
want tags to be updated, it doesn't make much sense to keep it and I'm
expecting its deletion.

It appears to me that the suggested fix doing test $(git cat-file -t
"$ref") = 'tag' && sha1=$(git rev-parse "$ref") so that $sha1 is
obtained again from the tag ref but without dereferencing recursively
should only apply if --tag-name-filter has been provided. What do you
think?

> The application of "map" shell function to obtain
> $rewritten is done on the unwrapped object name by passing "$ref^0"
> to rev-parse, but perhaps that "^0" is the real source of the
> problem instead, so that it checks what new object the original
> annotated tag was rewritten to?  If the tag object was rewritten,
> either to empty to signal its removal or to a new object name, then
> we do want to update-ref it, but the decision should be made on its
> object name, not the object name of the commit it points at?
>
Are you suggesting $sha1 should be obtained differently before
entering case "$rewritten" ?
That would mean changing sha1=$(git rev-parse "$ref"^0) at line 376 to
something like $(git cat-file -t "$ref") = 'tag' && sha1=$(git
rev-parse "$ref") || sha1=$(git rev-parse "$ref^0") ?

Gregory

From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] builtin-fast-export.c: add default case to avoid crash on 
	corrupt repo
Date: Sun, 22 Mar 2009 13:22:39 +0100
Message-ID: <40aa078e0903220522g66cf2172l9f1a43ed562cc4d3@mail.gmail.com>
References: <1237675051-6688-1-git-send-email-kusmabite@gmail.com>
	 <7vd4cabffl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 13:24:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlMiq-0001hi-KW
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 13:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753946AbZCVMWq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 08:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753819AbZCVMWq
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 08:22:46 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:34714 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbZCVMWn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 08:22:43 -0400
Received: by ey-out-2122.google.com with SMTP id 4so405820eyf.37
        for <git@vger.kernel.org>; Sun, 22 Mar 2009 05:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VYfe87VoN9x3ZJUl458JvHZFqlPQJcr4txv0uZbCSdE=;
        b=n+fFZCTEN/fTrND7uQjTj/imJ7lOpcflhnNoNR+f9tnVHN84AJr/ICf3Qv4hwqJH2K
         Ow4QfdxlimUIPNZnDAPNN7yvSIptI9M6wSssoJVwTXNC4OnJigd+p6IMCoT0HAS06W78
         RNEEH8A0rW0rAD+SkiN3uLq9U+2dCAePCHf3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=j1OQEim1Jt2ENxDM8r8ER+p/nbc92eTsT/wlr8Ss93ZEGASuvD/7+a2wHl6BVtsKX4
         4hFnREdkQFHUKBEzi/lYiqkU+Ey7Nr75rYFSaGmVTSRjtsPYfPmzS/vUAUMVmjgg0TjG
         Ms0eEfkkOK6H0PUONmPTj1vnGGhy4rUDLYJfo=
Received: by 10.210.45.17 with SMTP id s17mr4500875ebs.74.1237724559832; Sun, 
	22 Mar 2009 05:22:39 -0700 (PDT)
In-Reply-To: <7vd4cabffl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114137>

On Sun, Mar 22, 2009 at 12:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
> A tag can point at anything, so this is not an issue about "crash on a
> _corrupt_ repository".

Ah, my bad. I wrongly assumed corrupted repos were the only ways of
triggering this issue. I quite easily managed to reproduce the crash
by setting up some tags to trees and tag objects to trees.

> I am not very familiar with this program, but the codepath involved should
> be prepared to _see_ any type of object instead of dying.
>
> What to do after _seeing_ a type of object is a different matter.  It
> appears that there is no way to feed a tree object to fast-import, but I
> think the fast-import language can represent a tag that points at another
> tag just fine.  So the best you can do is perhaps to issue a warning
> "skipping a tag that points at a tree object" and impoement a proper
> handling of a tag that points at a tag.
>

My patch simply applied the same error that was already present for
tags to tag objects, but yeah. Handling tagged tags and warning
instead of erroring-out makes more sense to me as well. I'll see if I
can write it up, and resubmit a patch.

After looking some more at the code, it seems that there's an attempt
to handle tags to tags there already, but it doesn't seem to work
properly; the program error out with a "fatal: Tag [tagname] points
nowhere?". This seems to be because the tagged-pointer of the second
tag-object is NULL. Now, I'm no expert, but from browsing some code,
it seems that "parse_object(tag->object.sha1)" should have been
performed on the tag before looking up the tagged object. Does this
make sense?

Also, I guess this calls for a couple of test-cases or something. I
haven't written any tests yet, so I might need some time to figuring
it out.

Anyway, I guess this makes the most sense as a four-patch series:
1) Add test-cases for tags of tag objects, tag objects of tag objects,
tags of trees and tag objects of trees.
2) Turn the existing error into a warning
3) Add the missing warning and remove the crash
4) Fix fast-export to export tags pointing to tags.

Makes sense?

Additionally, to reduce the chance of similar bugs in the future, the
code could be refactored a bit to have a handle_commit()-function, so
what goes on becomes a bit more obvious. Since this doesn't really
change any functionality, I guess it could be handed in as a separate
patch.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656

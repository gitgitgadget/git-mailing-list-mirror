From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 2/3] fast-export: improve speed by skipping blobs
Date: Mon, 6 May 2013 14:09:56 -0500
Message-ID: <CAMP44s2rdkND40QDQA9T7MNGoKPtnr50nV98aExUe4bCOXZGyA@mail.gmail.com>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-3-git-send-email-felipe.contreras@gmail.com>
	<20130506123111.GB3809@sigill.intra.peff.net>
	<7v7gjctabm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 06 21:10:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZQnT-0001Um-PX
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 21:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751Ab3EFTJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 15:09:59 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:48724 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755591Ab3EFTJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 15:09:58 -0400
Received: by mail-la0-f48.google.com with SMTP id eg20so3599408lab.21
        for <git@vger.kernel.org>; Mon, 06 May 2013 12:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=qbCS73AB9J/qG19nHNpaTs85OcPlyErQL1J0TWGtFP4=;
        b=zuiOZvkdKH3FN2UpNQt/PbwSY++FWzkJ/U4iXKPnP0aTFpoASrCpxNwfoH+3ONovHg
         ILSL6DIBaYzaAT2znPTKEKmP37YrSd3Lnx59aoFVqYXWG6gbT5b61/6oWd7iXBGqm/NY
         WTTjA2ml+1fphQUErN6VvcPc0Bu6IXrE+UKSsgXRigKpOJ/7U6BUtQDEp9rR+Kq5ILiL
         XWmfjfpu4FT1rCBldw1bSVYz5Pm7EX9TvPfApZmuVpPkgV93Mn3y40JQifskR0r1SC3/
         1w0H/lH2C/iN1lK4MgppWO7JFXXSuk8uijXgptWCUywZRG9rs0tPKWsch2c3y6Rb6Lk8
         F4zQ==
X-Received: by 10.112.154.98 with SMTP id vn2mr8553906lbb.8.1367867396636;
 Mon, 06 May 2013 12:09:56 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Mon, 6 May 2013 12:09:56 -0700 (PDT)
In-Reply-To: <7v7gjctabm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223484>

On Mon, May 6, 2013 at 10:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Sun, May 05, 2013 at 05:38:53PM -0500, Felipe Contreras wrote:
>>
>>> We don't care about blobs, or any object other than commits, but in
>>> order to find the type of object, we are parsing the whole thing, which
>>> is slow, specially in big repositories with lots of big files.
>>
>> I did a double-take on reading this subject line and first paragraph,
>> thinking "surely fast-export needs to actually output blobs?".
>>
>> Reading the patch, I see that this is only about not bothering to load
>> blob marks from --import-marks. It might be nice to mention that in the
>> commit message, which is otherwise quite confusing.
>
> I had the same reaction first, but not writing the blob _objects_
> out to the output stream would not make any sense, so it was fairly
> easy to guess what the author wanted to say ;-).

That's how fast-export has worked since --export-marks was introduced.

>> I'm also not sure why your claim "we don't care about blobs" is true,
>> because naively we would want future runs of fast-export to avoid having
>> to write out the whole blob content when mentioning the blob again.
>
> The existing documentation is fairly clear that marks for objects
> other than commits are not exported, and the import-marks codepath
> discards anything but commits, so there is no mechanism for the
> existing fast-export users to leave blob marks in the marks file for
> later runs of fast-export to take advantage of.  The second
> invocation cannot refer to such a blob in the first place.
>
> The story is different on the fast-import side, where we do say we
> dump the full table and a later run can depend on these marks.

Yes, and gaining nothing but increased disk-space.

> By discarding marks on blobs, we may be robbing some optimization
> possibilities, and by discarding marks on tags, we may be robbing
> some features, from users of fast-export; we might want to add an
> option "--use-object-marks={blob,commit,tag}" or something to both
> fast-export and fast-import, so that the former can optionally write
> marks for non-commits out, and the latter can omit non commit marks
> if the user do not need them. But that is a separate issue.

How? The only way we might rob optimizations is if there's an obscene
amount files, otherwise the number of blob marks that we are
*actually* going to use ever again is extremely tiny.

-- 
Felipe Contreras

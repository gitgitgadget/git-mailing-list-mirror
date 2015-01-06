From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH v2 0/2] Accept any notes ref
Date: Mon,  5 Jan 2015 22:03:51 -1000
Message-ID: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c>
Cc: Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>
To: Git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 09:06:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8P7f-00035D-KO
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 09:04:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754086AbbAFIEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 03:04:07 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:32937 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754028AbbAFIEE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 03:04:04 -0500
Received: by mail-pd0-f170.google.com with SMTP id v10so29976331pde.1
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 00:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=qox75oBS7nZ3dTwz5cjitXnHXznLFo6ETK7D0pFaMJg=;
        b=WS/39EbylPz79ZZ1TLqKK0w1rpqhIq/bAwmRaZXU5HNcSszQmGjUOiIcqV28Sd6wTS
         OQJShRBtmN5g1YvwpmrxIxKjaqg1FWw6K2t3GFWw4CknGQMSnBuy7Sk2DzUZYsJFnlPp
         GWFoRoTzUTWWSpKWRGJ9Vyecs7FWsaNO6cUXlxuDwSn1qWES203JIJ0CEfY605O7bFIp
         2jdl+ETwK3fywiERl2ZPhuG7didnyK/+xaa+MR78bhCr5GRY5M8w0g1AQJlRg80rTUJD
         FGLuoLFzdGukKh/Vx0Co8f0oNDrM0q0UyTvagi5YCd8fwo6/uKqa+vdWVzdkeV3Y9R6N
         izUQ==
X-Received: by 10.68.68.206 with SMTP id y14mr152060374pbt.165.1420531444189;
        Tue, 06 Jan 2015 00:04:04 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id ug6sm56550745pab.7.2015.01.06.00.04.02
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 00:04:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262048>

This is a resend of the original patch by Scott Chacon combined with the
suggested patch by Johan Herland with a summary of the discussion so far
in the hope to restart discussion about including this change.

The original thread can be found at [1].

The history so far:

The Patch 1/2 was originally submitted to allow using refs outside of
the refs/notes/ namespace as notes refs for the purpose of merging notes.
However, that patch actually just relaxes the restriction on notes refs so
that a fully-qualified ref will be used as-is in the notes code and affects
more than just notes merging.

The concern was then raised that this is a "stealth-enabler" patch and that
even if notes refs are allowed outside of refs/notes/ then they should still
be restricted to a some subset (to be determined) of the the refs/ hierarchy
and not just allowed anywhere.

But, I feel that the rest of Git does not restrict the user in this way -- if
the user really wants to do something that is "not recommended" there is
almost always a mechanism and/or option to leave the user in control and allow
it despite any recommendation(s) to the contrary.

So I am resending this summary with attached patches (both of which are
very trivial) to allow using any ref for notes as long as it's fully qualified
(i.e. starts with "refs/").  Patch 1/2 does that and patch 2/2 fixes the test
that breaks because of it.

In the hope of restarting discussion towards enabling use of refs outside of
refs/notes/ with the notes machinery I conclude by including Peff's final
reply to the original thread which I think contains the most compelling
aregument for inclusion:

On Dec 4, 2014, at 02:26, Jeff King wrote:

> On Sat, Nov 22, 2014 at 10:04:57AM -0800, Kyle J. McKay wrote:
>
>> On Sep 19, 2014, at 11:22, Junio C Hamano wrote:
>>
>>> By "stealth enabler" I mean the removal of refs/notes/ restriction
>>> that was originally done as a safety measure to avoid mistakes of
>>> storing notes outside.  The refs/remote-notes/ future direction
>>> declares that it is no longer a mistake to store notes outside
>>> refs/notes/, but that does not necessarily have to mean that
>>> anywhere under refs/ is fine.  It may make more sense to be explicit
>>> with the code touched here to allow traditional refs/notes/ and the
>>> new hierarchy only.  That way, we will still keep the "avoid
>>> mistakes" safety and enable the new layout at the same time.
>>
>> This is the part where I want to lobby for inclusion of this change.
>> I do not believe it is consistent with existing Git practice to
>> enforce restrictions like this (you can only display/edit/etc. notes
>> under refs/notes/*).
>
> Yeah, this is the compelling part to me. There is literally no way to
> utilize the notes codes for any ref outside of refs/notes currently.
> We don't know if refs/remote-notes is the future, or refs/remotes/
> origin/notes, or something else. But we can't even experiment with it in a
> meaningful way because the plumbing layer is so restrictive.
>
> The notes feature has stagnated. Not many people use it because it  
> requires so much magic to set up and share notes. I think it makes sense to  
> remove a safety feature that is making it harder to experiment with. If the  
> worst case is that people start actually _using_ notes and we get  
> proliferation of places that people are sticking them in the refs hierarchy,
> that is vastly preferable IMHO to the current state, in which few people use
> them and there is little support for sharing them at all.

-Kyle

[1] http://thread.gmane.org/gmane.comp.version-control.git/257281

Kyle J. McKay (1):
  t/t3308-notes-merge.sh: succeed with relaxed notes refs

Scott Chacon (1):
  notes: accept any ref

 notes.c                | 2 +-
 t/t3308-notes-merge.sh | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.1.4

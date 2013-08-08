From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Fri, 9 Aug 2013 00:44:01 +0530
Message-ID: <CALkWK0mE=Gov1YocbGMs4cUGf+-uEorvkFwBEpP0JXfDLPwuyQ@mail.gmail.com>
References: <1375756727-1275-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org> <201308081134.35735.mfick@codeaurora.org>
 <7va9ks9frm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Martin Fick <mfick@codeaurora.org>, Duy Nguyen <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 08 21:14:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7Vfa-0002um-NW
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 21:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966189Ab3HHTOm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 15:14:42 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:64690 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966176Ab3HHTOl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 15:14:41 -0400
Received: by mail-ie0-f179.google.com with SMTP id c11so2469570ieb.24
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 12:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1IOFNb+gHSYlnb4Kocnx16ru/vVfj1+4muFuphVLvnE=;
        b=Jr/e2vCMzCEOTH9ws/Jo+jOk2/0fpicYeWsPa2PMNdXEp/ARMQAt0H5MhcP4hFZJX0
         7oGOvOXvZX/wKE0YXYzdHG0WwagJFfI+4qCsNt/tfRuXTUjQLkjsiGSHNHRx+pwNhXHS
         y6wddy5pvkqkvBg6TEBPzsViPt/iZqhozXG1MNzBj+LWAmSb/iHA9tlJMLG0KgYEy2OI
         UVbE8SKxMg0unvgiGR+e/coVHwEXw5DW+Dp4aJh6sgFwKFocot1Cg7k2ciIldWWNMPa4
         ZquNXqIRiSGM/sUEA2h/i4KK28VgKYv3H1fswQF2k6a3/HKmP1db6CGHGiDZ6p3KCKqi
         hgyQ==
X-Received: by 10.43.88.3 with SMTP id ay3mr2772086icc.61.1375989281114; Thu,
 08 Aug 2013 12:14:41 -0700 (PDT)
Received: by 10.64.37.130 with HTTP; Thu, 8 Aug 2013 12:14:01 -0700 (PDT)
In-Reply-To: <7va9ks9frm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231923>

Junio C Hamano wrote:
> Martin Fick <mfick@codeaurora.org> writes:
>> Assuming I understand what you are suggesting, would these
>> "young object" likely still get "deduped" in an efficient
>> way without doing history traversal (it sounds like they
>> would)?
>
> Yes.
>
> The very first thing pack-object machinery does is to get the list
> of object names and sort them in a certain order to help producing
> good deltas, and this initial input preprocessing will dedup them.

So, the proposal is to create an index of young objects without doing
reachability analysis (I still didn't get the point of packing them;
as I pointed out, it seems to be rather counter-productive) to help
the actual packing? From what I vaguely understood:

1. Index all the young objects to save a history traversal (?)

2. Perform the reachability analysis using the index in step 1, and
then generate the pack.

I'm not yet clear about what information 1 contains to help 2. Is it
the rough ordering? (The big important objects come near the top of
the pack, and the deltas are generated against them). I say "rough"
because the ordering might change after the unreachable objects are
pruned.

*scratches head*

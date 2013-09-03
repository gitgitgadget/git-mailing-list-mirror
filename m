From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] {fetch,receive}-pack: drop unpack-objects, delay loosing
 objects until the end
Date: Tue, 3 Sep 2013 18:56:23 +0700
Message-ID: <CACsJy8ButV8Y6Rm=F8dLTw3NvRCJZ1RgJ5f-591ASbOqfDRRTQ@mail.gmail.com>
References: <1378091107-31682-1-git-send-email-pclouds@gmail.com> <20130903064938.GB3608@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 03 13:56:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGpEB-0007ko-3D
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 13:56:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932771Ab3ICL4z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 07:56:55 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:55725 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932710Ab3ICL4y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 07:56:54 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so6505146oag.10
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 04:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QqC2r50QKkyZTBJ6MPfbk8KKzouzCyN5GzzWjQxgFoc=;
        b=QN/Q04Dulgf3m4inIyK0liDxz/BkI/02n9+bLgNkWFELHAuff1R55AH6dF1YY9fPBn
         YIe4SpCd1mScnGS9na5TSMWbeozp+CGLbGbIRCNY/s8pVPIPU+fy0a3hjvDrVTed0dS1
         uuUxNaCSSkYIh5vW+0q0IDSqDcJh2bb0mwN4l9JoEA8fZQy8vX0PjzSaCWC/2zA0wAKL
         LcU38n4AuOsroPBLuZrIiJF5gE4g8Sit2SWfw4X3mbAjJcd/rSbjzVp+1QqD8l23ogCy
         ynIktP5CmO7HDmdodevy6dRQHbRwoePWd7GOSecjKvr3wJbp0VOBnIMXa/h2Hq1WOuzj
         eMBg==
X-Received: by 10.60.44.9 with SMTP id a9mr500816oem.67.1378209414029; Tue, 03
 Sep 2013 04:56:54 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Tue, 3 Sep 2013 04:56:23 -0700 (PDT)
In-Reply-To: <20130903064938.GB3608@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233718>

On Tue, Sep 3, 2013 at 1:49 PM, Jeff King <peff@peff.net> wrote:
>>  - by going through index-pack first, then unpack, we pay extra cost
>>    for completing a thin pack into a full one. But compared to fetch's
>>    total time, it should not be noticeable because unpack-objects is
>>    only called when the pack contains a small number of objects.
>
> ...but the cost is paid by total pack size, not number of objects. So if
> I am pushing up a commit with a large uncompressible blob, I've
> effectively doubled my disk I/O. It would make more sense to me for
> index-pack to learn command-line options specifying the limits, and then
> to operate on the pack as it streams in. E.g., to decide after seeing
> the header to unpack rather than index, or to drop large blobs from the
> pack (and put them in their own pack directly) as we are streaming into
> it (we do not know the blob size ahead of time, but we can make a good
> guess if it has a large on-disk size in the pack).

Yeah letting index-pack do the work was my backup plan :) I think if
there is a big blob in the pack, then the pack should not be unpacked
at all. If you store big blobs in a separate pack you already pay the
the lookup cost of one more pack in find_pack_entry(), why go through
the process of unpacking? index-pack still has the advantage of
streaming though. Will rework.
-- 
Duy

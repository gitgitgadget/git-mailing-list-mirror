From: James Denholm <nod.helm@gmail.com>
Subject: Re: [PATCH v2] contrib/subtree bugfix: Can't `add` annotated tag
Date: Wed, 14 May 2014 22:50:01 +0000
Message-ID: <20140514225001.GA5850@debian>
References: <1399954138-2807-1-git-send-email-nod.helm@gmail.com>
 <xmqqa9alo4lm.fsf@gitster.dls.corp.google.com>
 <20140513230201.GA32562@debian>
 <xmqqy4y5l1c7.fsf@gitster.dls.corp.google.com>
 <20140514213206.GA12228@debian>
 <xmqqtx8shwel.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kevin Cagle <kcagle@micron.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 15 00:50:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wki04-0005Gd-O3
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbaENWuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:50:06 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:63729 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751609AbaENWuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:50:04 -0400
Received: by mail-we0-f177.google.com with SMTP id x48so225482wes.22
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=u2RiUK2gd480NLjbbYV7iw4Ye7sYfzm/TPhHNT3/2dg=;
        b=F4haepPpcrHuXTnKgJ/PqPk6pOpa85+FI2N8p87U1HhDCrqp/7TFyqOW6WcYn2eNNb
         L3jQnXWf97fOau0b2YeRZHWznqTKHxVsIHJGtq9cpPKWQ3Moxf5eY/4lbezcfJXw19s2
         lEj/vK2xPUZW03Rp+prgsIuzD4LDXbBY2vKqyRzo1PNsgJj1qvPBKE8B/3jjXpEO2Ptj
         5dRrAyfQo3jERIGxAkOVNoIfvsebB1KdTLDKuIXDUICmuiH7fHXYzo16y4vd5jvs3P3t
         tLVz3/kPHQrr31vSYrXt9ODxyLbhxAkfsTKr6PA1cVg246ClcxsTUuNysPsAzIKri5P3
         y/+Q==
X-Received: by 10.180.183.131 with SMTP id em3mr17060066wic.56.1400107803434;
        Wed, 14 May 2014 15:50:03 -0700 (PDT)
Received: from debian ([2a04:1980:3100:1aac:21b:21ff:feda:4cbe])
        by mx.google.com with ESMTPSA id ek4sm6412860wib.9.2014.05.14.15.50.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 May 2014 15:50:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqtx8shwel.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249045>

Junio C Hamano wrote:
> To me, it looks like all that is necessary is to accept your patch
> but with a three-byte tightening to detect such a pathological case
> and signal an error, which is what " &&", which I added to your new
> line that sets revp=$(peel_committish ...), is about.
> 
> This patch, with or without these extra " &&" three bytes, will not
> be part of the upcoming 2.0 release anyway, so we have enough time
> to iron it out.

Ah, right, sorry, somehow I missed the " &&" in the amended patch. I
don't know how I overlooked that. That indeed would be plenty.

> Sorry, I am lost.  What would be a problem exactly?
> 
> A FETCH_HEAD can be pointing at an object that is not committish,
> and users involved, both at the originating end who controls the
> repository you fetched from and at the receiving end who wanted to
> fetch the object, are *not* expeting to be able to make a merge of
> such an object anyway.  My suggestion was not to ask you to come up
> with a sane behaviour when the user told us to add a single blob
> with "subtree add"; it was merely to detect such unintended use as
> an error.

Yeah, what I meant by problem was the possibility of finding a way to
pre-empt the case of a tag pointing to a blob and handle it as
gracefully as possible, and try to leave the user with their working
tree in the state from before the subtree call.

The reason I'd suggest it might be worth handling at some point is that
(in the far flung future) it may not be out of the scope of subtree to
pull not only other repos to a local subtree, but also specific trees
(or perhaps blobs) to a local subtree. Conceptually, I'd argue that a
sensible future functionality in order to allow subtree users to deal
with upstreams that don't split their projects up sanely (cough splutter
Facebook's internal). Hence, working out a way to determine tag types,
possibly before doing the fetch somehow, would be a boon to that
methinks.

Of course, this is something I haven't yet thought enough about and the
idea is likely full of holes, but hey, I'm nothing if not impractically
idealist.

---
Regards,
James Denholm.

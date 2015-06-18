From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/19] Introduce an internal API to interact with the fsck machinery
Date: Thu, 18 Jun 2015 15:11:02 -0700
Message-ID: <xmqq8ubgd5vt.fsf@gitster.dls.corp.google.com>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
	<cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jun 19 00:11:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5i1e-0005Qa-Fz
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 00:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbbFRWLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 18:11:06 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36267 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbbFRWLE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 18:11:04 -0400
Received: by igbiq7 with SMTP id iq7so1802852igb.1
        for <git@vger.kernel.org>; Thu, 18 Jun 2015 15:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=cr2eZy/xO2gKjGG+RYxFwzXyRqIwHZ00cxvJkFwdqn8=;
        b=Ood/HmxxObdCMbD59OBA4mzP0SLnS6FTmMsdTcc0pKqg9CnH5xPvhVx2CEbCp1ySU5
         3dk0MQSxOqAgMbdlDj9JH8SauGllNNyr5ZTyuftI+WngOh/SpE3oEUd/iDlVFPEObwxl
         9LpH2fYXrrVI/EyTMWBziNCbLzzBQMok6CzYCDwZdurL2m2B/d819x+skg5y6cyFLE4R
         IH1ohwE6oLZv5Zes8hH178buYHhyvy5DrAe8QGRF7Qc8itQr37OFosHVX68d7ws7hfuH
         Xrilhn7sXnMAjPNIh9QDQt/+QVtTu3/6UTJ0GWqXIHaHPwzqPMWk2IO7HNpwWoEeIu7x
         wHbw==
X-Received: by 10.50.79.228 with SMTP id m4mr427315igx.6.1434665463463;
        Thu, 18 Jun 2015 15:11:03 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e04a:861:67b3:9e25])
        by mx.google.com with ESMTPSA id p193sm5789509ioe.34.2015.06.18.15.11.02
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 18 Jun 2015 15:11:02 -0700 (PDT)
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Thu, 18 Jun 2015 22:07:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272085>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> At the moment, the git-fsck's integrity checks are targeted toward the
> end user, i.e. the error messages are really just messages, intended for
> human consumption.
>
> Under certain circumstances, some of those errors should be allowed to
> be turned into mere warnings, though, because the cost of fixing the
> issues might well be larger than the cost of carrying those flawed
> objects.

> Interdiff below the diffstat. It's huge. Sorry.

Heh, no need to say sorry, though.  A large interdiff means you did
a lot more work, after all.

I haven't had a chance to go through the all the patches, but one
thing I noticed that did not appear in the interdiff is that some of
the message IDs are unclear.  For example, there are BAD_something,
INVALID_something and MISSING_something.  The last one is in a
different category and is good, but how are the former two
differenciated?  Do they follow some systematic rules, or they are
named after the way how they happened to be reported in the original
textual error message?

Some of the questionable groups are:

    BAD_DATE DATE_OVERFLOW

    BAD_TREE_SHA1 INVALID_OBJECT_SHA1 INVALID_TREE

    BAD_PARENT_SHA1 INVALID_OBJECT_SHA1

Also it is unclear if NOT_SORTED is to be used ever for any error
other than a tree object sorted incorrectly, or if we start noticing
a new error that something is not sorted, we will reuse this one.

I also briefly wondered if fsck.skipList should be finer grained
than "these are know to be broken, do not bother reporting problems
with them" (e.g. I know v0.99 lacks "tagger" so I want to squelch
MISSING_TAGGER_ENTRY for it, but I want to be notified on any other
errors).  But that only matters if we update Git to a version with a
new fsck that knows yet more kinds of breakages, so it is not a huge
issue, and the simplicity of "be silent on these objects" is
probably better overall.

Thanks.

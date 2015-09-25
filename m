From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] gc: remove broken refs
Date: Thu, 24 Sep 2015 17:08:41 -0700
Message-ID: <xmqqr3lnuzqu.fsf@gitster.mtv.corp.google.com>
References: <cover.1443085919.git.johannes.schindelin@gmx.de>
	<8855bae256311446dffd221ab33c1163eb104c4a.1443085919.git.johannes.schindelin@gmx.de>
	<20150924175758.GB15117@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 25 02:08:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfGZE-0003FG-DP
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 02:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbbIYAIo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 20:08:44 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35781 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbbIYAIn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 20:08:43 -0400
Received: by pacfv12 with SMTP id fv12so88633706pac.2
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 17:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=nbBD/6g/VQ3YM3/hDBKcvwvnNjzGfAJbrmWBAyym76Q=;
        b=HdtOa9YzI3GlIfKmBUpRa/4rjBvO7PSqOggJknigct0MMZbwQgcBv5PCMcLUq2nqqw
         XNOR+YqGm8Vylc6oSmxw3PoUIyMGPu2rapP6Pw5X7wotkhFBUPhiwSit8WjP6pen04F9
         H46Q5sQnSb4Zuw2n4v4y3Ibx8715P2viAakOkLHTlUTw3GnXREfsnQEeQcGuKHGLwjBA
         FNi+lFNQFataxDUiUnMLYfHNU0TKWgGTO7p4hTnBZnzGzM9W4XEoRBRv4IFZhVmpuFYm
         71l5Kut9xN/RLFj5eYx1WD4JN911sXaKee+LiDj0Mf+R1Dwtc38qXlMriuJKrC/+Y3zP
         Y1+A==
X-Received: by 10.66.147.74 with SMTP id ti10mr3137922pab.88.1443139723093;
        Thu, 24 Sep 2015 17:08:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:9c11:78a0:634d:a891])
        by smtp.gmail.com with ESMTPSA id u1sm546829pbz.56.2015.09.24.17.08.42
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Thu, 24 Sep 2015 17:08:42 -0700 (PDT)
In-Reply-To: <20150924175758.GB15117@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 24 Sep 2015 13:57:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278637>

Jeff King <peff@peff.net> writes:

> For the same reasons as in my earlier responses, I think it's dangerous
> to remove broken refs (it makes a small corruption much worse). It seems
> reasonably sane to remove a dangling symref, though if we teach
> for_each_ref to gracefully skip them, then leaving them in place isn't a
> problem.

One thing I wondered was if we can reliably tell between a ref that
wanted to be a real ref that records a broken object name and a ref
that wanted to be a symbolic ref that points a bogus thing, and if
we can't, should we worry about it too much.  The former is more
serious, as the history behind the commit it wanted to but failed to
record is at risk of being pruned.

One case that is clearly safe is "ref: refs/heads/gone"; it is not
likely to be the result of attempting to write a real object name
gone bad by whatever filesystem corruption.  On the other hand, an
obviously problematic case is an empty file.  We cannot tell if the
"broken" ref used to anchor the tip of a real history (which is
about to be lost with Dscho's patch 1/4) or was merely pointing at
another ref (which will not harm the object database if ignored).

So the rule should be

    If resolve_ref_unsafe_1() says it is a symbolic ref, if
    check_ref_format() is OK with the ref it points at, and if that
    pointee is missing, then it is safe to skip.

All other funnies should trigger the safety.

The collection of "broken and can be removed" refs introduced by 3/4
may also have to take that into account, I think.

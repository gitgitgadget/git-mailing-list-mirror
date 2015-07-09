From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Do less work when given "from" matches current branch head
Date: Thu, 09 Jul 2015 15:47:56 -0700
Message-ID: <xmqq380xuew3.fsf@gitster.dls.corp.google.com>
References: <20150709055227.GA32360@glandium.org>
	<1436424609-26159-1-git-send-email-mh@glandium.org>
	<xmqqk2u9uky9.fsf@gitster.dls.corp.google.com>
	<20150709223018.GA3403@glandium.org>
	<xmqq7fq9uf1w.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 00:48:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDKbr-0004mf-Oi
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 00:48:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbbGIWr7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 18:47:59 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:35882 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977AbbGIWr6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 18:47:58 -0400
Received: by iecvh10 with SMTP id vh10so186367985iec.3
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 15:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=r9/SAvsD704yCaDA2elS6Yb3cWeqx37T/lCZgowKqH0=;
        b=ek+GgLa7rDkvA8apKQm+TGy+zARJVq/0LeaVeEYQA8YFjgpLpKREjp/c69CGWAbVNK
         SKokKSoVbwPwV/CCjJWfY2Y6pvHOM6uAO1xU2Y0KpKWukLlEDS6jqlJ4y+2xJICKpHRB
         BiHo1vX6YmZUPgBvwyQRJES+XMgU8FEUbWxHN3JC0HMxQsRdRlT5dJ83D/hmL3M0hCQp
         LPDBUxesLso4rHXUWu/FYzv/kJbNlDp2qDZTgjP1+Li3JcY/lAH5vy/gs19GWk3fknUr
         ZrLENu9rv7wI0D2/qrkaHasRBMcUgtW/eCczqJWsbhB0FWRM3LtC9kQn/sj8wnN7MzDd
         DW0A==
X-Received: by 10.107.153.66 with SMTP id b63mr2019436ioe.101.1436482078375;
        Thu, 09 Jul 2015 15:47:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:647a:d824:a8a3:7bb0])
        by smtp.gmail.com with ESMTPSA id k74sm5160174iok.30.2015.07.09.15.47.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 15:47:57 -0700 (PDT)
In-Reply-To: <xmqq7fq9uf1w.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 09 Jul 2015 15:44:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273784>

Junio C Hamano <gitster@pobox.com> writes:

> Mike Hommey <mh@glandium.org> writes:
>
>>> Does that mean the original code was doing a release that was
>>> unnecessary?  Or does it mean this patch changes what happens on
>>> that codepath, namely (1) leaking resource, and/or (2) keeping a
>>> tree of the original 'b' that does not have anything to do with the
>>> tree of 's', preventing the later lazy-load code from reading the
>>> tree of 's' and instead of building on top of a wrong tree content?
>>
>> I guess the question is whether branch_tree.tree can be in a state that
>> doesn't match that of branch_tree.versions[1].sha1. If not, then if s
>> and b have the same branch_tree.versions[1].sha1 for some reason, then
>> keeping the old branch_tree.tree makes no practical difference from
>> resetting it. Except it skips the busy-work.
>
> Perhaps my comment was misleading.  I _think_ the state at the end
> of this function (i.e. the latter hunk you added to the function
> makes the above issue I raised go away).  It just made me feel

s/this function (/this function is good (/;

> uneasy to leave branch_tree.tree and branch_tree.versions[] in an
> inconsistent state inside this function, while it calls a few helper
> functions (hence my comment on the fact that they do not seem to be
> affected by this inconsistency).

From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-import: Do less work when given "from" matches current branch head
Date: Thu, 09 Jul 2015 15:44:27 -0700
Message-ID: <xmqq7fq9uf1w.fsf@gitster.dls.corp.google.com>
References: <20150709055227.GA32360@glandium.org>
	<1436424609-26159-1-git-send-email-mh@glandium.org>
	<xmqqk2u9uky9.fsf@gitster.dls.corp.google.com>
	<20150709223018.GA3403@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 00:44:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDKYU-0002RH-Fm
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 00:44:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbbGIWob (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2015 18:44:31 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33472 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbbGIWo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jul 2015 18:44:29 -0400
Received: by iggp10 with SMTP id p10so24160571igg.0
        for <git@vger.kernel.org>; Thu, 09 Jul 2015 15:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=MsGM+iJgFq7XTniFxYGdGMYbZB+OaduN1vte/fgV1Bk=;
        b=kRH+tcA+JsfXwMhmIcS2Apa52JFJxPobBQvOMjEdE8qlyt9y67RWe2C9XYz+ZN1SM2
         UBiAwLw/LKz+hNld3SVTM5EsPEMAu/TiZ3X8PAcpRUpCCrTTGiImhs5y2oVKC0p/RB9+
         wRpkRobIdNT9WLO2lKxs18igywdgMtr2LcXucW8GEcCgzaoEaskespVYBYXTU/fscwuj
         15yBDQYGhFFqwjmpppRTgDtkWzeIDlfiy2RuEPHwMwPOqPHQa1S35u3ClYffE5IxZfwp
         wcQbTz/oNzgYSG1x5enWY9kzGarY+z07ueR5F0AQedSBxeHWya+dDi2zBjfFKPnDvQkM
         089w==
X-Received: by 10.107.152.146 with SMTP id a140mr28667633ioe.72.1436481869038;
        Thu, 09 Jul 2015 15:44:29 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:647a:d824:a8a3:7bb0])
        by smtp.gmail.com with ESMTPSA id kk9sm102337igb.7.2015.07.09.15.44.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 09 Jul 2015 15:44:28 -0700 (PDT)
In-Reply-To: <20150709223018.GA3403@glandium.org> (Mike Hommey's message of
	"Fri, 10 Jul 2015 07:30:18 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273783>

Mike Hommey <mh@glandium.org> writes:

>> Does that mean the original code was doing a release that was
>> unnecessary?  Or does it mean this patch changes what happens on
>> that codepath, namely (1) leaking resource, and/or (2) keeping a
>> tree of the original 'b' that does not have anything to do with the
>> tree of 's', preventing the later lazy-load code from reading the
>> tree of 's' and instead of building on top of a wrong tree content?
>
> I guess the question is whether branch_tree.tree can be in a state that
> doesn't match that of branch_tree.versions[1].sha1. If not, then if s
> and b have the same branch_tree.versions[1].sha1 for some reason, then
> keeping the old branch_tree.tree makes no practical difference from
> resetting it. Except it skips the busy-work.

Perhaps my comment was misleading.  I _think_ the state at the end
of this function (i.e. the latter hunk you added to the function
makes the above issue I raised go away).  It just made me feel
uneasy to leave branch_tree.tree and branch_tree.versions[] in an
inconsistent state inside this function, while it calls a few helper
functions (hence my comment on the fact that they do not seem to be
affected by this inconsistency).

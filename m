From: Ilya Basin <basinilya@gmail.com>
Subject: Re[4]: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Tue, 28 May 2013 16:57:34 +0400
Message-ID: <1421181699.20130528165734@gmail.com>
References: <1438528085.20130501090926@gmail.com> <1409591910.20130501123153@gmail.com> <7vhaim8w48.fsf@alter.siamese.dyndns.org> <455264907.20130501235104@gmail.com> <20130501213031.GA13056@dcvr.yhbt.net> <7v1u9q5pu5.fsf@alter.siamese.dyndns.org> <20130502024926.GA12172@dcvr.yhbt.net> <12810110770.20130502213124@gmail.com> <366899002.20130506125846@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 28 14:58:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhJTi-0002qP-FV
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 14:58:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933947Ab3E1M6H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 08:58:07 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:44769 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933954Ab3E1M6A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 08:58:00 -0400
Received: by mail-lb0-f180.google.com with SMTP id r10so7659159lbi.39
        for <git@vger.kernel.org>; Tue, 28 May 2013 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:x-mailer:reply-to:x-priority:message-id:to:cc:subject
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=8ooUumFXpPntV/no3SZkBwFgy3/hE1fNMIuTvhNlWbQ=;
        b=vwrgv9D5R82vj8LDxZJ6OO4LSjKojLE3jkDa2T8+F/gBc2QHCGYvg0r/9ykbq0e/bi
         H5DxcZxha4c3y3psXchdus8L7502MUh1XxG2sqIarulWZId+MmCt8beKaiv2vy6NqNh9
         g/778d1aRg7Ylft8vTF4W+kkJTL/wLkoxPoFzUjBvP2bI3omodHUhdclEiOA8FDWamxa
         ihoj6kzLMRUCU4R3a6GLxtNbBvhN1Ak8jr/2/15r/8LXl0YYlUdIUc4T2ht1T0fq3vsq
         1weoum/Npm4N0RrUG13ESx4sRRhc6LMXAplP3nax9N7M6KuZWAYoMQjnx8IeHayBjEE4
         PaGg==
X-Received: by 10.112.63.169 with SMTP id h9mr16326237lbs.135.1369745878587;
        Tue, 28 May 2013 05:57:58 -0700 (PDT)
Received: from BASIN.reksoft.ru (gate.reksoft.ru. [188.64.144.36])
        by mx.google.com with ESMTPSA id a3sm7243909lbg.2.2013.05.28.05.57.56
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 05:57:57 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <366899002.20130506125846@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225639>

IB> * I think git-svn doesn't handle the case, when a tag is deleted.
IB>   I expected it to rename the ref from "tags/tagname" to
IB>   "tags/tagname@rev", but that doesn't happen.
IB>   If a tag is replaced, there's no way to tell what was the previous
IB>   state of that tag: git-svn just rewrites the ref.

OK, I figured out that git-svn creates a merge commit having one of
its parents the previous state of the tag and another parent the state
of the new copy src folder.

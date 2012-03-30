From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: top-level gitignore considered harmful
Date: Fri, 30 Mar 2012 09:30:27 +0000
Message-ID: <1333099827-ner-1054@calvin>
References: <20120329211136.GA1112@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Carlos =?iso-8859-1?q?Mart=EDn?= Nieto <cmn@elego.de>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jeff King <peff@peff.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 11:30:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDYAa-0003DE-Ob
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 11:30:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760483Ab2C3Jav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 05:30:51 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:44686 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760089Ab2C3Jat (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 05:30:49 -0400
Received: by wibhq7 with SMTP id hq7so404610wib.1
        for <git@vger.kernel.org>; Fri, 30 Mar 2012 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=wXQM3Hgo5S2tPOeW3KvSB0U9plH+IxRsSl2jYlCvy+A=;
        b=k1pUj7nT9dTQkGJosUsTMwCO4VaHOlj6XF8RWblqqToftxA0yO4u6URg92cmfpKPkK
         tUPqWGB6eWCszUI0Qwel9xy2VShgvVD9SOl7FOWBaW7/F1j/YclU8WOFgdDXn6kvdZUX
         o8NIkh/DNXv5eNb4+Z6i5MGM+IuQq4eVdXAK6okus5Rnz96jMyoEHE3w/9umbLjaRbBT
         4OA1dddqg1damYBjuqCdUcZUuaBBVThC9/yaq3jejc/z3t748ljyyDH9UjTCbJhMDoep
         QD6Bp4+V6o37r+66QLFa3N4HbO5i0gOYAmVayBTzvQN94D21Wcw26cGdYAav037EVyK6
         ajhg==
Received: by 10.180.95.197 with SMTP id dm5mr4507465wib.20.1333099847602;
        Fri, 30 Mar 2012 02:30:47 -0700 (PDT)
Received: from calvin.caurea.org (62-2-168-230.static.cablecom.ch. [62.2.168.230])
        by mx.google.com with ESMTPS id l5sm4851067wia.11.2012.03.30.02.30.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Mar 2012 02:30:45 -0700 (PDT)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id AC4E217321A; Fri, 30 Mar 2012 09:30:27 +0000 (UTC)
In-Reply-To: <20120329211136.GA1112@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194341>

On Thu, 29 Mar 2012 17:11:36 -0400, Jeff King <peff@peff.net> wrote:
> So we were sitting around chatting today about how slow "git status" is
> in the gigantic WebKit repository (because really, what else would one
> chat about?). Carlos noticed that git spends a lot of time in the
> gitignore code path.  It turns out that the WebKit repository has a
> couple hundred excludes in the top-level .gitignore, many of which are
> for specific files deep in the repository.
> 
> Since these patterns are compared via fnmatch(), we have to process them
> linearly for each entry[1]. And since the patterns are at the top level,
> we check them for each of the ~180,000 files in the repository. So "git
> status" will do O(m*n) work, where "m" is the number of patterns and "n"
> is the number of files in the repository. And as a project grows over
> time, one might expect "m" to be some constant factor of "n". So this is
> really O(n^2) (albeit with some mitigating constant at the front).

Many months ago I noticed that as well, when somebody came to #git and
complained that git status is slow (it toook *many* seconds for him). We
tracked that down to the fact that his .gitignore contained hundreds of
entries. He basically did `git ls-files --other >> .gitignore`, so his
.gitignore included every single object file and all other build artefacts.
I told him to use wildcards and `git status` became usable again.

tom

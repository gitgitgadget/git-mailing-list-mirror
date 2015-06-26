From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug in 'git am' when applying a broken patch
Date: Fri, 26 Jun 2015 13:58:21 -0700
Message-ID: <xmqq7fqqtceq.fsf@gitster.dls.corp.google.com>
References: <20150601001759.GA3934@kroah.com>
	<xmqqwpzn5lht.fsf@gitster.dls.corp.google.com>
	<xmqqd21f5k7w.fsf@gitster.dls.corp.google.com>
	<CAPig+cTc72npgXUA9EirGonrjwhXCROxn4cc=6=uPywers_h9w@mail.gmail.com>
	<xmqq8uc35gap.fsf@gitster.dls.corp.google.com>
	<CAGZ79kYbyTOeEvJBPqWOX8fxbB637N5aV3Q=yENQXu4v9FzBPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Git List <git@vger.kernel.org>,
	Gaston Gonzalez <gascoar@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 23:00:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8ajv-0001qD-Ih
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 23:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753918AbbFZU7C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 16:59:02 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:33189 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbbFZU6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 16:58:24 -0400
Received: by igtg8 with SMTP id g8so9929573igt.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=W1Zhe3thzc4I6+MPp1qq1Ia6E8/BwAemuiCoWOxSO8E=;
        b=tSvytESKkQt2pzNd492QddcK2l0ENCBAGJYn1mvFGmaSCKmFF8C+fB25XpIivQMlGi
         AaoECsRyQOO9AliCfrrupx53pncWJpafs0Zyv64+gfZvFRofyr/QF6lWln7II1r+K6Ug
         SUAyFojG4qsFhAuEmNq3Dg3ePBR/U2Yt94WqNOCkwg59Dy4EMgEE+6Add0IMuK1LU/ip
         TkB1rgCAnZg73o9XYC3tcPCIzCYlFZvJsuEBzTfOcllbVDIaMSC4pg1S8nTpdwrEdv5Y
         nudjMZHcv22O77JJ6FVJAdPIPyDiWXvBhh2pkvTA4f1+enAsx4mqTGrk5N7/QGXgydgN
         v/fg==
X-Received: by 10.50.87.38 with SMTP id u6mr24435igz.39.1435352303403;
        Fri, 26 Jun 2015 13:58:23 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id ax8sm21951igc.17.2015.06.26.13.58.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 13:58:22 -0700 (PDT)
In-Reply-To: <CAGZ79kYbyTOeEvJBPqWOX8fxbB637N5aV3Q=yENQXu4v9FzBPQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 26 Jun 2015 12:49:46 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272825>

Stefan Beller <sbeller@google.com> writes:

> In the hunk header we can learn about the
> expected lines to read for this hunk and after the hunk we only have
> 3 possible lines:
>
>   * it's the next hunk, then the line starts with @@

This is true.

>   * it's a new file, so the line starts with "diff --git"

This is true with s/--git//.

>   * it's the end of the patch, so the line is "--\n" and the line there after
>     is version number as git describe puts (not sure we want to test on that)

This is not true in general, as we do not want to limit "git apply"
to only what "git diff" produces.  You can write anything after a
patch and that is still a valid patch.  And that anything could be a
line that begins with '-', ' ' and '+'; as long as the line numbers
in the hunk header are correct, we'd ignore it.

So as you said, the change you are responding to is "better than
nothing", and would only help when you truncate the patch (or break
the numbers), but does not protect against arbitrary breakage.

One thing we _could_ do is after seeing the end of a message
(i.e. we did not see "@@" that signals there are more hunks in the
current patch, and we did not see "diff " that signals there are
more patches), we keep scanning and declare breakage if we see lines
that begin with something that looks like a hunk "@@ ... @@".

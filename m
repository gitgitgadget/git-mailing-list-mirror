From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v14 04/13] ref-filter: implement an `align` atom
Date: Sun, 30 Aug 2015 10:27:11 -0700
Message-ID: <xmqq8u8sznyo.fsf@gitster.mtv.corp.google.com>
References: <1440857537-13968-1-git-send-email-Karthik.188@gmail.com>
	<1440857537-13968-5-git-send-email-Karthik.188@gmail.com>
	<CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 19:27:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW6O8-0002rZ-6g
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 19:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753598AbbH3R1O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Aug 2015 13:27:14 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36652 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753530AbbH3R1N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Aug 2015 13:27:13 -0400
Received: by pabpg12 with SMTP id pg12so7200064pab.3
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 10:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=+HR27yP8NCdaT48ziJysj1u2jIOj+ZxkEUCFi4plqIg=;
        b=ISOK6POZCcYuv/LSBSeDFQZBQSDD2FQ0Wb54pWt1L9hjHpWTPHCNp7W5/o7JnhBmw2
         sa8s1NNBhT/U+HewvUvSBXloS4wLBtz+b7m134I4woHS3nD5fEdrm70ai9OfVQMzjTBX
         9vkerVvc67kivO5grcGSOzbVdAisVGf4zy3sJ/sksf4gQcnu8WV19ddLL5RmHyyF48wt
         /hutnz5vTS0Xg7H5Ke1beVWMxVZOqbOZwIkTOqDfcpyO0YtaLDYMT0uWenWybyF25LMT
         YUFMLdj2S03YSsmmHnI7Si5QzEOYcMwhgbPssW+LjMViEZhWqyGQc9MfJkzULropgOlG
         V6Bw==
X-Received: by 10.66.253.229 with SMTP id ad5mr31230571pad.101.1440955633278;
        Sun, 30 Aug 2015 10:27:13 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7887:edde:b54f:7986])
        by smtp.gmail.com with ESMTPSA id df2sm11888920pad.19.2015.08.30.10.27.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 30 Aug 2015 10:27:12 -0700 (PDT)
In-Reply-To: <CAPig+cRHRPehkd+9PwOqpXkRUvaJa42zLtCKMEfv2W=ZJUZJzA@mail.gmail.com>
	(Eric Sunshine's message of "Sat, 29 Aug 2015 23:27:23 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276828>

Eric Sunshine <sunshine@sunshineco.com> writes:

> With the disclaimer that I wasn't following the quoting discussion
> closely: Is this condition going to be sufficient for all cases, such
> as an %(if:) atom? That is, if you have:
>
>     %(if:notempty)%(bloop)%(then) --option=%(bloop)%(end)
>
> isn't the intention that, %(bloop) within the %(then) section should
> be quoted but not the literal "--option="?

I think you'll see that the intention of the above is to quote the
entirty of the result of %(if...)...%(end) if you read the previous
discussion.  The "quoting" is used when you say you are making --format
write a script in specified programming language, e.g.

	for-each-ref --shell --format='
        	a=%(atom) b=%(if...)...%(end)
		do interesting things using $a and $b here
	' | sh

You are correct to point out in the earlier part of your message I
am responding to that %(align) is not special and any nested thing
including %(if) will uniformly trigger the same "usually each atom
is quoted separately, but with this opening atom, everything up to
the matching end atom is evaluated first and then the result is
quoted" logic.

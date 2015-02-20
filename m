From: David Turner <dturner@twopensource.com>
Subject: Re: Git Scaling: What factors most affect Git performance for a
 large repo?
Date: Thu, 19 Feb 2015 19:42:49 -0500
Organization: Twitter
Message-ID: <1424392969.30029.15.camel@leckie>
References: <CAH8BJxEr_v+aitpZduXPC4oiRhMuySpc7Wb1aGcYe_p3mWjn+w@mail.gmail.com>
	 <CACsJy8Dortn4fHwF8xSgJ=KoJ9o1qzmc_UyaVq003D2sxFZEuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stephen Morton <stephen.c.morton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 01:43:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YObgH-0004kY-OH
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 01:42:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbbBTAmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 19:42:53 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:59396 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614AbbBTAmw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 19:42:52 -0500
Received: by mail-qg0-f54.google.com with SMTP id z60so10837611qgd.13
        for <git@vger.kernel.org>; Thu, 19 Feb 2015 16:42:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=hXJy0Cw0VnTQvX1byD3gqwAwinwGDn4bPRjk6egrGfE=;
        b=bD2kkbLoja3tD2tIbLww3WkIgwXqrWsRHiNTIvmiN6xPOSLQCE8oBMuSgCBmwSnews
         qtYJrts47Pnub+kifa1f35dU7muxPw5mFv7ttEwx9+WR4An5tWk0/ch0HEaFs2/TAHHg
         v+lvDOricnEQlnyVHZGB3zAb9Bio53lFW9gG1XGfKdkOubOpOW3fLPilHpKeEiF6NELU
         SrUKxwq2iKAHBjs391SSXMcuJ+yTXpuKKRQ9AI+qdJB/r4pGS1JObUp7VQIi7livTK/M
         Q3S5wtW1W536m4eQf57YrGS1YWAi4aPBFCZYFNfFxVf/cO0yxVrXS857or5hDh7n1czT
         tOuQ==
X-Gm-Message-State: ALoCoQl4CHvr7+6fDhnHV4+pKN/AVkF+UL+9YQeOOrHTnSvbdJaYH2UO3utyr2HmNZ/5YE5XQiXn
X-Received: by 10.140.93.73 with SMTP id c67mr17222807qge.53.1424392972202;
        Thu, 19 Feb 2015 16:42:52 -0800 (PST)
Received: from [172.18.24.59] ([8.25.196.26])
        by mx.google.com with ESMTPSA id 81sm10818699qhh.46.2015.02.19.16.42.50
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Feb 2015 16:42:51 -0800 (PST)
In-Reply-To: <CACsJy8Dortn4fHwF8xSgJ=KoJ9o1qzmc_UyaVq003D2sxFZEuQ@mail.gmail.com>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264125>

On Fri, 2015-02-20 at 06:38 +0700, Duy Nguyen wrote:
> >    * 'git push'?
> 
> This one is not affected by how deep your repo's history is, or how
> wide your tree is, so should be quick..
> 
> Ah the number of refs may affect both git-push and git-pull. I think
> Stefan knows better than I in this area.

I can tell you that this is a bit of a problem for us at Twitter.  We
have over 100k refs, which adds ~20MiB of downstream traffic to every
push.

I added a hack to improve this locally inside Twitter: The client sends
a bloom filter of shas that it believes that the server knows about; the
server sends only the sha of master and any refs that are not in the
bloom filter.  The client  uses its local version of the servers' refs
as if they had just been sent.  This means that some packs will be
suboptimal, due to false positives in the bloom filter leading some new
refs to not be sent.  Also, if there were a repack between the pull and
the push, some refs might have been deleted on the server; we repack
rarely enough and pull frequently enough that this is hopefully not an
issue.

We're still testing to see if this works.  But due to the number of
assumptions it makes, it's probably not that great an idea for general
use.

There are probably more complex schemes to compute minimal (or
small-enough) packs; in particular, if the patch is just a few megs off
of master, it's better to just send the whole pack.  That doesn't work
for us because we've got a log-based replication scheme that the pack
appends to, and we don't want the log to get too big; we want
more-minimal packs than that.  But it might work for others.

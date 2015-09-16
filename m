From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/67] mailsplit: make PATH_MAX buffers dynamic
Date: Wed, 16 Sep 2015 11:13:37 -0700
Message-ID: <xmqqpp1iqlke.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915152806.GJ29753@sigill.intra.peff.net>
	<CAPig+cQ+TvT2_ZrbbYFQOdjDNs+b-ADJb+EbKVTP-HaCghjCow@mail.gmail.com>
	<20150916101418.GD13966@sigill.intra.peff.net>
	<20150916102524.GA28002@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 20:13:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcHDD-0002Xz-Pz
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 20:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505AbbIPSNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 14:13:39 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36779 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752965AbbIPSNj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 14:13:39 -0400
Received: by padhk3 with SMTP id hk3so215611376pad.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 11:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RqwXFJJ8l0UTzjGLtWpTg3o1b30HaeKEhP2TQUvW9GI=;
        b=n1CQC9XyxDBMBKK5psXMTadujDey8dMns1qDNd/U0k1XO6md0HykYHqrZDyBy/zP0T
         bz/EzIji5wmG/AeBckfqJa1Nkw0jHAD48nxa26JlLN359E3vdWGBUnocK61uq8VF2xOC
         yATdeIDCABGuykodKXVN6wprVojPunEWqtOwk1wLCmu18X1CqwBfC40hvyvN7DdSaWb7
         jipyNpvArq8u13mx7rAZMEdtYKgwLHG4X4JtKFoCWhgI+QLlx+dUHRfzMN5IqCxeXFFB
         /G4tK6tbotoXgUDLkekcg79pTs0Gz8ghksPXFgTZHvMuosEv7dPyMz8p5xxfiaVmUz1R
         4SEA==
X-Received: by 10.68.190.38 with SMTP id gn6mr61454311pbc.125.1442427218538;
        Wed, 16 Sep 2015 11:13:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id rz9sm29074072pbb.61.2015.09.16.11.13.37
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 11:13:37 -0700 (PDT)
In-Reply-To: <20150916102524.GA28002@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Sep 2015 06:25:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278042>

Jeff King <peff@peff.net> writes:

> +		free(file);
> +		file = xstrfmt("%s/%s", maildir, list.items[i].string);

Repeated pattern makes one wonder if a thin wrapper

	xstrfmt_to(&file, "%s/%s", maildir, list.items[i].string);

that first frees the existing value and then overwrites is an
overall win.  Perhaps not, as you would (1) initialize the variable
to NULL before doing a series of xstrfmt_to(), and (2) free the final
one yourself.

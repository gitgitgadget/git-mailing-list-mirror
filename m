From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 18/19] fsck: git receive-pack: support excluding objects from fsck'ing
Date: Sat, 20 Jun 2015 10:28:53 -0700
Message-ID: <xmqq4mm2l25m.fsf@gitster.dls.corp.google.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
	<cover.1434720655.git.johannes.schindelin@gmx.de>
	<e843f9f1defca543d3f2eb3143cf9fee8c72f695.1434720655.git.johannes.schindelin@gmx.de>
	<xmqqwpyz5t66.fsf@gitster.dls.corp.google.com>
	<9b7c42e6ec81fd70015b8fe9ff2bd137@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 20 19:29:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6MZi-0005ad-73
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jun 2015 19:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbbFTR26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2015 13:28:58 -0400
Received: from mail-ig0-f182.google.com ([209.85.213.182]:34943 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754866AbbFTR24 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2015 13:28:56 -0400
Received: by igblr2 with SMTP id lr2so10726525igb.0
        for <git@vger.kernel.org>; Sat, 20 Jun 2015 10:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=QsYqf+bmMJwSGQbAnvlN2RWg+XB3uFXVOyP8tTkBixw=;
        b=oAWcoWMAPMV29D2O3DyvUGH8cEksF+LL2UAK/mf/gMTGiOBSKK/quLaTnP3ss70DS8
         hAlhT9qQ1ucEpCXCmo/qab/2Eck9GOkHsLlhTFsqePkctzKaG4z0wbDLc4Ro8RKIiT5x
         VyJZXKm2rQ5jaTNLvx94wbC34cpZ3Y2uU+EkmnXZtioyj/z+u32dSpu+Q5x+vHRsAARr
         +K0ZmtWiOLpl3KO+jc4Xm+j9nMWiy1LObmbDqp5t2gfcNtrjmgTCTCmm4019r10hxaws
         YESKohHT6TV2Tp1WWSSOMoKL547f5RWNPd9HylTkxtWoLitqnegDn8AjHhLDvJKQfLxA
         WEZA==
X-Received: by 10.43.139.6 with SMTP id iu6mr18450641icc.32.1434821336222;
        Sat, 20 Jun 2015 10:28:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f44b:8ca4:e732:8441])
        by mx.google.com with ESMTPSA id qh9sm4077711igb.20.2015.06.20.10.28.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 20 Jun 2015 10:28:54 -0700 (PDT)
In-Reply-To: <9b7c42e6ec81fd70015b8fe9ff2bd137@www.dscho.org> (Johannes
	Schindelin's message of "Sat, 20 Jun 2015 14:45:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272235>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> There is a problem, though: `git_config_pathname()` accepts a
> `const char **` parameter to set the path, yet I need to `free()`
> that pointer afterwards because it has been obtained through
> `expand_user_path()` which detaches that buffer from a `strbuf`.

"I have 'const char *' because I do not ever change the string
myself after getting it from an API function, but free() does not
want to free a const pointer" occurs sometimes in our codebase and
it is OK to cast the constness away (many callsites to free()
already do so).

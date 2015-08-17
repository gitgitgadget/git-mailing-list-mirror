From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/7] Flags and config to sign pushes by default
Date: Mon, 17 Aug 2015 12:54:59 -0700
Message-ID: <xmqq7fotd71o.fsf@gitster.dls.corp.google.com>
References: <1439492451-11233-1-git-send-email-dborowitz@google.com>
	<xmqqbne9ivry.fsf@gitster.dls.corp.google.com>
	<CAD0k6qSjZW-5eMw-OOHP0cGdj08PesdKVgE9OAFvESwCueyH6w@mail.gmail.com>
	<xmqqwpwxha4r.fsf@gitster.dls.corp.google.com>
	<CAD0k6qR2HkHHYu8429mvdvN1bkLeTpD-5EbO4Mt+o69rC+P6aQ@mail.gmail.com>
	<xmqqtwrxesqa.fsf@gitster.dls.corp.google.com>
	<CAD0k6qTWojeWT10xw_Dc5=Fw5r3rP0PUQOyqO7JAz6Vu+tV54w@mail.gmail.com>
	<xmqq614deoq8.fsf@gitster.dls.corp.google.com>
	<CAD0k6qRPxkdOgAo=0+_f8bcFoL70MSvLDJ_OjrFtVMKtcqVV_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 21:55:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRQUv-0001G2-LG
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 21:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbbHQTzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 15:55:03 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33609 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbbHQTzA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 15:55:00 -0400
Received: by pabyb7 with SMTP id yb7so115070414pab.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2015 12:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xtcwLR1rZtaR4Bjd5NmVa+NH/1+49a27XHRfJXuLWVo=;
        b=hMXpAi+dQ1DTNLDqpVewUUMEaK/3DNdZ8UJQHZfOkYcXb0B9Pd+qKv0N7qq72Sq4QH
         Pg8wQx1Cm5XjyIuTbiMcg3YHYsP/7ku+Sbx/bpw8YTqdPDpeUPPKwBYlas9fKaIKvMza
         9xbJ5Cs94pxv+Zwa1ivMrOra66s+jnI7/gB9aGg76ly6QcNrEMpE+P8lV4rqwBBrMFM4
         kl9S9cXgl3eC7yhMk1kxyZTdMu2sgNYeYpGf84SMLnoZMSaL2LZR7aMlNwl5N4QLaBaT
         r1AoHoMQxsaNwaaptcBFJ6BEOqu8ieTcHC8OLLdnKvEtM5wrJQIgNk6lBc1HRyslVQJx
         0gIw==
X-Received: by 10.66.250.226 with SMTP id zf2mr5779974pac.20.1439841300550;
        Mon, 17 Aug 2015 12:55:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4db:7e94:b576:3da])
        by smtp.gmail.com with ESMTPSA id rs9sm4882772pab.14.2015.08.17.12.54.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 12:55:00 -0700 (PDT)
In-Reply-To: <CAD0k6qRPxkdOgAo=0+_f8bcFoL70MSvLDJ_OjrFtVMKtcqVV_A@mail.gmail.com>
	(Dave Borowitz's message of "Mon, 17 Aug 2015 14:54:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276086>

Dave Borowitz <dborowitz@google.com> writes:

> Is there a common utility function that does what we want? Basically
> git_config_maybe_bool but not specifically about configs.

Interesting.  git_config_maybe_bool() and its friends take the usual
(name, value) and pretend to be part of the "config" family, primarily
because that was where they came from.

But they do not really care about "name", which is used for error
reporting and that is what makes them look very specific to the
config subsystem.

I did a quick grep of git_config_maybe_bool() and I _think_ all
callers are prepared to handle errors themselves, so it might be a
good direction to go in the longer term to drop "name" and rename
the function to git_parse_maybe_bool() or something, and make these
callers use that.

In the shorter term, at least we should be able to introduce
git_parse_maybe_bool() that does not take "name", use that as a
helper to implement git_config_maybe_bool(), so that the existing
callers of git_config_maybe_bool() does not have to change.  And
that new helper can be used as your "Basically it, but not
specifically about configs".

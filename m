From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv3 4/4] am, rebase: teach quiet option
Date: Tue, 16 Jun 2009 00:50:05 -0700
Message-ID: <4A374EAD.9030309@gmail.com>
References: <1245117905-19351-1-git-send-email-bebarino@gmail.com>	<1245117905-19351-2-git-send-email-bebarino@gmail.com>	<1245117905-19351-3-git-send-email-bebarino@gmail.com>	<1245117905-19351-4-git-send-email-bebarino@gmail.com>	<1245117905-19351-5-git-send-email-bebarino@gmail.com> <7vbpoog1py.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Thomas Adam <thomas.adam22@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 09:50:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGTQv-0002wk-KM
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 09:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839AbZFPHuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 03:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752876AbZFPHuH
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 03:50:07 -0400
Received: from mail-px0-f189.google.com ([209.85.216.189]:62271 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751296AbZFPHuG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 03:50:06 -0400
Received: by pxi27 with SMTP id 27so787831pxi.33
        for <git@vger.kernel.org>; Tue, 16 Jun 2009 00:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=D5jWSeVhiqBZCQZaCnULRQieQNK8HiZ9t4N29G3F22U=;
        b=GN6LZwOuSz7pY+5i2bHqjkueH4DRuKfGdgbZUrh8V4xhET1H/Q3/N1EdexPfmntxoD
         i94tgAuilEO11wcuo1J225Jdy35s7fJPX3sYn/fbIzaHg26yek5jBQtbgIbS2J+YlvQi
         8S7JLbnqDx1XhjaDE0SZzmRwAk1v6N3mswBm0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=JEaT6MGjhmyd1fAFtg9zR8UtUXuGpFCYnkKXe8N1F3wfPN+39NkjTkqtP6Ut1Ssg+F
         o30UZvr5K9STZh87BfuFJktKkyemxScPmB58B92yC8KxtKJg/hy5es1xwJscs92igdeS
         mEm8IWoUq0eni4N3z4+W/PqH9SlZHb9u86MkY=
Received: by 10.114.185.12 with SMTP id i12mr13152284waf.178.1245138607942;
        Tue, 16 Jun 2009 00:50:07 -0700 (PDT)
Received: from ?192.168.1.5? (user-0c9haco.cable.mindspring.com [24.152.169.152])
        by mx.google.com with ESMTPS id v39sm101086wah.62.2009.06.16.00.50.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Jun 2009 00:50:07 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090429)
In-Reply-To: <7vbpoog1py.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121663>

Junio C Hamano wrote:
> Hmm, this long conditional body looks ugly, and I suspect it is harder to
> maintain than necessary.  Can we do something about it?
>
> 	# When we are allowed to fall back to 3-way later, don't give
>         # false errors during the initial attempt.
> 	squelch=
> 	if test "$threeway" = t && test -n "$GIT_QUIET"
> 	then
> 		squelch='>/dev/null 2>&1 '
> 	fi
>         eval "git apply $squelch$git_apply_opt"' --index "$dotest/patch"'
>

Thanks. I thought there would be a nicer way but I didn't know it.

> Ah, I was blind.
>
> While sending non-error messages to stderr is justifiable, I do not think
> this one is, because all the other progress-y message in this program we
> reviewed so far go to stdout.  I think we should drop >&2 here.

Will do, gotta fixup some tests for that though...

> There is one more thing to think about in git-am, which I do not think you
> addressed.  Consider this scenario.
>
>     (1) Tell am to run quietly, feeding a four-patch series.
>
> 	$ git am -q -3 mbox
>
>     (2) The first patch applies cleanly; the second one does not apply,
>         even with -3, and leaves conflict (you did the right thing not to
>         squelch the message when this happens).
>
>     (3) You fix it up, and save the result from your editor, and tell it
>         to continue.
>
> 	$ git am --resolved
>
> Now, should the second invocation be also quiet, or talkative as default?
>
> Note that the third and fourth patch are applied with -3 option in effect,
> even though you did not say -3 when you restarted "am" with --resolved
> (cf. ll.280-340 in git-am.sh).

Thanks for bringing this up. I gave this some thought before I sent the
series out but I was secretly hoping nobody would care :-) I think it's
more correct and maybe even more consistent to keep the quiet option
enabled.

Seeing as this series is going for round 4 I'll make sure to include
this as well.

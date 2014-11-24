From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: [RFC] [PATCH] remote: add new --fetch option for set-url
Date: Mon, 24 Nov 2014 23:16:03 +0100
Message-ID: <27811375.1kgEM3BV3q@al>
References: <6997784.RuzRO1AFsK@al> <1628833.9HksdDrMW8@al> <xmqqtx1ouug8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 24 23:16:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt1vb-0002kd-3U
	for gcvg-git-2@plane.gmane.org; Mon, 24 Nov 2014 23:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbaKXWQL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 17:16:11 -0500
Received: from lekensteyn.nl ([178.21.112.251]:56025 "EHLO lekensteyn.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbaKXWQK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 17:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2014-q3;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From; bh=/p0zaDfu3MhM9SlPhQE1qGbeAfkIm3PneSUkCDd5kwA=;
	b=GELV/+n9oLqStZ4NqLMSW3EZaOfO19TSU21g04WyF6CCN5FypY4uRg77lMjx86HtpRhAOl7io1NbRnEPYUWev89jMmt7maTe7G0PEi15oxYCSEHeVXXKJ3BQRFDRJPIr3sNlOwhlQMrezM1G5GrE6PoUv5TTm5N7ZQEfD0GhVIGx2EOYpL5rIa3b2BJmpG/B+y94Odx34jxaKoWIoQ3Y6KXlFhNykgJdOzef0g1mvlar5UPlGFHpMBFQEnVGIqQovEzuPbIgorIXKRGNccOe7icgkVfA9Zi0FfHrplQV86yNNwZkewX7b2qvXkBBIr7weOzInR8BGzjapx340cb7lw==;
Received: by lekensteyn.nl with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <peter@lekensteyn.nl>)
	id 1Xt1vQ-0006Bx-G6; Mon, 24 Nov 2014 23:16:04 +0100
User-Agent: KMail/4.14.3 (Linux/3.17.0-rc4-custom-00168-g7ec62d4; KDE/4.14.3; x86_64; ; )
In-Reply-To: <xmqqtx1ouug8.fsf@gitster.dls.corp.google.com>
X-Spam-Score: 0.0 (/)
X-Spam-Status: No, hits=0.0 required=5.0 tests=NO_RELAYS=-0.001,URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260158>

On Monday 24 November 2014 14:04:07 Junio C Hamano wrote:
> Peter Wu <peter@lekensteyn.nl> writes:
> 
> > I propose to add the option --fetch next to --push with the meaning "set
> > the fetch/push URL of remote NAME to URL". Then --fetch --push means
> > "set the fetch and push URL of remote NAME to URL". 
> 
> What would (and "should") the configuration look like after you did
> this?
> 
> 	git remote set-url nick $url1
>         git remote set-url nick --push $url2
>         git remote set-url nick $url3
> 
> Whatever happens without your patch after the above is what the
> current users (i.e. those who do not use the --fetch option) expect,
> so if the behaviour does not change with your patch, then there is
> one less incompatibilities to worry about.
> 
> A new option "--fetch" introducing a different behaviour is
> perfectly fine; existing users who are not using it will not be
> harmed by sudden behaviour change.

As stated before, I took care to avoid backwards incompatibilities. The
command will still work as expected by the users who are aware of this
particular behavior. What I am suggesting (and which is independent of
the patch) is to make the command have a more consistent behavior.
Either it should set the fetch URL, or both the fetch and push URL, but
not vary its behavior depending on whether a push URL is set or not.
That should make the behavior of the command more consistent.

> > In a future git version, this could be made the default option to
> > avoid surprises (which would be backwards incompatible though).
> 
> I am not sure what you mean "by default".  If you mean "set both if
> remote.nick.pushurl does not exist but otherwise update only
> remote.nick.url", then the sequence
> 
> 	git remote set-url nick $url1
>         git remote set-url nick --push $url2
>         git remote set-url nick $url3
> 
> would retain the current behaviour, so it probably is OK.
> 
> If you mean to always set remote.nick.url and remote.nick.pushurl
> pointing at the same value when neither --fetch nor --push is given,
> That would make the sequence behave quite different from what people
> would expect, and you would need to devise a transition plan to
> first start warning when the user did something that will behave
> differently between the current version and the future version
> without changing the behaviour, then switch the behaviour but keep
> warning and finally remove the warning, or something like that.
> 
> And the above three-command sequence may not be the only case where
> the change you are proposing may hurt existing users.

The "default" refers to the behavior of "git remote set-url" in absence
of "--push" and "--fetch" options. A transition period is expected (if
this idea is put forward). Since nobody seems to be bitten by this
option, I am not sure if it really adds much value to make this change
though.
-- 
Kind regards,
Peter
https://lekensteyn.nl

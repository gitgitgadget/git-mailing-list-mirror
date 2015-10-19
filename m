From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to
 ignore instead?
Date: Sun, 18 Oct 2015 20:51:19 -0400
Message-ID: <CAM-tV-8BQPhGXe0nNFHEWPV_SnoOiCd9OxSiSYk22f86F4KtFA@mail.gmail.com>
References: <CAM-tV-_JPazYxeDYogtQTRfBxONpSZwb3u5pPanB=F9XnLnZyg@mail.gmail.com>
	<CAM-tV-_eOgnhqsTFN6kKW=tcS7gAPYaxskBaxnJZo3bsx02HZg@mail.gmail.com>
	<xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 19 02:51:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Znyg4-0002l7-Or
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 02:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbbJSAvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2015 20:51:21 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38198 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001AbbJSAvU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2015 20:51:20 -0400
Received: by wicll6 with SMTP id ll6so76493349wic.1
        for <git@vger.kernel.org>; Sun, 18 Oct 2015 17:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Jnq0wKQXzxcM1sKD3xspoAuD4hm/DocJaNJifgpOjQc=;
        b=NDe7co6Z63jPFjdGWFxzqJAIs8E8WjKy3x9T6XKKO0HHZFi/7DbpY9B09PTpAWMJGg
         MLxjq8whnPPY7KvPaBl2i1CQ8qLQY1AR5TUgZot5GCLr5LRDbRkt4jvH8Qo/BO/tYd/c
         ye0Bf+MkOdQBWNQsl3cvlasg/UJzp77AosPnC0EPgFKKfxBR+jSAhxaWKBeWqWKYdsOG
         zQxU+oGIWIUNgaUN98Y6IHUyH+OHqmgpyMRfR7ujkeVRjqzqtNjSDRimzt2pHGEdk8gZ
         aB/Rc8CCSwb4jhtJsF4O1y9AnCthnaAfR95ba2c6fJ4QmQAPgC3Nqz6/2IVh395Frm1C
         vyiQ==
X-Received: by 10.194.5.35 with SMTP id p3mr34390372wjp.132.1445215879193;
 Sun, 18 Oct 2015 17:51:19 -0700 (PDT)
Received: by 10.28.29.87 with HTTP; Sun, 18 Oct 2015 17:51:19 -0700 (PDT)
In-Reply-To: <xmqqfv18awj4.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: cRXTjEmjaquvJGM1un5qS9F7o-g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279823>

On Sun, Oct 18, 2015 at 1:58 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I cannot speak for the person who was primarily responsible for
> designing this behaviour, but I happen to agree with the current
> behaviour in the situation where it was designed to be used.  Upon
> the first use in your session, the "daemon" is auto-spawned, you can
> keep talking with that same instance during your session, and you do
> not have to do anything special to shut it down when you log out.

Oh, hmm this does makes sense. Now that I think of the log out case, I
think ignoring the SIGHUP would be the wrong thing for us too.

> Isn't that what happens here?

I think our problem is that when Emacs creates the "git push" process
with a pty[1], it somehow puts that process in its own new session, so
when "git push" finishes it takes the daemon down with it. But seeing
it like this, it seems clear that the problem is from the Emacs side.

[1]: and using pipes instead of a pty doesn't allow entering the
password: https://github.com/magit/magit/issues/2309#issuecomment-147101903

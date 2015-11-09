From: Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: git-credential-cache--daemon quits on SIGHUP, can we change it to
 ignore instead?
Date: Sun, 8 Nov 2015 21:58:06 -0500
Message-ID: <CAM-tV-9CNO_hqnweFpLaRHx4xEA32CPRdq56y6vYMWqURV9kgg@mail.gmail.com>
References: <CAM-tV-9sNgHncsWRPh36tEY3YFORUJBA-Q6W5R=mvX_KhSmWEQ@mail.gmail.com>
	<xmqqfv0ylwa7.fsf@gitster.mtv.corp.google.com>
	<20151026215016.GA17419@sigill.intra.peff.net>
	<xmqqoafkci6j.fsf@gitster.mtv.corp.google.com>
	<20151027184702.GB12717@sigill.intra.peff.net>
	<CAM-tV--B3HaC1DcORfnx9bWW9-quyk0=pQDxmvonc=6dgrMOxA@mail.gmail.com>
	<20151030001000.GA2123@sigill.intra.peff.net>
	<CAM-tV-_dc_YEE0Dh2T=8+_DcBiq_rvynOw2cFi+8QizkeGTusw@mail.gmail.com>
	<20151030005057.GA23251@sigill.intra.peff.net>
	<CAM-tV-8qSVJFOxLQt9SaYK_WqpxixzPArJnAK=3tHU9inM9Law@mail.gmail.com>
	<20151030210849.GA7149@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 09 03:58:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvces-0008GI-2b
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 03:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbbKIC6K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Nov 2015 21:58:10 -0500
Received: from mail-ig0-f172.google.com ([209.85.213.172]:35280 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbbKIC6H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Nov 2015 21:58:07 -0500
Received: by igl9 with SMTP id 9so22064718igl.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2015 18:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6Vck5jTRDYU31dYnHfpKzmPAYDXpiTxUl4opWWQbNPQ=;
        b=sct5jLH1nW7CmGjNBdnvwNB9FZ04oCNa8drTNYMTjQ2pKYUb7+r3BI70w4Om7k3uNH
         eWSG+DXPeJX37/C7R8/7KqF+q/2O3Ouh06MmkAF4Hq2OFjjA8aCa6WYq48KFGMjbEeJe
         +RaTMeGzYL1Ar2383XOaivcRZkHhDAj/zG9+anGTsumxUEwnOGxIhPIT3DCr2BisfU/f
         OXCNsAJy4PU472gD673mSHuqT6hGYexejqZ7tr8EqkwLyrzGV37Yv1rHWxWcoN/BBPis
         +CB9VBkAh3BTqGt1C7pwL0AhJzIWrgScR1H+WNTRAXgSsxwtcMioNyx9pfofWLtRklOA
         5DGA==
X-Received: by 10.50.61.203 with SMTP id s11mr2498344igr.79.1447037886238;
 Sun, 08 Nov 2015 18:58:06 -0800 (PST)
Received: by 10.79.119.2 with HTTP; Sun, 8 Nov 2015 18:58:06 -0800 (PST)
In-Reply-To: <20151030210849.GA7149@sigill.intra.peff.net>
X-Google-Sender-Auth: X_aEyYJvZjxy6CruUZBmLORurcg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281044>

On Fri, Oct 30, 2015 at 5:08 PM, Jeff King <peff@peff.net> wrote:
> Right. And not only is that hard to get right (I doubt, for example, you
> support the arbitrary "!" shell expressions that git does), but it's
> impossible to know for sure that will be needed, because you cannot know
> all possible helpers (I might even have a helper that is a shell snippet
> that calls credential-cache).

Yep, in that case the user would have to override the result of parsing.

>> Ah, maybe the missing piece I forgot to mention is that we could make
>> our pre/1st-helper be an emacsclient command, which would tell Emacs
>> to startup the daemon. So the daemon would be a subprocess of Emacs,
>> not "git push", thereby avoiding the SIGHUP. In our current workaround
>> we startup the daemon (if it's not running) before git commands that
>> we think are going to run credential helpers (i.e. "push", "pull",
>> "fetch"), hence my thought that it would be nicer if we only did that
>> before git is *actually* going to run the helpers.
>
> I don't think even git knows it will need a helper until it is actually
> ready to call one (e.g., it may depend on getting an HTTP 401 from the
> server).

Yes, so just call me first. :)

>
> I am leaning more towards ignoring SIGHUP (configurably) being the only
> really sane path forward. Do you want to try your hand at a patch?

Something like this?

diff --git i/credential-cache--daemon.c w/credential-cache--daemon.c
index eef6fce..e3f2612 100644
--- i/credential-cache--daemon.c
+++ w/credential-cache--daemon.c
@@ -256,6 +256,9 @@ int main(int argc, const char **argv)
         OPT_END()
     };

+    int ignore_sighup = 0;
+    git_config_get_bool("credential.cache.ignoreSighup", &ignore_sighup);
+
     argc = parse_options(argc, argv, NULL, options, usage, 0);
     socket_path = argv[0];

@@ -264,6 +267,12 @@ int main(int argc, const char **argv)

     check_socket_directory(socket_path);
     register_tempfile(&socket_file, socket_path);
+
+    if (ignore_sighup) {
+        sigchain_pop(SIGHUP);
+        signal(SIGHUP, SIG_IGN);
+    }
+
     serve_cache(socket_path, debug);
     delete_tempfile(&socket_file);

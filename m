From: Paul Sokolovsky <paul.sokolovsky@linaro.org>
Subject: Re: git 2.2.x: Unexpected, overstrict file permissions after "git
 update-server-info"
Date: Tue, 6 Jan 2015 14:43:22 +0200
Organization: Linaro
Message-ID: <20150106144322.61d7ff89@x230>
References: <20150105210724.032e9718@x230>
	<20150106034702.GA11503@peff.net>
	<xmqqd26sql0v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 13:45:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8TTz-0005Jq-Sg
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 13:43:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755257AbbAFMnb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 07:43:31 -0500
Received: from mail-la0-f49.google.com ([209.85.215.49]:46328 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755241AbbAFMna (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 07:43:30 -0500
Received: by mail-la0-f49.google.com with SMTP id hs14so20047823lab.36
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 04:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-type
         :content-transfer-encoding;
        bh=O7w07D9z72AQrmhAS4NSTSv+e2wIpP8mJOLbPos3jf4=;
        b=PWwqdeg74s7AKjU0KvnoV+0ePbIIkHQ3TjrEWRAPENJwCl/j10f7sEVu1OnqTZWTgn
         c9kQeRTsZtok0Ov4jLB/R7KkSG5gByS45TH1nI5ApGFNCJPleibXQRmslz+F5IgI7QeO
         f8hd4K2Vy6QIiBcb3g9ZWOIra8yPuWw1iyqwbD1cUecDiuhUmofKgXfPmyQXRTvxGBA9
         xx7W4lDPdsN1kgYdyh8s1Trmd0h+6m+4Sag0LmW/eo9g2r+ujQJ2uQzn0emaewFAqfa2
         fOK8BQH5rNyV9DU3AjAA/ORYv4yKr0P7yUgS1IwQ0u58UT8P8088ry0IpNF7IwN6cMRk
         Zk8A==
X-Gm-Message-State: ALoCoQnL63yI7bb8BN3cmJXlHQQs3RTh/KyMp6VqrQOpIymFS+XIn8qnG3qw/BUI1n1nTe14IqcX
X-Received: by 10.112.72.98 with SMTP id c2mr56098342lbv.95.1420548208239;
        Tue, 06 Jan 2015 04:43:28 -0800 (PST)
Received: from x230 ([91.225.122.14])
        by mx.google.com with ESMTPSA id ao2sm7037178lac.8.2015.01.06.04.43.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 06 Jan 2015 04:43:27 -0800 (PST)
X-Google-Original-From: Paul Sokolovsky <Paul.Sokolovsky@linaro.org>
In-Reply-To: <xmqqd26sql0v.fsf@gitster.dls.corp.google.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262062>

Hello,

On Tue, 06 Jan 2015 02:08:16 -0800
Junio C Hamano <gitster@pobox.com> wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, I didn't consider the mode impact of using mkstemp. That is
> > definitely a regression that should be fixed. Though of course if
> > you really do want 0644, you should set your umask to 0022. :)
> > ...
> > If you haven't set core.sharedrepository, then adjust_shared_perm
> > is a noop. But you shouldn't have to do that. Git should just
> > respect your umask in this case.
> 
> Thanks for a nicely done patch series, but I am not sure if I agree
> with the analysis and its conclusion.
> 
> If adjust_shared_perm is a no-op, how do we ensure that other files
> that need to be served by a dumb HTTP server are readable by it?

Just don't make it unreadable on purpose (or by mistake) by git. The
rest is taken care by OS.

>   Is
> it because we just happen not to use mkstemp() to create them (and
> also is it because the pushers do not have umask 007 or stronger to
> prevent files from being read by the HTTP server user)?
> 
> Is our goal here to give the users this statement?
> 
>     For shared repository served by dumb HTTP and written by users
>     who are different from the user that runs the HTTP server, you
>     need to do nothing special.
>
> If that is the case, shouldn't the rule be something a lot looser
> than "we should just respect your umask"?  To satisify the above
> goal, shouldn't we somehow make it readable by the HTTP user even
> when some pusher has a draconian 0077 umask?

I would dread such solution. umask is well-known Unix device to control
permissions of created files. If someone sets it to 0077, they want
new files be not accessible by anyone but their owner, period. It
doesn't make sense to work that around. Or at least, it's different
issue from the reported here.

>  But that, while still
> complying to the promise of "nothing special", would imply we would
> have to make everything readable everywhere, whish is an unachievable
> goal.  We need to somehow be able to say "this repository should be
> readable by these people" per-repository basis.
> 
> And we have a mechanism exactly designed to do so to defeat
> draconian umask individual users have.

I'm not sure I understand how this "draconian umask" got into picture
here at all. The original report was "with liberal umask, there're
draconian file permissions". Jeff's patch fixes exactly it. Transposing
"draconian" into "umask" position make it completely different
problem.

> 
> It feels to me that the old set-up were "working" by accident, not
> by design (I may be mistaken--so correct me if that were the case).

If you mean our setup, I don't see anything wrong with it: we installed
git and apache from our distro, we installed Gerrit from the official
site, we made a cronjob to be run from gerrit user (as the owner of
repositories). Everything worked, as expected. Upgrading to git 2.2.1
broke it, because umask was not followed. What can be wrong here except
not following umask?

> And if that is the case, I do not think it is a good idea to try to
> hide the broken configuration under the rug longer.  "As long as
> everybody writes world-readable files, you do not have to do
> anything" will break when the next person with 0xx7 umask setting
> pushes, no?



Thanks,
Paul

Linaro.org | Open source software for ARM SoCs
Follow Linaro: http://www.facebook.com/pages/Linaro
http://twitter.com/#!/linaroorg - http://www.linaro.org/linaro-blog

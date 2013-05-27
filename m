From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] fetch: don't try to update unfetched tracking refs
Date: Mon, 27 May 2013 17:01:29 +0100
Message-ID: <20130527160129.GN27005@serenity.lan>
References: <9c6fd36368cd6b0fba4855be4d31106781c02f58.1369654825.git.john@keeping.me.uk>
 <20130527154252.GB8250@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 27 18:01:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ugzrg-0008Sk-3Y
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 18:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415Ab3E0QBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 12:01:36 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:49932 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab3E0QBf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 12:01:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 0C48CCDA52A;
	Mon, 27 May 2013 17:01:35 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IxzRqW9HITDV; Mon, 27 May 2013 17:01:34 +0100 (BST)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 83C32CDA487;
	Mon, 27 May 2013 17:01:31 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130527154252.GB8250@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225602>

On Mon, May 27, 2013 at 11:42:52AM -0400, Jeff King wrote:
> On Mon, May 27, 2013 at 12:40:25PM +0100, John Keeping wrote:
> 
> > Since commit f269048 (fetch: opportunistically update tracking refs,
> > 2013-05-11) we update tracking refs opportunistically when fetching
> > remote branches.  However, if a refspec is given on the command line
> > that does not include a configured (non-pattern) refspec a fatal error
> > occurs.
> 
> I'm not sure I understand what the last sentence means. I tried to add a
> test like:
> 
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index ff43e08..02e30e1 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -422,6 +422,16 @@ test_expect_success 'configured fetch updates tracking' '
>  	)
>  '
>  
> +test_expect_success 'non-configured ref does not confuse tracking update' '
> +	cd "$D" &&
> +	git update-ref refs/odd/location HEAD &&
> +	(
> +		cd three &&
> +		git fetch origin refs/odd/location &&
> +		git rev-parse --verify FETCH_HEAD
> +	)
> +'
> +
>  test_expect_success 'pushing nonexistent branch by mistake should not segv' '
>  
>  	cd "$D" &&
> 
> but it does not fail with the existing code. Can you give an example
> that fails?

I have this in my .git/config for git.git:

    [remote "origin"]
            url = git://github.com/gitster/git
            fetch = +refs/heads/*:refs/remotes/origin/*
            fetch = +refs/notes/amlog:refs/notes/amlog

Then doing "git fetch origin master" fails because:

    fatal: Couldn't find remote ref refs/notes/amlog

The following test fails for me (and passes with my patch) - note that
in "two", remote.one.fetch is configured as
"refs/heads/master:refs/heads/one".

-- >8 --
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ff43e08..c540257 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -422,6 +422,19 @@ test_expect_success 'configured fetch updates tracking' '
 	)
 '
 
+test_expect_success 'configured ref does not confuse tracking' '
+
+	cd "$D" &&
+	(
+		cd one &&
+		git branch -f side
+	) &&
+	(
+		cd two &&
+		git fetch one side
+	)
+'
+
 test_expect_success 'pushing nonexistent branch by mistake should not segv' '
 
 	cd "$D" &&

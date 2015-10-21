From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] fix flaky untracked-cache test
Date: Thu, 22 Oct 2015 00:47:29 +0200
Message-ID: <B454F5BF-A18E-4D36-9B97-F7D51DC48EB0@gmail.com>
References: <1445284095-6602-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, pclouds@gmail.com, tboegi@web.de
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 00:47:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zp2AZ-0007Uc-4a
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 00:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568AbbJUWre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2015 18:47:34 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36447 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756560AbbJUWrd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2015 18:47:33 -0400
Received: by wicfx6 with SMTP id fx6so111695595wic.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2015 15:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y4gZdijOxf+RDxOQPg1u4VJMsd7bmzlcPFsVDNA3suA=;
        b=dRNVkj1ryfTHMq+Yemekl/sAgx0noYwqXoZvKJYu2O3AQHlrVuSCpdmC5HhPnSOlm/
         SrHfnr0GUbahiUPdVP50CvVp65pBQn5rf5k6Et/IdOhBzs64hmYwbBxn1zVAiNSwTRZJ
         kFf8P3S4TBI+TX6XJIQqd36yXp+ANkM2h/pKuNH61jGN/3BY2w+OwfgWZsolBj+yV6kb
         EN+s+2vklDqH7eMahvW0KaRR3YTv1b/T5lf/MHH/bo03Xc4fmeqFN5LtrMQEG96PS0Ww
         Mw3C2XQNrlRV7r8OU3WASi3MiyfXknrnbAyaoJn3FILxaXVcFYTVrekXaMbDsO3hVqMZ
         Mz0w==
X-Received: by 10.180.207.235 with SMTP id lz11mr14030741wic.1.1445467652090;
        Wed, 21 Oct 2015 15:47:32 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB5C89.dip0.t-ipconnect.de. [93.219.92.137])
        by smtp.gmail.com with ESMTPSA id ld5sm13105010wjc.18.2015.10.21.15.47.30
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 21 Oct 2015 15:47:31 -0700 (PDT)
In-Reply-To: <1445284095-6602-1-git-send-email-dturner@twopensource.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280027>

Looks good to me, Ack.

Test run with 74301d6 + my TravisCI patch:
https://travis-ci.org/larsxschneider/git/builds/86702932
... on Linux it failed in 1/2 cases after 53min
... on OSX it failed in 2/2 cases after 6min

Test run with 74301d6 + my TravisCI patch + David's t7063 patch:
https://travis-ci.org/larsxschneider/git/builds/86707133
.. on Linux it failed in 0/2 cases after 77min
...on OSX it failed in 0/2 cases after 48min (no error, CI system timed out, click on the builds to see detailed log output)

Cheers,
Lars

On 19 Oct 2015, at 21:48, David Turner <dturner@twopensource.com> wrote:

> Dirty the test worktree's root directory, as the test expects.
> 
> When testing the untracked-cache, we previously assumed that checking
> out master would be sufficient to mark the mtime of the worktree's
> root directory as racily-dirty.  But sometimes, the checkout would
> happen at 12345.999 seconds and the status at 12346.001 seconds,
> meaning that the worktree's root directory would not be racily-dirty.
> And since it was not truly dirty, occasionally the test would fail.
> By making the root truly dirty, the test will always succeed.
> 
> Tested by running a few hundred times.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> t/t7063-status-untracked-cache.sh | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
> index 37a24c1..0e8d0d4 100755
> --- a/t/t7063-status-untracked-cache.sh
> +++ b/t/t7063-status-untracked-cache.sh
> @@ -412,7 +412,9 @@ test_expect_success 'create/modify files, some of which are gitignored' '
> 	echo two bis >done/two &&
> 	echo three >done/three && # three is gitignored
> 	echo four >done/four && # four is gitignored at a higher level
> -	echo five >done/five # five is not gitignored
> +	echo five >done/five && # five is not gitignored
> +	echo test >base && #we need to ensure that the root dir is touched
> +	rm base
> '
> 
> test_expect_success 'test sparse status with untracked cache' '
> -- 
> 2.4.2.644.g97b850b-twtrsrc
> 

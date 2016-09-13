Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031421FCA9
	for <e@80x24.org>; Tue, 13 Sep 2016 06:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754401AbcIMG6J (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 02:58:09 -0400
Received: from mail2.tiolive.com ([94.23.229.207]:45325 "EHLO
        mail2.tiolive.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754078AbcIMG6I (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 02:58:08 -0400
Received: from teco.navytux.spb.ru (pppoe.95-55-154-162.dynamic.avangarddsl.ru [95.55.154.162])
        by mail2.tiolive.com (Postfix) with ESMTPSA id 82B8DBF0346;
        Tue, 13 Sep 2016 08:58:05 +0200 (CEST)
Received: from kirr by teco.navytux.spb.ru with local (Exim 4.87)
        (envelope-from <kirr@teco.navytux.spb.ru>)
        id 1bjhfM-0005Zs-Tf; Tue, 13 Sep 2016 09:58:00 +0300
Date:   Tue, 13 Sep 2016 09:58:00 +0300
From:   Kirill Smelkov <kirr@nexedi.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Vicent Marti <tanoku@gmail.com>,
        =?iso-8859-1?Q?J=E9rome?= Perrin <jerome@nexedi.com>,
        Isabelle Vallet <isabelle.vallet@nexedi.com>,
        Kazuhiko Shiozaki <kazuhiko@nexedi.com>,
        Julien Muchembled <jm@nexedi.com>, git@vger.kernel.org
Subject: Re: [PATCH] t/perf/run: Don't forget to copy config.mak.autogen &
 friends to build area
Message-ID: <20160913065800.cpye2rqgizszgsuc@teco.navytux.spb.ru>
References: <20160910150512.19473-1-kirr@nexedi.com>
 <xmqqh99l2aqt.fsf@gitster.mtv.corp.google.com>
 <xmqqd1k92aif.fsf@gitster.mtv.corp.google.com>
 <xmqqpoo8yasu.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpoo8yasu.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/ (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2016 at 04:10:09PM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > In other words, something along this line, perhaps.
> > ...
> 
> Not quite.  There is no guanratee that the user is using autoconf at
> all.  It should be more like this, I think.
> 
>  t/perf/run | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/t/perf/run b/t/perf/run
> index aa383c2..7ec3734 100755
> --- a/t/perf/run
> +++ b/t/perf/run
> @@ -30,7 +30,13 @@ unpack_git_rev () {
>  }
>  build_git_rev () {
>  	rev=$1
> -	cp -t build/$rev ../../{config.mak,config.mak.autogen,config.status}
> +	for config in config.mak config.mak.autogen config.status
> +	do
> +		if test -f "../../$config"
> +		then
> +			cp "../../$config" "build/$rev/"
> +		fi
> +	done
>  	(cd build/$rev && make $GIT_PERF_MAKE_OPTS) ||
>  	die "failed to build revision '$mydir'"
>  }

Junio, thanks for encouraging feedback and for catching the *-isms. What
you propose is good (and we also automatically fix error when there was
no config.mak - it was working but cp was giving an error to stderr but
script was continuing normally).

I would amend your squash the following way:

* `test -f` -> `test -e`, because -f tests whether a file exists _and_
  is regular file. Some people might have config.mak as a symlink for
  example. We don't want to miss them too.

Please find updated patch below:

---- 8< ----
From: Kirill Smelkov <kirr@nexedi.com>
Subject: [PATCH] t/perf/run: Don't forget to copy config.mak.autogen & friends
 to build area

Otherwise for people who use autotools-based configure in main worktree,
the performance testing results will be inconsistent as work and build
trees could be using e.g. different optimization levels.

See e.g.

	http://public-inbox.org/git/20160818175222.bmm3ivjheokf2qzl@sigill.intra.peff.net/

for example.

NOTE config.status has to be copied because otherwise without it the build
would want to run reconfigure this way loosing just copied config.mak.autogen.

Signed-off-by: Kirill Smelkov <kirr@nexedi.com>
---
 t/perf/run | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/perf/run b/t/perf/run
index cfd7012..e8adeda 100755
--- a/t/perf/run
+++ b/t/perf/run
@@ -30,7 +30,13 @@ unpack_git_rev () {
 }
 build_git_rev () {
 	rev=$1
-	cp ../../config.mak build/$rev/config.mak
+	for config in config.mak config.mak.autogen config.status
+	do
+		if test -e "../../$config"
+		then
+			cp "../../$config" "build/$rev/"
+		fi
+	done
 	(cd build/$rev && make $GIT_PERF_MAKE_OPTS) ||
 	die "failed to build revision '$mydir'"
 }
-- 
2.9.2.701.gf965a18.dirty

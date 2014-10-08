From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Can I fetch an arbitrary commit by sha1?
Date: Wed, 8 Oct 2014 20:30:29 +0700
Message-ID: <20141008133029.GA23010@lanh>
References: <CAENte7htO13s91UJFNzW4aBhsGxE=LpnvaZfce+vqQU5+a-cYg@mail.gmail.com>
 <CAPBPrnsA4KxNximtKXcC37kuwBHK0Esytdm4nsgLHkrJSg3Ufw@mail.gmail.com>
 <20141002161006.GB2505@peff.net>
 <CACh33FpWPuyJRryf6hzbAkqWJMwzz1mLLDDRxEQ0niT2CznTRg@mail.gmail.com>
 <CACsJy8B0dbE0C3M0PO-EfaZ_bSxwGJSFVejEGFzjHSOZKOc+Jw@mail.gmail.com>
 <20141007131257.GA24348@lanh>
 <xmqqwq8bizzi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Patrick Donnelly <batrick@batbytes.com>, Jeff King <peff@peff.net>,
	Dan Johnson <computerdruid@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 15:30:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbrJx-0005IH-KY
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 15:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756546AbaJHNaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 09:30:22 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:55164 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756509AbaJHNaU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 09:30:20 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so9069423pad.36
        for <git@vger.kernel.org>; Wed, 08 Oct 2014 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ZQhMPULZUd9rndVcrrK7aS5u6rh2lA2R5W81Ly7lMq8=;
        b=h9K7mbvltHIzj10MJnADrNBDjzr7w/DmMArk1JQ3BnH4zfSyX/Kt2EsU7JUF1cbvDV
         lDiOvgyvI3OdDk4vkot0tZ0f4vetOT2vFW11MEsjKtKy2S+FXNvC+KVX5G7epXKsGosQ
         ECm3Fn90ECIbz0V0bLrk7vciKaCgpNumBpML5x0ewxiiD+c9Vmt3kKwa/r2NYEh2v82f
         +0sg75y3j9SOfz2vG5GeMnKj+8JePn4rODO2hpdLUKhWlm1gD3tz5EFzz2cr+ggewhuE
         bEAjk2THN+nyLPdQKOZLq05FPacO5v4fWY2YTRaVuUEjd0pdWXmdU979CbHfwqALSCz8
         hgjQ==
X-Received: by 10.66.250.227 with SMTP id zf3mr9333533pac.135.1412775019636;
        Wed, 08 Oct 2014 06:30:19 -0700 (PDT)
Received: from lanh ([115.73.214.17])
        by mx.google.com with ESMTPSA id iq3sm26337pbb.71.2014.10.08.06.30.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Oct 2014 06:30:18 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 08 Oct 2014 20:30:29 +0700
Content-Disposition: inline
In-Reply-To: <xmqqwq8bizzi.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 07, 2014 at 09:52:33AM -0700, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
> > Hmm.. Junio already did most of the work in 051e400 (helping
> > smart-http/stateless-rpc fetch race - 2011-08-05), so all we need to
> > do is enable uploadpack.allowtipsha1inwant and apply this patch
> 
> Not that patch, I would think.
> 
> I would understand "if !stateless_rpc and !allowtipsha1 then it is
> an error", though.

Fair enough. It seems to work, technically, using the patch below. But
I think people would rather have support from "git clone" and "git
clone --branch" can't deal with SHA-1 this way yet. And --branch might
be a bad place to enable this..

So it needs more work. Any help is appreciated, as I still need to
finish my untracked cache series first and re-evaluate watchman series
before git 3.0 is released.

-- 8< --
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 67e0ab3..bdc121e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1277,4 +1277,22 @@ EOF
 	git push --no-thin --receive-pack="$rcvpck" no-thin/.git refs/heads/master:refs/heads/foo
 '
 
+test_expect_success 'shallow fetch reachable SHA1 (but not a ref)' '
+	mk_empty testrepo &&
+	(
+		cd testrepo &&
+		test_commit foo &&
+		test_commit bar
+	) &&
+	SHA1=`git --git-dir=testrepo/.git rev-parse HEAD^` &&
+	git init shallow &&
+	(
+		cd shallow &&
+		test_must_fail git fetch --depth=1 ../testrepo/.git $SHA1 &&
+		git --git-dir=../testrepo/.git config uploadpack.allowtipsha1inwant true &&
+		git fetch --depth=1 ../testrepo/.git $SHA1 &&
+		git cat-file commit $SHA1 >/dev/null
+	)
+'
+
 test_done
diff --git a/upload-pack.c b/upload-pack.c
index c789ec0..4a9a656 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -454,8 +454,12 @@ static void check_non_tip(void)
 	char namebuf[42]; /* ^ + SHA-1 + LF */
 	int i;
 
-	/* In the normal in-process case non-tip request can never happen */
-	if (!stateless_rpc)
+	/*
+	 * In the normal in-process case without
+	 * uploadpack.allowtipsha1inwant, non-tip requests can never
+	 * happen
+	 */
+	if (!stateless_rpc && !allow_tip_sha1_in_want)
 		goto error;
 
 	cmd.argv = argv;
-- 8< --

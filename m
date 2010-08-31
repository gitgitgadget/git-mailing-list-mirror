From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] merge: Make '--log' an integer option for number
 of shortlog entries
Date: Wed, 1 Sep 2010 00:43:37 +0530
Message-ID: <20100831191324.GA27381@kytes>
References: <1282991734-3368-1-git-send-email-artagnon@gmail.com>
 <1283226800-28980-1-git-send-email-artagnon@gmail.com>
 <20100831143236.GC2315@burratino>
 <7vzkw2abpz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 21:15:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqWJF-0001Xf-3G
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 21:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752555Ab0HaTPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Aug 2010 15:15:48 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:63755 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750720Ab0HaTPr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Aug 2010 15:15:47 -0400
Received: by pxi10 with SMTP id 10so2580275pxi.19
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 12:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=gpkiRZ/w0RDjCyd7lctz2RDJOAREZJqruUJX8Qqx3cA=;
        b=VFCI1Vtds5M10wVT208Ed2sxx8uvvKwh2v3cZY8IDOqi8PJOxps10mDZ+9z5Rp26XU
         +Wv9v0EMG83/Nf+EiUAQ0AlKF+YJkSujQJyDAUJ2cjx+bH+WUbQywZa8fLMVIG/OMdFX
         6WJZyECJ/2NuEfryNYB+yOMwNSiMCZAMu/Xms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Lx6SDjv/njnd1zdk3fQMcIaG/MojfTK1YudMqk9ZLBwG9mj2+QTA4UpgP6A5NrGYb5
         RWwLD6Eq/HkljB1nIafzYOQGAoVwyAk1LhvjmhS3mmsbxNvbzYuIoiHfdLhCWrSrUZu0
         Chr5q799W/1vrK4BoH6nHUJIU8AWKnNuTPht0=
Received: by 10.142.180.1 with SMTP id c1mr6417803wff.59.1283282147429;
        Tue, 31 Aug 2010 12:15:47 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id t11sm11423739wfc.16.2010.08.31.12.15.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 12:15:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzkw2abpz.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154967>

Hi,

Junio C Hamano writes:
> Hmm, do we plan on that?  It sounds a little bit insane.  Erroring it out
> would be Ok.  How about doing this on top?

> @@ -350,7 +350,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
>  		return 0;
>  	}
>  	if (shortlog_len < 0)
> -		shortlog_len = DEFAULT_MERGE_LOG_LEN;
> +		die("Negative --log=%d???", shortlog_len);
>  
>  	if (inpath && strcmp(inpath, "-")) {
>  		in = fopen(inpath, "r");

It's a little asymmetric- the program won't error out when 'merge.log'
is set to -1. Then again, it's probably nicer to simply pretend that
we didn't see that invalid configuration.

Also, to avoid breaking the '--log=-1' test, either drop the test
altogether or use something like this:

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 395c23e..3bfdebc 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -236,7 +236,7 @@ test_expect_success '--log=0 disables shortlog' '
 	test_cmp expected actual
 '
 
-test_expect_success '--log=-1 does something sane' '
+test_expect_code 128 '--log=-1 errors out' '
 	cat >expected <<-EOF &&
 	Merge branch ${apos}left${apos}
 
@@ -248,8 +248,7 @@ test_expect_success '--log=-1 does something sane' '
 	  Common #1
 	EOF
 
-	git fmt-merge-msg --log=-1 <.git/FETCH_HEAD >actual &&
-	test_cmp expected actual
+	git fmt-merge-msg --log=-1 <.git/FETCH_HEAD >actual
 '
 
 test_expect_success 'fmt-merge-msg -m' '

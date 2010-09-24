From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 05/24] t9300 (fast-import): check exit status from command
 substitutions
Date: Fri, 24 Sep 2010 02:11:56 -0500
Message-ID: <20100924071156.GF4666@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <20100905032253.GB2344@burratino>
 <20100924065900.GA4666@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	David Barr <david.barr@cordelta.com>,
	Sam Vilain <sam@vilain.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 24 09:14:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2UZ-0006YC-Uo
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:14:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442Ab0IXHOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:14:43 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39861 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793Ab0IXHOn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:14:43 -0400
Received: by iwn5 with SMTP id 5so2156897iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0OvXJpDypStS0ID0PaqTCf1rt0b8QMK+iDIhKNgooV8=;
        b=s7L2FwecMW2BjR90LBiVvv3aIAmeGasbCFv+kcesuLl4iwZ0XJ6fpXChfp1AkX4SIT
         09PdnZ0P0/kPNQaAKYPgmqVAmCHjZhpW6sYcuEUnIRukcpIj+EvEPKKiqbhZbuMs3tcx
         bgdxrwQYe+eiaZ4ES+dtiYpV5G4fH5DpTqqms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=H6LqHf2AGO8h9kVtk5003u/VA/9oK1/eeKAt0QBRAE9BT/hz7WAHq2ppo3xxDzJeIH
         BVewfhgO8nCUOgFntIfeYcAS2wwRYCUYtVP1iUc7qEK+KXYl7ifi/MMBpyx32/MD7wBA
         CNPqCVh2uG89EWmXWcfRNWyT3u4hYHgIZYsl8=
Received: by 10.231.10.134 with SMTP id p6mr3138529ibp.50.1285312482349;
        Fri, 24 Sep 2010 00:14:42 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id n20sm1945657ibe.17.2010.09.24.00.14.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:14:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156939>

If "git rev-parse" starts to crash or misbehave, we want to
notice.

Cc: Shawn O. Pearce <spearce@spearce.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 47339a3..c113ddf 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -127,24 +127,32 @@ test_expect_success \
 	'A: verify file4' \
 	'git cat-file blob master:file4 >actual && test_cmp expect actual'
 
-cat >expect <<EOF
-object $(git rev-parse refs/heads/master)
-type commit
-tag series-A
-
-An annotated tag without a tagger
-EOF
 test_expect_success 'A: verify tag/series-A' '
+	master=$(git rev-parse --verify refs/heads/master) &&
+	cat >expect <<-EOF &&
+	object $master
+	type commit
+	tag series-A
+
+	An annotated tag without a tagger
+	EOF
 	git cat-file tag tags/series-A >actual &&
 	test_cmp expect actual
 '
 
-cat >expect <<EOF
-:2 `git rev-parse --verify master:file2`
-:3 `git rev-parse --verify master:file3`
-:4 `git rev-parse --verify master:file4`
-:5 `git rev-parse --verify master^0`
-EOF
+test_expect_success 'setup: compute expected marks' '
+	{
+		printf ":2 " &&
+		git rev-parse --verify master:file2 &&
+		printf ":3 " &&
+		git rev-parse --verify master:file3 &&
+		printf ":4 " &&
+		git rev-parse --verify master:file4 &&
+		printf ":5 " &&
+		git rev-parse --verify master^0
+	} >expect
+'
+
 test_expect_success \
 	'A: verify marks output' \
 	'test_cmp expect marks.out'
-- 
1.7.2.3

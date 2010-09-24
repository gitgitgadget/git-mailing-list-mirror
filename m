From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 03/24] t9300 (fast-import): guard "export large marks" test
 setup
Date: Fri, 24 Sep 2010 02:09:50 -0500
Message-ID: <20100924070950.GD4666@burratino>
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
X-From: git-owner@vger.kernel.org Fri Sep 24 09:13:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oz2Sp-0005zW-8Y
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 09:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab0IXHMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 03:12:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49173 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751849Ab0IXHMx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 03:12:53 -0400
Received: by iwn5 with SMTP id 5so2155697iwn.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 00:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=0mDZThPC2jsjAwhnoQqDNiwuXDQtzIlXm5toDfAA28o=;
        b=Vsc4jy8n16/pOJMey3MqwR7fKfNaRmPmi8zvt1vPr1FTB4R/etLX01DLJ5pLTPt7On
         SMCJ5KFlvm9vWtIwW+Ud7M14Q9Ksm3e5tazBoFti4njRlSiWjpLNK9GqKDXqyt1f6ddN
         ttZ+uCw9O8T2YRyvVoUQplGSTvaixv8UdjHPI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=NGsGTG9ApL0MrUB1S8K8+ewxHYfTtHf3jl+4JC2Ff5R6KPYaK0r+PTXAYXzR9+Vvd/
         sn/Tur9aJHHX93C9U2jTsZYCCDtnsvfeEcBykzXqukCr74WDkL38JyD+WasZzutaFGUH
         aDN5SKvaWanG3+/FzH0xmGppwBIO+9Hr79gdg=
Received: by 10.231.193.81 with SMTP id dt17mr1987905ibb.177.1285312368903;
        Fri, 24 Sep 2010 00:12:48 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id h8sm1944016ibk.15.2010.09.24.00.12.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 00:12:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100924065900.GA4666@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156937>

Since the setup for the large marks test involves more complex code
than just a "cat", "echo", or assignment, make it part of the
test_expect_success assertion.  This way, the test script will report
a failure if the setup breaks from a coding mistake, unusual shell, or
other unforseen circumstance.

While at it, make some other small simplifications (grouping commands
that write to the same file with { }; using ">file" instead of ": >file"
to empty a file).

Cc: Shawn O. Pearce <spearce@spearce.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |  106 +++++++++++++++++++++++++-----------------------
 1 files changed, 55 insertions(+), 51 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index ed37a4e..735ac83 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -184,58 +184,62 @@ test_expect_success \
 	 test `git rev-parse --verify master:file2` \
 	    = `git rev-parse --verify verify--import-marks:copy-of-file2`'
 
-test_tick
-mt=$(git hash-object --stdin < /dev/null)
-: >input.blob
-: >marks.exp
-: >tree.exp
-
-cat >input.commit <<EOF
-commit refs/heads/verify--dump-marks
-committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
-data <<COMMIT
-test the sparse array dumping routines with exponentially growing marks
-COMMIT
-EOF
-
-i=0
-l=4
-m=6
-n=7
-while test "$i" -lt 27; do
-    cat >>input.blob <<EOF
-blob
-mark :$l
-data 0
-blob
-mark :$m
-data 0
-blob
-mark :$n
-data 0
-EOF
-    echo "M 100644 :$l l$i" >>input.commit
-    echo "M 100644 :$m m$i" >>input.commit
-    echo "M 100644 :$n n$i" >>input.commit
-
-    echo ":$l $mt" >>marks.exp
-    echo ":$m $mt" >>marks.exp
-    echo ":$n $mt" >>marks.exp
-
-    printf "100644 blob $mt\tl$i\n" >>tree.exp
-    printf "100644 blob $mt\tm$i\n" >>tree.exp
-    printf "100644 blob $mt\tn$i\n" >>tree.exp
-
-    l=$(($l + $l))
-    m=$(($m + $m))
-    n=$(($l + $n))
-
-    i=$((1 + $i))
-done
-
-sort tree.exp > tree.exp_s
-
 test_expect_success 'A: export marks with large values' '
+	test_tick &&
+	mt=$(git hash-object --stdin </dev/null) &&
+	>input.blob &&
+	>marks.exp &&
+	>tree.exp &&
+
+	cat >input.commit <<-EOF &&
+	commit refs/heads/verify--dump-marks
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data <<COMMIT
+	test the sparse array dumping routines with exponentially growing marks
+	COMMIT
+	EOF
+
+	(
+		i=0 &&
+		l=4 &&
+		m=6 &&
+		n=7 &&
+		while test "$i" -lt 27
+		do
+			cat >>input.blob <<-EOF &&
+			blob
+			mark :$l
+			data 0
+			blob
+			mark :$m
+			data 0
+			blob
+			mark :$n
+			data 0
+			EOF
+			{
+				echo "M 100644 :$l l$i" &&
+				echo "M 100644 :$m m$i" &&
+				echo "M 100644 :$n n$i"
+			} >>input.commit &&
+			{
+				echo ":$l $mt" &&
+				echo ":$m $mt" &&
+				echo ":$n $mt"
+			} >>marks.exp &&
+			{
+				printf "100644 blob $mt\tl$i\n" &&
+				printf "100644 blob $mt\tm$i\n" &&
+				printf "100644 blob $mt\tn$i\n"
+			} >>tree.exp &&
+			l=$(($l + $l)) &&
+			m=$(($m + $m)) &&
+			n=$(($l + $n)) &&
+			i=$((1 + $i)) ||
+			exit
+		done
+	) &&
+	sort tree.exp >tree.exp_s &&
 	cat input.blob input.commit | git fast-import --export-marks=marks.large &&
 	git ls-tree refs/heads/verify--dump-marks >tree.out &&
 	test_cmp tree.exp_s tree.out &&
-- 
1.7.2.3

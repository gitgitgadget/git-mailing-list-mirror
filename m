From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH jn/fast-import-blob-access] t9300: avoid short reads from dd
Date: Mon, 13 Dec 2010 00:31:51 -0600
Message-ID: <20101213063151.GB20812@burratino>
References: <0BB1933F-1C3D-4C24-9C91-263121BF55FB@gernhardtsoftware.com>
 <20101212214909.GA19709@burratino>
 <2F4185D2-5846-45CB-BC92-6BC07AE5CEC8@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Junio C Hamano <gitster@pobox.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 07:32:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS1x6-0000fV-3E
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 07:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab0LMGb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 01:31:58 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:61875 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162Ab0LMGb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 01:31:58 -0500
Received: by yxt3 with SMTP id 3so3096262yxt.19
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 22:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=rCdETTrLqM9IWk89N3FQaiOCpo4KBTxeNB0wI/3uJVo=;
        b=h1wOmhE2odJxh7NRBnOZzJjHYUJOqsQfqN8dmc8r+/EBAI90zkwAYMDr+aZWyiBEAc
         lNf02VSF0rZrcbWMvHk1BfwTv5r1BqZZk7Fk813JEy8OL+gsXI7YykEyI7spgIIpa5xP
         GfYwuvwRSsB37rC2fJ0/5pQr1M1zGgEEpYVrc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=GimcZ0oVUfN0kC/hoD6eGZOodwlj1gBrgs/inQhiCzrGyXmu80rQhygGVhItY3SQLE
         +85ZBXJrSiD6vcztuhf/26j60qAXJH/2CTakmHSINWMuJF3TARB7+AEqDOfqKnUAUinp
         QposnkAqjRr8JYhnMX9WjQHDixtAW9RehwtjM=
Received: by 10.91.153.10 with SMTP id f10mr4429168ago.172.1292221917240;
        Sun, 12 Dec 2010 22:31:57 -0800 (PST)
Received: from burratino (adsl-69-209-48-248.dsl.chcgil.sbcglobal.net [69.209.48.248])
        by mx.google.com with ESMTPS id 2sm7002222anw.18.2010.12.12.22.31.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 22:31:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <2F4185D2-5846-45CB-BC92-6BC07AE5CEC8@gernhardtsoftware.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163518>

dd is a thin wrapper around read(2).  As open group Issue 7 explains:

	It shall read the input one block at a time, using the specified
	input block size; it shall then process the block of data
	actually returned, which could be smaller than the requested
	block size.

Any short read --- for example from a pipe whose capacity cannot fill
a block --- results in that block being truncated.  As a result, the
first cat-blob test (9300.114) fails on Mac OS X, where the pipe
capacity is around 8 KiB.

Fix the test by using a block size of 1.  Each read will block until
the next byte of input is available.

It would be even nicer to use head -c which expresses the intention
more clearly.  Alas, IRIX "head" does not support the -c option.

Reported-by: Brian Gernhardt <brian@gernhardtsoftware.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 t/t9300-fast-import.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 055ddc6..ed28d3c 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -1794,7 +1794,7 @@ test_expect_success PIPE 'R: copy using cat-file' '
 
 	read blob_id type size <&3 &&
 	echo "$blob_id $type $size" >response &&
-	dd of=blob bs=$size count=1 <&3 &&
+	dd of=blob bs=1 count=$size <&3 &&
 	read newline <&3 &&
 
 	cat <<EOF &&
@@ -1845,7 +1845,7 @@ test_expect_success PIPE 'R: print blob mid-commit' '
 		EOF
 
 		read blob_id type size <&3 &&
-		dd of=actual bs=$size count=1 <&3 &&
+		dd of=actual bs=1 count=$size <&3 &&
 		read newline <&3 &&
 
 		echo
@@ -1880,7 +1880,7 @@ test_expect_success PIPE 'R: print staged blob within commit' '
 		echo "cat-blob $to_get" &&
 
 		read blob_id type size <&3 &&
-		dd of=actual bs=$size count=1 <&3 &&
+		dd of=actual bs=1 count=$size <&3 &&
 		read newline <&3 &&
 
 		echo deleteall
-- 
1.7.2.4

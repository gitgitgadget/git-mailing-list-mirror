From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] t6022: Use -eq not = to test output of wc -l
Date: Tue, 16 Nov 2010 11:10:32 -0600
Message-ID: <20101116171031.GB13398@burratino>
References: <1289251766-48316-1-git-send-email-brian@gernhardtsoftware.com>
 <7vaalajkiq.fsf@alter.siamese.dyndns.org>
 <4CE22EC2.7040603@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 16 18:11:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIP49-0006QL-Nj
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 18:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755377Ab0KPRLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 12:11:12 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63997 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755274Ab0KPRLL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 12:11:11 -0500
Received: by gyh4 with SMTP id 4so479826gyh.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 09:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=uSq/aw6Sc0sMBWPKxVPJ8bTdYGLmBpccYthIlL4kAGg=;
        b=lFeiSbGoAKJKwCrQKyulDNdpiY5Le2IMkA+4G5SZmvm6Q4B7BmQseYnLNeU3uwknKb
         VE7pZJb3AruUlsm3iOF+/BGzl8KdYIsFsBvBrp/aH2dcwyoB4U0NtGfbU0ofG7lDJYWV
         OnVufSM5Om3GFeCeRgVnL7tt4YOOCK4T0091A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rZ6auKwYYaxJ77KC5z3ih7h0Y/dKLrd7sGVf7iwkul7hP/0zf57AsCiNKAWT2sckFe
         nhuvy9sAlN81En+UIt6RzDlvAU+pqzO1xBTT454sbsmL6LdmsAcNmPOy+mGwo7zV0hq4
         Jznd72UbMPIAc/hLc5bIeIQZ3N/jNqfx+dTL0=
Received: by 10.151.110.2 with SMTP id n2mr12051834ybm.164.1289927470640;
        Tue, 16 Nov 2010 09:11:10 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id 52sm912946yhl.17.2010.11.16.09.11.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 09:11:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE22EC2.7040603@viscovery.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161565>

Johannes Sixt wrote:

> - It doesn't save any messages or fix-ups during review: instead of "do
> not quote!" we have to say "use test_line_count!".

I was nervous about introducing test_line_count for that reason.

Another consideration won out: not syntax but output format.  See
cae3aa79 (t6022 (renaming merge): chain test commands with &&,
2010-10-31).  Kind of analogous to test_cmp, which is a similar
headache to get used over less portable or less pleasant alternatives.

If a piped variant is needed, I would prefer it to work something
like this.  Usage:

	{
		command_producing_five_lines |
		test_line_count = 5 -
	}

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1ea0116..35a5634 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -660,15 +660,24 @@ test_path_is_missing () {
 # output through when the number of lines is wrong.
 
 test_line_count () {
+	line_count_tmp=
 	if test $# != 3
 	then
 		error "bug in the test script: not 3 parameters to test_line_count"
-	elif ! test $(wc -l <"$3") "$1" "$2"
+	fi
+	if test "$3" = -
+	then
+		line_count_tmp=test_line_count.output
+		cat >"$line_count_tmp"
+		set -- "$1" "$2" "$line_count_tmp"
+	fi
+	if ! test $(wc -l <"$3") "$1" "$2"
 	then
 		echo "test_line_count: line count for $3 !$1 $2"
 		cat "$3"
 		return 1
 	fi
+	rm -f "$line_count_tmp"
 }
 
 # This is not among top-level (test_expect_success | test_expect_failure)

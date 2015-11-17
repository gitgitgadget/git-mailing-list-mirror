From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v5 3/6] git-p4: retry kill/cleanup operations in tests with timeout
Date: Tue, 17 Nov 2015 09:28:07 +0100
Message-ID: <52A9F66D-12C4-4BB5-A2D4-C476A1E12DC5@gmail.com>
References: <1447592920-89228-1-git-send-email-larsxschneider@gmail.com> <1447592920-89228-4-git-send-email-larsxschneider@gmail.com> <CAPig+cQkNB3VzbC_R_T=ppkgvmTbOWnK22hFxyMzJH1DZ_iVhQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 09:28:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zybcd-00069f-Ln
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 09:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752447AbbKQI2L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 03:28:11 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36049 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751869AbbKQI2K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2015 03:28:10 -0500
Received: by wmww144 with SMTP id w144so142944362wmw.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2015 00:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Qz0riJZuQF99UgeD2g1ccEPbeAvjuZ0rxDFwMQ9EPjU=;
        b=aXBHtQxmuLqj4KSnCfPXrtpp65jjH4lX4oJo/vwJFeF5s6YNgzZI51M64FmmPuV3H4
         a5WzwzCOZQNpdKORIgk1fFNeCWs5ms6jj36+mUghpaQwtSBsSJiMxvu3lHrFtJpcF+H0
         Mc3PzSIjFEiz1jPSfRJIHuijc0b/SHAQ9x81djjJmnBpzV13ODcHkBUNdDjv1Brc2/UH
         Zy7XbyFGoTGytL55atw1LykPgB0TSuuS8qh1zZoG2SxWOzxe2FDlRa8JQGoPj3ti4UQx
         ORDiUwY9iFk4sIxq+sOxon9pLG9ULJAkttWxVwB2YfTSiyTtp327NpToMflEtC/PC1Cm
         S5Mg==
X-Received: by 10.28.23.66 with SMTP id 63mr1047908wmx.4.1447748889043;
        Tue, 17 Nov 2015 00:28:09 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB4D5B.dip0.t-ipconnect.de. [93.219.77.91])
        by smtp.gmail.com with ESMTPSA id 71sm22690913wmm.24.2015.11.17.00.28.08
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 17 Nov 2015 00:28:08 -0800 (PST)
In-Reply-To: <CAPig+cQkNB3VzbC_R_T=ppkgvmTbOWnK22hFxyMzJH1DZ_iVhQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281388>


On 16 Nov 2015, at 22:14, Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Sun, Nov 15, 2015 at 8:08 AM,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> In rare cases kill/cleanup operations in tests fail. Retry these
>> operations with a timeout to make the test less flaky.
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
>> @@ -121,22 +125,33 @@ p4_add_user() {
>>        EOF
>> }
>> 
>> +retry_until_success() {
>> +    timeout=$(($(date +%s) + $RETRY_TIMEOUT))
> 
> There was some discussion previously[1] about detecting dynamically
> whether 'date +%s' was supported. Was this something that you intended
> to do, or did you decide against it since p4 is not supported on such
> platforms?
> 
> Same question also applies to patch 4/6.

While implementing it I thought more about it. P4D is only supported on platforms that support the date function. That means these tests will only run on platforms that support the date function. Consequently I wondered if this would justify the slightly more complicated code. However, if you think this change would help the patch to get accepted then I will add it.

Thanks,
Lars


> 
> [1]: http://article.gmane.org/gmane.comp.version-control.git/280978/match=lazy+prerequisite
> 
>> +    until "$@" 2>/dev/null || test $(date +%s) -gt $timeout
>> +    do :
>> +    done
>> +}
>> +
>> +retry_until_fail() {
>> +    timeout=$(($(date +%s) + $RETRY_TIMEOUT))
>> +    until ! "$@" 2>/dev/null || test $(date +%s) -gt $timeout
>> +    do :
>> +    done
>> +}

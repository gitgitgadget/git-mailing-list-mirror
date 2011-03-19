From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: [PATCH 1/2] git bisect run: exit code 126 and 127 abort the run
Date: Sat, 19 Mar 2011 16:18:56 +0100
Message-ID: <4D84C960.3010401@gmail.com>
References: <AANLkTikZ3Po-YdhO-qCn5usVkt4J196eFF6YdbAeMG_X@mail.gmail.com> <7v1v267no9.fsf@alter.siamese.dyndns.org> <AANLkTikRttGnxex1CYSQnSg4PgctFj0-qNjf5un+fL0W@mail.gmail.com> <4D81B04A.1010802@viscovery.net> <20110317072723.GH11931@sigill.intra.peff.net> <7vei654omv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 16:19:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0xw4-0006iX-D4
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 16:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321Ab1CSPTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 11:19:11 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62989 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755229Ab1CSPTF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 11:19:05 -0400
Received: by mail-fx0-f46.google.com with SMTP id 17so4465672fxm.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=01SHEIyNjza17u67kQ4oGN4cl9P47/x361xoSOZZQZk=;
        b=vH+d7Js0JM5mc9fNAFu9v7RUkcjMkBR4HMNRgEnWzpPTgQTAp44wk/KtM/rgms+05o
         k5JU2GzNel5vjyDhcZr852ymgtj7CYlYNHjBPecbgp8ZR8qeodAKT0Z6t4YUwu7YiRzH
         JQEdtBGu2hiHytgtXsVdB0IcTiFwQPChnqAo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=wz/0sjjzetaRYgBjBs/zF39z3X9ZzTsQROD1DmagANJGct4eArda7w4fxTon83QnfN
         jZ2OUryRxCGSERm5wis/7b8GpEaTwGH+uSS+wjy5BM29BnMMF5HkVxUJD5Y5cySJDPVm
         9LvYnlM3KAEd6sHKkaSLoyg8exwYu9hEUR4bw=
Received: by 10.223.6.11 with SMTP id 11mr2643702fax.92.1300547945189;
        Sat, 19 Mar 2011 08:19:05 -0700 (PDT)
Received: from [192.168.1.101] (aapp186.neoplus.adsl.tpnet.pl [83.5.149.186])
        by mx.google.com with ESMTPS id j12sm1785653fax.9.2011.03.19.08.19.03
        (version=SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 08:19:04 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
In-Reply-To: <7vei654omv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169438>

Those codes are reserved by POSIX to indicate
"command not executable" and "command not found":
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_08_02

Bisect used to treat them as codes returned by user
to mark a "bad" code.

With that approach it was not possible to differentiate
between codes returned by the user and codes returned by
shell (which is likely a sign of a poorly written test
script).

Another minor problem was lack of consistency in exit codes.
A "bad" code was marked by any value in range 1-124,126-127
and the gap in the middle looked weird.

Change the meaning of exit codes 126 and 127 to
"abort the bisect process" to fixes the above problems.

Signed-off-by: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
---
 git-bisect.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

W dniu 17.03.2011 18:56, Junio C Hamano pisze:
> Jeff King <peff@peff.net> writes:
> 
>>   2. If we do detect such a mishap, I'm not sure that "indeterminate
>>      result" is necessarily the best result, as that will just keep
>>      trying more and more commits without success. It is more likely a
>>      sign of a poorly written test script, and the best thing we could
>>      do is die and say "your test script looks buggy".
> 
> Exactly. I agree "Aborting the bisect as run-script is a crap" is the
> right thing to do here.

Here's a patch. Next one changes git-bisect.txt

There's also Documentation/git-bisect-lk2009.txt which talks about exit
codes and should be changed somehow. As I understand it's a quote from an
email so I don't know if it should be edited in place, or should a note
be added at beginning?


(And again my patch has commit message longer than the changes...
 Now I understand why in-code documentation is lacking - after writing
 lengthy commit message documenting the code is just too much ;) )

diff --git a/git-bisect.sh b/git-bisect.sh
index c21e33c..9ca4852 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -376,9 +376,9 @@ bisect_run () {
       res=$?
 
       # Check for really bad run error.
-      if [ $res -lt 0 -o $res -ge 128 ]; then
+      if [ $res -lt 0 -o $res -ge 126 ]; then
 	  echo >&2 "bisect run failed:"
-	  echo >&2 "exit code $res from '$@' is < 0 or >= 128"
+	  echo >&2 "exit code $res from '$@' is < 0 or >= 126"
 	  exit $res
       fi
 
-- 
1.7.1

-- 
Piotr Krukowiecki

From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: git checkout creates strange '(null)'-branch
Date: Tue, 8 May 2012 13:50:35 +0200
Message-ID: <CABPQNSZjdpz8zqYOwBQ_SPeh0JqyxQ1bjrghG1vzxt0GiLR22w@mail.gmail.com>
References: <CABPQNSZbgZsQBReSqOskNQ4oZokHSibVr=yHdn6oSFjtdRvVVA@mail.gmail.com>
 <4FA904C3.7070208@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue May 08 13:51:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRiwq-0007Kr-NV
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 13:51:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753011Ab2EHLvQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 07:51:16 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:35829 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735Ab2EHLvP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 07:51:15 -0400
Received: by dady13 with SMTP id y13so2550950dad.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=bwCVhY3OLUEpj+ELEYdmz6nGUK+BcCBqfV0KLN44Ojc=;
        b=sO5UMvXKgaIxyvmPoqL5Qwn69AAJB3hv32f8X5uamwWx8otuC5lYGuTM0x6BZRYT5B
         xkWDNxWf5A3HvTMfOI/d3n17a//DThWwcq1uItCNMjk1qadx/5C8vfm+0Z8yUuXnRtax
         +su1Z+vdbmn7ENDTuWlRfwcmLV8z/McaWaFhFHA2EuS92kIjnlUTyh5IvASwHB/lU6b2
         kUPXGl1fw66RNiG/dgBA6Ci7Tke77aBJpOikRpW9uLz6WbUjzF+4IPYjLPK0F1HKcVh4
         CQocmfs9YCbPMH9sA6lJpUSQTZCKtfNI/plCpxdaGTN33YfXrebXQz4J5mE71KGH1Zl3
         hutA==
Received: by 10.68.230.70 with SMTP id sw6mr6780119pbc.111.1336477875394; Tue,
 08 May 2012 04:51:15 -0700 (PDT)
Received: by 10.68.73.65 with HTTP; Tue, 8 May 2012 04:50:35 -0700 (PDT)
In-Reply-To: <4FA904C3.7070208@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197354>

On Tue, May 8, 2012 at 1:34 PM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> Am 5/8/2012 13:24, schrieb Erik Faye-Lund:
>> + =A0 =A0 =A0 =A0 =A0 =A0 git show-ref | !grep "(null)"
> ...
>> Now, doing this doesn't make my test above pass,
>
> It is unlikely to pass if you used this test script literally, becaus=
e
>
> =A0 $ !grep
> =A0 !grep: command not found
>
> "!" is not an operator in a shell script. Insert a space.

Whoops, you are of course right, my bad. Actually, inserting a space
doesn't quite do the trick, but doing
"! (git show-ref | grep "(null)")" instead seems to work. I'm no
shell-script wizard ;)

The test still fails, though :)

I didn't actually fix up the code so the test failed, so I guess
that's why I didn't see a false negative. Instead, I fixed up the code
so it failed earlier.

But if I apply the following patch, the test passes. I'm not saying
it's the right thing to do, though.

(Warning: white-space damaged because of copying diffs between terminal=
s)

---8<---
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 23fc56d..d70e819 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1096,8 +1096,11 @@ int cmd_checkout(int argc, const char **argv,
const char *prefix)
                int flag;

                if (!read_ref_full("HEAD", rev, 0, &flag) &&
-                   (flag & REF_ISSYMREF) && is_null_sha1(rev))
+                   (flag & REF_ISSYMREF) && is_null_sha1(rev)) {
+                       if (!opts.new_branch)
+                               return 0;
                        return switch_unborn_to_new_branch(&opts);
+               }
        }
        return switch_branches(&opts, &new);
 }
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 81827e6..5b1932c 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -520,4 +520,16 @@ test_expect_success 'moving the superproject does
not break submodules' '
        )
 '

+test_expect_failure 'committing to empty submodule does not create
(null) branch' '
+       test_create_repo empty-repo &&
+       git submodule add ./empty-repo empty-submodule &&
+       (
+               cd empty-submodule &&
+               echo "foo" > bar.txt &&
+               git add bar.txt &&
+               git commit -m. &&
+               ! (git show-ref | grep "(null)")
+       )
+'
+
 test_done
---8<---

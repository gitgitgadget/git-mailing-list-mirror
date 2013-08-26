From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2] submodule: prevent warning in summary output
Date: Mon, 26 Aug 2013 21:59:44 +0200
Message-ID: <521BB3B0.4060908@web.de>
References: <1376958397-800967-1-git-send-email-sandals@crustytoothpaste.net> <521B114B.2080709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Mon Aug 26 21:59:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VE2x5-0003lO-88
	for gcvg-git-2@plane.gmane.org; Mon, 26 Aug 2013 21:59:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327Ab3HZT7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 15:59:47 -0400
Received: from mout.web.de ([212.227.17.11]:49740 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751998Ab3HZT7q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 15:59:46 -0400
Received: from [192.168.178.41] ([79.193.82.101]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0MgZLb-1VRZck0ulL-00O0q1 for <git@vger.kernel.org>;
 Mon, 26 Aug 2013 21:59:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <521B114B.2080709@gmail.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:Zpkuwss4CV3mcQgAhx5yswXqUaGGzZnUK25PcE7xq0jqJjWpUk4
 YmBp9M0Y4rc4OuYKXLRL9sDcuM57M4s9wDKTJyecf1DLokO6AlGrpUdIgDWTDbdVmqoXdIb
 a0Kv6p2c9/Agr6GWYEd7EuDI1oHrsAvwUjn7rSB3ji53kxVR1XV+Nc2rGUVaP8YCVkGn34h
 MwjBsJLernSVVztiEwCxg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233020>

Am 26.08.2013 10:26, schrieb Chris Packham:
> Hi Brian,
> 
> Sorry for the delay.

Same here.

> On 20/08/13 12:26, brian m. carlson wrote:
>> When git submodule summary is run and there is a deleted submodule, there is an
>> warning from git rev-parse:
>>
>>   fatal: Not a git repository: '.vim/pathogen/.git'
>>
>> Silence this warning, since it is fully expected that a deleted submodule will
>> not be a git repository.
>>
>> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
>> ---
>>
>> I hesitated to add the test for $status because it will end up having no effect
>> since we exclude that case later.  However, for correctness, I included it.
>>
>>  git-submodule.sh | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index 2979197..eec3135 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
>> @@ -1070,7 +1070,10 @@ cmd_summary() {
>>  		missing_src=
>>  		missing_dst=
>>  
>> +		test $status = D && missing_src=t
> 
> I tend to agree with you that this line is redundant. I'm not sure that
> it's what Jens was looking for in v1.

Unfortunately you'll get another two "fatal: Not a git repository:" errors
when you drop this. Further down a "git rev-list" and a "git log" are run
on the submodule unless one of the "missing" variables is set. But this
doesn't feel quite right as we are misusing the missing_src variable for
something else here ...

>> +
>>  		test $mod_src = 160000 &&
>> +		test -e "$name/.git" &&
>>  		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
>>  		missing_src=t
>>
> 
> This part looks good to me.

I agree that this is much better than just piping all errors to /dev/null,
but I was thinking of

+               test $status != D &&

instead of

+		test -e "$name/.git" &&

above to still catch errors where the submodule repo is gone but the
submodule wasn't deleted.

The following diff silences all "fatal: Not a git repository:" errors for
me using the status variable. But now four tests in t7401 are failing
because they disagree about an empty line and/or the "(0)" at the end of
a line. But this could be a good starting point (and includes a test for
what we are trying to fix here :-).

----------------------------------8<-------------------------
diff --git a/git-submodule.sh b/git-submodule.sh
index 2979197..69f6a1b 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -1071,6 +1071,7 @@ cmd_summary() {
                missing_dst=

                test $mod_src = 160000 &&
+               test $status != D &&
                ! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
                missing_src=t

@@ -1103,6 +1104,7 @@ cmd_summary() {
                        else
                                range=$sha1_dst
                        fi
+                       test $status != D &&
                        GIT_DIR="$name/.git" \
                        git rev-list --first-parent $range -- | wc -l
                        )
@@ -1143,6 +1145,7 @@ cmd_summary() {
                                GIT_DIR="$name/.git" \
                                git log --pretty='format:  > %s' -1 $sha1_dst
                        else
+                               test $status != D &&
                                GIT_DIR="$name/.git" \
                                git log --pretty='format:  < %s' -1 $sha1_src
                        fi
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index ac2434c..66c73f6 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -215,12 +215,13 @@ EOF
 commit_file sm1 &&
 rm -rf sm1
 test_expect_success 'deleted submodule' "
-       git submodule summary >actual &&
+       git submodule summary >actual 2>err &&
        cat >expected <<-EOF &&
 * sm1 $head6...0000000:

 EOF
-       test_cmp expected actual
+       test_cmp expected actual &&
+       ! test -s err
 "

 test_create_repo sm2 &&

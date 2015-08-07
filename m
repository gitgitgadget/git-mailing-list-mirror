From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/3] clone: do not include authentication data in guessed dir
Date: Fri, 07 Aug 2015 13:45:54 -0700
Message-ID: <xmqqh9oayghp.fsf@gitster.dls.corp.google.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<1438769179-5943-1-git-send-email-ps@pks.im>
	<1438769179-5943-2-git-send-email-ps@pks.im>
	<xmqqzj253a39.fsf@gitster.dls.corp.google.com>
	<xmqqr3nh34tv.fsf@gitster.dls.corp.google.com>
	<xmqqmvy534m0.fsf@gitster.dls.corp.google.com>
	<20150806094732.GA746@pks-xps>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	sunshine@sunshineco.com, pclouds@gmail.com
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Fri Aug 07 22:46:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNoWg-0001ii-7M
	for gcvg-git-2@plane.gmane.org; Fri, 07 Aug 2015 22:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965AbbHGUp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2015 16:45:58 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36412 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753839AbbHGUp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2015 16:45:57 -0400
Received: by pdco4 with SMTP id o4so49011582pdc.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2015 13:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=wa6N0mdQu0yyvXYjwIiZ2+ncqNpOTris/h2xVUqHRp0=;
        b=PMQ6uM1NfYURv4PgEQvjD5UfH1s3MkSEHzak3/mabo+nAPk38Ie09PP4Joust8XvjN
         v6rWNM0L7P+2zwPTNayRudGydhKDR3mu2YJOT/Y0voUr9nyxGjmqTK5DesV//vZ0us/S
         DtiLyL6ojPHVAmRqkKYVqLJ65vFYaf1lkVaOY/0J/ZfUnkPphVZh6kWJRQwJ757IJi1D
         T0aq00yeaT25Rxg4vaVfuDsMbrL4toq2uz8i3oFChBRsTrL0+rE/o1slvDI69In7qJC4
         neL5v900Biku0oZVQQsQQ8sXtIZXSoPA1h8ZPtKHX29zjfLNo3Qyhr8iPqG4DPOxm25N
         5JyA==
X-Received: by 10.70.100.201 with SMTP id fa9mr18563337pdb.34.1438980356583;
        Fri, 07 Aug 2015 13:45:56 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6597:23b2:a33a:2b5b])
        by smtp.gmail.com with ESMTPSA id le8sm11095934pbc.24.2015.08.07.13.45.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Aug 2015 13:45:54 -0700 (PDT)
In-Reply-To: <20150806094732.GA746@pks-xps> (Patrick Steinhardt's message of
	"Thu, 6 Aug 2015 11:47:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275486>

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Aug 05, 2015 at 12:41:27PM -0700, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > For completeness, here is what I think the end result (together with
>> > Peff's series) of the test should look like.
>> > ...
>> > Note that ssh://user:passw@rd@host:1234/ and user:passw@rd@host:/
>> > tests fail for the same reason (finding @ should be greedy, I think).
>> 
>> And I think this should make it pass.  Just remember the last
>> occurrence of '@' by moving the 'start' every time we see an '@'
>> sign.
>> 
>>  builtin/clone.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>> 
>> diff --git a/builtin/clone.c b/builtin/clone.c
>> index cae288f..5d86439 100644
>> --- a/builtin/clone.c
>> +++ b/builtin/clone.c
>> @@ -160,13 +160,12 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
>>  		start += 3;
>>  
>>  	/*
>> -	 * Skip authentication data.
>> +	 * Skip authentication data, if exists.
>>  	 */
>> -	ptr = start;
>> -	while (ptr < end && !is_dir_sep(*ptr) && *ptr != '@')
>> -		ptr++;
>> -	if (*ptr == '@')
>> -		start = ptr + 1;
>> +	for (ptr = start; ptr < end && !is_dir_sep(*ptr); ptr++) {
>> +		if (*ptr == '@')
>> +			start = ptr + 1;
>> +	}
>>  
>>  	/*
>>  	 * Strip trailing spaces, slashes and /.git
>
> I guess it makes sense to skip over @-signs greedily. Is there
> anything I need to do here or will you squash those changes in?

Sorry but I won't have patience to split the "these need squashing
in" into multiple pieces and add them to appropriate commits in the
5 patch series (counting Peff's two fixes on top of which you built
your 3 patch series) correctly.  You as the original author are much
better equipped to do so than I am, so I'd appreciate if you can
reroll them as a 5-patch series.

Among the changes, the fix to builtin/clone.c needs to be squashed
into your "clone: do not include authentication data in guessed
dir", and the remainder of the patch to t5603 should go to Peff's
"clone: add tests for output directory", but with most of them
marked initially as failing.  And then as you fix them in your
patches, some of the "fail" mark should be dropped.

Thanks.

 builtin/clone.c          | 11 +++++------
 t/t5603-clone-dirname.sh | 14 +++++++++++++-
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index cae288f..5d86439 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -160,13 +160,12 @@ static char *guess_dir_name(const char *repo, int is_bundle, int is_bare)
 		start += 3;
 
 	/*
-	 * Skip authentication data.
+	 * Skip authentication data, if exists.
 	 */
-	ptr = start;
-	while (ptr < end && !is_dir_sep(*ptr) && *ptr != '@')
-		ptr++;
-	if (*ptr == '@')
-		start = ptr + 1;
+	for (ptr = start; ptr < end && !is_dir_sep(*ptr); ptr++) {
+		if (*ptr == '@')
+			start = ptr + 1;
+	}
 
 	/*
 	 * Strip trailing spaces, slashes and /.git
diff --git a/t/t5603-clone-dirname.sh b/t/t5603-clone-dirname.sh
index 27dbd6c..4897ea8 100755
--- a/t/t5603-clone-dirname.sh
+++ b/t/t5603-clone-dirname.sh
@@ -22,7 +22,8 @@ test_clone_dir () {
 	expect=success
 	bare=non-bare
 	clone_opts=
-	for i in "$@"; do
+	for i in "$@"
+	do
 		case "$i" in
 		fail)
 			expect=failure
@@ -61,12 +62,23 @@ test_clone_dir ssh://host/foo/ foo
 test_clone_dir ssh://host/foo.git/ foo
 test_clone_dir ssh://host/foo/.git/ foo
 
+test_clone_dir host:foo/ foo
+test_clone_dir host:foo.git/ foo
+test_clone_dir host:foo/.git/ foo
+
 # omitting the path should default to the hostname
 test_clone_dir ssh://host/ host
 test_clone_dir ssh://host:1234/ host
 test_clone_dir ssh://user@host/ host
+test_clone_dir host:/ host
+
+# auth materials should be redacted
 test_clone_dir ssh://user:password@host/ host
 test_clone_dir ssh://user:password@host:1234/ host
+test_clone_dir ssh://user:passw@rd@host:1234/ host
+test_clone_dir user@host:/ host
+test_clone_dir user:password@host:/ host
+test_clone_dir user:passw@rd@host:/ host
 
 # trailing port-like numbers should not be stripped for paths
 test_clone_dir ssh://user:password@host/test:1234 1234
-- 
2.5.0-423-ga363579

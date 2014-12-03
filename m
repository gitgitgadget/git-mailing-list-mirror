From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH v5 1/1] http: Add Accept-Language header if possible
Date: Wed, 3 Dec 2014 14:06:56 -0800
Message-ID: <CAO2U3QjG2rUgUrM5odX0UOnHsENnYTfwaRLhHv8gka7qj4XWdw@mail.gmail.com>
References: <1405792730-13539-1-git-send-email-eungjun.yi@navercorp.com>
 <1417522356-24212-1-git-send-email-eungjun.yi@navercorp.com>
 <1417522356-24212-2-git-send-email-eungjun.yi@navercorp.com>
 <CAPig+cTsULQPxoaSQ-ZvjWJ9Rgpdf3zG7ObPg4TnxFbXT9TwnA@mail.gmail.com>
 <xmqqppc0wh33.fsf@gitster.dls.corp.google.com> <CAO2U3QgDzDTt-zujw1yk51HFdp4oACusXeZ59h-CUgU41vgDHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Yi EungJun <semtlenori@gmail.com>,
	Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 23:07:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwI5B-000853-Vi
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 23:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbaLCWHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 17:07:34 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:39989 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbaLCWHR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 17:07:17 -0500
Received: by mail-oi0-f41.google.com with SMTP id a3so11562332oib.28
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 14:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bPV4wwXVhlJpZdYGC/1Tt88tpV+4R1MqRgz2c6AiGQU=;
        b=i/mgXnbUSZeH8VvboGv5TzFu/NvMsW41opJBZHY2i59p1VnNeE/M//yVMsd4c9raxc
         7rl4nzmFFnA5NraMm62brfl9p2ILwbqY4AQmo5Z+wdkt3vZA5JNvNWX7uU9/BcxVaeA0
         uKWFvdzxRhu67eJ3KCdmaZ8Wf1lFvtFSCobBriFnDvIfuGeAALeIXUi14WDqE4XynHKc
         4kEKfYH4TdVNCuXB2tHD3RVzgHqZi+AsV8Ni6pV23XVuLutcHRBPBb7QMQHZeQJ42PB/
         GddcX5haIY55dq0A+b48JZUnqLuj6Mb5yazxPXzRArZnqcAYzmVitfNM2Ipms8VEvue8
         2bog==
X-Received: by 10.202.49.131 with SMTP id x125mr4319065oix.17.1417644436741;
 Wed, 03 Dec 2014 14:07:16 -0800 (PST)
Received: by 10.202.48.207 with HTTP; Wed, 3 Dec 2014 14:06:56 -0800 (PST)
In-Reply-To: <CAO2U3QgDzDTt-zujw1yk51HFdp4oACusXeZ59h-CUgU41vgDHw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260701>

On Wed, Dec 3, 2014 at 2:00 PM, Michael Blume <blume.mike@gmail.com> wrote:
> On Wed, Dec 3, 2014 at 1:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>>> @@ -515,6 +517,9 @@ void http_cleanup(void)
>>>>                 cert_auth.password = NULL;
>>>>         }
>>>>         ssl_cert_password_required = 0;
>>>> +
>>>> +       if (cached_accept_language)
>>>> +               strbuf_release(cached_accept_language);
>>>
>>> Junio already mentioned that this is leaking the memory of the strbuf
>>> struct itself which was xmalloc()'d by get_accept_language().
>>
>> I actually didn't ;-)  A singleton cached_accept_language strbuf
>> itself being kept around, with its reuse by get_accept_language(),
>> is fine and is not a leak.  But clearing the strbuf alone will
>> introduce correctness problem---the second HTTP connection will see
>> an empty strbuf, get_accept_language() will say "we've already
>> computed and the header we must issue is an empty string", which is
>> not correct.
>>
>> In the fix-up "SQUASH???" commit I queued on top of this patch on
>> 'pu', I had to run "sort -u" on the output to the standard error
>> stream, as there seemed to be two HTTP connections and the actual
>> output had two headers, even though the test expected only one in
>> the output.  I suspect that it is a fallout from this bug that the
>> original code passed that test that expects only one.
>>
>>>> +static struct strbuf *get_accept_language(void)
>>>
>>> I find this API a bit strange. Use of strbuf to construct the returned
>>> string is an implementation detail of this function. From the caller's
>>> point of view, it should just be receiving a constant string: one
>>> which it needs neither to modify nor free. Also, if the caller were to
>>> modify the returned strbuf for some reason, then that modification
>>> would impact all future calls to get_accept_language() since the
>>> strbuf is 'static' and not recomputed. Instead, I would expect the
>>> declaration to be:
>>>
>>>     static const char *get_accept_language(void)
>>
>> Makes sense to me.
>>
>>>> +                       /* Put a q-factor only if it is less than 1.0. */
>>>> +                       if (q < max_q)
>>>> +                               strbuf_addf(cached_accept_language, q_format, q);
>>>> +
>>>> +                       if (q > 1)
>>>> +                               q--;
>>
>> I didn't mention this but if q ever goes below 1, wouldn't it mean
>> that there is no point continuing this loop?
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> This seems to be failing under Mac OS for me
>
> not ok 25 - git client sends Accept-Language based on LANGUAGE,
> LC_ALL, LC_MESSAGES and LANG
> #
> # check_language "ko-KR, *;q=0.1" ko_KR.UTF-8 de_DE.UTF-8 ja_JP.UTF-8
> en_US.UTF-8 &&
> # check_language "de-DE, *;q=0.1" ""          de_DE.UTF-8 ja_JP.UTF-8
> en_US.UTF-8 &&
> # check_language "ja-JP, *;q=0.1" ""          ""          ja_JP.UTF-8
> en_US.UTF-8 &&
> # check_language "en-US, *;q=0.1" ""          ""          ""
> en_US.UTF-8
> #


verbose results

Initialized empty Git repository in
/Users/Shared/Jenkins/Home/jobs/git/workspace/t/trash
directory.t5550-http-fetch-dumb/.git/
expecting success:
git config push.default matching &&
echo content1 >file &&
git add file &&
git commit -m one
echo content2 >file &&
git add file &&
git commit -m two

[master (root-commit) f5983e9] one
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
 create mode 100644 file
[master 2ff8a06] two
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+), 1 deletion(-)
ok 1 - setup repository

expecting success:
cp -R .git "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
(cd "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
git config core.bare true &&
mkdir -p hooks &&
echo "exec git update-server-info" >hooks/post-update &&
chmod +x hooks/post-update &&
hooks/post-update
) &&
git remote add public "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" &&
git push public master:master

Everything up-to-date
ok 2 - create http-accessible bare repository with loose objects

expecting success:
git clone $HTTPD_URL/dumb/repo.git clone-tmpl &&
cp -R clone-tmpl clone &&
test_cmp file clone/file

Cloning into 'clone-tmpl'...
ok 3 - clone http repository

expecting success:
mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/" &&
cp -Rf "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
      "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/repo.git"

ok 4 - create password-protected repository

expecting success:
write_script "$TRASH_DIRECTORY/askpass" <<-\EOF &&
echo >>"$TRASH_DIRECTORY/askpass-query" "askpass: $*" &&
case "$*" in
*Username*)
what=user
;;
*Password*)
what=pass
;;
esac &&
cat "$TRASH_DIRECTORY/askpass-$what"
EOF
GIT_ASKPASS="$TRASH_DIRECTORY/askpass" &&
export GIT_ASKPASS &&
export TRASH_DIRECTORY

ok 5 - setup askpass helper

expecting success:
set_askpass wrong &&
test_must_fail git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-fail &&
expect_askpass both wrong

Cloning into 'clone-auth-fail'...
fatal: Authentication failed for 'http://127.0.0.1:5550/auth/dumb/repo.git/'
ok 6 - cloning password-protected repository can fail

expecting success:
set_askpass wrong &&
git clone "$HTTPD_URL_USER_PASS/auth/dumb/repo.git" clone-auth-none &&
expect_askpass none

Cloning into 'clone-auth-none'...
ok 7 - http auth can use user/pass in URL

expecting success:
set_askpass wrong pass@host &&
git clone "$HTTPD_URL_USER/auth/dumb/repo.git" clone-auth-pass &&
expect_askpass pass user@host

Cloning into 'clone-auth-pass'...
ok 8 - http auth can use just user in URL

expecting success:
set_askpass user@host pass@host &&
git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-both &&
expect_askpass both user@host

Cloning into 'clone-auth-both'...
ok 9 - http auth can request both user and pass

expecting success:
test_config_global credential.helper "!f() {
cat >/dev/null
echo username=user@host
echo password=pass@host
}; f" &&
set_askpass wrong &&
git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-helper &&
expect_askpass none

Cloning into 'clone-auth-helper'...
ok 10 - http auth respects credential helper config

expecting success:
test_config_global "credential.$HTTPD_URL.username" user@host &&
set_askpass wrong pass@host &&
git clone "$HTTPD_URL/auth/dumb/repo.git" clone-auth-user &&
expect_askpass pass user@host

Cloning into 'clone-auth-user'...
ok 11 - http auth can get username from config

expecting success:
test_config_global "credential.$HTTPD_URL.username" wrong &&
set_askpass wrong pass@host &&
git clone "$HTTPD_URL_USER/auth/dumb/repo.git" clone-auth-user2 &&
expect_askpass pass user@host

Cloning into 'clone-auth-user2'...
ok 12 - configured username does not override URL

expecting success:
echo content >>file &&
git commit -a -m two &&
git push public &&
(cd clone && git pull) &&
test_cmp file clone/file

[master d4af499] two
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
To /Users/Shared/Jenkins/Home/jobs/git/workspace/t/trash
directory.t5550-http-fetch-dumb/httpd/www/repo.git
   2ff8a06..d4af499  master -> master
From http://127.0.0.1:5550/dumb/repo
   2ff8a06..d4af499  master     -> origin/master
Updating 2ff8a06..d4af499
Fast-forward
 file | 1 +
 1 file changed, 1 insertion(+)
ok 13 - fetch changes via http

expecting success:
cp -R clone-tmpl clone2 &&

HEAD=$(git rev-parse --verify HEAD) &&
(cd clone2 &&
git http-fetch -a -w heads/master-new $HEAD $(git config remote.origin.url) &&
git checkout master-new &&
test $HEAD = $(git rev-parse --verify HEAD)) &&
test_cmp file clone2/file

Switched to branch 'master-new'
ok 14 - fetch changes via manual http-fetch

expecting success:
git push public master:other &&
(cd clone &&
git remote set-head origin -d &&
git remote set-head origin -a &&
git symbolic-ref refs/remotes/origin/HEAD > output &&
echo refs/remotes/origin/master > expect &&
test_cmp expect output
)

To /Users/Shared/Jenkins/Home/jobs/git/workspace/t/trash
directory.t5550-http-fetch-dumb/httpd/www/repo.git
 * [new branch]      master -> other
origin/HEAD set to master
ok 15 - http remote detects correct HEAD

expecting success:
cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo.git
"$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git &&
git --bare repack -a -d
) &&
git clone $HTTPD_URL/dumb/repo_pack.git

Cloning into 'repo_pack'...
ok 16 - fetch packed objects

expecting success:
cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git
"$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
p=`ls objects/pack/pack-*.pack` &&
chmod u+w $p &&
printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
) &&
mkdir repo_bad1.git &&
(cd repo_bad1.git &&
git --bare init &&
test_must_fail git --bare fetch $HTTPD_URL/dumb/repo_bad1.git &&
test 0 = `ls objects/pack/pack-*.pack | wc -l`
)

1+0 records in
1+0 records out
256 bytes transferred in 0.000014 secs (18512790 bytes/sec)
Initialized empty Git repository in
/Users/Shared/Jenkins/Home/jobs/git/workspace/t/trash
directory.t5550-http-fetch-dumb/repo_bad1.git/
fatal: pack has bad object at offset 168: inflate returned -5
error: Unable to find d4af499a00b28bc0ab78fa94cc6a449fae19b08d under
http://127.0.0.1:5550/dumb/repo_bad1.git
Cannot obtain needed object d4af499a00b28bc0ab78fa94cc6a449fae19b08d
error: fetch failed.
ls: objects/pack/pack-*.pack: No such file or directory
ok 17 - fetch notices corrupt pack

expecting success:
cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git
"$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
p=`ls objects/pack/pack-*.idx` &&
chmod u+w $p &&
printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
) &&
mkdir repo_bad2.git &&
(cd repo_bad2.git &&
git --bare init &&
test_must_fail git --bare fetch $HTTPD_URL/dumb/repo_bad2.git &&
test 0 = `ls objects/pack | wc -l`
)

1+0 records in
1+0 records out
256 bytes transferred in 0.000013 secs (19522579 bytes/sec)
Initialized empty Git repository in
/Users/Shared/Jenkins/Home/jobs/git/workspace/t/trash
directory.t5550-http-fetch-dumb/repo_bad2.git/
error: non-monotonic index
/Users/Shared/Jenkins/Home/jobs/git/workspace/t/trash
directory.t5550-http-fetch-dumb/repo_bad2.git/objects/pack/pack-7244949d8d6e59a30923b3fff7801f159ef4ba5d.idx.temp
error: Unable to find d4af499a00b28bc0ab78fa94cc6a449fae19b08d under
http://127.0.0.1:5550/dumb/repo_bad2.git
Cannot obtain needed object d4af499a00b28bc0ab78fa94cc6a449fae19b08d
error: fetch failed.
ok 18 - fetch notices corrupt idx

expecting success:
grep /git-upload-pack <"$HTTPD_ROOT_PATH"/access.log >act
: >exp
test_cmp exp act

ok 19 - did not use upload-pack service

expecting success:
test_must_fail git clone "$HTTPD_URL/error/text" 2>stderr &&
grep "this is the error message" stderr

remote: this is the error message
ok 20 - git client shows text/plain errors

expecting success:
test_must_fail git clone "$HTTPD_URL/error/html" 2>stderr &&
! grep "this is the error message" stderr

ok 21 - git client does not show html errors

expecting success:
test_must_fail git clone "$HTTPD_URL/error/charset" 2>stderr &&
grep "this is the error message" stderr

remote: this is the error message
ok 22 - git client shows text/plain with a charset

expecting success:
test_must_fail git clone "$HTTPD_URL/error/utf16" 2>stderr &&
grep "this is the error message" stderr

remote: this is the error message
ok 23 - http error messages are reencoded

expecting success:
test_must_fail git clone "$HTTPD_URL/error/odd-spacing" 2>stderr &&
grep "this is the error message" stderr

remote: this is the error message
ok 24 - reencoding is robust to whitespace oddities

expecting success:
check_language "ko-KR, *;q=0.1" ko_KR.UTF-8 de_DE.UTF-8 ja_JP.UTF-8
en_US.UTF-8 &&
check_language "de-DE, *;q=0.1" ""          de_DE.UTF-8 ja_JP.UTF-8
en_US.UTF-8 &&
check_language "ja-JP, *;q=0.1" ""          ""          ja_JP.UTF-8
en_US.UTF-8 &&
check_language "en-US, *;q=0.1" ""          ""          ""          en_US.UTF-8

not ok 25 - git client sends Accept-Language based on LANGUAGE,
LC_ALL, LC_MESSAGES and LANG
#
# check_language "ko-KR, *;q=0.1" ko_KR.UTF-8 de_DE.UTF-8 ja_JP.UTF-8
en_US.UTF-8 &&
# check_language "de-DE, *;q=0.1" ""          de_DE.UTF-8 ja_JP.UTF-8
en_US.UTF-8 &&
# check_language "ja-JP, *;q=0.1" ""          ""          ja_JP.UTF-8
en_US.UTF-8 &&
# check_language "en-US, *;q=0.1" ""          ""          ""
en_US.UTF-8
#

expecting success:
check_language "ko-KR, en-US;q=0.99, fr-CA;q=0.98, de;q=0.97, sr;q=0.96, \
ja;q=0.95, zh;q=0.94, sv;q=0.93, pt;q=0.92, nb;q=0.91, *;q=0.01" \
ko_KR.EUC-KR:en_US.UTF-8:fr_CA:de.UTF-8@euro:sr@latin:ja:zh:sv:pt:nb

ok 26 - git client sends Accept-Language with many preferred languages

expecting success:
GIT_CURL_VERBOSE=1 LANGUAGE= git ls-remote "$HTTPD_URL/dumb/repo.git"
2>stderr &&
! grep "^Accept-Language:" stderr

d4af499a00b28bc0ab78fa94cc6a449fae19b08d HEAD
d4af499a00b28bc0ab78fa94cc6a449fae19b08d refs/heads/master
d4af499a00b28bc0ab78fa94cc6a449fae19b08d refs/heads/other
ok 27 - git client does not send an empty Accept-Language

# failed 1 among 27 test(s)
1..27

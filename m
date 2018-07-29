Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6EA3208E9
	for <e@80x24.org>; Sun, 29 Jul 2018 19:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeG2VST (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Jul 2018 17:18:19 -0400
Received: from felt-1.demon.nl ([80.101.98.107]:33328 "EHLO felt.demon.nl"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726785AbeG2VST (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jul 2018 17:18:19 -0400
Received: from [192.168.129.4] (x004.home.local [192.168.129.4])
        by felt.demon.nl (AIX7.1/8.14.4/8.14.4) with ESMTP id w6TJkcmn14286872;
        Sun, 29 Jul 2018 19:46:38 GMT
Subject: Re: git broken for AIX somewhere between 2.13.2 and 2.13.3
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <fb935882-25b1-db5f-d765-50dab297f733@felt.demon.nl>
 <20180729181006.GC945730@genre.crustytoothpaste.net>
From:   Michael <aixtools@felt.demon.nl>
Message-ID: <466c7a59-0535-e72c-6c90-5288a53b59a0@felt.demon.nl>
Date:   Sun, 29 Jul 2018 21:46:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180729181006.GC945730@genre.crustytoothpaste.net>
Content-Type: multipart/alternative;
 boundary="------------124671E08FE0208FF4785888"
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a multi-part message in MIME format.
--------------124671E08FE0208FF4785888
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29/07/2018 20:10, brian m. carlson wrote:
> On Sun, Jul 29, 2018 at 06:44:26PM +0200, Michael wrote:
>> root@x066:[/tmp/xxx]git --version
>> git version 2.13.3
>> root@x066:[/tmp/xxx]git clone git@github.com:aixtools/hello-world.git
>> Cloning into 'hello-world'...
>> remote: Counting objects: 3, done.
>> remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 3
>> Receiving objects: 100% (3/3), done.
>> fatal: pack is corrupted (SHA1 mismatch)
>> fatal: index-pack failed
>>
>> p.s. - what surprises me re: git-2.13.2 - no messages about 'Cloning into
>> ...', which version 2.13.1 did give.
>>
>> I guess a bisect is the next step - between version 2.13.2 and 2.13.3. Other
>> suggestions welcome!
> Are you using SHA1DC on that system, and does compiling with another
> SHA-1 implementation help?  There was a change to the SHA1DC code big
> endian detection in that commit, which might be the cause of your
> problems if you're using a POWER or PowerPC system.

I was thinking it might be an 'endian' issue. So, yes - AIX runs on 
POWER, only as BigEndian.

git bisect returns:

michael@x071:[/data/prj/aixtools/git/github/git-master]git bisect bad
Bisecting: 1 revision left to test after this (roughly 1 step)
[35049a2343948f686861e176a8c395f9f67da7b6] Merge branch 
'aw/contrib-subtree-doc-asciidoctor' into maint
michael@x071:[/data/prj/aixtools/git/github/git-master]git bisect good
Bisecting: 0 revisions left to test after this (roughly 0 steps)
[9936c1b52a39fa14fca04f937df3e75f7498ac66] sha1dc: update from upstream


michael@x071:[/data/prj/aixtools/git/github/git-master]git bisect bad
9936c1b52a39fa14fca04f937df3e75f7498ac66 is the first bad commit
commit 9936c1b52a39fa14fca04f937df3e75f7498ac66
Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Date:   Sat Jul 1 22:05:45 2017 +0000

     sha1dc: update from upstream

     Update sha1dc from the latest version by the upstream maintainer[1].

     See commit 6b851e536b ("sha1dc: update from upstream", 2017-06-06) for
     the last update.

     This solves the Big Endian detection on Solaris reported against
     v2.13.2[2], hopefully without any regressions. A version of this has
     been tested on two Solaris SPARC installations, Cygwin (by jturney on
     cygwin@Freenode), and on numerous more boring systems (mainly
     linux/x86_64). See [3] for a discussion of the implementation and
     platform-specific issues.

     See commit a0103914c2 ("sha1dc: update from upstream", 2017-05-20) and
     6b851e536b ("sha1dc: update from upstream", 2017-06-06) for previous
     attempts in the 2.13 series to address various compile-time feature
     detection in this library.

     1. 
https://github.com/cr-marcstevens/sha1collisiondetection/commit/19d97bf5af05312267c2e874ee6bcf584d9e9681 

     2. 
<CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
(https://public-inbox.org/git/CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com/) 

     3. https://github.com/cr-marcstevens/sha1collisiondetection/pull/34

     Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     Signed-off-by: Junio C Hamano <gitster@pobox.com>

:040000 040000 a84797967fb742e4ca9618a641d53ce3a6c6589b 
32efa656d78901da961e4a47d84b6d82fede064b M      sha1dc


--------------124671E08FE0208FF4785888
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">On 29/07/2018 20:10, brian m. carlson
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20180729181006.GC945730@genre.crustytoothpaste.net">
      <pre wrap="">On Sun, Jul 29, 2018 at 06:44:26PM +0200, Michael wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">root@x066:[/tmp/xxx]git --version
git version 2.13.3
root@x066:[/tmp/xxx]git clone <a class="moz-txt-link-abbreviated" href="mailto:git@github.com:aixtools/hello-world.git">git@github.com:aixtools/hello-world.git</a>
Cloning into 'hello-world'...
remote: Counting objects: 3, done.
remote: Total 3 (delta 0), reused 0 (delta 0), pack-reused 3
Receiving objects: 100% (3/3), done.
fatal: pack is corrupted (SHA1 mismatch)
fatal: index-pack failed

p.s. - what surprises me re: git-2.13.2 - no messages about 'Cloning into
...', which version 2.13.1 did give.

I guess a bisect is the next step - between version 2.13.2 and 2.13.3. Other
suggestions welcome!
</pre>
      </blockquote>
      <pre wrap="">
Are you using SHA1DC on that system, and does compiling with another
SHA-1 implementation help?  There was a change to the SHA1DC code big
endian detection in that commit, which might be the cause of your
problems if you're using a POWER or PowerPC system.
</pre>
    </blockquote>
    <p>I was thinking it might be an 'endian' issue. So, yes - AIX runs
      on POWER, only as BigEndian.
      <br>
      <br>
      git bisect returns:
      <br>
      <br>
      michael@x071:[/data/prj/aixtools/git/github/git-master]git bisect
      bad
      <br>
      Bisecting: 1 revision left to test after this (roughly 1 step)
      <br>
      [35049a2343948f686861e176a8c395f9f67da7b6] Merge branch
      'aw/contrib-subtree-doc-asciidoctor' into maint
      <br>
      michael@x071:[/data/prj/aixtools/git/github/git-master]git bisect
      good
      <br>
      Bisecting: 0 revisions left to test after this (roughly 0 steps)
      <br>
      [9936c1b52a39fa14fca04f937df3e75f7498ac66] sha1dc: update from
      upstream
      <br>
      <br>
      <br>
      michael@x071:[/data/prj/aixtools/git/github/git-master]git bisect
      bad
      <br>
      9936c1b52a39fa14fca04f937df3e75f7498ac66 is the first bad commit
      <br>
      commit 9936c1b52a39fa14fca04f937df3e75f7498ac66
      <br>
      Author: Ævar Arnfjörð Bjarmason <a class="moz-txt-link-rfc2396E"
        href="mailto:avarab@gmail.com">&lt;avarab@gmail.com&gt;</a>
      <br>
      Date:   Sat Jul 1 22:05:45 2017 +0000
      <br>
      <br>
          sha1dc: update from upstream
      <br>
      <br>
          Update sha1dc from the latest version by the upstream
      maintainer[1].
      <br>
      <br>
          See commit 6b851e536b ("sha1dc: update from upstream",
      2017-06-06) for
      <br>
          the last update.
      <br>
      <br>
          This solves the Big Endian detection on Solaris reported
      against
      <br>
          v2.13.2[2], hopefully without any regressions. A version of
      this has
      <br>
          been tested on two Solaris SPARC installations, Cygwin (by
      jturney on
      <br>
          cygwin@Freenode), and on numerous more boring systems (mainly
      <br>
          linux/x86_64). See [3] for a discussion of the implementation
      and
      <br>
          platform-specific issues.
      <br>
      <br>
          See commit a0103914c2 ("sha1dc: update from upstream",
      2017-05-20) and
      <br>
          6b851e536b ("sha1dc: update from upstream", 2017-06-06) for
      previous
      <br>
          attempts in the 2.13 series to address various compile-time
      feature
      <br>
          detection in this library.
      <br>
      <br>
          1. <a class="moz-txt-link-freetext"
href="https://github.com/cr-marcstevens/sha1collisiondetection/commit/19d97bf5af05312267c2e874ee6bcf584d9e9681">https://github.com/cr-marcstevens/sha1collisiondetection/commit/19d97bf5af05312267c2e874ee6bcf584d9e9681</a>
      <br>
          2. <a class="moz-txt-link-rfc2396E"
href="mailto:CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com">&lt;CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com&gt;</a>
      <br>
      (<a class="moz-txt-link-freetext"
href="https://public-inbox.org/git/CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com/">https://public-inbox.org/git/CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com/</a>)
      <br>
          3. <a class="moz-txt-link-freetext"
        href="https://github.com/cr-marcstevens/sha1collisiondetection/pull/34">https://github.com/cr-marcstevens/sha1collisiondetection/pull/34</a>
      <br>
      <br>
          Signed-off-by: Ævar Arnfjörð Bjarmason <a
        class="moz-txt-link-rfc2396E" href="mailto:avarab@gmail.com">&lt;avarab@gmail.com&gt;</a>
      <br>
          Signed-off-by: Junio C Hamano <a
        class="moz-txt-link-rfc2396E" href="mailto:gitster@pobox.com">&lt;gitster@pobox.com&gt;</a>
      <br>
      <br>
      :040000 040000 a84797967fb742e4ca9618a641d53ce3a6c6589b
      32efa656d78901da961e4a47d84b6d82fede064b M      sha1dc
      <br>
      <br>
    </p>
  </body>
</html>

--------------124671E08FE0208FF4785888--

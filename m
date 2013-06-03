From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (May 2013, #09; Wed, 29)
Date: Mon, 03 Jun 2013 23:47:23 +0200
Message-ID: <51AD0EEB.4020106@web.de>
References: <7va9ndqqyf.fsf@alter.siamese.dyndns.org> <51A7A73C.6070103@web.de> <20130531194051.GC1072@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Tue Jun 04 00:00:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ujcnp-0003m5-Le
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 00:00:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758444Ab3FCWAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 18:00:30 -0400
Received: from mout.web.de ([212.227.15.14]:53317 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752412Ab3FCWA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 18:00:28 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jun 2013 18:00:28 EDT
Received: from [192.168.178.41] ([91.3.151.162]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0Ljamy-1U8Ltz1lii-00c4KE; Mon, 03 Jun 2013 23:47:23
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <20130531194051.GC1072@serenity.lan>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:B2/s4LDAnQMx9JiNpE6blZyTSZelP0XAn64b7xT9wCz
 PurtlgVxtBH8VLvbIZo72f4g9XeI50sZBmBvfv26m4gGu9A+bD
 Ahn/Ytd7gRKDN0mB7A1APVIJAzF9M68iTwjj44YJpI9LV00ZhH
 KxKnale8Tbp5K8KWz9FaUnGQNSo7Lo/6nXqS/S05LViKpRUlnP
 wj45A40agvh9dXxgfJexw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226297>

Am 31.05.2013 21:40, schrieb John Keeping:
> On Thu, May 30, 2013 at 09:23:40PM +0200, Jens Lehmann wrote:
>> Am 30.05.2013 01:58, schrieb Junio C Hamano:
>>> * jk/submodule-subdirectory-ok (2013-04-24) 3 commits
>>>   (merged to 'next' on 2013-04-24 at 6306b29)
>>>  + submodule: fix quoting in relative_path()
>>>   (merged to 'next' on 2013-04-22 at f211e25)
>>>  + submodule: drop the top-level requirement
>>>  + rev-parse: add --prefix option
>>>
>>>  Allow various subcommands of "git submodule" to be run not from the
>>>  top of the working tree of the superproject.
>>
>> The summary and status commands are looking good in this version
>> (they are now showing the submodule directory paths relative to
>> the current directory). Apart from that my other remarks from
>> gmane $221575 still seem to apply. And this series has only tests
>> for status, summary and add (and that just with an absolute URL),
>> I'd rather like to see a test for each submodule command (and a
>> relative add to) to document the desired behavior.
> 
> To summarize what I think are the outstanding issues from your email:
> 
> * Should '$sm_path' be relative in "submodule foreach"?
> * "submodule add" with a relative path
> * "submodule init" initializes all submodules
> * Tests
> 
> The current version does make '$sm_path' relative in "submodule
> foreach", although it's hard to spot because we have to leave doing so
> until right before the "eval".

Yes. If I read the code correctly the submodule is cd'ed in before
the foreach command is executed, so $sm_path should only be used for
displaying info about where the command is executed anyway. Looks
like your code is doing the right thing adjusting $sm_path to be
relative to the directory the user is in. But a test showing that
would really be nice ;-)

> I'm not sure what you mean about "submodule add" - the new version
> treats the "path" argument as relative (providing it is not an absolute
> path).  The "repository" argument is not changed by running from a
> subdirectory but I think that's correct since it is documented as being
> relative to the superproject's origin repository.

Sorry, I should have been more specific here. I saw that you did some
changes to make "submodule add" do the right thing with relative paths,
but the following change to t7406 does not work like I believe it
should but instead makes the test fail:
-------------------8<---------------------
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index a4ffea0..9766b9e 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -559,7 +559,9 @@ test_expect_success 'add different submodules to the same pa
 test_expect_success 'submodule add places git-dir in superprojects git-dir' '
        (cd super &&
         mkdir deeper &&
-        git submodule add ../submodule deeper/submodule &&
+        (cd deeper &&
+         git submodule add ../../submodule submodule
+        ) &&
         (cd deeper/submodule &&
          git log > ../../expected
         ) &&
-------------------8<---------------------

> "submodule init" is behaving in the same way as "deinit" - if you say
> "submodule init ." then it will only initialize submodules below the
> current directory.  The difference is that "deinit" dies if it is not
> given any arguments whereas "init" will initialize everything from the
> top level down.  I'm not sure whether to change this; given the
> direction "git add -u" is heading in for 2.0 I think the current
> behaviour is the most consistent with the rest of Git.

I meant that both commands still print the submodule names from the
top-level directory, not the one the user is in.

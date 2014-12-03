From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] t/lib-gpg: adjust permissions for gnupg 2.1
Date: Wed, 03 Dec 2014 12:23:36 +0100
Message-ID: <547EF2B8.3020106@drmicha.warpmail.net>
References: <547DB6C3.5010704@drmicha.warpmail.net> <9c28f16c677bbc774e5b8dfc79b6ffe2c55d1720.1417527514.git.git@drmicha.warpmail.net> <20141202210753.GD23461@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 03 12:23:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xw823-0005qd-0X
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 12:23:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbaLCLXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 06:23:39 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59436 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750815AbaLCLXi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2014 06:23:38 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id DAC702093F
	for <git@vger.kernel.org>; Wed,  3 Dec 2014 06:23:37 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute4.internal (MEProxy); Wed, 03 Dec 2014 06:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=Q2DU7AEb9AZM3NpmGbNW1e
	XQX7I=; b=Hkm7MJHFHXkxRFn9v8nUy2sAhWq8i5dnD4ajh2EhZTqrD6jUXHCMUa
	Kolfu6fx4p8jDt40kqrYUI0pA7aRX0sMWMu9flly5HpMZat1IhFW6G+0iusAk15R
	Hwlnm+YNPMeUdqKFPC/3byP4n1B5z5ZYKH3l36zKPRosAKSorXGzE=
X-Sasl-enc: tW7zRG0vIvRdFE72n2KsUf6ZiC74+f+1tvffTU+LnT36 1417605817
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4F50568011E;
	Wed,  3 Dec 2014 06:23:37 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <20141202210753.GD23461@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260644>

Jeff King schrieb am 02.12.2014 um 22:07:
> On Tue, Dec 02, 2014 at 02:40:27PM +0100, Michael J Gruber wrote:
> 
>> Before gnupg 2.1 (aka "modern branch"), gpghome would contain only files
>> which allowed t/lib-gpg.sh to set permissions explicitely, and we did
>> that since
>> 28a1b07 (t/lib-gpg: adjust permissions for gnupg 2.1, 2014-12-02)
>> in order to adjust wrong permissions from a checkout on ro file systems.
> 
> I think this 28a1b07 is wrong. Did you mean e7f224f?

Ouch, I'm afraid I got that from my copy of the commit. After all, there
is some truth in the patch/apply vs. push/pull-merge workflow discussion...

>> gnupg 2.1 creates a new directory in gpghome which would get its x bit removed.
> 
> Thanks for digging in this. The story is a little more tricky, though,
> and I do not think this patch is strictly necessary.
> 
> We copy lib-gpg/* to the trash directory, and only run gpg on it there.
> So it is there that gpg2.1 will munge the files, _after_ we have
> copied and done our chmod. And that works fine with the current code.

Right. I should'nt draft patches when I don't have gpg2.1...

> The problem came when I was trying to test/debug, and outside of the
> tests did "cd lib-gpg && gpg2 ...". That munged my lib-gpg directory,
> and the resulting breakage was copied into each subsequent trash
> directory.
> 
> So while your patch is not necessary, it is a nice defense against this
> sort of manual munging, or against future patches which add more
> directories. But...
> 
>> Adjust and use +X so that any directory would get its x bit set. This
>> also keeps the x bit on files which had it set for whatever wrong
>> reason, but we care only about having at least the necessary
>> permissions for the tests to run.
> 
> Taking a step back, though, I am not sure I understand the reasoning
> behind the original e7f224f. The rationale in the commit message is that
> we want to make sure that the files are writable. But why would they not
> be? They are created by "cp -R", so unless your umask does not allow the
> owner to write to the files, they should be writable, no? And if your
> umask is set that way, lots of things are going to break.

IIRC: We had reports about some ro checkouts where the tests went wrong.
I.e., the git.git checkout was on a ro file system, and the cp somehow
created ro files in the tmp. Or was it the archive/pax issue?

In any case, we need writable gpghome (and contents), and the original
patch ensured that.

> And indeed, if I remove the chmods completely, like:
> 
> diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
> index cd2baef..6ee4bb6 100755
> --- a/t/lib-gpg.sh
> +++ b/t/lib-gpg.sh
> @@ -17,8 +17,6 @@ else
>  		# Name and email: C O Mitter <committer@example.com>
>  		# No password given, to enable non-interactive operation.
>  		cp -R "$TEST_DIRECTORY"/lib-gpg ./gpghome
> -		chmod 0700 gpghome
> -		chmod 0600 gpghome/*
>  		GNUPGHOME="$(pwd)/gpghome"
>  		export GNUPGHOME
>  		test_set_prereq GPG
> 
> the tests run fine for me. What am I missing?

You messed with the wrong parts in gpghome :)

> I do think the original "0700" chmod _is_ useful, though. But not
> because it makes sure things are writable, but because it makes sure
> that it is _not_ world-readable. GPG complains about the lax permissions
> (of course it does not know that the keyrings are not really secrets in
> this case). However, this does not actually prevent the tests from
> running successfully.
> 
> So from my perspective, the simplest thing is to keep the original
> "chmod 0700" for that reason (or make it "chmod go-rwx", if you like),
> and drop the inner chmod completely (effectively reverting e7f224f). But
> again, perhaps there is some case that it covers that I do not
> understand.
> 
> -Peff
> 

I would say the "modern branch" of gpg2.1 is still a bit unstable. If
the tests do run with it (as they seem to do, unless you mess with the
source of the cp) there are no permission fixes to do.

Orthogonal to that is the pinentry issue: I haven't checked whether
gpg2.1 asking for passphrases on passphrase-less secure keys is to be
fixed on the gpg side. If yes, I would just wait for that since gpg2.1
is not common yet.

If not, we should provide (in gpg config) an alternative pinentry that
just returns an empty passphrase without bugging the user.

Michael

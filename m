From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 20:00:47 +0530
Message-ID: <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com> <87ppxmogdv.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 22 16:31:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUHmM-00017n-9G
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 16:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755226Ab3DVOb3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 10:31:29 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:63351 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754222Ab3DVOb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 10:31:28 -0400
Received: by mail-ie0-f179.google.com with SMTP id 16so7143026iea.10
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=sEHWmrsi3cv7O2HqrAeUIb0sRbusb5HdwEiZXAfK4sw=;
        b=BgvcsyP9EDaA2L7HLg0VJIVXvcX3A5dKZfPCSOLT3TgnhyJaescXZ7PAyL62+lD+k9
         BJrkalEyC5A/JqmtGxDozkzXWWumI61Y38hBhLmiNYUVY+QbaQqGtvIZNdpIhL/jfvP5
         3XoISAf/LAuW9XeL91gzPKETJozZknMb+Fu4/Be1yZRE3Q2o+FGqw/R7wur/rpOuNJow
         fSdItTH64vAsVB8LYKiV8FE5SApkKZcGtsBrem1oRQXYxzR3h1aPuFOf5++csvPfY1Ee
         WyaQ18DIXMoZxfXlGAdSyWLXERXY77Hi/eYzVoFrfIpnYoKD7Bj/CnShCWyhQ8kn9+Hn
         L5GA==
X-Received: by 10.50.50.71 with SMTP id a7mr21413565igo.14.1366641087779; Mon,
 22 Apr 2013 07:31:27 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 07:30:47 -0700 (PDT)
In-Reply-To: <87ppxmogdv.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222017>

Thomas Rast wrote:
> [...]

I think you've misunderstood the whole thing.  The histories of M^1
and M^2 are completely unrelated: they're from different projects
altogether.  Considering the /ichi in M^2 a "rename" of the /ichi in
M^1 is completely wrong.  They have nothing to do with each other.  I
intentionally named it "ichi" in my orphan branch just to drive my
point.  I suspect you've got confused because I used an orphan branch
to emulate a different project's history.  If you want an end-user
understanding of the problem, use git subtree:

    $ cd /tmp
    $ git clone gh:artagnon/varlog
    $ cd varlog
    $ git subtree add --prefix=clayoven \
       gh:artagnon/clayoven master
    $ cd clayoven
    $ git log README.md

What do you expect?  The same output you would get if you cloned
gh:artagnon/clayoven separately and executed 'git log README.md' on
it.

Now, clayoven's README.md (the one in HEAD^2) has nothing to do with
varlog's README.md (the one in HEAD^1).  It's just incidental that
both projects have a README.md.  I repeat: clayoven and varlog have
_nothing_ to do with each other.  If I say git log --follow README.md
in the above example, I don't even get the HEAD commit.  And I
wouldn't expect to either.

I will repeat this: --follow has nothing to do with the problem I've
specified.  And it is not tied to "renaming" (ie. changing the
name/path of a file) as you've made it look.  If you're still not
convinced, I've included a testcase for --follow "following" over a
merge commit (include it after the --follow test in the t4202).  Try
it without the --follow and you'll see what I mean.  Neither the
filename nor the filepath of ichi has changed in this example.

-- 8< --
test_expect_success '--follow over merge' '
	git checkout -b featurebranch
	echo foodle >>ichi &&
	git add ichi &&
	test_tick &&
	git commit -m "add a line to the end of ichi" &&
	echo moodle >unrelated &&
	git add unrelated &&
	test_tick &&
	git commit -m quux &&
	git checkout master &&
	mv ichi ichi.bak &&
	echo gooble >ichi &&
	cat ichi.bak >>ichi &&
	git add ichi &&
	test_tick &&
	git commit -m "add a line to the beginning of ichi" &&
	git merge featurebranch &&
	git log --follow --oneline ichi >actual &&
	cat >expect <<-\EOF &&
	df26551 add a line to the beginning of ichi
	882d8d9 add a line to the end of ichi
	2fbe8c0 third
	f7dab8e second
	3a2fdcb initial
	EOF
	test_cmp expect actual
'

From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 01/12] tests: add initial bash completion tests
Date: Sun, 8 Apr 2012 05:30:02 -0500
Message-ID: <20120408103002.GA3177@burratino>
References: <1333854479-23260-1-git-send-email-felipe.contreras@gmail.com>
 <1333854479-23260-2-git-send-email-felipe.contreras@gmail.com>
 <20120408050140.GA5862@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Apr 08 12:30:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGpNz-0005Bw-I5
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 12:30:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755221Ab2DHKaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Apr 2012 06:30:12 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33700 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755109Ab2DHKaL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Apr 2012 06:30:11 -0400
Received: by iagz16 with SMTP id z16so4800292iag.19
        for <git@vger.kernel.org>; Sun, 08 Apr 2012 03:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=+oIy2qdVVWXpxYfaGR2ZAhnyGGKsk4auSsrkZAx09Qg=;
        b=aqfI4AWM2fD+q9RJJX5f1cDfEC9ZtE0OkbfV7zXLy3DWt46uZ4AE7eRgiFFx97o6L8
         VyQ1EqpwSzBR6oDJGi3H8iaDh3l8j/H4cX8/83p1qzRKuAcSN+hhpCBt0OW8e9CYMjgz
         ZoISSwaegcd4oUD6slWv/ZaFbRaGuZYVlIeSEGp2uukgF+xxQlhF8zfywWpKGpAW1Gae
         U0ycvIxnBfW6V5UsyEq3Uh202oHiov8vFFgYl6lQR27avSRgGW0TiXK1aqCz4OhAbr36
         XrLNnuE/90lWaGx+mo3dABul/s+UE7N9803/kXkTuhYTpNU+PeWCh8iJgI2XQx7NvO/N
         Y9sQ==
Received: by 10.50.89.168 with SMTP id bp8mr2555300igb.3.1333881010690;
        Sun, 08 Apr 2012 03:30:10 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id kn3sm11060092igc.15.2012.04.08.03.30.09
        (version=SSLv3 cipher=OTHER);
        Sun, 08 Apr 2012 03:30:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120408050140.GA5862@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194989>

(dropping Shawn from cc list since he hasn't been working on the
 completion script for a couple of years now)
Jeff King wrote:
> On Sun, Apr 08, 2012 at 06:07:48AM +0300, Felipe Contreras wrote:

>> +	cat >expected <<-\EOF &&
>> +	fetch 
>> +	filter-branch 
>> +	filter-branch.sh 
>> +	format-patch 
>> +	fsck 
>> +	EOF
>> +	test_completion "git f"
>
> This test fails for me. The problem is that I have other git-f* programs
> in my PATH
[...]
>                                     We can't just sanitize the PATH in
> test-lib.sh, since those git programs might be in /usr/bin or some other
> directory containing other commands necessary to run the test suite. We
> could sanitize it temporarily just for the _git completion invocation,
> which consists only of builtins (and we know we're running under bash,
> so we can trust that things like "test" are builtins). But it still
> feels horribly hacky.

Not to mention that it would break the TEST_INSTALLED_GIT facility.

Is there some reason we care about the exact list of completions for
"git f"?  The above also looks a little bogus because if someone were
to remove the +x bit on the git-filter-branch.sh source file or ensure
it is not on the PATH when tests are run (I have no particular opinion
about whether that's a good idea; it's just an example) then this
would change the actual output.  That doesn't seem particularly
important to check for when talking about how the tab completion
behaves on the installed system.

Maybe it would make sense to check a few representative items.

	# builtin
	grep "^fetch\$" out &&

	# builtin whose implementation is not in builtin/cmd.c
	grep "^format-patch\$" out &&

	# script
	grep "^filter-branch\$" out &&

	# plumbing
	! grep "^fsck-objects\$" out &&

	sort out >out.sorted &&
	test_cmp out.sorted out

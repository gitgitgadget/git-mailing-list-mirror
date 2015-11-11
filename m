From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Wed, 11 Nov 2015 09:02:52 +0100
Message-ID: <5C9FC321-5B5E-47E6-9BCE-6CDAA41D6E54@gmail.com>
References: <56428A6A.5010406@ramsayjones.plus.com> <CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com> <CAGZ79kb1pDhcP+hN9+C0xK-VYKxfnhvj6a2Len6kOWgmv4+fmQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 09:03:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwQMu-000708-M4
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 09:03:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbbKKIC4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 03:02:56 -0500
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36778 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752131AbbKKICz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2015 03:02:55 -0500
Received: by wmww144 with SMTP id w144so148981013wmw.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 00:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=42YFUX/ZMMuhCJIJVtFzjxwFDYPP8/YcVqF0tOG4/dc=;
        b=p1i1D5BAK7IbzO0ARZmLwsix8IBOOvjDQYK/wGMZJmwsEhz+Wor+rjq3Ml1UFMcJ8k
         kf0xcrYPnefHZfm+pqQqO4NfnVTUdy3XGNMmjLmLRpNoKP/0+Hi5WDXEMrU6kUgsYNUb
         cQ9IkGgCiFxEA9V0dyLyzKRJQuDsSh8uNDeArfJfrnYBpvPmDtkeMCYwB1NMa5CSE/eL
         n570FZlEb/B2m2dGBS00LOWEnYvZB9We7ddOzXuGN7q2MKezKLE2/MhxAMxX5jbZt00R
         tGKkffFhJhvuhNQOunfWUYg9UAH3aHQgwJ1pzpOXgQb8XdZQ/LT1pK7dRhAVXx3u+h2i
         hfxA==
X-Received: by 10.194.172.162 with SMTP id bd2mr8281400wjc.140.1447228974580;
        Wed, 11 Nov 2015 00:02:54 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB6148.dip0.t-ipconnect.de. [93.219.97.72])
        by smtp.gmail.com with ESMTPSA id c194sm8219910wmd.13.2015.11.11.00.02.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Nov 2015 00:02:53 -0800 (PST)
In-Reply-To: <CAGZ79kb1pDhcP+hN9+C0xK-VYKxfnhvj6a2Len6kOWgmv4+fmQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281151>


On 11 Nov 2015, at 03:00, Stefan Beller <sbeller@google.com> wrote:

> On Tue, Nov 10, 2015 at 5:22 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, Nov 10, 2015 at 7:23 PM, Ramsay Jones
>> <ramsay@ramsayjones.plus.com> wrote:
>>> Commit f8117f55 ("http: use off_t to store partial file size",
>>> 02-11-2015) changed the type of some variables from long to off_t.
>>> The 32-bit build, which enables the large filesystem interface
>>> (_FILE_OFFSET_BITS == 64), defines the off_t type as a 64-bit
>>> integer, whereas long is a 32-bit integer. This results in a couple
>>> of printf format warnings.
>>> 
>>> In order to suppress the warnings, change the format specifier to use
>>> the PRIuMAX macro and cast the off_t argument to uintmax_t. (See also
>>> the http_opt_request_remainder() function, which uses the same
>>> solution).
>> 
>> I just ran across the problem when building 'next' on my Mac and was
>> about to investigate, so am happy to find that the work has already
>> been done. Thanks.
>> 
>> My machine is 64-bit, though, so perhaps it's misleading to
>> characterize this as a fix for 32-bit builds. In particular, off_t is
>> 'long long' on this machine, so it complains about the "long" format
>> specifier.
> 
> +Lars
> 
> I wonder if 32 bit compilation can be part of travis.

Unfortunately no. All their machines are 64-bit [1] and they have "no immediate plans to add this feature" [2].
However, we could the following build configuration on a 64-bit machine:

export CFLAGS="-m32"
export LDFLAGS="-m32"

I think then we could catch these kind of warnings. Do you see a downside with this approach?

- Lars

[1] http://docs.travis-ci.com/user/ci-environment/
[2] https://github.com/travis-ci/travis-ci/issues/986
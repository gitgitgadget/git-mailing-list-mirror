From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v5 3/3] t0302: test credential-store support for XDG_CONFIG_HOME
Date: Wed, 25 Mar 2015 20:03:47 +0100
Message-ID: <55130693.20607@kdbg.org>
References: <1427174429-5876-1-git-send-email-pyokagan@gmail.com>	<1427174429-5876-3-git-send-email-pyokagan@gmail.com> <CAPig+cTWnLYU8wU+WjEVpDBuWS7of=wxrWnq7b9W-r=wQh5S1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 20:04:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yaqaq-00047A-0p
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 20:03:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841AbbCYTDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 15:03:52 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:22188 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752033AbbCYTDv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 15:03:51 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 3lBzPc0gQbz5tl9;
	Wed, 25 Mar 2015 20:03:47 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 2EF10520C;
	Wed, 25 Mar 2015 20:03:47 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CAPig+cTWnLYU8wU+WjEVpDBuWS7of=wxrWnq7b9W-r=wQh5S1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266292>

Am 25.03.2015 um 07:42 schrieb Eric Sunshine:
> On Tue, Mar 24, 2015 at 1:20 AM, Paul Tan <pyokagan@gmail.com> wrote:
>> t0302 now tests git-credential-store's support for the XDG user-specific
>> configuration file $XDG_CONFIG_HOME/git/credentials. Specifically:
>>
>> * Ensure that the XDG file is strictly opt-in. It should not be created
>>    by git at all times if it does not exist.
>>
>> * Conversely, if the XDG file exists, ~/.git-credentials should
>>    not be created at all times.
>>
>> * If both the XDG file and ~/.git-credentials exists, then both files
>>    should be used for credential lookups. However, credentials should
>>    only be written to ~/.git-credentials.
>>
>> * Credentials must be erased from both files.
>>
>> * $XDG_CONFIG_HOME can be a custom directory set by the user as per the
>>    XDG base directory specification. Test that git-credential-store
>>    respects that, but defaults to "~/.config/git/credentials" if it does
>>    not exist or is empty.
>>
>> Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
>> Helped-by: Junio C Hamano <gitster@pobox.com>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Paul Tan <pyokagan@gmail.com>
>> ---
>> diff --git a/t/t0302-credential-store.sh b/t/t0302-credential-store.sh
>> index f61b40c..4e1f8ec 100755
>> --- a/t/t0302-credential-store.sh
>> +++ b/t/t0302-credential-store.sh
>> @@ -6,4 +6,118 @@ test_description='credential-store tests'
>>
>>   helper_test store
>>
>> +test_expect_success 'get: use xdg file if home file is unreadable' '
>
> I meant to mention this earlier. Does this test need to be protected
> by the POSIXPERM prerequisite since it's using chmod?
>
>      test_expect_success POSIXPERM 'get: ... unreadable' '
>
> Otherwise, the test will likely fail on Windows.

Well spotted! The test indeed fails on Windows. POSIXPERM is required.

>> +       echo "https://home-user:home-pass@example.com" >"$HOME/.git-credentials" &&
>> +       chmod -r "$HOME/.git-credentials" &&
>> +       mkdir -p "$HOME/.config/git" &&
>> +       echo "https://xdg-user:xdg-pass@example.com" >"$HOME/.config/git/credentials" &&
>> +       check fill store <<-\EOF
>> +       protocol=https
>> +       host=example.com
>> +       --
>> +       protocol=https
>> +       host=example.com
>> +       username=xdg-user
>> +       password=xdg-pass
>> +       --
>> +       EOF
>> +'

-- Hannes

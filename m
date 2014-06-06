From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH v2 10/11] test-lib: make it possible to override how test
 code is eval'd
Date: Thu, 05 Jun 2014 21:00:07 -0400
Message-ID: <53911297.9030106@bbn.com>
References: <1401176460-31564-1-git-send-email-rhansen@bbn.com>	<1401915687-8602-1-git-send-email-rhansen@bbn.com>	<1401915687-8602-11-git-send-email-rhansen@bbn.com> <xmqqk38vrrig.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 03:00:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsiW8-0000A7-0u
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jun 2014 03:00:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbaFFBAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 21:00:11 -0400
Received: from smtp.bbn.com ([128.33.1.81]:38849 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbaFFBAK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 21:00:10 -0400
Received: from socket.bbn.com ([192.1.120.102]:36643)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WsiW4-000Lvw-3P; Thu, 05 Jun 2014 21:00:20 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id E71E33FF81
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqk38vrrig.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250885>

On 2014-06-05 17:11, Junio C Hamano wrote:
> Richard Hansen <rhansen@bbn.com> writes:
> 
>> Because test_eval_ is defined while zsh is in sh emulation mode, the
>> shell code passed as an argument to test_expect_success would normally
>> be evaluated in sh emulation mode.  However, with this change, it is
>> now possible to evaluate the test code in zsh mode by adding the
>> following line to a zsh-based test script:
>>
>>     emulate -R zsh -c 'test_eval_override () { eval "$*"; }'
>>
>> With test_eval_override defined in zsh emulation mode, the call to
>> test_eval_override from test_eval_ will temporarily cause zsh to
>> switch from sh emulation mode to zsh emulation mode.
> 
> Micronit: aren't all "zsh emulation mode"s above "zsh native mode"s?

Sort of...  Zsh's emulation is under-documented, confusing, and
awkwardly implemented (in my opinion) so it's hard to precisely describe
what's going on in a few words.

I'll explain it here more precisely (apologies for the length) and you
can let me know if I should add more detail to the commit message and/or
code comments:

As far as I understand it, there isn't really such a thing as an
"emulation mode" in Zsh -- the phrase "emulation mode" is just a
convenient way to refer to the mechanism.  Zsh "emulates" other shells
by simply toggling a particular collection of shell options.  For
example, 'emulate sh' turns on the option that controls field splitting
and turns off the option that updates $0 whenever a function is called
(among other option changes).

One might expect 'emulate <shell> -c <code>' to be equivalent to
'emulate <shell>; <code>; emulate <previous_shell>' but it's not --
there's a significant behavior difference.  When '-c <code>' is used,
and only when '-c <code>' is used, a function defined inside <code> gets
"sticky options":  The shell remembers the state of some (all?) options
and saves them along with the function definition.  Whenever the
function is called, those sticky options are temporarily restored for
the duration of the function call.  (This is not entirely accurate --
there are some relatively unimportant cases where the sticky options
aren't restored -- but I don't understand the subtleties of the
mechanism well enough to provide a perfectly accurate description.)

If a function with sticky options calls a function without sticky
options, the sticky options remain in effect -- Zsh doesn't temporarily
revert the sticky options while it calls the non-sticky function.

Thus, if a function foo() is declared inside 'emulate sh -c <code>', and
it calls a function bar() that was declared outside of 'emulate', the
options are still set for POSIX sh during bar()'s execution.  This might
cause bar() to misbehave.  To work around this, bar() must be declared
like 'emulate zsh -c "bar() { stuff... }"' so that bar() gets its own
sticky options.

This commit makes it possible to declare a function that will get sticky
options so that we can control the state of the shell when the scriptlet
is executed.

> 
> In any case, the above explanation confuses me somewhat.  test_eval_
> is fed a scriptlet defined for various test_expect_success tests,
> and they are written in POSIX shells, not zsh, so wouldn't it be
> wrong to run them as if they are zsh native scripts, following
> non-POSIX shell syntax rules?

The scriptlets in lib-prompt-tests.sh are not actually written for POSIX
sh -- they are written in a common subset of the zsh and bash languages
(I should document this in lib-prompt-tests.sh).

We want to test how the __git_ps1 code behaves when interpreted in
"native" zsh mode (default options), because that's how it will be used
in the wild, so the scriptlets must be valid zsh code.  We also want to
test how __git_ps1 behaves in native bash mode, so the scriptlets must
also be valid bash code.  (Fortunately the similarities between the
shells make this easy to do.)

An alternative to this commit -- and I kinda like this idea so I'm
tempted to rewrite the series -- would be to do change the form of the
tests in lib-prompt-tests.sh to something like this:

    test_expect_success 'name of test here' '
        run_in_native_shell_mode '\''
            scriptlet code here
        '\''
    '

Then lib-zsh.sh would do this:

    run_in_native_shell_mode () { emulate -R zsh -c "$*"; }

and lib-bash.sh would do this:

    run_in_native_shell_mode () { eval "$*"; }

This approach makes it clear to others that the scriptlet code is not
actually POSIX shell code, but a common subset of multiple shell languages.

What do you think?

Ignoring t9902 for a moment, we could even stop doing that messy 'exec
$SHELL "$0" "$@"' stuff in lib-*sh.sh and let t9903 and t9904 run under
/bin/sh.  Then run_in_native_shell_mode() would be defined as follows:

  for zsh:

    # wrap the scriptlet in a function in case it does 'return'
    run_in_native_shell_mode () { zsh -c "foo () { $*; }; foo"; }

  for bash:

    # wrap the scriptlet in a function in case it does 'return'
    run_in_native_shell_mode () { bash -c "foo () { $*; }; foo"; }

Running the scriptlets in a separate process like this would cause its
own mess -- the separate processes wouldn't be able to use those
convenience shell functions I added (pcmode_expected(), etc.), so either
there'd be a lot of code copy+paste or each scriptlet would have to
source a helper library.

-Richard

> 
> Puzzled...
> 
>> Signed-off-by: Richard Hansen <rhansen@bbn.com>
>> ---
>>  t/test-lib.sh | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index c081668..3779634 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -414,7 +414,12 @@ maybe_setup_valgrind () {
>>  test_eval_ () {
>>  	# This is a separate function because some tests use
>>  	# "return" to end a test_expect_success block early.
>> -	eval </dev/null >&3 2>&4 "$*"
>> +	if command -v test_eval_override >/dev/null 2>&1
>> +	then
>> +		test_eval_override "$*"
>> +	else
>> +		eval "$*"
>> +	fi </dev/null >&3 2>&4
>>  }
>>  
>>  test_run_ () {

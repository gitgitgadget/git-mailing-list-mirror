From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Bug? git submodule add SSL certificate problem: unable to get
 local issuer certificate
Date: Tue, 10 Mar 2015 21:56:42 +1300
Message-ID: <54FEB1CA.7020204@web.de>
References: <F24DBF8D-40EE-4C8D-AE9C-463E59C4AAD7@aschemann.net> <27F61CEE-F1D3-4B7F-B394-8D06A4AD8976@aschemann.net> <20150309074339.GA31866@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Aschemann Gerd <gerd@aschemann.net>
X-From: git-owner@vger.kernel.org Tue Mar 10 10:17:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVGHz-0006yt-37
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 10:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752211AbbCJJRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2015 05:17:17 -0400
Received: from mout-xforward.web.de ([82.165.159.34]:49163 "EHLO
	mout-xforward.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752186AbbCJJRL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2015 05:17:11 -0400
X-Greylist: delayed 1212 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Mar 2015 05:17:11 EDT
Received: from [192.168.3.124] ([101.98.211.54]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LzKEH-1XRPi12P6f-014TUF; Tue, 10 Mar 2015 09:56:53
 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150309074339.GA31866@peff.net>
X-Provags-ID: V03:K0:ecslyRYKZmqmbZkQnABirAC6RqI0jsjXjNgy0wiw/STjZFSfZVb
 0Em08yec4iuuUS8Pkk0dXyjZfeJcP0tTyTUvIh36MGNT6lz/Bwc/WNr7qkdspcZDtuOMFaN
 2U6wOaqQTwtJW0wMjYG2piHFceARpnRGSilscFS+cnrY9Y1MPGtX7/HzkuMB6wrqi8Jc6nP
 7f4t/DbGKcxFfXs2aeUzg==
X-UI-Out-Filterresults: junk:10;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265221>

Am 09.03.2015 um 20:43 schrieb Jeff King:
> On Thu, Mar 05, 2015 at 04:20:10PM +0100, Aschemann Gerd wrote:
>
>> seems to be a bug: If adding a submodule from an https URL with a certificate issued by StartSSL (or even a private/self-signed one?) leads to the following error:
>>
>>    $ git -c http.sslverify=false submodule add https://example.com/git/xxx.git
>>    Cloning into 'xxx'...
>>    fatal: unable to access 'https://example.com/git/xxx.git/': server certificate verification failed. CAfile: /etc/ssl/certs/ca-certificates.crt CRLfile: none
>>    Clone of 'https://example.com/git/xxx.git' into submodule path 'xxx' failed
>>
>> Performing a simple clone works well:
>>
>>    $ git -c http.sslverify=false clone https://example.com/git/xxx.git
>>    Cloning into 'xxx'...
>>    Password for 'https://example.com':
>
> I think the problem is that the submodule code wipes all "local"
> environment variables before executing the submodule clone, and that
> includes the variable containing command-line config.
>
> Config like this is in a funny boat. We do not want it to cross
> transport boundaries, so that if we run:
>
>    git -c foo=bar clone /some/local/path
>
> the process serving /some/local/path should not see the "foo" option[1].
> But for submodules in the same repository, keeping the shared config is
> probably more reasonable (I can imagine a config variable that you might
> want to behave differently between the submodule and the main project,
> but I could not think of any off-hand, and I expect it would be a rare
> exception).
>
> Submodule folks (cc'd) may have opinions.

I tend to rather not share configs. While I agree that for the example
which started this it would be correct to simply pass http.sslverify,
that doesn't always make sense (e.g. it never does for a setting like
core.worktree).

We already have two options for submodule add and update that are
passed to the clone command (--reference & --depth), maybe it is time
to add another one for passing config options to clone (which then get
set permanently in the submodule's config).

> -Peff
>
> [1] This behavior comes from 655e8d9 (do not pass "git -c foo=bar"
>      params to transport helpers, 2010-08-24), and the original
>      discussion is here:
>
>        http://thread.gmane.org/gmane.comp.version-control.git/154241/focus=154255
>
>      I am tempted to simply drop the transport-layer blocking of config
>      options. It is not buying us anything security-wise, and it could
>      actually be convenient to pass options to the "other side". But it's
>      probably a bad idea, if only because it would not be consistently
>      applied to repos on the other side of git://, http://, or ssh
>      sessions.
>
>      So the sanest fix, if we want submodules to inherit the command-line
>      config, would be to drop GIT_CONFIG_PARAMETERS from local_repo_env,
>      and have the transport code suppress it manually.
>

From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC/PATCH] config.c: Make git_config() work correctly when called
 recursively
Date: Tue, 14 Jun 2011 19:19:19 +0100
Message-ID: <4DF7A627.2080600@ramsay1.demon.co.uk>
References: <4DF106B8.2080902@ramsay1.demon.co.uk> <20110609203958.GA4671@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, johan@herland.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 15 19:52:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWuGC-00025V-Js
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 19:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752383Ab1FORwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 13:52:07 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:33553 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751725Ab1FORwG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 13:52:06 -0400
X-Greylist: delayed 84558 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jun 2011 13:52:05 EDT
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1QWYEL-0000lc-dE; Tue, 14 Jun 2011 18:20:50 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20110609203958.GA4671@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175843>

[Sorry for the late reply - I've been away from email for several days...]

Jeff King wrote:
> On Thu, Jun 09, 2011 at 06:45:28PM +0100, Ramsay Jones wrote:
> 
>> The recursive call to git_config() is due to the "schizophrenic stat"
>> functions on cygwin, and is arrived at as follows:

[...]

> Wow, that's quite a call-chain.

:-P

>> I have not sent this patch to the list before, since I had planned to find
>> a different solution first, so this (updated patch) is more by way of an
>> extended bug-report! Having said that, it works fine ...
> 
> I think it's actually a pretty sane approach. Your other option would be
> not lazily configuring cygwin stat, which means putting an extra very
> early stat call somewhere.
> 
> But look at how deep the call chain above is. And consider how the bug
> manifested itself: silently ignoring some config. So I wouldn't be
> terribly surprised if there is another such recursion hiding somewhere,
> or if we manage to introduce one accidentally in the future.
> 
> So making git_config safe for recursion seems like a good solution for
> future maintainability.

Indeed, that is exactly why this was my first (and so far only) solution
to this problem; it is simple, safe and resilient in the face of future
patches! [I'm not going to commit to auditing all of the current calls to
git_config(), checking all subsequent call-chains for calls to [l]stat(),
let alone all future changes to git.]

However, I anticipated some resistance to this approach, so I have intended
to find another solution (for about 4 months now!), in order to present the
list with some alternatives. I would be quite happy not to bother ;-)

[Actually, one of my preferred solutions is to revert commit adbc0b6 et. seq.,
but that is a whole different discussion!]

> The patch looks sane from my quick skim, though:
> 
>> -static FILE *config_file;
>> -static const char *config_file_name;
>> -static int config_linenr;
>> -static int config_file_eof;
>> +typedef struct config_file {
>> +	struct config_file *prev;
>> +	FILE *f;
>> +	const char *name;
>> +	int linenr;
>> +	int eof;
>> +	struct strbuf value;
>> +	char var[MAXNAME];
>> +} config_file;
>> +
>> +static config_file *cf;
> 
> Since you've nicely encapsulated all of the global data in this struct,
> maybe it is worth simply passing a struct pointer down the call-chain
> instead of relying on a global pointer. Then you can let the language do
> its job and stop managing the stack yourself.

The first version of this patch did exactly that! However, that first patch
failed the test-suite. :(

The failure was caused by a change to the die_bad_config() function, which
in the current patch looks like this:

    @@ -374,8 +381,8 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 
     static void die_bad_config(const char *name)
     {
    -	if (config_file_name)
    -		die("bad config value for '%s' in %s", name, config_file_name);
    +	if (cf && cf->name)
    +		die("bad config value for '%s' in %s", name, cf->name);
     	die("bad config value for '%s'", name);
     }

In order not to change the public interface (note that git_config_int() and
git_config_ulong() call die_bad_config()), I had to change this function so
that it only contains the final die() call. Thus, the error message no longer
included the config filename. This caused the test called 'invalid unit' in
t1300-repo-config.sh to fail.

I could, of course, have simply changed the expect file so that it would pass
the test, but I wanted the change to be self-contained and to pass all existing
tests (ie. the external interface/behaviour should *not* change).

So, I ended up with this (even simpler) patch.

Thank you for your comments on the patch.

ATB,
Ramsay Jones

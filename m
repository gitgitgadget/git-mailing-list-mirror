From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: [PATCHv5 0/2] bash completion: Support "divergence from upstream"
 messages in __git_ps1
Date: Thu, 17 Jun 2010 22:31:46 +0100
Message-ID: <4C1A9442.7080304@pileofstuff.org>
References: <20100612000002.GA30196@neumann> <cover.1276336602.git.trast@student.ethz.ch> <4C13F32B.7060106@pileofstuff.org> <201006140942.43099.trast@student.ethz.ch> <4C17F5B3.4070907@pileofstuff.org> <7v7hlyg5nh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 17 23:32:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPMgo-0006EW-3w
	for gcvg-git-2@lo.gmane.org; Thu, 17 Jun 2010 23:31:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759994Ab0FQVbw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jun 2010 17:31:52 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:65126 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752732Ab0FQVbv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Jun 2010 17:31:51 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20100617213149.FDKR3075.mtaout03-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Thu, 17 Jun 2010 22:31:49 +0100
Received: from [192.168.1.5] (really [80.6.134.127])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.2.02.00.01 201-2161-120-102-20060912) with ESMTP
          id <20100617213149.NDTR1598.aamtaout03-winn.ispmail.ntl.com@[192.168.1.5]>;
          Thu, 17 Jun 2010 22:31:49 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100423 Thunderbird/3.0.4
In-Reply-To: <7v7hlyg5nh.fsf@alter.siamese.dyndns.org>
X-Cloudmark-Analysis: v=1.1 cv=ZtHxNT4mZm3rCuM0SmWmgWxeBwJsziC8EqOrwwVkrhA= c=1 sm=0 a=duM3rHejoagA:10 a=uEzv4HemXiYA:10 a=8nJEP1OIZ-IA:10 a=1tNjHJYGQUadGi1QIQkA:9 a=6gnTn3okqwYzaYZObg4A:7 a=eLFVj-_uBok1ddbnJaAIyHjAWH8A:4 a=wPNLvfGTeEIA:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149328>

I agree with all the points I haven't specifically replied to.  The
first patch makes the appropriate changes.  The second patch fixes
largely unrelated "set -u" issues I stumbled over while running tests.

On 16/06/10 20:05, Junio C Hamano wrote:
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 57245a8..dabcdaa 100755
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -42,6 +42,23 @@
>>  #       set GIT_PS1_SHOWUNTRACKEDFILES to a nonempty value. If there're
>>  #       untracked files, then a '%' will be shown next to the branch name.
>>  #
>> +#       If you would like to see the difference between HEAD and its
>> +#       upstream, set GIT_PS1_SHOWUPSTREAM to a nonempty value.  A "<"
>> +#       indicates you are behind, ">" indicates you are ahead, and
>> +#       "<>" indicates you have diverged.  You can further control
>> +#       behaviour by setting GIT_PS1_SHOWUPSTREAM to a space-separated
>> +#       list of values:
>> +#           git           compare HEAD to @{upstream}
>> +#           svn           compare HEAD to your SVN upstream
>> +#           verbose       show number of commits ahead/behind (+/-) upstream
>> +#           legacy        don't use the '--count' option available in recent
>> +#                         versions of git-rev-list
>> +#       By default, __git_ps1 will compare HEAD to your SVN upstream
>> +#       if it can find one, or @{upstream} otherwise.
> 
> This feels somewhat weird.
> 
> I can sort-of read from the above that I can set the variable to a random
> string, e.g. "garbage", if I only want a simple show-upstream feature
> without frills (i.e. I don't want it to be verbose, I don't want it to
> restrict the comparison only to "git" upstream nor "svn" upstream, and I
> don't think I would ever use ancient git that lack "rev-list --count").
> But the description does not assure me that the random string I happened
> to choose (in this case "garbage") is a safe one.  Perhaps list (and
> implement) "default" as a safe, otherwise-no-op value?

I agree this would improve the documentation, but I've used "auto"
instead of "default", to give a hint that that the code is being a bit
automagical.  I don't see how adding code would help though -
"GIT_PS1_SHOWUPSTREAM=auto" is already covered in the default case of an
unrecognised string, and adding code to make "GIT_PS1_SHOWUPSTREAM=1" do
nothing or print a warning would just confuse people that skip-read the
documentation and set the value to see what happened.

> How much overhead are we shaving if you specify "git" (without "svn") or
> "svn" (without "git") to the variable?  I suspect that the bulk of the
> time is spent by reading from "git config" to look for svn-remote.*.url,
> which you seem to unconditionally do even when "git" was asked for
> anyway.

In my tests, a single invocation of git-config took an average of
roughly 0.005s with a 30-line .git/config, and roughly 0.030s with a
.git/config that contained about 17,600 extra nonsense lines (aaa = aaa,
aab = aab, etc.).  In both cases, the extra test for svn-remote.*.url
made no significant difference to the time taken, whereas a second
invocation of `git config` (obviously) doubled the time taken.

Checking the SVN upstream with `git log --first-parent -1
--grep="^git-svn-id: \(${svn_url_pattern:2}\)"` is actually quite a
serious time issue, especially if you have made many commits since your
upstream.  A test with 100 empty commits since the SVN upstream took
roughly 0.012 seconds on average.  A test on git itself (>22,000
commits) took roughly 0.29 seconds to determine there was no SVN upstream.

Speed (and user confidence in speed) isn't the main reason to allow the
user to force "git" or "svn".  If someone had e.g. imported their old
SVN history into a git project, or did clever git tricks on a branch
they regularly merged into SVN, they would want to override the default
behaviour.  This is probably quite rare now I think about it, and I've
rejigged the documentation a bit to reflect that.

> 
>> +#       You can
>> +#       override the value of GIT_PS1_SHOWUPSTREAM on a per-repository
>> +#       basis by setting the bash.showUpstream config variable.
> 
> That's totally backwards from it should be, isn't it?
> 
> Usually configuration variables are used to give you the default, and
> you use environment variables to override them.
> 

I basically agree with Thomas here.  Going down that route without
parsing all the options in one big `--get-regexp` mess would take O(n)
time, where n consists mostly of config options I don't care about.

>> +				;;
>> +			svn-remote.*.url)
>> +				svn_remote[ $((${#svn_remote[@]} + 1)) ]="$value"
>> +				svn_url_pattern+="\\|$value"
>> +				upstream=svn # default upstream is SVN if available
>> +				;;
> 
> I expected that (1) when on a branch that is a fork of a svn upstream, you
> would use the svn magic; (2) otherwise when on a branch that is a fork of
> a git upstream, you would use "@{upstream}".  That way, the users do not
> even have to say "git" or "svn" in GIT_PS1_SHOWUPSTREAM at all, no?
> 
> But that does not seem to be what is happening here.  Your loop seems to
> force "upstream=svn" if I have one branch that is a fork from svn
> upstream, even if my current branch does not have anything to do with that
> branch nor svn upstream.  Is that what was intended?

I'm not sure I understand how you would detect if something is a fork of
an SVN/git upstream.  It's certainly deliberate not to do a `git log` if
it's avoidable, for the efficiency reasons I mentioned above.  But it
seems like a good idea to use @{upstream} in the "auto" case if no SVN
upstream was found, so I've changed the patch to do that.  Please let me
know if there's some applicable magic I'm not aware of :)

>> +		esac
>> +	done < <(git config -z --get-regexp '^(svn-remote\..*\.url|bash\.showupstream)$' 2>/dev/null | tr '\0\n' '\n ')
> 
> If you "tr" to trash "\0" anyway, do you need to run "config -z"?

The `tr` is there to work around issues like this:

	git config bash.showUpstream $'svn\nlegacy'
	git config bash.showUpstream | tr '\0\n' '\n '

The end result is a format that can be easily parsed with `read`.
Without the -z, I'd have no way to tell the difference between the end
of a config item and a literal newline.

Having said that, I have no strong opinion about which is the more
appropriate thing to do here - slow down everyone's prompt to deal with
an edge case, or break otherwise-valid behaviour because the solution is
ugly.  The latest patch still has it in - let me know if you'd prefer it
out.

> 
>> +	# parse configuration values
>> +	for option in ${GIT_PS1_SHOWUPSTREAM}; do
> 
> Is this safe under "set -u"?  See 25a31f8 (bash-completion: Support
> running when set -u is enabled, 2009-01-15).

This is safe under "set -u", as this function is only called if
$GIT_PS1_SHOWUPSTREAM is defined.  But testing showed several issues
that make me suspect __git_ps1 never worked under "set -u".  My second
patch fixes those issues.

	- Andrew

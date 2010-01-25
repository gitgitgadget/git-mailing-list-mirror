From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page
 when regenerating cache (WIP)
Date: Mon, 25 Jan 2010 12:41:25 -0800
Message-ID: <4B5E01F5.20402@eaglescrag.net>
References: <cover.1264198194.git.jnareb@gmail.com> <201001251246.40237.jnareb@gmail.com> <20100125130230.GE9553@machine.or.cz> <201001251448.27513.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 21:42:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZVlP-0003ya-Bz
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 21:42:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833Ab0AYUmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 15:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550Ab0AYUmS
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 15:42:18 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:53070 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab0AYUmR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 15:42:17 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0PKfPlm027472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 25 Jan 2010 12:41:26 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <201001251448.27513.jnareb@gmail.com>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Mon, 25 Jan 2010 12:41:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137991>

On 01/25/2010 05:48 AM, Jakub Narebski wrote:
> On Mon, Jan 25, 2010, Petr Baudis wrote:
>> On Mon, Jan 25, 2010 at 12:46:39PM +0100, Jakub Narebski wrote:
>>> On Sun, 24 Jan 2010, Petr Baudis wrote:
> 
>>>>   I have stupid question, common to both the original patch and this
>>>> RFC.
>>>>
>>>>> [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page when
>>>>> regenerating cache (WIP)
>>>>
>>>>   Just why is a "Generating..." page appropriate?
>>>>
>>>>   I have to admit I hate it; can you please at least make it
>>>> configurable? Why is it needed at all? It [...] confuses
>>>> non-interactive HTTP clients [...]
> 
>>> Second, gitweb can always check User-Agent header, and serve 
>>> "Generating..." page only to web browsers:
>>>
>>>   unless (defined $cgi->user_agent() &&
>>>           $cgi->user_agent() =~ /\b(Mozilla|Opera)\b/i) {
>>>   	return;
>>>   }
>>>
>>> or something like that.
>>
>> I'm not too happy with this. What about Safari? Opera? ELinks? There's a
>> lot of web browsers.
> 
> The "Mozilla" part would catch all "Mozilla compatibile" web browsers,
> including Firefox (and other Gecko-based web browsers), Internet Explorer,
> WebKit based browsers including Safari and Chrome and Konqueror.
> The "Opera" part would catch Opera.
> http://www.nczonline.net/blog/2010/01/12/history-of-the-user-agent-string/
> 
> As to other web browsers like Elinks, Lynx, w3m, Dillo, etc.: the issue
> is whether they honor '<meta http-equiv="refresh" content="0" />'.  
> I think it is better to stay on the safe side; it is not disaster if web
> browser is not shown "Generating..." page where it could (but see 
> explanation below).

Most of them do, that particular tag has been around for a long time and
since it doesn't require Javascript to do the page refresh it's pretty
much universal.

The problem is going to be with things like wget when someone wants to
snag a binary file.  This works fine if the file is already cached, but
the user doesn't get what they are expecting if they get a blob that
isn't the final file, but the html contents of the page.  I don't know
of any hint that things like wget would send to the server that you
could switch based on, but it would be more or less the non-background
caching state.

>> Most of the issues can be worked around, but I'm not sure why to go
>> through all the trouble. I just personally don't see the value in having
>> the placeholder in there at all, to me it is distracting UI even if all
>> the technicalities are put aside.
> 
> The issue that "Generating..." page tries to solve is, I think, the 
> following.  
> 
> Some actions, like 'blame' view or pickaxe search, or grep search,
> can take quite a long time to generate, with times counted in
> tens of seconds.  It is not that visible for non-caching, because
> gitweb streams output so we have at least _some_ output upfront quite
> fast.
> 
> Now those patches (mine and J.H. both) make gitweb use locking
> (it is IIRC configurable in J.H. patch) to make only one process
> generate the page if it is missing from cache, or is stale.  Now
> if it is missing, we have to wait until it is generated in full
> before being able to show it to client.  While it is possible to
> "tee" output (using PerlIO::tee, or Capture::Tiny, or tie like
> CGI::Cache) writing it simultaneously to browser and to cache for 
> the process that is generating data, it is as far as I understand
> it impossible for processes which are waiting for data.  Therefore
> the need for "Generating..." page, so the user does not think that
> web server hung or something, and is not generating output.
>  
> We can try to reduce occurrences of cache miss stampedes by using
> 'expires_variance' feature[1] from CHI - Unified caching interface.
> We can also turn off locking and tee output to have some output upfront
> as an activity indicator instead of this "Generating..." page.
> 
> [1]: http://search.cpan.org/~jswartz/CHI-0.33/lib/CHI.pm#set
> 
>> But if it will be possible to turn this off eventually, it's all your
>> call whether to bother implementing it. :-)
> 
> In my implementation it is (or rather would be) as simple as just
> not passing 'generating_info' => \&git_generating_data_html in the
> GitwebCache::SimpleFileCache constructor.
> 

At least in mine it was don't allow background caching.  It would force
everyone to wait on the one process that was actually generating
content.  But it means a few blank pages with a spinning working icon
until the cache releases it's exclusive lock.

- John 'Warthog9' Hawley

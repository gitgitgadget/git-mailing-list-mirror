From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [RFC PATCH 10/10] gitweb: Show appropriate "Generating..." page
 when regenerating cache (WIP)
Date: Mon, 25 Jan 2010 12:32:37 -0800
Message-ID: <4B5DFFE5.6060908@eaglescrag.net>
References: <cover.1264198194.git.jnareb@gmail.com> <201001251246.40237.jnareb@gmail.com> <20100125130230.GE9553@machine.or.cz> <201001251448.27513.jnareb@gmail.com> <20100125135653.GN4159@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 25 21:33:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZVcq-0000c4-3v
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 21:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab0AYUd2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 15:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107Ab0AYUd1
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 15:33:27 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:54958 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611Ab0AYUd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 15:33:26 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o0PKWb0l026594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Mon, 25 Jan 2010 12:32:38 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091209 Fedora/3.0-4.fc12 Lightning/1.0pre Thunderbird/3.0
In-Reply-To: <20100125135653.GN4159@machine.or.cz>
X-Enigmail-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Mon, 25 Jan 2010 12:32:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137990>

On 01/25/2010 05:56 AM, Petr Baudis wrote:
> On Mon, Jan 25, 2010 at 02:48:26PM +0100, Jakub Narebski wrote:
>> Now those patches (mine and J.H. both) make gitweb use locking
>> (it is IIRC configurable in J.H. patch) to make only one process
>> generate the page if it is missing from cache, or is stale.  Now
>> if it is missing, we have to wait until it is generated in full
>> before being able to show it to client.  While it is possible to
>> "tee" output (using PerlIO::tee, or Capture::Tiny, or tie like
>> CGI::Cache) writing it simultaneously to browser and to cache for 
>> the process that is generating data, it is as far as I understand
>> it impossible for processes which are waiting for data.  Therefore
>> the need for "Generating..." page, so the user does not think that
>> web server hung or something, and is not generating output.
> 
> Ah, ok, so the message is there to cover up for a technical problem. ;-)
> I didn't quite realize. Then, it would be great to tweak the mechanisms
> so that the user does not really have to wait.

No, that is an incorrect assumption on how the 'Generating...' page
works, and your missing a bit of the point.

(1) The message itself 'Generating...' is a que to the user that
something is happening and that the browser is not actually hanging.
Web users are at the point where if things are not instantaneous and
show immediately they will either browse away completely or hit the
refresh button incessantly until content does appear.  While the page is
usually only seen for about a second, and I'll admit it can be annoying,
it's nothing more than a 'sit tight a second'.  For things like the
front page it can take upwards of 7 seconds to generate for a single
user, a lot to ask for a no response scenario.

(2) It prevents the stampeding herd problem, which was very vehemently
discussed 4 years ago by HPA and myself and roughly boils down to this:

When a single user comes into the site, in particular the front page, it
kicks off a process that will start to generate at it, causing a huge
amount of git requests into individual repositories and a lot of disk
i/o.  A second user will then come in and the same requests will start
to be done from the beginning again, and so on until you basically kill
the machine because the disk i/o goes up enough that it can't ever
service the requests fast enough.

This does 2 things in the end:

1) means there's only 1 copy of the page ever being generated, thus
meaning there isn't extraneous and dangerous disk i/o going on on the system

2) prevents a user from reporting to the website that it's broken by
giving them a visual que that things aren't broken.


> So, I wonder about two things:
> 
> (i) How often does it happen that two requests for the same page are
> received? Has anyone measured it? Or is at least able to make
> a minimally educated guess? IOW, isn't this premature optimization?

For most pages, not many but it happens more often than you think.  The
data I have is much too old to be useful now but the front page could,
at times, have up to 30 people waiting for it without caching.  This is
a very important patch believe it or not.  For a site the size of
kernel.org it cannot exist without this.

But here's a quick stat, in 36 hours git.kernel.org has had
156099 accesses world wide or about 1.2 accesses a second.

android.git.kernel.org, in the same time period has had 115818 accesses.

If the first request takes 7 seconds to generate, by the time it's done
there are now 3 additional requests running.  If it again takes 7
seconds to generate there are now another 3 requests running, etc.  Very
quickly you've got so much i/o running the box more or less is useless.

> (ii) Can't the locked gitwebs do the equivalent of tail -f?

Not really going to help much, most of the gitweb operations won't
output much of anything beyond the header until it's collected all of
the data it needs anyway and then there will be a flurry of output.  It
also means that this 'Generating...' page will only work for caching
schemes that tail can read out of, which I'm not sure it would work all
that well with things like memcached or a non-custom caching layer where
we don't necessarily have direct access to the file being written to.

At least the way I had it (and I'll admit I haven't read through Jakub's
re-working of my patches so I don't know if it's still there) is that
with background caching you only get the 'Generating...' page if it's
new or the content is grossly out of data.  If it's a popular page and
it's not grossly out of date it shows you the 'stale' data while it
generates the new content in the background anyway, only locking you out
when the new file is being written.  Or at least that's how I had it.

- John 'Warthog9' Hawley

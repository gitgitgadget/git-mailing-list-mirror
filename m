From: "J.H." <warthog9@kernel.org>
Subject: Re: [PATCH 0/2] gitweb: Improve handling of configuration files
Date: Wed, 25 May 2011 11:38:57 -0700
Message-ID: <4DDD4CC1.3070103@kernel.org>
References: <1306341328-11108-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Drew Northup <drew.northup@maine.edu>,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 20:41:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPJ1T-0002FZ-PO
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 20:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab1EYSla (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 14:41:30 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:56405 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab1EYSl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 14:41:29 -0400
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.4) with ESMTP id p4PIcvFR012971
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Wed, 25 May 2011 11:38:57 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <1306341328-11108-1-git-send-email-jnareb@gmail.com>
X-Enigmail-Version: 1.1.2
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.6 (shards.monkeyblade.net [198.137.202.13]); Wed, 25 May 2011 11:38:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174445>

On 05/25/2011 09:35 AM, Jakub Narebski wrote:
> This two-in-one series is response to Junio's concerns about being
> backwards-incompatibile and different ways of solving "system-wide
> policy" problem.

I realize I'm jumping on this mid way through, but I did read back
through the history.

Start with Patch 1, it looks fine and I support the change.  Makes it a
lot easier to include config files.

> Patches 2/2 version A and 2/2 version B are mutually exclusive.
> Junio, you would have to choose which one to include.

To speak to Junio's concerns seem to boil down to a general concern that
something in /etc/gitweb.conf may interfere with unintended interaction
in the local repository, and has suggested that we do an explicit
include to solve the problem.

I would argue against this, for a couple of reasons:

1) Git itself treats /etc/git.conf in this exact manor, it reads in
stuff from /etc/git.conf and then local repos can change or override
things as needed.  In fact this is quite beneficial, because it gives
site admins a simple and easy way to give an automatic hint to a repo
about things the admin would like.

Case in point turning on things like updateserverinfo, or automatic packing.

The fact that an admin doesn't need to do anything for this change to be
effective in most places is actually the expected result of the
sysadmin.  The systems administrator is saying "hey we need to have this
on everywhere and instead of getting 100 people to all change their
configs, we make one change and the hint is automatically everywhere".

>From a kernel.org perspective, that's what I'd expect.  I'm not keen on
having to go and either add some include line to each config file for
gitweb config (which feels like a kludge) just to centralize config
elements.

2) Trying to get people to do includes in their config files, or to
completely ignore the system wide config isn't a sustainable practice.
It would be akin to asking that every repository on kernel.org add
something to their config, which each individual person has to go and
add on their own.

That's akin to asking 400 people to make a change to 900+ repositories,
and then to remember to make that change for every new repo that gets
created.

Now I don't have 900 instances of gitweb running, but I am up to at
least 3 independent instances, and I can think of a 4th that is in the
works.  Having a system-wide config that gives the basics is appealing
to me.

Now that I've said all that, here's what I propose.

We go back to the way Jakub proposed this originally, where it reads in
the system wide config, and then overwrites things from the local
config.  This really is more in line with what people, particularly
system wide sysadmins, will expect.

To alleviate the concerns of people who thing the systemwide may cause
problems I propose, instead of an explicit include, we do an explicit
exclude for the system wide config.  We have a new config directive that
basically says throw out the systemwide config, take me back to defaults
and let me override from there.  This means needing to either store a
copy of the defaults on start-up, or like with gitweb-caching the
defaults are kept in a separate file and can just be re-read, and it
means that the local config would need to be read twice.

This means that if the individual wants to ignore the hints the systems
administrator is giving in system wide config, then they are making an
explicit choice to do so, either because they know better or something
like git-instaweb where it generally doesn't trust it.  Either way, it's
the exceptions who are making the choice, not the general case.

I'll admit this might even convince me that a single configuration
structure for the entire script is better than individual variable names.

- John 'Warthog9' Hawley

From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [RFC] Implementing gitweb output caching - issues to solve
Date: Thu, 09 Dec 2010 20:46:55 -0800
Message-ID: <4D01B0BF.1010609@eaglescrag.net>
References: <201011041721.53371.jnareb@gmail.com> <4D00316F.9000305@eaglescrag.net> <201012092330.06688.jnareb@gmail.com> <20101209225211.GA20426@burratino> <88CF82F1-0363-47B4-8C6F-AE4A2DA1714B@wundersolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@ucw.cz>, admin@repo.or.cz
To: Olaf Alders <olaf@wundersolutions.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 05:45:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQurM-0003Vz-0d
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 05:45:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114Ab0LJEp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 23:45:26 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:37039 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109Ab0LJEpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 23:45:25 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBA4j81t031876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 9 Dec 2010 20:45:09 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <88CF82F1-0363-47B4-8C6F-AE4A2DA1714B@wundersolutions.com>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 20:45:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163388>

>> Interesting.  http://www.user-agents.org/ seems to suggest that many
>> robots do use Mozilla (though I don't think it's worth bending over
>> backwards to help them see the page correctly).

If a robot reports itself and we don't know about it, I'm fine with
giving it the 'Generating...' page as opposed to what it's expecting.
The number of robots and things of that nature that won't handle the
meta refresh are fewer than the number of people who will be clicking
with eyeballs on a screen.

>> HTTP::BrowserDetect uses a blacklist as far as I can tell.  Maybe in
>> the long term it would be nice to add a whitelist ->human() method.
>>
>> Cc-ing Olaf Alders for ideas.
> 
> Thanks for including me in this.  :)  I'm certainly open to patching the module, but I'm not 100% clear on how  you would want to implement this.  How is ->is_human different from !->is_robot?  To clarify, I should say that from the snippet above, I'm not 100% clear on what the problem is which needs to be solved.

At this point I don't really see an issue with HTTP::BrowserDetect's
robot() function, and I agree with human = !->is_robot.

One thing I would like to see is the ability to do some sort of an add
to the list of things to check for.  As you are probably aware there are
more agents that exist than what you have setup, I'm moving forward and
handling it with the following:

sub is_dumb_client {
        my($user_agent) = lc $ENV{'HTTP_USER_AGENT'};

        my $browser_detect = HTTP::BrowserDetect->new($user_agent);

        return 1 if ( $browser_detect->robot() );

        foreach my $adc ( @additional_dumb_clients ) {
                return 1 if ( index( $user_agent, lc $adc ) != -1 );
        }

        return 0;
}

which could be simplified if there was just some way to do

        my($user_agent) = lc $ENV{'HTTP_USER_AGENT'};

        my $browser_detect = HTTP::BrowserDetect->new($user_agent);

        $browser_detect->add_robots( @array );

        return 1 if ( $browser_detect->robot() );

Not sure that particularly generalizes, and honestly it's only 4 lines
of code to do add additional checks.

- John 'Warthog9' Hawley

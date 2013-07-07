From: David Rothenberger <daveroth@acm.org>
Subject: Re: [PATCH 0/2] allow git-svn fetching to work using serf
Date: Sat, 06 Jul 2013 20:44:15 -0700
Message-ID: <51D8E40F.2020008@acm.org>
References: <CB53C901-3643-46AE-AA80-CED5E20AC3B7@gmail.com> <51D7C47D.5070700@acm.org> <20130707002804.GF30132@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 05:44:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvfts-0006M0-Pm
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 05:44:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425Ab3GGDod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Jul 2013 23:44:33 -0400
Received: from plane.gmane.org ([80.91.229.3]:42139 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295Ab3GGDoc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jul 2013 23:44:32 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Uvftl-0006EQ-S4
	for git@vger.kernel.org; Sun, 07 Jul 2013 05:44:29 +0200
Received: from c-24-16-16-7.hsd1.wa.comcast.net ([24.16.16.7])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 05:44:29 +0200
Received: from daveroth by c-24-16-16-7.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 05:44:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-16-16-7.hsd1.wa.comcast.net
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130707002804.GF30132@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229723>

On 7/6/2013 5:28 PM, Jonathan Nieder wrote:
> David Rothenberger wrote:
>> On 7/5/2013 8:41 PM, Kyle McKay wrote:
> 
>>> Daniel Shahaf has suggested also setting
>>> "servers:global:http-bulk-updates=on".
>>
>> I have a patch that does this, but since turning on bulk updates has
>> a possible performance penalty, I prefer your approach. 
> 
> I assume that's because http-bulk-updates defeats caching.  If so,
> makes sense.

I believe that "bulk updates" means that serf makes one request for a
lot of information and receives it all in one big response. In "skelta"
mode, serf makes a single request for a single piece of information. The
serf authors feel this can lead to improved overall throughput because
they can pipeline these requests and have multiple connections open at
the same time.

The downside, though, is that serf will do multiple open_file calls in
parallel as it descends down sibling directories.

> It's still not clear to me how we know that ra_serf driving the editor
> in a non depth-first manner is the problem here.  Has that explanation
> been confirmed somehow?

I did do a trace of "git svn fetch" and observed this non-depth-first
traversal. It certainly causes the failure we've observed.

> Is there a simple explanation of why violating the depth-first
> constraint would lead to multiple blob (i.e., file, not directory)
> deltas being opened in a row without an intervening close?

I believe serf is doing the following for a number of files in parallel:
 1. open_file
 2. apply_textdelta
 3. change_file_prop, change_file_prop, ...
 4. close_file


-- 
David Rothenberger  ----  daveroth@acm.org

Nusbaum's Rule:
        The more pretentious the corporate name, the smaller the
        organization.  (For instance, the Murphy Center for the
        Codification of Human and Organizational Law, contrasted
        to IBM, GM, and AT&T.)

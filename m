From: "Harlan, Peter" <peter.harlan@hp.com>
Subject: Re: Problem with Git rev-list output
Date: Fri, 15 Aug 2014 07:26:04 +0000
Message-ID: <AFBFD05B9DF375478FAB650FE9527BB426187E5B@G1W3782.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Crabtree, Andrew" <andrew.crabtree@hp.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 09:28:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIBwC-00074r-Oc
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 09:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbaHOH2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 03:28:32 -0400
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:35577 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489AbaHOH2a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Aug 2014 03:28:30 -0400
Received: from g2t2353.austin.hp.com (g2t2353.austin.hp.com [15.217.128.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g9t1613g.houston.hp.com (Postfix) with ESMTPS id 11F82605F4
	for <git@vger.kernel.org>; Fri, 15 Aug 2014 07:27:52 +0000 (UTC)
Received: from G2W4316.americas.hpqcorp.net (g2w4316.austin.hp.com [16.197.9.73])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by g2t2353.austin.hp.com (Postfix) with ESMTPS id 47F0E1A2
	for <git@vger.kernel.org>; Fri, 15 Aug 2014 07:27:27 +0000 (UTC)
Received: from G1W5784.americas.hpqcorp.net (16.193.26.2) by
 G2W4316.americas.hpqcorp.net (16.197.9.73) with Microsoft SMTP Server (TLS)
 id 14.3.169.1; Fri, 15 Aug 2014 07:26:05 +0000
Received: from G1W3782.americas.hpqcorp.net ([169.254.4.191]) by
 G1W5784.americas.hpqcorp.net ([16.193.26.2]) with mapi id 14.03.0169.001;
 Fri, 15 Aug 2014 07:26:04 +0000
Thread-Topic: Re: Problem with Git rev-list output
Thread-Index: Ac+4WOL6WsFCQ1kITk+9Yhn8GYogVA==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [15.217.50.23]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255281>

On 2014-08-12 01:10:28 Andrew Crabtree wrote:
> I'm seeing some oddity in one of my repositories where the root commit is being output in 'rev-list' even
> when I pass in a reference that should exclude it from being output.
...
> Seeing the issue with versions of git from 1.7 to 2.1.

I have a small test repo on GitHub that demonstrates the problem.  I expect it is caused by the commit dates being out of sequence:

1. Clone the "revlist" repo:

# git clone https://github.com/pcharlan/revlist.git                             
Cloning into 'revlist'...

2. master has six commits (with out-of-order dates):

# git log --pretty='%h %cd' master
0f9e594 Sun May 20 01:01:01 2007 -0700
1ad887b Sun May 20 01:01:01 2007 -0700
cde7188 Sun May 20 01:01:01 2007 -0700
51af1c0 Sun May 20 01:01:01 2007 -0700   <-- date seven years ago
0e080e8 Tue Aug 12 11:51:19 2014 -0700  <-- present day
77ce973 Fri May 20 01:01:01 2011 -0700  <-- three years ago

3. Pruning master with origin/other (a branch with the same root and also out-of-order dates) has no effect, counter to expectation:

# git log --pretty='%h %cd' master ^origin/other
0f9e594 Sun May 20 01:01:01 2007 -0700
1ad887b Sun May 20 01:01:01 2007 -0700
cde7188 Sun May 20 01:01:01 2007 -0700
51af1c0 Sun May 20 01:01:01 2007 -0700
0e080e8 Tue Aug 12 11:51:19 2014 -0700
77ce973 Fri May 20 01:01:01 2011 -0700     <--- Reachable from origin/other

4. Pruning master with the parent of origin/other removes the root commit:

# git log --pretty='%h %cd' master ^origin/other~
0f9e594 Sun May 20 01:01:01 2007 -0700
1ad887b Sun May 20 01:01:01 2007 -0700
cde7188 Sun May 20 01:01:01 2007 -0700
51af1c0 Sun May 20 01:01:01 2007 -0700
0e080e8 Tue Aug 12 11:51:19 2014 -0700

Q: Is this expected behavior?  If so, and assuming that it's the dates that are throwing Git off, is there a way to tell Git to not care about the dates, or to care less than it does?

Thanks,

--Pete

Peter Harlan
HP Networking

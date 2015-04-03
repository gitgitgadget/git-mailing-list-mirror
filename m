From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: git 2.3.4, ssh: Could not resolve hostname
Date: Fri, 03 Apr 2015 02:02:15 +0200
Message-ID: <551DD887.2010403@web.de>
References: <56B33978-76A0-4EE0-BCC0-EF030FD52E41@rawsound.com> <20150402180914.GA19081@peff.net> <201C57EF-FC96-4FFB-81D2-90F94428A6CA@rawsound.com> <20150402191452.GA20420@peff.net> <xmqq7ftujpu1.fsf@gitster.dls.corp.google.com> <62968860-FA58-4339-AF0B-264197EC8A04@rawsound.com> <20150402193524.GA21555@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1?= =?UTF-8?B?c2Vu?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, "Reid Woodbury Jr." <reidw@rawsound.com>
X-From: git-owner@vger.kernel.org Fri Apr 03 02:02:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ydp4N-0001FZ-76
	for gcvg-git-2@plane.gmane.org; Fri, 03 Apr 2015 02:02:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752745AbbDCACj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 20:02:39 -0400
Received: from mout.web.de ([212.227.15.4]:59727 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751360AbbDCACh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 20:02:37 -0400
Received: from macce.local ([87.146.143.47]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0MKek3-1Yd0Ny2nHr-0023T6; Fri, 03 Apr 2015 02:02:26
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150402193524.GA21555@peff.net>
X-Provags-ID: V03:K0:cVdRVItdJ42AwSnBXQ/gOydkgDKNnHdFW9WONbeU3cYIhqoC7uQ
 hpIvrNe5XajGOw8Jt04PES1CXBtg2LVJY2yqfzDZBQmVz+szcY3PoBVGrSfzpvl8uELEo8b
 9cK6IcaOMJF0fbQp7FYzIuUgToDzlaViY8YWR84HktcdMwlePcPYQb2USR2MXA3ED2hpQZH
 67ye8iJmYgTbq7aK01kpA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266694>

On 2015-04-02 21.35, Jeff King wrote:
> On Thu, Apr 02, 2015 at 12:31:14PM -0700, Reid Woodbury Jr. wrote:
> 
>> Ah, understand. Here's my project URL for 'remote "origin"' with a
>> more meaningful representation of their internal FQDN:
>>
>> 	url = ssh://rwoodbury@systemname.groupname.online:/opt/git/inventory.git
>>
>> The "online" is their literal internal TLD.
> 
> Thanks. The problem is the extra ":" after "online"; your URL is
> malformed. You can just drop that colon entirely.
> 
> I do not think we need to support this syntax going forward (the colon
> is meaningless here, and our documentation is clear that it should go
> with a port number), but on the other hand, it might be nice to be more
> liberal, as we were in v2.3.3 and prior. I'll leave it to Torsten to see
> whether supporting that would hurt some of the other cases, or whether
> it would make the code too awkward.
> 
> -Peff

Thanks for digging.

This makes my think that it is
a) non-standard to have the extra colon
b) The error message could be better
c) We don't have a test case
d) This reminds my of an improvement from Linus:
608d48b2207a61528
......
    So when somebody passes me a "please pull" request pointing to something
    like the following
    
    	git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
    
    (note the extraneous colon at the end of the host name), git would happily
    try to connect to port 0, which would generally just cause the remote to
    not even answer, and the "connect()" will take a long time to time out.
.....

Sorry guys for the regression, the old parser handled the extra colon as "port 0",
the new one looks for the "/" as the end of the hostname (and the beginning of the path) 

Either we accept the extra colon as before, or the parser puts out a better error message,
(because the OS doesn't seem to do so):

./git clone git://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
Cloning into 'v4l-dvb'...
fatal: unable to connect to git.kernel.org::
git.kernel.org:[0: 62.157.140.133]: errno=Connection refused
git.kernel.org:[1: 80.156.86.78]: errno=Connection refused

(Especially the "::" is a little bit funny: the first ':' is the extra one,
the second one comes from the error message:
"unable to connect to %s:\n%s"

That is not really user-friendly, so I put it onto my TODO-list
It seems as if it comes from the repair of another regression, which re-allows
the usage of IPV6 addresses without []:
./git fetch-pack  --diag-url  ssh://::1/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
Diag: url=ssh://::1/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
Diag: protocol=ssh
Diag: userandhost=::1
Diag: port=NONE
Diag: path=/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git


And this makes sense too:
./git fetch-pack  --diag-url  ssh://git.kernel.org:1/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
Diag: url=ssh://git.kernel.org:1/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
Diag: protocol=ssh
Diag: userandhost=git.kernel.org
Diag: port=1
Diag: path=/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git


But not this one:
 ./git fetch-pack  --diag-url  ssh://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
Diag: url=ssh://git.kernel.org:/pub/scm/linux/kernel/git/mchehab/v4l-dvb.git
Diag: protocol=ssh
Diag: userandhost=git.kernel.org:
Diag: port=NONE


Spontaneously I would say that a trailing ':' at the end of a hostname in the ssh:// scheme
can be safely ignored, what do you think ?

From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http.c: don't rewrite the user:passwd string multiple
 times
Date: Wed, 19 Jun 2013 09:40:54 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1306190927020.23103@tvnag.unkk.fr>
References: <1371520840-24906-1-git-send-email-bcasey@nvidia.com> <20130618051902.GA5916@sigill.intra.peff.net> <CA+sFfMdEvwzmnEBeO+_pwdmN3m5rkJvUCVFFJU8mtmyN+WxH6w@mail.gmail.com> <20130618221327.GA14234@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <bcasey@nvidia.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 19 09:41:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpD15-0006be-Gr
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 09:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756578Ab3FSHlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 03:41:15 -0400
Received: from giant.haxx.se ([80.67.6.50]:34194 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756336Ab3FSHlP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jun 2013 03:41:15 -0400
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id r5J7etQq010202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 09:40:55 +0200
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id r5J7etV6010199;
	Wed, 19 Jun 2013 09:40:55 +0200
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20130618221327.GA14234@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228356>

On Tue, 18 Jun 2013, Jeff King wrote:

>> But, I don't know if there is any multi-processing happening within the 
>> curl library.
>
> I don't think curl does any threading; when we are not inside 
> curl_*_perform, there is no curl code running at all (Daniel can correct me 
> if I'm wrong on that).

Correct, that's true. The default setup of libcurl never uses any threading at 
all, everything is done using non-blocking calls and state-machines.

There's but a minor exception, so let me describe that case just to be 
perfectly clear:

When you've build libcurl with the "threaded resolver" backend, libcurl fires 
up a new thread to resolve host names with during the name resolving phase of 
a transfer and that thread can then actually continue to run when 
curl_multi_perform() returns.

That's however very isolated, stricly only for name resolving and there should 
be no way for an application to mess that up. Nothing of what you've discussed 
in this thread would affect or harm that thread. The biggest impact it tends 
to have on applications (that aren't following the API properly or assume a 
little too much) is that it changes the nature of what file descriptors to 
wait for slightly during the name resolve phase.

Some Linux distros ship their default libcurl builds using the threaded 
resolver.

-- 

  / daniel.haxx.se

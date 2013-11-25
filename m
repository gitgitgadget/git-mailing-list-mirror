From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: error: git-remote-https died of signal 13
Date: Mon, 25 Nov 2013 08:20:18 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1311250815150.27300@tvnag.unkk.fr>
References: <5290D994.9040505@googlemail.com> <20131124065400.GB5535@sigill.intra.peff.net> <5291F70A.7070508@googlemail.com> <20131124133356.GA3507@sigill.intra.peff.net> <529214D7.1030203@googlemail.com> <20131124155439.GA8047@sigill.intra.peff.net>
 <52922A22.2090109@googlemail.com> <20131125063945.GA16313@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 25 08:20:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkqTK-00006O-6o
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 08:20:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738Ab3KYHUb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 02:20:31 -0500
Received: from giant.haxx.se ([80.67.6.50]:53881 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972Ab3KYHUa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 02:20:30 -0500
Received: from giant.haxx.se (dast@localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-4.1) with ESMTP id rAP7KI30004576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2013 08:20:18 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id rAP7KIju004571;
	Mon, 25 Nov 2013 08:20:18 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <20131125063945.GA16313@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238302>

On Mon, 25 Nov 2013, Jeff King wrote:

> Thanks. I'm having trouble reproducing the SIGPIPE locally, but I am able to 
> see via strace the write we make in curl_multi_cleanup. The call stack is:
>
>  curl_multi_cleanup
>    -> close_all_connections
>      -> Curl_disconnect
>        -> Curl_ossl_close
>          ...
>
> Daniel, does the call to Curl_disconnect need to be wrapped with 
> sigpipe_ignore/reset, similar to 7d80ed64e435155?

Yes. It very much looks like that. The SSL "closing" is what was the problem I 
had to adress.

But I then decided that if a 3rd library has one way to generate SIGPIPE it 
may very well have another in a separate spot so I decided to do the wrap at 
the top level immediately in the entry point when getting called by the 
application. Following that, the SIGPIPE ignore/restore should rather be made 
in curl_multi_cleanup.

-- 

  / daniel.haxx.se
